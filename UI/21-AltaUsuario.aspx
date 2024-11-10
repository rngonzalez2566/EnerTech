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
            background-color: #004d40; /* Cambiado a un verde oscuro */
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

        /* Animación de botones */
        .btn-register {
            transform: translateY(0);
            animation: buttonHover 0.3s ease-in-out;
        }

        @keyframes buttonHover {
            from { transform: translateY(-3px); }
            to { transform: translateY(0); }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="register-container">
            <!-- Mensaje de error -->
            <asp:Label ID="lblError" runat="server" CssClass="error-label" Visible="false"></asp:Label>
            
            <!-- Encabezado -->
            <h2>Registro de Usuario</h2>
            
            <!-- Email -->
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Email" TextMode="Email" OnTextChanged="txtEmail_TextChanged"></asp:TextBox>
            
            <!-- Contraseña -->
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" Placeholder="Contraseña" TextMode="Password"></asp:TextBox>
            
            <!-- Razón Social -->
            <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="form-control" Placeholder="Razón Social"></asp:TextBox>
            
            <!-- Identificación -->
            <asp:TextBox ID="txtIdentificacion" runat="server" CssClass="form-control" Placeholder="Identificación"></asp:TextBox>
            
            <!-- Nombre -->
            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Placeholder="Nombre"></asp:TextBox>
            
            <!-- Apellido -->
            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" Placeholder="Apellido"></asp:TextBox>
            
            <!-- Tipo de Documento -->
            <asp:DropDownList ID="ddlTipoDocumento" runat="server" CssClass="form-select">
                <asp:ListItem Value="DNI">DNI</asp:ListItem>
                <asp:ListItem Value="CUIT">CUIT</asp:ListItem>
                <asp:ListItem Value="Pasaporte">Pasaporte</asp:ListItem>
            </asp:DropDownList>
            
            <!-- Tipo Cliente -->
            <asp:DropDownList ID="ddlTipoCliente" runat="server" CssClass="form-select">
                <asp:ListItem Value="Consumidor Final">Consumidor Final</asp:ListItem>
                <asp:ListItem Value="Responsable Inscripto">Responsable Inscripto</asp:ListItem>
            </asp:DropDownList>
            
            <!-- Botón de Registro -->
            <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-register" Text="Registrarse" OnClick="btnRegister_Click" />
        </div>
    </form>
</body>
</html>
