using System;
using System.Web.UI;

namespace AutoConcilia
{
    public partial class Index : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Intentamos obtener el usuario autenticado de la sesión
            string usuario = Session["Usuario"] as string;

            // Si el usuario está autenticado (no es null ni vacío)
            if (!string.IsNullOrWhiteSpace(usuario))
            {
                // Redirige al Dashboard; 'false' evita ejecutar más procesamiento en la respuesta
                Response.Redirect("Dashboard.aspx", false);
                // Completa la respuesta para evitar que se siga procesando la página actual
                Context.ApplicationInstance.CompleteRequest();
            }
        }
    }
}
