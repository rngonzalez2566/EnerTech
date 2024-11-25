<%@ Page Title="Alta de Producto" Language="C#" AutoEventWireup="true" CodeBehind="71-AltaProducto.aspx.cs" Inherits="UI._71_AltaProducto" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Alta de Producto</title>
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
<body>
    <!-- Incluir el Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <form runat="server">
        <div class="content">
            <h2 class="text-center text-success mb-4">Alta de Producto</h2>

            <!-- Volver a Productos -->
            <div class="mb-4">
                <a href="70-Productos.aspx" class="btn btn-outline-secondary">Volver a Productos</a>
            </div>

            <!-- Formulario de Alta de Producto en dos columnas -->
            <asp:Panel ID="PanelAltaProducto" runat="server">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="txtCodigo" class="form-label">Código del Producto</label>
                        <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control" placeholder="Ingrese el código" />
                        <asp:RequiredFieldValidator ID="rfvCodigo" runat="server" ControlToValidate="txtCodigo" ErrorMessage="El código es obligatorio" CssClass="error-message" Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="txtDescripcion" class="form-label">Descripción</label>
                        <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" placeholder="Ingrese la descripción" />
                        <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" ControlToValidate="txtDescripcion" ErrorMessage="La descripción es obligatoria" CssClass="error-message" Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="ddlCategoria" class="form-label">Categoría</label>
                        <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select" />
                        <asp:RequiredFieldValidator ID="rfvCategoria" runat="server" ControlToValidate="ddlCategoria" InitialValue="" ErrorMessage="Debe seleccionar una categoría" CssClass="error-message" Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="ddlMarca" class="form-label">Marca</label>
                        <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-select" />
                        <asp:RequiredFieldValidator ID="rfvMarca" runat="server" ControlToValidate="ddlMarca" InitialValue="" ErrorMessage="Debe seleccionar una marca" CssClass="error-message" Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="ddlIVA" class="form-label">IVA</label>
                        <asp:DropDownList ID="ddlIVA" runat="server" CssClass="form-select" />
                        <asp:RequiredFieldValidator ID="rfvIVA" runat="server" ControlToValidate="ddlIVA" InitialValue="" ErrorMessage="Debe seleccionar el IVA" CssClass="error-message" Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="txtCantidad" class="form-label">Cantidad</label>
                        <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ingrese la cantidad" />
                        <asp:RequiredFieldValidator ID="rfvCantidad" runat="server" ControlToValidate="txtCantidad" ErrorMessage="La cantidad es obligatoria" CssClass="error-message" Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="txtPrecio" class="form-label">Precio</label>
                        <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ingrese el precio" />
                        <asp:RequiredFieldValidator ID="rfvPrecio" runat="server" ControlToValidate="txtPrecio" ErrorMessage="El precio es obligatorio" CssClass="error-message" Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="fuImagen" class="form-label">Imagen del Producto (opcional)</label>
                        <asp:FileUpload ID="fuImagen" runat="server" CssClass="form-control" />
                    </div>
                </div>

                <!-- Botón para guardar -->
                <div class="d-grid gap-2">
                    <asp:Button ID="btnGuardarProducto" runat="server" Text="Guardar Producto" CssClass="btn btn-primary" OnClick="btnGuardarProducto_Click" />
                </div>
            </asp:Panel>

            <!-- Mensaje de error -->
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-3"></asp:Label>
        </div>
    </form>

    <footer class="text-center mt-5 py-4 bg-dark text-white">
        &copy; 2024 EnerTech | Energías Renovables - Todos los derechos reservados.
    </footer>
</body>
</html>
