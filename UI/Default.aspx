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
            cursor: pointer;
        }

        nav a:hover {
            color: #aed581;
        }

        .btn-login {
            padding: 8px 15px;
            border: 1px solid white;
            border-radius: 5px;
        }

        .btn-login:hover {
            background-color: white;
            color: #00796b;
        }

        /* Encabezado con imagen */
        header {
            position: relative;
            height: 500px;
            background: url('Images/banner-renewable-energy.jpg') no-repeat center center;
            display: flex;
            justify-content: center;
            align-items: center;
            color: gray;
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

        .content section img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 20px;
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

        footer .footer-content {
            display: flex;
            justify-content: space-between;
            padding: 20px 50px;
        }

        footer .footer-content div {
            flex: 1;
            margin: 0 10px;
        }

        footer h4 {
            margin-bottom: 10px;
        }

    </style>

    <!-- Barra de navegación -->
    <nav>
        <a href="#quienes-somos">Quiénes Somos</a>
        <a href="#mision">Misión</a>
        <a href="#vision">Visión</a>
        <a href="#footer">Contacto</a> <!-- Este enlace apunta al footer -->
        <a href="11-Login.aspx" class="btn-login">Iniciar Sesión</a> <!-- Opción de iniciar sesión -->
    </nav>

    <!-- Encabezado con imagen de fondo -->
    <header id="inicio">
        <h1>EnerTech</h1>
        <p>Innovación en Energías Renovables</p>
    </header>

    <!-- Contenido principal -->
    <div class="content" id="mainContent">

        <!-- Sección de Quiénes Somos -->
        <section id="quienes-somos">
            <img src="Images/team-image.jpg" alt="Quiénes Somos" />
            <h2>Quiénes Somos</h2>
            <p>
                Somos una empresa tecnológica comprometida con el desarrollo de soluciones innovadoras para la industria de energías renovables.
                Con un equipo multidisciplinario de ingenieros, desarrolladores y expertos en tecnología, trabajamos día a día
                para ofrecer software que potencia la eficiencia y sostenibilidad en cada proyecto.
            </p>
        </section>

        <!-- Sección de Misión -->
        <section id="mision">
            <img src="Images/mission-image.jpg" alt="Nuestra Misión" />
            <h2>Nuestra Misión</h2>
            <p>
                En Software Factory, nuestra misión es desarrollar soluciones tecnológicas innovadoras y sostenibles,
                enfocadas en el sector de energías renovables. Nos comprometemos a mejorar la eficiencia energética global
                a través de la tecnología avanzada.
            </p>
        </section>

        <!-- Sección de Visión -->
        <section id="vision">
            <img src="Images/vision-image.jpg" alt="Nuestra Visión" />
            <h2>Nuestra Visión</h2>
            <p>
                Ser un líder global en la creación de software especializado en energías renovables, impulsando la transición
                hacia un futuro más verde y sostenible mediante el uso de tecnología de vanguardia.
            </p>
        </section>
    
    </div>

    <!-- Footer -->
    <footer id="footer">
        <div class="footer-content">
            <div>
                <h4>EnerTech</h4>
                <p>Innovación en Energías Renovables</p>
            </div>
            <div>
                <h4>Contacto</h4>
                <p>Teléfono: +54 11 1234-5678</p>
                <p>Email: contacto@enertech.com</p>
            </div>
            <div>
                <h4>Dirección</h4>
                <p>Av. Siempre Viva 742, Buenos Aires, Argentina</p>
            </div>
        </div>
        &copy; 2024 EnerTech | Energías Renovables - Todos los derechos reservados.
    </footer>

</asp:Content>
