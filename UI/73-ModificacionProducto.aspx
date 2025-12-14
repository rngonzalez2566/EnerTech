<%@ Page Title="Modificación de Producto" Language="C#" AutoEventWireup="true" CodeBehind="73-ModificacionProducto.aspx.cs" Inherits="UI._73_ModificacionProducto" %>

<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>
<%@ Register Src="~/controls/ValidarModificacionProducto.ascx" TagPrefix="uc" TagName="ValidarModificacionProducto" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Modificación de Producto</title>
    <!-- Bootstrap 5 -->

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

        .form-control, .form-select {
            border-radius: 5px;
        }

        .btn-primary {
            background-color: #00796b;
            border-color: #00796b;
        }

            .btn-primary:hover {
                background-color: #004d40;
                border-color: #004d40;
            }

        .error-message {
            color: #d9534f;
            font-size: 14px;
        }
    </style>
</head>
<!-- Incluir el Navbar -->
<uc:Navbar ID="navigationBar" runat="server" />
<body>


    <form runat="server">
        <div class="content">
            <h2 class="text-center text-success mb-4" runat="server" data-translate="modify_product_title">Modificación de Producto
            </h2>

            <!-- Volver a Productos -->
            <div class="mb-4">
                <a id="lnkBackToProducts"
                    runat="server"
                    href="70-Productos.aspx"
                    class="btn btn-outline-secondary"
                    data-translate="back_to_products">Volver a Productos
                </a>
            </div>

            <div class="row">
                <uc:ValidarModificacionProducto ID="ValidarModificacionProductoControl" runat="server" />
            </div>

            <div class="d-grid gap-2">
                <asp:Button ID="btnGuardarCambios"
                    runat="server"
                    CssClass="btn btn-primary"
                    Text="Guardar Cambios"
                    data-translate="save_changes_button"
                    ValidationGroup="ModificacionProducto"
                    OnClick="btnGuardarCambios_Click" />
            </div>


            <!-- Mensaje de error -->
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-3"></asp:Label>
        </div>
    </form>

    <footer class="text-center mt-5 py-4 bg-dark text-white">
        &copy; 2024 EnerTech | Energías Renovables - Todos los derechos reservados.
    </footer>
</body>
</html>
