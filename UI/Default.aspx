<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UI._Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home - EnerTech</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7fa;
        }

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

        html { scroll-behavior: smooth; }

        .animated-header {
            height: 60vh;
            background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.7)),
                        url('Images/banner-renewable-energy.jpg') no-repeat center center;
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

        @keyframes typing { from { width: 0; } to { width: 100%; } }
        @keyframes blink-caret { from, to { border-color: transparent; } 50% { border-color: #ffffff; } }
        @keyframes fadeIn { 0% { opacity: 0; } 100% { opacity: 1; } }

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

        /* ✅ Estilo de botón activo de idioma (solo visual) */
        .lang-btn.active {
            background-color: #c5e1a5 !important;
            border-color: #c5e1a5 !important;
            color: #004d40 !important;
            font-weight: 700;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow">
            <div class="container">
                <a class="navbar-brand" href="#" runat="server" data-translate="brand_name">EnerTech</a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-center" id="navbarNav"></div>

                <div class="d-flex align-items-center gap-2">
                    <a id="btnLangEs" href="Default.aspx?lang=es" class="btn btn-outline-light btn-sm lang-btn">ES</a>
                    <a id="btnLangEn" href="Default.aspx?lang=en" class="btn btn-outline-light btn-sm lang-btn">EN</a>

                    <a id="lnkLogin" href="11-Login.aspx"
                       class="btn btn-outline-light btn-login ms-2"
                       runat="server"
                       data-translate="home_login">
                        Iniciar Sesión
                    </a>
                </div>
            </div>
        </nav>

        <!-- Header -->
        <header class="animated-header">
            <div class="overlay d-flex flex-column justify-content-center align-items-center">
                <h1 class="animated-text">
                    <span runat="server" data-translate="home_welcome_prefix">Bienvenido a</span>
                    <span class="highlight" runat="server" data-translate="brand_name">EnerTech</span>
                </h1>
                <p class="subtext" runat="server" data-translate="home_subtitle">Innovación en Energías Renovables</p>
            </div>
        </header>

        <!-- Main Content -->
        <div class="container py-5">
            <div class="row g-4">
                <div class="col-md-6 col-lg-4">
                    <div class="card shadow-sm border-0 h-100">
                        <img src="Images/team-image.jpg" class="card-img-top" alt="Quiénes Somos" />
                        <div class="card-body text-center">
                            <h2 class="card-title text-success" runat="server" data-translate="home_about_title">Quiénes Somos</h2>
                            <p class="card-text" runat="server" data-translate="home_about_text">
                                Somos una empresa tecnológica comprometida con el desarrollo de soluciones innovadoras para la industria de energías renovables.
                                Con un equipo multidisciplinario, trabajamos para ofrecer software que potencia la eficiencia y sostenibilidad en cada proyecto.
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-4">
                    <div class="card shadow-sm border-0 h-100">
                        <img src="Images/mission-image.jpg" class="card-img-top" alt="Nuestra Misión" />
                        <div class="card-body text-center">
                            <h2 class="card-title text-success" runat="server" data-translate="home_mission_title">Nuestra Misión</h2>
                            <p class="card-text" runat="server" data-translate="home_mission_text">
                                En EnerTech, nuestra misión es desarrollar soluciones tecnológicas innovadoras enfocadas en el sector de energías renovables,
                                mejorando la eficiencia energética global a través de tecnología avanzada.
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-md-12 col-lg-4">
                    <div class="card shadow-sm border-0 h-100">
                        <img src="Images/vision-image.jpg" class="card-img-top" alt="Nuestra Visión" />
                        <div class="card-body text-center">
                            <h2 class="card-title text-success" runat="server" data-translate="home_vision_title">Nuestra Visión</h2>
                            <p class="card-text" runat="server" data-translate="home_vision_text">
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
                    <h4 runat="server" data-translate="brand_name">EnerTech</h4>
                    <p runat="server" data-translate="home_footer_tagline">Innovación en Energías Renovables</p>
                </div>
                <div>
                    <h4 runat="server" data-translate="home_footer_contact_title">Contacto</h4>
                    <p runat="server" data-translate="home_footer_phone">Teléfono: +54 11 1234-5678</p>
                    <p runat="server" data-translate="home_footer_email">Email: contacto@enertech.com</p>
                </div>
                <div>
                    <h4 runat="server" data-translate="home_footer_address_title">Dirección</h4>
                    <p runat="server" data-translate="home_footer_address">Av. Laprida 742, Buenos Aires, Argentina</p>
                </div>
            </div>

            <div class="text-center mt-4" runat="server" data-translate="home_footer_copyright">
                &copy; 2024 EnerTech | Energías Renovables - Todos los derechos reservados.
            </div>
        </footer>

        <script>
            (function () {
                const params = new URLSearchParams(window.location.search);
                const lang = params.get("lang") || "es";

                // ✅ resaltar botón activo
                const btnEs = document.getElementById("btnLangEs");
                const btnEn = document.getElementById("btnLangEn");
                if (lang === "en") { btnEn?.classList.add("active"); }
                else { btnEs?.classList.add("active"); }

                // ✅ Propagar lang al Login (este link es server control, pero el href se mantiene)
                const login = document.getElementById("lnkLogin");
                if (login) {
                    const url = new URL(login.getAttribute("href"), window.location.origin);
                    url.searchParams.set("lang", lang);
                    login.setAttribute("href", url.pathname + url.search);
                }

                // ✅ Propagar a otros links internos .aspx
                document.querySelectorAll("a[href$='.aspx']").forEach(a => {
                    const href = a.getAttribute("href");
                    if (!href) return;
                    if (href.startsWith("http") || href.startsWith("#")) return;

                    const u = new URL(href, window.location.origin);
                    if (!u.searchParams.get("lang")) {
                        u.searchParams.set("lang", lang);
                        a.setAttribute("href", u.pathname + u.search);
                    }
                });
            })();
        </script>

    </form>
</body>
</html>
