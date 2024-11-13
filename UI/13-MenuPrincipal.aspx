<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="13-MenuPrincipal.aspx.cs" Inherits="UI._13_MenuPrincipal" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Menú Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    
  <!-- Incluir el Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <!-- Contenido principal -->
    <div class="content">
        <h1>Menú Principal</h1>
        <p>Bienvenido al sistema de administración. Selecciona una de las opciones en la barra de navegación para gestionar el sistema.</p>
    </div>

    <!-- Información del usuario centrada -->
    <div class="user-info">
        <h2>Hola, <%: usuario.Email %> </h2>
       <div class="user-image">
            <asp:Image ID="imgUser" runat="server" Width="200px" Height="200px" />
        </div>
    </div>
</body>
</html>
