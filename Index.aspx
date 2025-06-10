<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="AutoConcilia.Index" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AutoConcilia - Inicio</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBgzWqIDf76WneOIWyrWszusxbEuwyg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <style>
        /* Reset y configuración base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0A2E5B, #1E4E7A);
            color: #fff;
            overflow-x: hidden;
            text-align: center;
        }
        
        /* Header con efecto Glassmorphism */
        header {
            position: fixed;
            top: 0;
            width: 100%;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            backdrop-filter: blur(15px);
            background: rgba(255, 255, 255, 0.1);
            z-index: 1000;
            transition: background 0.3s ease-in-out;
        }
        header:hover {
            background: rgba(255, 255, 255, 0.15);
        }
        .logo {
            font-size: 24px;
            font-weight: 700;
            letter-spacing: 1px;
        }
        nav a {
            color: #fff;
            text-decoration: none;
            margin: 0 15px;
            font-size: 16px;
            transition: color 0.3s;
        }
        nav a:hover {
            color: #FDD835;
        }
        
        /* Sección Hero */
        .hero {
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 140px 20px 50px;
        }
        .hero h1 {
            font-size: 4rem;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
        }
        .hero p {
            font-size: 1.2rem;
            max-width: 700px;
            margin-bottom: 30px;
            opacity: 0.9;
        }
        .btn-container {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
        }
        .btn {
            border: 2px solid transparent;
            padding: 12px 25px;
            font-size: 1rem;
            border-radius: 50px;
            cursor: pointer;
            text-transform: uppercase;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.2);
            color: #fff;
        }
        .btn:hover {
            transform: scale(1.05);
        }
        .btn-login {
            border-color: #FDD835;
            background: transparent;
            color: #FDD835;
        }
        .btn-login:hover {
            background: #FDD835;
            color: #0A2E5B;
        }
        .btn-register {
            border-color: #fff;
        }
        .btn-register:hover {
            background: #fff;
            color: #0A2E5B;
        }
        .hero img {
            width: 250px;
            margin-top: 30px;
            animation: float 4s infinite ease-in-out;
        }
        @keyframes float {
            0% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
            100% { transform: translateY(0); }
        }
        
        /* Sección About – Información sobre Nosotros */
        .about {
            background: #f7f7f7;
            color: #333;
            text-align: center;
            padding: 80px 20px;
        }
        .about .container {
            max-width: 960px;
            margin: auto;
        }
        .about h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }
        .about p {
            font-size: 1rem;
            line-height: 1.6;
            margin-bottom: 20px;
            padding: 0 10px;
        }
        .about .info-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 40px;
            margin-top: 40px;
        }
        .about .info-card {
            background: #fff;
            color: #333;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            max-width: 300px;
        }
        
        /* Sección Características (NUEVA SECCIÓN) */
        .features {
            background: #f7f7f7;
            color: #333;
            padding: 80px 20px;
            text-align: center;
        }
        .features .container {
            max-width: 960px;
            margin: auto;
        }
        .features h2 {
            font-size: 2.5rem;
            margin-bottom: 30px;
        }
        .features .feature-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-top: 30px;
        }
        .features .feature-item {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            text-align: left;
        }
        .features .feature-item i {
            font-size: 2rem;
            color: #0A2E5B;
            margin-bottom: 15px;
        }
        .features .feature-item h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #1E4E7A;
        }
        .features .feature-item p {
            font-size: 1rem;
            line-height: 1.6;
        }

        /* Sección Testimonios (NUEVA SECCIÓN - Ejemplo básico) */
        .testimonials {
            background: linear-gradient(135deg, #0A2E5B, #1E4E7A);
            color: #fff;
            padding: 80px 20px;
            text-align: center;
        }
        .testimonials .container {
            max-width: 960px;
            margin: auto;
        }
        .testimonials h2 {
            font-size: 2.5rem;
            margin-bottom: 30px;
        }
        .testimonials .testimonial-card {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .testimonials .testimonial-card p {
            font-style: italic;
            margin-bottom: 15px;
            opacity: 0.9;
        }
        .testimonials .testimonial-card .author {
            font-weight: bold;
            opacity: 1;
        }
        
        /* Sección Social – Redes Sociales */
        .social {
            background: linear-gradient(135deg, #1E4E7A, #0A2E5B);
            color: #fff;
            text-align: center;
            padding: 80px 20px;
        }
        .social .container {
            max-width: 960px;
            margin: auto;
        }
        .social h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }
        .social p {
            font-size: 1rem;
            margin-bottom: 30px;
        }
        .social .social-icons {
            margin-top: 30px;
            display: flex;
            justify-content: center;
            gap: 30px;
        }
        .social .social-icons a {
            font-size: 2rem;
            color: #fff;
            transition: color .3s ease;
        }
        .social .social-icons a:hover {
            color: #FDD835;
        }
        
        /* Sección Interact – Más Información y Llamado a la Acción */
        .interact {
            background: #fff;
            color: #0A2E5B;
            text-align: center;
            padding: 80px 20px;
        }
        .interact .container {
            max-width: 960px;
            margin: auto;
        }
        .interact h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }
        .interact p {
            font-size: 1rem;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        /* Footer */
        footer {
            background: #0A2E5B;
            color: #fff;
            text-align: center;
            padding: 20px 10px;
        }
        footer .container {
            max-width: 960px;
            margin: auto;
        }
        footer p {
            margin: 0;
            font-size: 0.9rem;
        }
        
        /* Media Queries */
        @media (max-width: 768px) {
            .hero h1 { font-size: 2.8rem; }
            nav a { margin: 0 10px; font-size: 14px; }
            .about .info-container { flex-direction: column; align-items: center; }
            .features .feature-list { grid-template-columns: 1fr; } /* Columnas individuales en móviles para características */
        }
    </style>
</head>
<body>
    
    <header>
        <div class="logo">AutoConcilia</div>
        <nav>
            <a href="Login.aspx">Iniciar Sesión</a>
            <a href="Registro.aspx">Registrarse</a>
            <a href="#about">Sobre Nosotros</a>
            <a href="#features">Características</a> 
            <a href="#contact">Contacto</a> 
        </nav>
    </header>
    
    <section class="hero">
        <h1>Innovando tu Conciliación Bancaria</h1>
        <p>
            Descubre la nueva era en gestión financiera. Con AutoConcilia, simplificamos tus procesos
            y maximizamos tu productividad.
        </p>
        <div class="btn-container">
            <button class="btn btn-login" onclick="location.href='Login.aspx'">Iniciar Sesión</button>
            <button class="btn btn-register" onclick="location.href='Registro.aspx'">Registrarse</button>
        </div>
        <img src="https://cdn-icons-png.flaticon.com/512/2344/2344638.png" alt="Conciliación Bancaria">
    </section>
    
    <section class="about" id="about">
        <div class="container">
            <h2>Sobre Nosotros</h2>
            <p>
                En AutoConcilia nos dedicamos a transformar la manera en que las empresas gestionan su conciliación bancaria, ofreciendo soluciones innovadoras y precisas para optimizar la gestión financiera.
            </p>
            <div class="info-container">
                <div class="info-card">
                    <h3>Nuestra Visión</h3>
                    <p>Ser la plataforma líder en soluciones financieras, impulsando la eficiencia y transparencia en la gestión contable y bancaria.</p>
                </div>
                <div class="info-card">
                    <h3>Nuestra Misión</h3>
                    <p>Facilitar la conciliación bancaria mediante tecnología innovadora, simplificando procesos para empresas y usuarios.</p>
                </div>
            </div>
        </div>
    </section>
    
    <section class="features" id="features">
        <div class="container">
            <h2>Características Principales</h2>
            <div class="feature-list">
                <div class="feature-item">
                    <i class="fas fa-file-import"></i>
                    <h3>Importación Automática</h3>
                    <p>Importa tus estados de cuenta bancarios de forma automática y segura.</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-hand-holding-dollar"></i>
                    <h3>Conciliación Inteligente</h3>
                    <p>Nuestro sistema aprende de tus conciliaciones pasadas para sugerir coincidencias automáticamente.</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-chart-line"></i>
                    <h3>Reportes Detallados</h3>
                    <p>Genera informes personalizados para tener una visión clara de tu flujo de efectivo.</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-user-shield"></i>
                    <h3>Seguridad Robusta</h3>
                    <p>Protegemos tus datos financieros con encriptación de última generación.</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-cloud"></i>
                    <h3>Acceso en la Nube</h3>
                    <p>Accede a tu información desde cualquier dispositivo y en cualquier momento.</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-users"></i>
                    <h3>Colaboración Sencilla</h3>
                    <p>Permite que varios miembros de tu equipo trabajen en la conciliación de forma simultánea.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="testimonials">
        <div class="container">
            <h2>Lo que dicen nuestros clientes</h2>
            <div class="testimonial-card">
                <p>"AutoConcilia ha simplificado enormemente nuestro proceso de conciliación bancaria. ¡Ahorramos mucho tiempo!"</p>
                <p class="author">- Ana Pérez, Contadora</p>
            </div>
            <div class="testimonial-card">
                <p>"La función de importación automática es fantástica y la conciliación inteligente es muy precisa."</p>
                <p class="author">- Carlos López, Gerente Financiero</p>
            </div>
            </div>
    </section>
    
    <section class="social" id="contact">
        <div class="container">
            <h2>Conecta con Nosotros</h2>
            <p>Síguenos en nuestras redes sociales y mantente al día con nuestras novedades.</p>
            <div class="social-icons">
                <a href="https://www.facebook.com/AutoConciliaOficial" target="_blank" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
                <a href="https://www.twitter.com/AutoConcilia_es" target="_blank" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                <a href="https://www.instagram.com/AutoConcilia" target="_blank" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                <a href="https://www.linkedin.com/company/AutoConcilia-Solutions" target="_blank" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                </div>
        </div>
    </section>
    
    <section class="interact">
        <div class="container">
            <h2>¿Listo para Simplificar tu Conciliación?</h2>
            <p>
                Explora todas las funcionalidades de AutoConcilia y experimenta la eficiencia en tu gestión financiera.
            </p>
            <button class="btn btn-register" onclick="location.href='Demo.aspx'">Ver Demo</button>
        </div>
    </section>
    
    <footer>
        <div class="container">
            <p>&copy; 2025 AutoConcilia. Todos los derechos reservados.</p>
        </div>
    </footer>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script>
        gsap.from(".hero h1", { opacity: 0, y: -50, duration: 1 });
        gsap.from(".btn-container", { opacity: 0, scale: 0.8, duration: 1, delay: 0.5 });
        gsap.from(".about h2", { opacity: 0, y: 50, duration: 1, delay: 0.3 });
        gsap.from(".features h2", { opacity: 0, y: 50, duration: 1, delay: 0.5 });
        gsap.from(".testimonials h2", { opacity: 0, y: 50, duration: 1, delay: 0.7 });
        gsap.from(".social h2", { opacity: 0, y: 50, duration: 1, delay: 0.3 });
        gsap.from(".interact h2", { opacity: 0, y: 50, duration: 1, delay: 0.3 });
    </script>
    
    <script src="https://unpkg.com/scrollreveal"></script>
    <script>
        ScrollReveal().reveal('.about', { delay: 300, distance: '50px', origin: 'bottom' });
        ScrollReveal().reveal('.features', { delay: 400, distance: '60px', origin: 'bottom', interval: 200 });
        ScrollReveal().reveal('.testimonials .testimonial-card', { delay: 500, distance: '40px', origin: 'bottom', interval: 300 });
        ScrollReveal().reveal('.social', { delay: 300, distance: '50px', origin: 'bottom' });
        ScrollReveal().reveal('.interact', { delay: 300, distance: '50px', origin: 'bottom' });
    </script>
    
</body>
</html>