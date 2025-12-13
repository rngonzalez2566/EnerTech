<%@ Page Title="Registro de Usuario" Language="C#" AutoEventWireup="true" CodeBehind="21-AltaUsuario.aspx.cs" Inherits="UI._21_AltaUsuario" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registro de Usuario</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #004d40;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        .register-container {
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 6px 20px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .register-container h2 {
            color: #00796b;
            margin-bottom: 30px;
            font-weight: bold;
        }

        .form-control {
            border-radius: 10px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #00796b;
            box-shadow: 0 0 5px rgba(0, 121, 107, 0.5);
        }

        .btn-register {
            background-color: #00796b;
            color: white;
            border-radius: 10px;
            padding: 12px;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        .btn-register:hover {
            background-color: #005f56;
        }

        .form-select {
            border-radius: 10px;
            margin-bottom: 15px;
        }

        .error-label {
            color: red;
            font-size: 14px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="register-container">
            <asp:Label ID="lblError" runat="server" CssClass="error-label" Visible="false"></asp:Label>

            <h2 runat="server" data-translate="register_title">Registro de Usuario</h2>

            <asp:TextBox ID="txtEmail" runat="server"
                CssClass="form-control"
                Placeholder="Email"
                TextMode="Email"
                data-translate="register_email_placeholder"
                OnTextChanged="txtEmail_TextChanged" />

            <asp:TextBox ID="txtPassword" runat="server"
                CssClass="form-control"
                Placeholder="Contraseña"
                TextMode="Password"
                data-translate="register_password_placeholder" />

            <asp:TextBox ID="txtRazonSocial" runat="server"
                CssClass="form-control"
                Placeholder="Razón Social"
                data-translate="register_business_name_placeholder" />

            <asp:TextBox ID="txtIdentificacion" runat="server"
                CssClass="form-control"
                Placeholder="Identificación"
                data-translate="register_identification_placeholder" />

            <asp:TextBox ID="txtNombre" runat="server"
                CssClass="form-control"
                Placeholder="Nombre"
                data-translate="register_firstname_placeholder" />

            <asp:TextBox ID="txtApellido" runat="server"
                CssClass="form-control"
                Placeholder="Apellido"
                data-translate="register_lastname_placeholder" />

            <asp:DropDownList ID="ddlTipoDocumento" runat="server" CssClass="form-select">
                <asp:ListItem Value="DNI">DNI</asp:ListItem>
                <asp:ListItem Value="CUIT">CUIT</asp:ListItem>
                <asp:ListItem Value="Pasaporte">Pasaporte</asp:ListItem>
            </asp:DropDownList>

            <asp:DropDownList ID="ddlTipoCliente" runat="server" CssClass="form-select">
                <asp:ListItem Value="Consumidor Final">Consumidor Final</asp:ListItem>
                <asp:ListItem Value="Responsable Inscripto">Responsable Inscripto</asp:ListItem>
            </asp:DropDownList>

            <asp:Button ID="btnRegister" runat="server"
                CssClass="btn btn-register"
                Text="Registrarse"
                data-translate="register_button"
                OnClick="btnRegister_Click" />
        </div>
    </form>
</body>
</html>
