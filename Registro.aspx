<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="AutoConcilia.Registro" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>AutoConcilia - Registro</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KY4+xe37XKiJMu0fwWdi5V+3OcJtS23VmEWko9ka2MViNlPJhzTJd75N1YuanCXe+z+UEv51k2JPInQf6M6LQg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   
    <style>
        /* Reset y estilos globales */
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
        
        /* Contenedor central */
        .register-container {
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
        
        /* Título del formulario */
        .register-container h2 {
            margin-bottom: 20px;
            color: #333;
        }
        
        /* Agrupación de campos */
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
        
        /* Posicionamiento relativo para los campos con toggle */
        .field-wrapper {
            position: relative;
        }
        .toggle-visibility {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #0072ff;
            font-size: 16px;
        }
        
        /* Medidor de fortaleza de contraseña */
        .password-strength-container {
            margin-top: 10px;
            text-align: left; /* Asegura que la barra y el texto estén alineados a la izquierda */
        }
        #strengthBar {
            height: 5px;
            width: 0%;
            border-radius: 5px;
            transition: width 0.3s, background 0.3s;
        }
        #strengthLabel {
            display: block;
            margin-top: 5px;
            font-size: 13px;
            /* El color del texto de la etiqueta de fortaleza se maneja en JavaScript, pero se puede predeterminar aquí */
            color: #555; /* Color predeterminado */
        }
        
        /* Botón de registro */
        .btn-register {
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
        .btn-register:hover {
            background-color: #0D1B2A;
            transform: scale(1.05);
        }
        
        /* Mensaje de error */
        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
            /* La visibilidad es controlada por el servidor y JavaScript */
        }
        
        /* Enlace para usuarios ya registrados */
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
        // Función para validar la información ingresada en el lado del cliente.
        // Se ejecuta antes de enviar el formulario al servidor.
        function validarRegistro() {
            // Se obtienen los valores de los campos de entrada
            let txtNombreCompleto = document.getElementById("txtNombreCompleto").value.trim();
            let txtUsuario = document.getElementById("txtUsuario").value.trim();
            let txtEmail = document.getElementById("txtEmail").value.trim();
            let txtContrasena = document.getElementById("txtContrasena").value;
            let txtConfirmContrasena = document.getElementById("txtConfirmContrasena").value;

            let errorLabel = document.getElementById("errorMsg");
            errorLabel.style.display = "none"; // Oculta el mensaje de error por defecto

            // Validación de campos vacíos
            if (txtNombreCompleto === "" || txtUsuario === "" || txtEmail === "" || txtContrasena === "" || txtConfirmContrasena === "") {
                errorLabel.style.display = "block"; // Muestra el mensaje de error
                errorLabel.innerText = "Por favor, complete todos los campos.";
                return false; // Evita el envío del formulario
            }

            // Validación de coincidencia de contraseñas
            if (txtContrasena !== txtConfirmContrasena) {
                errorLabel.style.display = "block";
                errorLabel.innerText = "Las contraseñas no coinciden.";
                return false;
            }

            // Si todas las validaciones pasan, permite el envío del formulario.
            return true;
        }

        // Función para alternar la visibilidad de un campo de tipo contraseña.
        function togglePasswordVisibility(fieldId, iconId) {
            let field = document.getElementById(fieldId);
            let icon = document.getElementById(iconId);
            if (field.type === "password") {
                field.type = "text";
                icon.className = "fa fa-eye-slash"; // Cambia el icono a ojo tachado
            } else {
                field.type = "password";
                icon.className = "fa fa-eye"; // Cambia el icono a ojo
            }
        }

        // Función para comprobar la fortaleza de la contraseña.
        function checkPasswordStrength() {
            let password = document.getElementById("txtContrasena").value;
            let strengthLabel = document.getElementById("strengthLabel");
            let strengthBar = document.getElementById("strengthBar");

            let strength = 0;
            // Criterios de fortaleza:
            if (password.length >= 8) strength++; // Longitud mínima (cambié de 6 a 8 para una mejor práctica)
            if (password.match(/[A-Z]/)) strength++; // Mayúsculas
            if (password.match(/[a-z]/)) strength++; // Minúsculas (agregado para mejor granularidad)
            if (password.match(/[0-9]/)) strength++; // Números
            if (password.match(/[^A-Za-z0-9]/)) strength++; // Caracteres especiales

            // Actualiza la barra y la etiqueta de fortaleza
            if (strength === 0) {
                strengthLabel.innerText = "";
                strengthBar.style.width = "0%";
                strengthBar.style.background = "transparent"; // Ocultar la barra
            } else if (strength <= 2) {
                strengthLabel.innerText = "Débil";
                strengthLabel.style.color = "red"; // Color del texto
                strengthBar.style.width = "25%";
                strengthBar.style.background = "red";
            } else if (strength === 3) {
                strengthLabel.innerText = "Moderada";
                strengthLabel.style.color = "orange";
                strengthBar.style.width = "50%";
                strengthBar.style.background = "orange";
            } else if (strength === 4) {
                strengthLabel.innerText = "Buena";
                strengthLabel.style.color = "darkgreen"; // Un color distinto para buena
                strengthBar.style.width = "75%";
                strengthBar.style.background = "yellowgreen";
            } else if (strength >= 5) {
                strengthLabel.innerText = "Fuerte";
                strengthLabel.style.color = "green";
                strengthBar.style.width = "100%";
                strengthBar.style.background = "green";
            }
        }
    </script>
</head>
<body>
    <%-- Formulario de registro con runat="server" para la integración de código-backend --%>
    <form id="formRegistro" runat="server" onsubmit="return validarRegistro()">
        <div class="register-container">
            <h2>Registro de Usuario</h2>

            <div class="input-group">
                <asp:Label ID="lblNombreCompleto" runat="server" AssociatedControlID="txtNombreCompleto" Text="Nombre Completo:" ></asp:Label>
                <asp:TextBox ID="txtNombreCompleto" runat="server" CssClass="input-field"></asp:TextBox>
            </div>

            <div class="input-group">
                <asp:Label ID="lblUsuario" runat="server" AssociatedControlID="txtUsuario" Text="Usuario:" ></asp:Label>
                <asp:TextBox ID="txtUsuario" runat="server" CssClass="input-field"></asp:TextBox>
            </div>

            <div class="input-group">
                <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Correo Electrónico:" ></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field"></asp:TextBox>
            </div>

            <div class="input-group">
                <asp:Label ID="lblContrasena" runat="server" AssociatedControlID="txtContrasena" Text="Contraseña:" ></asp:Label>
                <div class="field-wrapper">
                    <asp:TextBox ID="txtContrasena" runat="server" CssClass="input-field" TextMode="Password" onkeyup="checkPasswordStrength()"></asp:TextBox>
                    <span class="toggle-visibility" onclick="togglePasswordVisibility('txtContrasena','iconPassword')">
                        <i id="iconPassword" class="fa fa-eye"></i>
                    </span>
                </div>
                <div class="password-strength-container">
                    <div id="strengthBar"></div>
                    <small id="strengthLabel"></small>
                </div>
            </div>

            <div class="input-group">
                <asp:Label ID="lblConfirmContrasena" runat="server" AssociatedControlID="txtConfirmContrasena" Text="Confirmar Contraseña:" ></asp:Label>
                <div class="field-wrapper">
                    <asp:TextBox ID="txtConfirmContrasena" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox>
                    <span class="toggle-visibility" onclick="togglePasswordVisibility('txtConfirmContrasena','iconConfirmPassword')">
                        <i id="iconConfirmPassword" class="fa fa-eye"></i>
                    </span>
                </div>
            </div>

            <div class="input-group">
                <asp:Label ID="lblRol" runat="server" AssociatedControlID="ddlRol" Text="Rol:" ></asp:Label>
                <asp:DropDownList ID="ddlRol" runat="server" CssClass="input-field">
                    <asp:ListItem Text="Administrador" Value="Administrador"></asp:ListItem>
                    <asp:ListItem Text="Contable" Value="Contable"></asp:ListItem>
                    <asp:ListItem Text="Auxiliar" Value="Auxiliar"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:Label ID="errorMsg" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <asp:Button ID="btnRegistro" runat="server" Text="Registrarse" CssClass="btn-registro" OnClick="btnRegistro_Click"></asp:Button>
            
            <div class="extra-link">
                ¿Ya tienes cuenta? <a href="Login.aspx">Inicia sesión</a>
            </div>
        </div>
    </form>
</body>
</html>