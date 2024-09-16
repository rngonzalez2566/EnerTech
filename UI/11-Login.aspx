<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="11-Login.aspx.cs" Inherits="UI._11_Login" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Iniciar Sesión - Software Factory</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #00796b, #48a999);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.2);
            width: 350px;
            text-align: center;
        }

        .login-container h2 {
            color: #00796b;
            font-size: 24px;
            margin-bottom: 20px;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .login-container input[type="submit"] {
            background-color: #00796b;
            color: white;
            padding: 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        .login-container input[type="submit"]:hover {
            background-color: #005f56;
        }

        .register-link {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: #00796b;
            font-size: 14px;
        }

        .register-link:hover {
            text-decoration: underline;
        }

        .login-container img {
            width: 100px;
            margin-bottom: 20px;
        }

        footer {
            position: absolute;
            bottom: 10px;
            width: 100%;
            text-align: center;
            font-size: 12px;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <!-- Incluir el logotipo de la empresa -->
            <img src="Images/logo.png" alt="Logo Software Factory" />
            <h2>Bienvenido</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" Placeholder="Email" TextMode="Email"></asp:TextBox><br />
            <asp:TextBox ID="txtPassword" runat="server" Placeholder="Contraseña" TextMode="Password"></asp:TextBox><br />
            <asp:Button ID="btnLogin" runat="server" Text="Iniciar Sesión" OnClick="btnLogin_Click" />
            <a href="21-AltaUsuario.aspx" class="register-link">¿No tienes cuenta? Regístrate</a>
        </div>
    </form>
    <footer>
        &copy; 2024 EnerTech | Energías Renovables
    </footer>
</body>
</html>
