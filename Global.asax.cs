﻿using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;

namespace AutoConcilia1
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Código que se ejecuta al iniciar la aplicación
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // Probar conexión con la base de datos
            Conexion.ProbarConexion();
        }
    }
}
