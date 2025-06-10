<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error404.aspx.cs" Inherits="AutoConcilia1.Error404" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Error 404 - Página No Encontrada</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0A2E5B, #1E4E7A);
            text-align: center;
            color: #fff;
        }
        .container {
            max-width: 500px;
            margin: auto;
            padding: 50px;
        }
        h1 {
            font-size: 80px;
            font-weight: bold;
            animation: fadeIn 1s ease-in-out;
        }
        p {
            font-size: 18px;
            margin-bottom: 20px;
            opacity: 0.8;
        }
        .redirect {
            font-size: 16px;
            font-weight: bold;
            color: #FFD700;
            cursor: pointer;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>404</h1>
        <p>Lo sentimos, la página que buscas no existe.</p>
        <p class="redirect">Redirigiendo en <span id="contador">5</span> segundos...</p>
        <a href="Index.aspx" style="color: #fff; text-decoration: none; font-size: 18px;">Volver al Inicio</a>
    </div>

    <script>
        let segundos = 5;
        const contador = document.getElementById("contador");
        const interval = setInterval(() => {
            segundos--;
            contador.innerText = segundos;
            if (segundos <= 0) {
                clearInterval(interval);
                window.location.href = "Index.aspx";
            }
        }, 1000);
    </script>
</body>
</html>
