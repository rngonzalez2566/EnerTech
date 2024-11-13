<%@ Page Title="Modificación de Producto" Language="C#" AutoEventWireup="true" CodeBehind="73-ModificacionProducto.aspx.cs" Inherits="UI._73_ModificacionProducto" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Modificación de Producto</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
            <h2 class="text-center text-success mb-4">Modificación de Producto</h2>

            <!-- Volver a Productos -->
            <div class="mb-4">
                <a href="70-Productos.aspx" class="btn btn-outline-secondary">Volver a Productos</a>
            </div>

            <!-- Formulario de Modificación de Producto en dos columnas -->
            <asp:Panel ID="PanelModificacionProducto" runat="server">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="txtCodigo" class="form-label">Código del Producto</label>
                        <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control" ReadOnly="True" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="txtDescripcion" class="form-label">Descripción</label>
                        <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" placeholder="Ingrese la descripción" />
                        <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" ControlToValidate="txtDescripcion" ErrorMessage="La descripción es obligatoria" CssClass="error-message" Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="ddlCategoria" class="form-label">Categoría</label>
                        <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="ddlMarca" class="form-label">Marca</label>
                        <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-select" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="ddlIVA" class="form-label">IVA</label>
                        <asp:DropDownList ID="ddlIVA" runat="server" CssClass="form-select" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="txtCantidad" class="form-label">Cantidad</label>
                        <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ingrese la cantidad" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="txtPrecio" class="form-label">Precio</label>
                        <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ingrese el precio" />
                    </div>

                    <!-- Agregar el control para la imagen aquí -->
                    <div class="col-md-6 mb-3">
                        <label for="fuImagen" class="form-label">Imagen del Producto (opcional)</label>
                        <asp:FileUpload ID="fuImagen" runat="server" CssClass="form-control" />
                    </div>

                    <!-- Mostrar la imagen actual si existe -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Imagen Actual</label>
                        <asp:Image ID="imgProducto" runat="server" CssClass="img-thumbnail" Visible="false" Width="200px" />
                    </div>
                </div>

                <!-- Botón para guardar cambios -->
                <div class="d-grid gap-2">
                    <asp:Button ID="btnGuardarCambios" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary" OnClick="btnGuardarCambios_Click" />
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
