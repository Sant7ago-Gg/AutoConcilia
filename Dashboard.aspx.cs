using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace AutoConcilia
{
    public partial class Dashboard : Page
    {
        // 🔹 Declaración correcta de los controles
        protected GridView gvRegistros;
        protected GridView gvExtractos;

        protected Button btnRegistros, btnExtractos, btnConciliacion, btnUsuarios, btnLogout;

        // 🔹 Método para obtener la conexión a la base de datos
        private MySqlConnection ObtenerConexion()
        {
            return new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MiConexionDB"].ConnectionString);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // 🔹 Verifica que exista un usuario en sesión; si no, redirige a Login.aspx
            if (Session["Usuario"] == null)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // 🔹 Configura el mensaje de bienvenida
            if (!IsPostBack)
            {
                string usuario = Session["Usuario"]?.ToString() ?? "Invitado";
                string rol = Session["Rol"]?.ToString() ?? "N/A";
                lblWelcome.Text = $"Bienvenido, {usuario} ({rol})!";

                // Cargar módulos del Dashboard
                CargarRegistrosContables();
                CargarExtractosBancarios();
            }
        }

        // 🔹 Método para cargar registros contables desde MySQL
        private void CargarRegistrosContables()
        {
            using (MySqlConnection conn = ObtenerConexion())
            {
                try
                {
                    conn.Open();
                    string query = "SELECT id, descripcion, monto FROM registros_contables";
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        gvRegistros.DataSource = reader;
                        gvRegistros.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    lblWelcome.Text = $"Error al cargar registros contables: {ex.Message}";
                }
            }
        }

        // 🔹 Método para cargar extractos bancarios
        private void CargarExtractosBancarios()
        {
            using (MySqlConnection conn = ObtenerConexion())
            {
                try
                {
                    conn.Open();
                    string query = "SELECT id, fecha, monto FROM extractos_bancarios";
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        gvExtractos.DataSource = reader;
                        gvExtractos.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    lblWelcome.Text = $"Error al cargar extractos bancarios: {ex.Message}";
                }
            }
        }

        // 🔹 Evento para iniciar conciliación automática
        protected void btnConciliacion_Click(object sender, EventArgs e)
        {
            try
            {
                using (MySqlConnection conn = ObtenerConexion())
                {
                    conn.Open();
                    string query = "CALL ProcedimientoConciliacion()"; // Ajusta según tu procedimiento almacenado
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.ExecuteNonQuery();
                    }

                    lblWelcome.Text = "Conciliación realizada con éxito!";
                }
            }
            catch (Exception ex)
            {
                lblWelcome.Text = $"Error en la conciliación: {ex.Message}";
            }
        }

        // 🔹 Evento para la gestión de usuarios
        protected void btnUsuarios_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionUsuarios.aspx");
        }

        // 🔹 Evento para cargar registros contables
        protected void btnRegistros_Click(object sender, EventArgs e)
        {
            Response.Redirect("CargarRegistros.aspx");
        }

        // 🔹 Evento para cargar extractos bancarios
        protected void btnExtractos_Click(object sender, EventArgs e)
        {
            Response.Redirect("CargarExtractos.aspx");
        }

        // 🔹 Evento para cerrar sesión
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx", false);

        }
    }
}