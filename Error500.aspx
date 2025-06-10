<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error500.aspx.cs" Inherits="AutoConcilia.Error500" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Error 500 - Error Interno del Servidor</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #d32f2f, #a00c0c);
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
        .retry-btn {
            background-color: #FFD700;
            color: #a00c0c;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }
        .retry-btn:hover {
            background-color: #ffb300;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>500</h1>
        <p>Ha ocurrido un error inesperado en el servidor.</p>
        <button class="retry-btn" onclick="window.location.reload()">Intentar de nuevo</button>
    </div>
</body>
</html>
