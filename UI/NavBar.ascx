<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavBar.ascx.cs" Inherits="UI.NavBar" %>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Página Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
    </style>
</head>
<body>

  <!-- Navbar personalizado -->
<div id="navigationBar" runat="server">
</div>

   <%-- <div class="container">
        <h1 class="text-center mt-5">Bienvenido a EnerTech</h1>
        <p class="text-center">Seleccione una opción del menú para comenzar.</p>
    </div>--%>

    <!-- Bootstrap JS para los dropdowns -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
