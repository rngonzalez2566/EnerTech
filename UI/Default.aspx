<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="UI._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
        }

        /* Barra de navegación */
        nav {
            background-color: #00796b;
            color: white;
            padding: 20px;
            text-align: center;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-size: 18px;
            transition: color 0.3s;
        }

        nav a:hover {
            color: #aed581;
        }

        /* Encabezado con imagen */
        header {
            position: relative;
            height: 500px;
            background: url('Images/banner-renewable-energy.jpg') no-repeat center center;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
        }

        header h1 {
            font-size: 48px;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
        }

        header p {
            font-size: 24px;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);
            margin-top: 10px;
        }

        /* Animación suave */
        .content section {
            opacity: 0;
            transform: translateY(50px);
            transition: opacity 0.6s ease-out, transform 0.6s ease-out;
        }

        .content.visible section {
            opacity: 1;
            transform: translateY(0);
        }

        /* Secciones */
        .content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 80px 20px;
            background-color: white;
        }

        .content section {
            background-color: #f4f4f4;
            padding: 40px;
            border-radius: 10px;
            margin-bottom: 40px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
        }

        /* Ajuste de tamaño de imágenes */
        .content section img {
            width: 50%; /* Reduce el ancho al 50% */
            height: auto;
            border-radius: 10px;
            margin-bottom: 20px;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }

        .content section h2 {
            color: #00796b;
            font-size: 28px;
            margin-bottom: 15px;
        }

        .content section p {
            font-size: 16px;
            color: #333;
            line-height: 1.8;
        }

        /* Footer */
        footer {
            background-color: #00796b;
            color: white;
            text-align: center;
            padding: 20px 0;
        }

        /* Animaciones */
        @keyframes fadeInUp {
            0% {
                opacity: 0;
                transform: translateY(50px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>

    <!-- Barra de navegación con enlace al login -->
    <nav>
        <a href="Home.aspx">Inicio</a>
        <a href="About.aspx">Quiénes Somos</a>
        <a href="Services.aspx">Servicios</a>
        <a href="Contact.aspx">Contacto</a>
        <a href="11-Login.aspx" class="btn btn-login">Iniciar Sesión</a> <!-- Enlace al formulario de login -->
    </nav>

    <!-- Encabezado con imagen de fondo -->
    <header>
        <h1>EnerTech</h1>
        <p>Innovación en Energías Renovables</p>
    </header>

    <!-- Contenido principal -->
    <div class="content" id="mainContent">

        <!-- Sección de Misión -->
        <section>
            <img src="Images/mission-image.jpg" alt="Nuestra Misión" />
            <h2>Nuestra Misión</h2>
            <p>
                En Software Factory, nuestra misión es desarrollar soluciones tecnológicas innovadoras y sostenibles,
                enfocadas en el sector de energías renovables. Nos comprometemos a mejorar la eficiencia energética global
                a través de la tecnología avanzada.
            </p>
        </section>

        <!-- Sección de Visión -->
        <section>
            <img src="Images/vision-image.jpg" alt="Nuestra Visión" />
            <h2>Nuestra Visión</h2>
            <p>
                Ser un líder global en la creación de software especializado en energías renovables, impulsando la transición
                hacia un futuro más verde y sostenible mediante el uso de tecnología de vanguardia.
            </p>
        </section>

        <!-- Sección de Quiénes Somos -->
        <section>
            <img src="Images/team-image.jpg" alt="Quiénes Somos" />
            <h2>Quiénes Somos</h2>
            <p>
                Somos una empresa tecnológica comprometida con el desarrollo de soluciones innovadoras para la industria de energías renovables.
                Con un equipo multidisciplinario de ingenieros, desarrolladores y expertos en tecnología, trabajamos día a día
                para ofrecer software que potencia la eficiencia y sostenibilidad en cada proyecto.
            </p>
        </section>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2024 EnerTech | Energías Renovables - Todos los derechos reservados.
    </footer>

    <script>
        // Animación cuando se desplaza la página
        window.addEventListener('scroll', function () {
            var content = document.getElementById('mainContent');
            var contentPosition = content.getBoundingClientRect().top;
            var screenPosition = window.innerHeight / 1.3;

            if (contentPosition < screenPosition) {
                content.classList.add('visible');
            }
        });
    </script>

</asp:Content>
