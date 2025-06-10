// Registro.aspx.cs (Asegúrate de que este archivo exista y esté en la misma carpeta que Registro.aspx)
using System;
using System.Web.UI; // Necesario para la clase Page
using System.Data.SqlClient; // Necesario para interactuar con SQL Server (si usas SQL Server)
using System.Configuration; // Necesario para acceder a la cadena de conexión del Web.config
using System.Security.Cryptography; // Para hashing de contraseñas
using System.Text; // Para codificación de texto

namespace AutoConcilia
{
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Este método se ejecuta cuando la página se carga.
            // Es buena práctica ocultar el mensaje de error en la carga inicial.
            if (!IsPostBack) // Solo se ejecuta la primera vez que se carga la página (no en postbacks)
            {
                errorMsg.Visible = false;
            }
        }

        protected void btnRegistro_Click(object sender, EventArgs e)
        {
            // La validación del lado del cliente (validarRegistro()) se ejecuta primero.
            // Si devuelve 'false', este método del lado del servidor no se llamará.
            // Sin embargo, es buena práctica volver a validar en el servidor por seguridad.

            // 1. Validación de campos vacíos (del lado del servidor)
            if (string.IsNullOrWhiteSpace(txtNombreCompleto.Text) ||
                string.IsNullOrWhiteSpace(txtUsuario.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtContrasena.Text) ||
                string.IsNullOrWhiteSpace(txtConfirmContrasena.Text))
            {
                errorMsg.Text = "Por favor, complete todos los campos.";
                errorMsg.Visible = true; // Hace visible el mensaje de error
                return; // Detiene la ejecución del método
            }

            // 2. Validación de coincidencia de contraseñas
            if (txtContrasena.Text != txtConfirmContrasena.Text)
            {
                errorMsg.Text = "Las contraseñas no coinciden.";
                errorMsg.Visible = true;
                return;
            }

            // --- IMPORTANTE: Agrega tu lógica de registro aquí ---
            // Esto es un ejemplo. ¡Asegúrate de adaptar esto a tu base de datos y modelo de seguridad!
            try
            {
                string nombreCompleto = txtNombreCompleto.Text.Trim();
                string usuario = txtUsuario.Text.Trim();
                string email = txtEmail.Text.Trim();
                string contrasena = txtContrasena.Text; // Contraseña en texto plano antes de hashear
                string rol = ddlRol.SelectedValue; // Valor seleccionado del DropDownList

                // 3. Hashear la contraseña por seguridad
                string contrasenaHasheada = HashPassword(contrasena);

                // 4. Guardar datos del usuario en la base de datos
                // Necesitarás una cadena de conexión en tu archivo Web.config
                // Ejemplo de Web.config:
                /*
                <configuration>
                  <connectionStrings>
                    <add name="DefaultConnection" connectionString="Data Source=TU_SERVIDOR;Initial Catalog=TU_BASE_DE_DATOS;Integrated Security=True" providerName="System.Data.SqlClient" />
                  </connectionStrings>
                </configuration>
                */
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    // Evita la inyección SQL usando parámetros.
                    string query = "INSERT INTO Usuarios (NombreCompleto, Usuario, Email, ContrasenaHash, Rol) VALUES (@NombreCompleto, @Usuario, @Email, @ContrasenaHash, @Rol)";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@NombreCompleto", nombreCompleto);
                        cmd.Parameters.AddWithValue("@Usuario", usuario);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@ContrasenaHash", contrasenaHasheada);
                        cmd.Parameters.AddWithValue("@Rol", rol);

                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Registro exitoso, redirigir al usuario
                            Response.Redirect("Login.aspx"); // Asegúrate de que "Login.aspx" exista
                        }
                        else
                        {
                            errorMsg.Text = "No se pudo registrar el usuario. Intente de nuevo.";
                            errorMsg.Visible = true;
                        }
                    }
                }
            }
            catch (SqlException sqlex)
            {
                // Manejar errores específicos de la base de datos (ej. usuario/email duplicado)
                if (sqlex.Number == 2627) // Código de error para violación de clave primaria/única (ej. usuario o email ya existe)
                {
                    errorMsg.Text = "El nombre de usuario o correo electrónico ya está registrado.";
                }
                else
                {
                    errorMsg.Text = "Error de base de datos: " + sqlex.Message;
                }
                errorMsg.Visible = true;
            }
            catch (Exception ex)
            {
                // Manejar otros errores generales
                errorMsg.Text = "Error al registrar usuario: " + ex.Message;
                errorMsg.Visible = true;
            }
        }

        // Función para hashear la contraseña (ejemplo con SHA256)
        private string HashPassword(string password)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2")); // Formato hexadecimal
                }
                return builder.ToString();
            }
        }
    }
}