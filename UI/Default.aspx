<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="UI._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7fa;
        }

        /* Navbar */
       .navbar {
    background-color: #00796b;
    padding: 1rem;
    transition: all 0.3s ease-in-out;
}

.navbar-brand {
    font-weight: bold;
    font-size: 24px;
    color: #c5e1a5 !important;
}

.navbar-nav .nav-link {
    color: #ffffff !important;
    transition: color 0.3s ease-in-out;
    font-size: 18px;
}

.navbar-nav .nav-link:hover {
    color: #aed581 !important;
    border-bottom: 2px solid #aed581;
}

.btn-login {
    border: 2px solid #c5e1a5;
    color: #c5e1a5 !important;
    border-radius: 30px;
    transition: all 0.3s ease-in-out;
}

.btn-login:hover {
    background-color: #c5e1a5;
    color: #00796b !important;
}

/* Efecto de scroll suave */
html {
    scroll-behavior: smooth;
}

        /* Header */
        header {
            position: relative;
            height: 60vh;
            background: url('Images/banner-renewable-energy.jpg') no-repeat center center/cover;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
            padding: 20px;
        }

            header h1 {
                font-size: 48px;
                font-weight: bold;
                text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.7);
            }

            header p {
                font-size: 24px;
                text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.7);
            }

        /* Content Sections */
        .content {
            padding: 60px 20px;
            background-color: #ffffff;
        }

        .section-card {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            overflow: hidden;
        }

            .section-card img {
                height: 200px;
                object-fit: cover;
            }

            .section-card h2 {
                color: #00796b;
                font-size: 28px;
                margin-top: 20px;
            }

            .section-card p {
                font-size: 16px;
                line-height: 1.6;
            }

        .card:hover {
            transform: translateY(-10px);
            transition: all 0.3s ease-in-out;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .card-text {
            font-size: 1rem;
            color: #555;
            line-height: 1.6;
        }

        /* Footer */
        footer {
            background-color: #004d40;
            color: white;
            padding: 40px 0;
        }

        .footer-content {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: space-around;
        }

            .footer-content div {
                flex: 1;
                min-width: 250px;
            }

        footer h4 {
            margin-bottom: 15px;
        }

        footer p {
            margin: 0;
        }

        /* Estilos del encabezado animado */
        .animated-header {
            height: 60vh;
            background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.7)), url('Images/banner-renewable-energy.jpg') no-repeat center center/cover;
            position: relative;
            overflow: hidden;
        }

        .overlay {
            height: 100%;
            width: 100%;
            position: absolute;
            top: 0;
            left: 0;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .animated-text {
            font-size: 48px;
            font-weight: bold;
            color: #ffffff;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.7);
            animation: typing 3s steps(22, end), blink-caret 0.75s step-end infinite;
            white-space: nowrap;
            overflow: hidden;
            border-right: 3px solid #ffffff;
        }

        .highlight {
            color: #c5e1a5;
            animation: fadeIn 3s ease-in-out infinite alternate;
        }

        .subtext {
            font-size: 24px;
            margin-top: 10px;
            color: #c5e1a5;
            opacity: 0;
            animation: fadeIn 2s forwards;
            animation-delay: 1.5s;
        }

        /* Animaciones */
        @keyframes typing {
            from {
                width: 0;
            }

            to {
                width: 100%;
            }
        }

        @keyframes blink-caret {
            from, to {
                border-color: transparent;
            }

            50% {
                border-color: #ffffff;
            }
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }


    </style>
  
   <!-- Navbar Moderno -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow">
    <div class="container">
        <!-- Logotipo de la empresa -->
        <a class="navbar-brand" href="#">EnerTech</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
        
        </div>
        <!-- Botón de Iniciar Sesión -->
        <a href="11-Login.aspx" class="btn btn-outline-light btn-login ms-3">Iniciar Sesión</a>
    </div>
</nav>

    <!-- Header -->
    <header class="animated-header">
        <div class="overlay d-flex flex-column justify-content-center align-items-center">
            <h1 class="animated-text">Bienvenido a <span class="highlight">EnerTech</span></h1>
            <p class="subtext">Innovación en Energías Renovables</p>
        </div>
    </header>

    <!-- Main Content -->
    <div class="container py-5">
        <div class="row g-4">
            <!-- Sección "Quiénes Somos" -->
            <div class="col-md-6 col-lg-4">
                <div class="card shadow-sm border-0 h-100">
                    <img src="Images/team-image.jpg" class="card-img-top" alt="Quiénes Somos">
                    <div class="card-body text-center">
                        <h2 class="card-title text-success">Quiénes Somos</h2>
                        <p class="card-text">
                            Somos una empresa tecnológica comprometida con el desarrollo de soluciones innovadoras para la industria de energías renovables.
                        Con un equipo multidisciplinario, trabajamos para ofrecer software que potencia la eficiencia y sostenibilidad en cada proyecto.
                   
                        </p>
                    </div>
                </div>
            </div>

            <!-- Sección "Nuestra Misión" -->
            <div class="col-md-6 col-lg-4">
                <div class="card shadow-sm border-0 h-100">
                    <img src="Images/mission-image.jpg" class="card-img-top" alt="Nuestra Misión">
                    <div class="card-body text-center">
                        <h2 class="card-title text-success">Nuestra Misión</h2>
                        <p class="card-text">
                            En EnerTech, nuestra misión es desarrollar soluciones tecnológicas innovadoras enfocadas en el sector de energías renovables,
                        mejorando la eficiencia energética global a través de tecnología avanzada.
                   
                        </p>
                    </div>
                </div>
            </div>

            <!-- Sección "Nuestra Visión" -->
            <div class="col-md-12 col-lg-4">
                <div class="card shadow-sm border-0 h-100">
                    <img src="Images/vision-image.jpg" class="card-img-top" alt="Nuestra Visión">
                    <div class="card-body text-center">
                        <h2 class="card-title text-success">Nuestra Visión</h2>
                        <p class="card-text">
                            Ser un líder global en la creación de software especializado en energías renovables, impulsando la transición hacia un futuro más verde y sostenible.
                   
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-content container">
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
        <div class="text-center mt-4">
            &copy; 2024 EnerTech | Energías Renovables - Todos los derechos reservados.
        </div>
    </footer>
        <script>
            document.querySelectorAll('.scroll-link').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const targetId = this.getAttribute('href');
                    const targetElement = document.querySelector(targetId);
                    if (targetElement) {
                        targetElement.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                });
            });
</script>
</asp:Content>


