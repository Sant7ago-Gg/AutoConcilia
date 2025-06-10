using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail; // Para enviar correos electrónicos
using System.Web;     // Para HttpUtility.UrlEncode
using System.Security.Cryptography; // Para generar el token
using System.Text;     // Para BitConverter

namespace AutoConcilia
{
    public partial class RecuperarContrasena : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                messageLabel.Visible = false; // Ocultar el mensaje en la carga inicial
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string identifier = txtIdentifier.Text.Trim();

            if (string.IsNullOrEmpty(identifier))
            {
                ShowMessage("Por favor, ingrese su correo electrónico o nombre de usuario.", false);
                return;
            }

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                string email = string.Empty;
                string userId = string.Empty;

                // 1. Buscar al usuario por email o nombre de usuario
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT Id, Email FROM Usuarios WHERE Usuario = @Identifier OR Email = @Identifier";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Identifier", identifier);
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            userId = reader["Id"].ToString();
                            email = reader["Email"].ToString();
                        }
                        reader.Close();
                    }
                }

                if (string.IsNullOrEmpty(userId))
                {
                    // Por seguridad, no decimos si el usuario existe o no.
                    // Siempre mostramos un mensaje genérico.
                    ShowMessage("Si la cuenta existe, se enviará un enlace de restablecimiento a su correo electrónico.", true);
                    return;
                }

                // 2. Generar un token de restablecimiento de contraseña
                string resetToken = GenerateResetToken();
                DateTime tokenExpiry = DateTime.UtcNow.AddHours(1); // Token válido por 1 hora

                // 3. Guardar el token y su fecha de expiración en la base de datos
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    // Primero, eliminar tokens antiguos para este usuario si existen
                    string deleteOldTokensQuery = "DELETE FROM PasswordResetTokens WHERE UserId = @UserId";
                    using (SqlCommand cmdDelete = new SqlCommand(deleteOldTokensQuery, con))
                    {
                        cmdDelete.Parameters.AddWithValue("@UserId", userId);
                        con.Open();
                        cmdDelete.ExecuteNonQuery();
                        con.Close();
                    }

                    // Insertar el nuevo token
                    string insertTokenQuery = "INSERT INTO PasswordResetTokens (UserId, Token, ExpiryDate) VALUES (@UserId, @Token, @ExpiryDate)";
                    using (SqlCommand cmdInsert = new SqlCommand(insertTokenQuery, con))
                    {
                        cmdInsert.Parameters.AddWithValue("@UserId", userId);
                        cmdInsert.Parameters.AddWithValue("@Token", resetToken);
                        cmdInsert.Parameters.AddWithValue("@ExpiryDate", tokenExpiry);
                        con.Open();
                        cmdInsert.ExecuteNonQuery();
                    }
                }

                // 4. Enviar correo electrónico con el enlace de restablecimiento
                SendPasswordResetEmail(email, userId, resetToken);

                ShowMessage("Se ha enviado un enlace de restablecimiento de contraseña a su correo electrónico.", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Ocurrió un error al procesar su solicitud: " + ex.Message, false);
                // Aquí podrías loggear el error para depuración
            }
        }

        private string GenerateResetToken()
        {
            // Genera un token seguro. Usar GUID es una opción simple y efectiva.
            // Para mayor seguridad, puedes combinar GUIDs con un hash o usar criptografía más avanzada.
            return Guid.NewGuid().ToString("N"); // "N" para formato sin guiones
        }

        private void SendPasswordResetEmail(string toEmail, string userId, string token)
        {
            try
            {
                // Asegúrate de que esta URL coincida con la ruta de tu página de restablecimiento
                // y que el dominio sea correcto para tu aplicación publicada.
                string resetLink = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) +
                                   ResolveUrl("~/RestablecerContrasena.aspx") +
                                   "?userId=" + HttpUtility.UrlEncode(userId) +
                                   "&token=" + HttpUtility.UrlEncode(token);

                // Configuración de correo electrónico (ajusta estos valores)
                // Es recomendable guardar estos en Web.config para mayor seguridad y flexibilidad
                string smtpHost = ConfigurationManager.AppSettings["SmtpHost"];
                int smtpPort = int.Parse(ConfigurationManager.AppSettings["SmtpPort"]);
                string smtpUsername = ConfigurationManager.AppSettings["SmtpUsername"];
                string smtpPassword = ConfigurationManager.AppSettings["SmtpPassword"];
                bool enableSsl = bool.Parse(ConfigurationManager.AppSettings["SmtpEnableSsl"]);
                string fromEmail = ConfigurationManager.AppSettings["FromEmail"];
                string fromName = ConfigurationManager.AppSettings["FromName"];

                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress(fromEmail, fromName);
                    mail.To.Add(toEmail);
                    mail.Subject = "Restablecer Contraseña de AutoConcilia";
                    mail.IsBodyHtml = true;
                    mail.Body = $"<p>Estimado usuario,</p>" +
                                $"<p>Hemos recibido una solicitud para restablecer la contraseña de su cuenta.</p>" +
                                $"<p>Por favor, haga clic en el siguiente enlace para restablecer su contraseña:</p>" +
                                $"<p><a href='{resetLink}'>{resetLink}</a></p>" +
                                $"<p>Este enlace expirará en 1 hora.</p>" +
                                $"<p>Si usted no solicitó un restablecimiento de contraseña, por favor ignore este correo.</p>" +
                                $"<p>Atentamente,<br/>El equipo de AutoConcilia</p>";

                    using (SmtpClient smtp = new SmtpClient(smtpHost, smtpPort))
                    {
                        smtp.Credentials = new System.Net.NetworkCredential(smtpUsername, smtpPassword);
                        smtp.EnableSsl = enableSsl;
                        smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                        smtp.Send(mail);
                    }
                }
            }
            catch (SmtpException smtpEx)
            {
                // Manejo de errores de SMTP (credenciales incorrectas, host inaccesible, etc.)
                ShowMessage("Error al enviar el correo de restablecimiento. Verifique la configuración del servidor SMTP. " + smtpEx.Message, false);
                // Loggear smtpEx
            }
            catch (Exception ex)
            {
                ShowMessage("Ocurrió un error inesperado al preparar el correo de restablecimiento. " + ex.Message, false);
                // Loggear ex
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            messageLabel.Text = message;
            messageLabel.Visible = true;
            if (isSuccess)
            {
                messageLabel.CssClass = "message success-message";
            }
            else
            {
                messageLabel.CssClass = "message error-message";
            }
        }
    }
}