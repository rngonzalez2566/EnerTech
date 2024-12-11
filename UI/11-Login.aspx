<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="11-Login.aspx.cs" Inherits="UI._11_Login" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <title>Iniciar Sesión - EnerTech</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            height: 100vh;
            background: linear-gradient(45deg, #00796b, #00c4a7);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 8px 30px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .login-container:hover {
            transform: translateY(-5px);
        }
        .login-container h2 {
            color: #00796b;
            margin-bottom: 30px;
        }
        .form-control {
            background-color: #f8f9fa;
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
        }
        .form-control:focus {
            box-shadow: 0 4px 12px rgba(0, 121, 107, 0.2);
        }
        .btn-primary {
            background-color: #00796b;
            border-color: #00796b;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .btn-primary:hover {
            background-color: #005f56;
            transform: translateY(-3px);
        }
        .register-link {
            color: #00796b;
        }
        .register-link:hover {
            color: #005f56;
            text-decoration: underline;
        }
        .logo {
            width: 80px;
            height: 80px;
            margin-bottom: 20px;
        }
        footer {
            position: absolute;
            bottom: 20px;
            width: 100%;
            text-align: center;
            color: #ffffff;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="d-flex flex-column align-items-center justify-content-center vh-100">
            <div class="login-container">
    <!-- Logotipo -->
    <img src="Images/logo.png" alt="Logo EnerTech" class="logo">
    
    <h2>Iniciar Sesión</h2>
    
    <!-- Campos del formulario -->
    <div class="mb-3">
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Email" TextMode="Email"></asp:TextBox>
    </div>
    <div class="mb-3">
        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" Placeholder="Contraseña" TextMode="Password"></asp:TextBox>
    </div>
    
    <!-- Botón de inicio de sesión -->
    <asp:Button ID="btnLogin" runat="server" Text="Iniciar Sesión" CssClass="btn btn-primary w-100 mb-3" OnClick="btnLogin_Click" />
    
    <!-- Mensaje de error -->
    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="d-block mb-3"></asp:Label>
    
    <!-- Enlaces adicionales -->
    <div class="d-flex flex-column align-items-center">
        <a href="12-RestablecerPassword.aspx" class="register-link mb-2">¿Olvidaste tu contraseña?</a>
        <a href="21-AltaUsuario.aspx" class="register-link">¿No tienes cuenta? Regístrate</a>
    </div>
</div>

        </div>
    </form>
    
    <footer>
        &copy; 2024 EnerTech | Energías Renovables
    </footer>

    <!-- Scripts de Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
