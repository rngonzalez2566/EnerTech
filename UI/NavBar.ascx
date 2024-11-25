<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavBar.ascx.cs" Inherits="UI.NavBar" %>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Página Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f0f4f7;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            margin-top: 20px;
        }

         .navbar {
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .navbar-brand {
        font-weight: bold;
        font-size: 24px;
        color: #c5e1a5 !important;
    }

    .navbar-nav .nav-link {
        color: white !important;
        font-size: 18px;
        transition: color 0.3s ease;
    }

    .navbar-nav .nav-link:hover {
        color: #aed581 !important;
    }

    .profile-icon img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        transition: transform 0.2s ease;
    }

    .profile-icon img:hover {
        transform: scale(1.1);
    }

    .dropdown-menu {
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .dropdown-menu .dropdown-item:hover {
        background-color: #e0f2f1;
        color: #00796b !important;
    }

    .btn-logout {
        background-color: #e57373;
        color: white;
        transition: background-color 0.3s ease;
    }

    .btn-logout:hover {
        background-color: #d32f2f;
        color: white;
    }
 .badge {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0.4rem;
    font-size: 0.85rem;
    min-width: 24px;
    min-height: 24px;
    border-radius: 50%;
    line-height: 1;
}

.nav-item .badge {
    background-color: #ffc107; /* Amarillo */
    color: #212529; /* Texto oscuro para contraste */
}

.nav-item .badge::after {
    content: attr(data-count);
    position: relative;
}

    </style>
</head
      <!-- Navbar personalizado -->
<div id="navigationBar" runat="server">
</div>

<body>


   <%-- <div class="container">
        <h1 class="text-center mt-5">Bienvenido a EnerTech</h1>
        <p class="text-center">Seleccione una opción del menú para comenzar.</p>
    </div>--%>

    <!-- Bootstrap JS para los dropdowns -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
