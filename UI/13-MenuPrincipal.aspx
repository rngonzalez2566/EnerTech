<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="13-MenuPrincipal.aspx.cs" Inherits="UI._13_MenuPrincipal" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Menú Principal</title>
    
    <style>
        body {
            background: url('https://source.unsplash.com/1600x900/?technology,energy') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            color: white;
            overflow: auto; /* Permitir interacción con la página */
        }

        .content {
            text-align: center;
            margin-top: 20%;
        }

        h1 {
            font-size: 3rem;
            font-weight: bold;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
        }

        p {
            font-size: 1.2rem;
        }

        .user-email {
            font-size: 1.5rem;
            color: #00bfa5;
            margin-top: 20px;
        }

        @keyframes float {
            0% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0); }
        }

        .floating {
            animation: float 3s ease-in-out infinite;
        }
    </style>
</head>
<body>
    <!-- Incluir el Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <!-- Contenido principal centrado -->
    <div class="container content">
          <h1 id="h1Bienvenido" runat="server" class="floating" data-translate="h1_mp">¡Bienvenido a EnerTech!</h1>
        <p id="pExploraOpciones" runat="server" data-translate="p_mp">Explora las opciones en el menú de navegación para gestionar el sistema.</p>
        <asp:Label ID="lblUsuarioEmail" runat="server" data-translate="lblUsuarioEmail"></asp:Label>
    </div>
</body>
</html>
