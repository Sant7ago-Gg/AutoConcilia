<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="AutoConcilia.Dashboard" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>AutoConcilia - Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Poppins', sans-serif;
      background: #f0f2f5;
      color: #333;
    }
    header {
      background: rgba(21, 101, 192, 0.85);
      backdrop-filter: blur(8px);
      color: white;
      padding: 20px;
      text-align: center;
    }
    nav {
      background: rgba(13, 71, 161, 0.95);
      display: flex;
      justify-content: center;
      padding: 10px;
    }
    nav a {
      color: white;
      margin: 0 15px;
      text-decoration: none;
      font-weight: 500;
      transition: color 0.3s;
    }
    nav a:hover { color: #ffeb3b; }
    .content {
      max-width: 1100px;
      margin: 30px auto;
      padding: 20px;
    }
    .welcome {
      font-size: 1.6rem;
      text-align: center;
      margin-bottom: 30px;
    }
    .modules {
      display: flex;
      flex-wrap: wrap;
      gap: 30px;
      justify-content: space-around;
    }
    .module {
      background: #fff;
      padding: 20px;
      border-radius: 10px;
      flex: 1 1 320px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      transition: transform 0.3s ease;
    }
    .module:hover {
      transform: translateY(-5px);
    }
    .module h3 {
      color: #1565c0;
      margin-bottom: 10px;
    }
    .module p {
      font-size: 0.95rem;
      margin-bottom: 15px;
    }
    .module button {
      display: block;
      margin-top: 10px;
    }
    .logout-button {
      background-color: #d32f2f;
      border: none;
      padding: 10px 20px;
      color: white;
      font-size: 16px;
      border-radius: 6px;
      cursor: pointer;
      margin: 30px auto;
      display: block;
    }
    .logout-button:hover { background-color: #b71c1c; }
    footer {
      text-align: center;
      padding: 15px;
      background: #0D47A1;
      color: white;
      font-size: 0.9rem;
      margin-top: 40px;
    }
  </style>
</head>
<body>
  <form id="formDashboard" runat="server">
    <header>
      <h1>Bienvenido a AutoConcilia</h1>
      <p>Gestión moderna de conciliaciones bancarias</p>
    </header>

    <nav>
      <a href="Index.aspx"><i class="fas fa-home"></i> Inicio</a>
      <a href="Perfil.aspx"><i class="fas fa-user"></i> Perfil</a>
      <a href="Configuracion.aspx"><i class="fas fa-cog"></i> Configuración</a>
      <a href="Logout.aspx"><i class="fas fa-sign-out-alt"></i> Salir</a>
    </nav>

    <div class="content">
      <asp:Label ID="lblWelcome" runat="server" CssClass="welcome" />

      <div class="modules">
        <div class="module">
          <h3>Cargar Registros Contables</h3>
          <p>Sube tus archivos contables para ser procesados y almacenados.</p>
          <asp:Button ID="btnRegistros" runat="server" Text="Subir Registros" OnClick="btnRegistros_Click" CssClass="logout-button" />
        </div>

        <div class="module">
          <h3>Cargar Extractos Bancarios</h3>
          <p>Importa extractos desde tu banco para integrarlos al sistema.</p>
          <asp:Button ID="btnExtractos" runat="server" Text="Subir Extractos" OnClick="btnExtractos_Click" CssClass="logout-button" />
        </div>

        <div class="module">
          <h3>Conciliación Automática</h3>
          <p>Compara registros y extractos para generar coincidencias automáticamente.</p>
          <asp:Button ID="btnConciliacion" runat="server" Text="Iniciar Conciliación" OnClick="btnConciliacion_Click" CssClass="logout-button" />
        </div>

        <div class="module">
          <h3>Gestión de Usuarios</h3>
          <p>Administra los usuarios y roles que tienen acceso al sistema.</p>
          <asp:Button ID="btnUsuarios" runat="server" Text="Administrar Usuarios" OnClick="btnUsuarios_Click" CssClass="logout-button" />
        </div>
      </div>

      <asp:Button ID="btnLogout" runat="server" Text="Cerrar Sesión" CssClass="logout-button" OnClick="btnLogout_Click" />
    </div>

    <footer>
      &copy; 2025 AutoConcilia. Todos los derechos reservados.
    </footer>
  </form>
</body>
</html>
