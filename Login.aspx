<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AutoConcilia.Login" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>AutoConcilia - Login</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap">
  <!-- Si utilizas FontAwesome para íconos en tus enlaces o modales -->
  <script src="https://kit.fontawesome.com/yourkitid.js" crossorigin="anonymous"></script>
  <style>
    /* Configuración base y reset */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      margin: 0;
      padding: 0;
      background: linear-gradient(135deg, #001f3f, #0072ff);
      font-family: 'Poppins', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }
    /* Contenedor general que agrupa el formulario y la información adicional */
    .login-wrapper {
       display: flex;
       flex-direction: row;
       gap: 30px;
       max-width: 900px;
       width: 100%;
       margin: auto;
       align-items: stretch;
       padding: 20px;
    }
    /* Login Container – Formulario principal */
    .login-container {
      background: rgba(255, 255, 255, 0.9);
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
      width: 360px;
      text-align: center;
      animation: fadeIn 1s ease-in-out;
      display: flex;
      flex-direction: column;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .login-container h2 {
      margin-bottom: 20px;
      color: #333;
    }
    .input-group {
      margin-bottom: 20px;
      text-align: left;
    }
    .input-field {
      width: 100%;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 16px;
      transition: 0.3s ease;
    }
    .input-field:focus {
      border-color: #0072ff;
      box-shadow: 0 0 8px rgba(0, 114, 255, 0.5);
    }
    .btn-login {
      background-color: #0072ff;
      color: white;
      border: none;
      padding: 12px;
      border-radius: 8px;
      width: 100%;
      cursor: pointer;
      font-size: 16px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      margin-top: 10px;
    }
    .btn-login:hover {
      background-color: #0056b3;
      transform: scale(1.05);
      box-shadow: 0 6px 12px rgba(0, 114, 255, 0.3);
    }
    .error-message {
      color: red;
      font-size: 14px;
      margin-bottom: 15px;
      display: none;
    }
    /* Sección de enlaces: Recuperar contraseña y Sobre Nosotros */
    .links {
      margin-top: 15px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 14px;
    }
    .links a {
      color: #0072ff;
      text-decoration: none;
      transition: color 0.3s;
      cursor: pointer;
    }
    .links a:hover {
      color: #0056b3;
    }
    /* Panel lateral con información sobre nosotros */
    .about-us {
      background: rgba(255, 255, 255, 0.95);
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
      flex: 1;
      text-align: left;
      animation: fadeIn 1s ease-in-out;
    }
    .about-us h3 {
      margin-bottom: 15px;
      color: #333;
    }
    .about-us p {
      font-size: 15px;
      line-height: 1.6;
      color: #555;
      margin-bottom: 10px;
    }
    /* Responsive */
    @media (max-width: 768px) {
      .login-wrapper {
         flex-direction: column;
         align-items: center;
      }
      .about-us {
         width: 100%;
      }
      .login-container {
         width: 100%;
      }
    }
  </style>
  <script>
      function validarLogin() {
          let usuario = document.getElementById("txtUsuario").value;
          let password = document.getElementById("txtPassword").value;
          if (usuario.trim() === "" || password.trim() === "") {
              let errorLabel = document.getElementById("errorMsg");
              errorLabel.style.display = "block";
              errorLabel.innerText = "Por favor, complete todos los campos.";
              return false;
          }
          return true;
      }
      // Función opcional para mostrar información adicional sobre nosotros en un modal simple.
      function mostrarModalAboutUs() {
          alert("AutoConcilia es una solución innovadora en la conciliación bancaria. Nuestro compromiso es simplificar y eficientizar la gestión financiera, ofreciendo transparencia y seguridad en cada proceso.");
      }
  </script>
</head>
<body>
  <form id="formLogin" runat="server" onsubmit="return validarLogin()">
    <div class="login-wrapper">
      <!-- Formulario de Login -->
      <div class="login-container">
        <h2>Iniciar Sesión</h2>
        <div class="input-group">
          <asp:Label ID="lblUsuario" runat="server" AssociatedControlID="txtUsuario" Text="Usuario:"></asp:Label>
          <asp:TextBox ID="txtUsuario" runat="server" CssClass="input-field"></asp:TextBox>
        </div>
        <div class="input-group">
          <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword" Text="Contraseña:"></asp:Label>
          <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-field"></asp:TextBox>
        </div>
        <div class="input-group">
          <asp:Label ID="lblRol" runat="server" AssociatedControlID="ddlRol" Text="Rol:"></asp:Label>
          <asp:DropDownList ID="ddlRol" runat="server" CssClass="input-field">
            <asp:ListItem Text="Administrador" Value="Administrador"></asp:ListItem>
            <asp:ListItem Text="Contable" Value="Contable"></asp:ListItem>
            <asp:ListItem Text="Auxiliar" Value="Auxiliar"></asp:ListItem>
          </asp:DropDownList>
        </div>
        <asp:Label ID="errorMsg" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="btn-login" OnClick="btnLogin_Click"></asp:Button>
        <!-- Enlaces para Recuperar Contraseña y ver información sobre Nosotros -->
        <div class="links">
          <a href="RecuperarContrasena.aspx">¿Olvidaste tu contraseña?</a>
          <a href="#" onclick="mostrarModalAboutUs()">Sobre Nosotros</a>
        </div>
      </div>
      
      <!-- Panel lateral con información discreta sobre la empresa -->
      <div class="about-us">
        <h3>Sobre Nosotros</h3>
        <p>
          En AutoConcilia nos dedicamos a transformar la experiencia financiera mediante soluciones innovadoras para la conciliación bancaria.
        </p>
        <p>
          Nuestra visión es ser líderes en tecnología financiera, optimizando procesos y garantizando transparencia y seguridad en cada transacción.
        </p>
        <p>
          Con un equipo comprometido y herramientas de última generación, trabajamos día a día para simplificar la gestión contable y bancaria.
        </p>
      </div>
    </div>
  </form>
</body>
</html>
