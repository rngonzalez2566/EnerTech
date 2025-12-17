<%@ Page Title="Modificar Usuario" Language="C#" AutoEventWireup="true"
    CodeBehind="22-ModificacionUsuario.aspx.cs" Inherits="UI._22_ModificacionUsuario" %>

<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Modificar Usuario</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
        }

        .content {
            max-width: 900px;
            margin: 80px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .form-control, .form-select { border-radius: 5px; }

        .btn-primary { background-color: #00796b; border-color: #00796b; }
        .btn-primary:hover { background-color: #004d40; border-color: #004d40; }

        .error-message { color: #d9534f; font-size: 14px; }

        /* ✅ Labels más “suaves” */
        .label-title {
            font-weight: 600;
            font-size: 0.85rem;
            color: #6c757d;
            margin-bottom: 6px;
        }
    </style>
</head>
<body>
    <uc:Navbar ID="navigationBar" runat="server" />

    <form id="form1" runat="server">
        <div class="content">

            <h2 id="titleEditarUsuario"
                runat="server"
                class="text-center text-success mb-4"
                data-translate="user_edit_title">
                Modificar Usuario
            </h2>

            <div class="mb-4">
                <a id="lnkBackToUsers"
                   runat="server"
                   href="13-MenuPrincipal.aspx"
                   class="btn btn-outline-secondary"
                   data-translate="back_to_users">
                    Volver a Usuarios
                </a>
            </div>

            <asp:HiddenField ID="hfIdUsuario" runat="server" />

            <div class="row g-3">

                <div class="col-md-6">
                    <label id="lblEmail" runat="server" class="form-label label-title" data-translate="user_email">
                        Email
                    </label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail" CssClass="error-message"
                        ErrorMessage="Email requerido" ValidationGroup="EditarUsuario" />
                </div>

                <div class="col-md-6">
                    <label id="lblIdentificacion" runat="server" class="form-label label-title" data-translate="user_identification">
                        Identificación
                    </label>
                    <asp:TextBox ID="txtIdentificacion" runat="server" CssClass="form-control" TextMode="Number" />
                    <asp:RequiredFieldValidator ID="rfvIdent" runat="server"
                        ControlToValidate="txtIdentificacion" CssClass="error-message"
                        ErrorMessage="Identificación requerida" ValidationGroup="EditarUsuario" />
                </div>

                <div class="col-md-6">
                    <label id="lblNombre" runat="server" class="form-label label-title" data-translate="user_name">
                        Nombre
                    </label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                        ControlToValidate="txtNombre" CssClass="error-message"
                        ErrorMessage="Nombre requerido" ValidationGroup="EditarUsuario" />
                </div>

                <div class="col-md-6">
                    <label id="lblApellido" runat="server" class="form-label label-title" data-translate="user_lastname">
                        Apellido
                    </label>
                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvApellido" runat="server"
                        ControlToValidate="txtApellido" CssClass="error-message"
                        ErrorMessage="Apellido requerido" ValidationGroup="EditarUsuario" />
                </div>

                <div class="col-md-12">
                    <label id="lblRazon" runat="server" class="form-label label-title" data-translate="user_business_name">
                        Razón Social
                    </label>
                    <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-6">
                    <label id="lblTipoDoc" runat="server" class="form-label label-title" data-translate="user_document_type">
                        Tipo de documento
                    </label>
                    <asp:DropDownList ID="ddlTipoDocumento" runat="server" CssClass="form-select">
                        <asp:ListItem Text="DNI" Value="DNI" />
                        <asp:ListItem Text="CUIT" Value="CUIT" />
                        <asp:ListItem Text="CUIL" Value="CUIL" />
                        <asp:ListItem Text="Pasaporte" Value="PAS" />
                    </asp:DropDownList>
                </div>

                <div class="col-md-6">
                    <label id="lblTipoCliente" runat="server" class="form-label label-title" data-translate="user_customer_type">
                        Tipo de cliente
                    </label>
                    <asp:DropDownList ID="ddlTipoCliente" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Consumidor Final" Value="Consumidor Final" />
                        <asp:ListItem Text="Empresa" Value="Empresa" />
                    </asp:DropDownList>
                </div>

                <div class="col-md-6">
                    <label id="lblEstado" runat="server" class="form-label label-title" data-translate="user_status">
                        Estado
                    </label>
                    <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Activo" Value="Activo" />
                        <asp:ListItem Text="Inactivo" Value="Inactivo" />
                        <asp:ListItem Text="Bloqueado" Value="Bloqueado" />
                    </asp:DropDownList>
                </div>

            </div>

            <div class="d-grid gap-2 mt-4">
              <asp:Button ID="btnGuardarCambios" runat="server"
    Text="Guardar cambios"
    CssClass="btn btn-primary"
    OnClick="btnGuardarCambios_Click"
    ValidationGroup="EditarUsuario"
    CausesValidation="true" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-3"></asp:Label>

        </div>
    </form>

    <footer class="text-center mt-5 py-4 bg-dark text-white">
        &copy; 2024 EnerTech | Energías Renovables - Todos los derechos reservados.
    </footer>
</body>
</html>
