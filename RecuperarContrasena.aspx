<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecuperarContrasena.aspx.cs" Inherits="AutoConcilia.RecuperarContrasena" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>AutoConcilia - Recuperar Contraseña</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KY4+xe37XKiJMu0fwWdi5V+3OcJtS23VmEWko9ka2MViNlPJhzTJd75N1YuanCXe+z+UEv51k2JPInQf6M6LQg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <style>
        /* Reutiliza el CSS de tu página de registro para mantener la coherencia */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background: linear-gradient(to bottom right, #0D1B2A, #1B3358);
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        
        .form-container { /* Cambié el nombre de la clase para ser más genérico */
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.3);
            width: 420px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        
        .form-container h2 {
            margin-bottom: 20px;
            color: #333;
        }
        
        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .input-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-size: 14px;
        }
        .input-field {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .input-field:focus {
            border-color: #0072ff;
            box-shadow: 0 0 8px rgba(0, 114, 255, 0.5);
            outline: none;
        }
        
        .btn-submit { /* Cambié el nombre de la clase para ser más genérico */
            background-color: #1B3358;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            width: 100%;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s ease-in-out;
        }
        .btn-submit:hover {
            background-color: #0D1B2A;
            transform: scale(1.05);
        }
        
        .message { /* Para mensajes de éxito o error */
            font-size: 14px;
            margin-bottom: 15px;
            /* La visibilidad la controla el servidor */
        }
        .success-message {
            color: green;
        }
        .error-message {
            color: red;
        }
        
        .extra-link {
            margin-top: 20px;
            font-size: 14px;
        }
        .extra-link a {
            color: #0072ff;
            text-decoration: none;
            transition: color 0.3s;
        }
        .extra-link a:hover {
            color: #0056b3;
        }
    </style>
    
    <script>
        // Validación del lado del cliente para el campo de email/usuario
        function validateForgotPassword() {
            let identifier = document.getElementById("<%= txtIdentifier.ClientID %>").value.trim(); // Usar ClientID
            let messageLabel = document.getElementById("<%= messageLabel.ClientID %>"); // Usar ClientID

            messageLabel.style.display = "none"; // Ocultar mensaje previo

            if (identifier === "") {
                messageLabel.style.display = "block";
                messageLabel.className = "message error-message";
                messageLabel.innerText = "Por favor, ingrese su correo electrónico o nombre de usuario.";
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <form id="formRecuperarContrasena" runat="server" onsubmit="return validateForgotPassword()">
        <div class="form-container">
            <h2>¿Olvidaste tu Contraseña?</h2>
            <p>Ingresa tu correo electrónico o nombre de usuario para restablecer tu contraseña.</p>

            <asp:Label ID="messageLabel" runat="server" CssClass="message" Visible="false"></asp:Label>

            <div class="input-group">
                <asp:Label ID="lblIdentifier" runat="server" AssociatedControlID="txtIdentifier" Text="Correo electrónico o Nombre de Usuario:"></asp:Label>
                <asp:TextBox ID="txtIdentifier" runat="server" CssClass="input-field"></asp:TextBox>
            </div>

            <asp:Button ID="btnSubmit" runat="server" Text="Restablecer Contraseña" CssClass="btn-submit" OnClick="btnSubmit_Click"></asp:Button>
            
            <div class="extra-link">
                <a href="Login.aspx">Volver a Iniciar Sesión</a>
            </div>
        </div>
    </form>
</body>
</html>