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

                <h2 runat="server" data-translate="login_title">Iniciar Sesión</h2>

                <!-- Campos del formulario -->
                <div class="mb-3">
                    <asp:TextBox ID="txtEmail"
                                 runat="server"
                                 CssClass="form-control"
                                 TextMode="Email"
                                 data-translate-placeholder="login_email_placeholder" />
                </div>

                <div class="mb-3">
                    <asp:TextBox ID="txtPassword"
                                 runat="server"
                                 CssClass="form-control"
                                 TextMode="Password"
                                 data-translate-placeholder="login_password_placeholder" />
                </div>

                <!-- Botón de inicio de sesión -->
                <asp:Button ID="btnLogin"
                            runat="server"
                            CssClass="btn btn-primary w-100 mb-3"
                            Text="Iniciar Sesión"
                            data-translate="login_button"
                            OnClick="btnLogin_Click" />

                <!-- Mensaje de error -->
                <asp:Label ID="lblMessage"
                           runat="server"
                           ForeColor="Red"
                           CssClass="d-block mb-3"
                           Visible="false"></asp:Label>

                <!-- Enlaces adicionales (se les agrega lang desde code-behind) -->
                <div class="d-flex flex-column align-items-center">
                    <a id="lnkReset" runat="server" class="register-link mb-2" data-translate="forgot_password_link">
                        ¿Olvidaste tu contraseña?
                    </a>
                    <a id="lnkRegister" runat="server" class="register-link" data-translate="no_account_register_link">
                        ¿No tienes cuenta? Regístrate
                    </a>
                </div>

            </div>
        </div>
    </form>

    <footer runat="server" data-translate="login_footer">
        &copy; 2024 EnerTech | Energías Renovables
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
