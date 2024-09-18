<%@ Page Title="Registro de Usuario" Language="C#" AutoEventWireup="true" CodeBehind="21-AltaUsuario.aspx.cs" Inherits="UI._21_AltaUsuario" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registro de Usuario</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
        }

        /* Formulario de registro */
        .register-container {
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            width: 400px;
            margin: 80px auto;
            text-align: center;
        }

        .register-container h2 {
            color: #00796b;
            font-size: 28px;
            margin-bottom: 20px;
        }

        .register-container input[type="text"],
        .register-container input[type="password"],
        .register-container select {
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .register-container input[type="submit"] {
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

        .register-container input[type="submit"]:hover {
            background-color: #005f56;
        }

        .register-container select {
            font-size: 14px;
            padding: 10px;
        }
    </style>
</head>
<body>
    <div class="register-container"><asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false" CssClass="error-label"></asp:Label>
        <h2>Registro de Usuario</h2>
        <!-- Formulario de registro -->
        <form id="form1" runat="server">
            <!-- Email -->
            <asp:TextBox ID="txtEmail" runat="server" Placeholder="Email" TextMode="Email" OnTextChanged="txtEmail_TextChanged"></asp:TextBox><br />
            
            <!-- Password -->
            <asp:TextBox ID="txtPassword" runat="server" Placeholder="Contraseña" TextMode="Password"></asp:TextBox><br />
            
            <!-- Razon Social -->
            <asp:TextBox ID="txtRazonSocial" runat="server" Placeholder="Razón Social"></asp:TextBox><br />
            
            <!-- Identificacion -->
            <asp:TextBox ID="txtIdentificacion" runat="server" Placeholder="Identificación"></asp:TextBox><br />

            <!-- Nombre -->
            <asp:TextBox ID="txtNombre" runat="server" Placeholder="Nombre"></asp:TextBox><br />

            <!-- Apellido -->
            <asp:TextBox ID="txtApellido" runat="server" Placeholder="Apellido"></asp:TextBox><br />

            <!-- Tipo de Documento -->
            <asp:DropDownList ID="ddlTipoDocumento" runat="server">
                <asp:ListItem Value="DNI">DNI</asp:ListItem>
                <asp:ListItem Value="CUIT">CUIT</asp:ListItem>
                <asp:ListItem Value="Pasaporte">Pasaporte</asp:ListItem>
            </asp:DropDownList><br />

            <!-- Tipo Cliente -->
            <asp:DropDownList ID="ddlTipoCliente" runat="server">
                <asp:ListItem Value="Consumidor Final">Consumidor Final</asp:ListItem>
                <asp:ListItem Value="Responsable Inscripto">Responsable Inscripto</asp:ListItem>
            </asp:DropDownList><br />

            <!-- Botón de Registro -->
            <asp:Button ID="btnRegister" runat="server" Text="Registrarse" OnClick="btnRegister_Click" />
        </form>
    </div>
</body>
</html>
