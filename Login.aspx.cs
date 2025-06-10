using System;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace AutoConcilia
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Si ya existe un usuario en sesión, redirige al Dashboard.
            if (Session["Usuario"] != null)
            {
                Response.Redirect("Dashboard.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Se extraen y limpian los datos ingresados por el usuario.
            string username = txtUsuario.Text.Trim();
            string passwordHash = HashPassword(txtPassword.Text);
            string role = ddlRol.SelectedValue;

            // Validación simulada de las credenciales.
            if (ValidarUsuario(username, passwordHash, role))
            {
                Session["Usuario"] = username;
                Session["Rol"] = role;
                Response.Redirect("Dashboard.aspx", false);
                Context.ApplicationInstance.CompleteRequest(); // Finaliza el procesamiento actual
            }
            else
            {
                errorMsg.Text = "Credenciales incorrectas.";
                errorMsg.Visible = true;
            }
        }

        // Método para generar un hash SHA-256 de la contraseña.
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashBytes);
            }
        }

        // Validación simulada del usuario: se acepta "admi" con la contraseña "123" (hasheada).
        private bool ValidarUsuario(string usuario, string passwordHash, string role)
        {
            // Credenciales de prueba.
            string validUsuario = "admi";
            string validPasswordHash = HashPassword("123");

            // Se comparan ignorando mayúsculas y espacios.
            if (usuario.Equals(validUsuario, StringComparison.OrdinalIgnoreCase) && passwordHash == validPasswordHash)
            {
                // Si necesitas validar el rol, puedes agregar condiciones adicionales aquí.
                return true;
            }
            return false;
        }
    }
}