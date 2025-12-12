<%@ Page Title="Alta de Producto" Language="C#" AutoEventWireup="true" CodeBehind="71-AltaProducto.aspx.cs" Inherits="UI._71_AltaProducto" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Alta de Producto</title>
    <!-- Bootstrap 5 -->
    <!-- <link ...> si lo estás usando en el master o layout -->

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
    <!-- Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <form runat="server">
        <div class="content">
            <!-- Título -->
            <h2 id="titleAltaProducto"
                runat="server"
                class="text-center text-success mb-4"
                data-translate="product_create_title">
                Alta de Producto
            </h2>

            <!-- Volver a Productos -->
            <div class="mb-4">
                <a id="lnkBackToProducts"
                   runat="server"
                   href="70-Productos.aspx"
                   class="btn btn-outline-secondary"
                   data-translate="back_to_products">
                    Volver a Productos
                </a>
            </div>

            <!-- Formulario de Alta de Producto -->
            <asp:Panel ID="PanelAltaProducto" runat="server">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label id="lblCodigo"
                               runat="server"
                               for="txtCodigo"
                               class="form-label"
                               data-translate="product_code_label">
                            Código del Producto
                        </label>
                        <asp:TextBox ID="txtCodigo"
                                     runat="server"
                                     CssClass="form-control"
                                     placeholder="Ingrese el código"
                                     data-translate="product_code_placeholder" />
                        <asp:RequiredFieldValidator ID="rfvCodigo" runat="server"
                            ControlToValidate="txtCodigo"
                            ErrorMessage="El código es obligatorio"
                            CssClass="error-message"
                            Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label id="lblDescripcion"
                               runat="server"
                               for="txtDescripcion"
                               class="form-label"
                               data-translate="description_label">
                            Descripción
                        </label>
                        <asp:TextBox ID="txtDescripcion"
                                     runat="server"
                                     CssClass="form-control"
                                     placeholder="Ingrese la descripción"
                                     data-translate="description_placeholder" />
                        <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server"
                            ControlToValidate="txtDescripcion"
                            ErrorMessage="La descripción es obligatoria"
                            CssClass="error-message"
                            Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label id="lblCategoria"
                               runat="server"
                               for="ddlCategoria"
                               class="form-label"
                               data-translate="category_label">
                            Categoría
                        </label>
                        <asp:DropDownList ID="ddlCategoria"
                                          runat="server"
                                          CssClass="form-select" />
                        <asp:RequiredFieldValidator ID="rfvCategoria" runat="server"
                            ControlToValidate="ddlCategoria"
                            InitialValue=""
                            ErrorMessage="Debe seleccionar una categoría"
                            CssClass="error-message"
                            Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label id="lblMarca"
                               runat="server"
                               for="ddlMarca"
                               class="form-label"
                               data-translate="brand_label">
                            Marca
                        </label>
                        <asp:DropDownList ID="ddlMarca"
                                          runat="server"
                                          CssClass="form-select" />
                        <asp:RequiredFieldValidator ID="rfvMarca" runat="server"
                            ControlToValidate="ddlMarca"
                            InitialValue=""
                            ErrorMessage="Debe seleccionar una marca"
                            CssClass="error-message"
                            Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label id="lblIVA"
                               runat="server"
                               for="ddlIVA"
                               class="form-label"
                               data-translate="iva_label">
                            IVA
                        </label>
                        <asp:DropDownList ID="ddlIVA"
                                          runat="server"
                                          CssClass="form-select" />
                        <asp:RequiredFieldValidator ID="rfvIVA" runat="server"
                            ControlToValidate="ddlIVA"
                            InitialValue=""
                            ErrorMessage="Debe seleccionar el IVA"
                            CssClass="error-message"
                            Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label id="lblCantidad"
                               runat="server"
                               for="txtCantidad"
                               class="form-label"
                               data-translate="quantity_label">
                            Cantidad
                        </label>
                        <asp:TextBox ID="txtCantidad"
                                     runat="server"
                                     CssClass="form-control"
                                     TextMode="Number"
                                     placeholder="Ingrese la cantidad"
                                     data-translate="quantity_placeholder" />
                        <asp:RequiredFieldValidator ID="rfvCantidad" runat="server"
                            ControlToValidate="txtCantidad"
                            ErrorMessage="La cantidad es obligatoria"
                            CssClass="error-message"
                            Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label id="lblPrecio"
                               runat="server"
                               for="txtPrecio"
                               class="form-label"
                               data-translate="price_label">
                            Precio
                        </label>
                        <asp:TextBox ID="txtPrecio"
                                     runat="server"
                                     CssClass="form-control"
                                     TextMode="Number"
                                     placeholder="Ingrese el precio"
                                     data-translate="price_placeholder" />
                        <asp:RequiredFieldValidator ID="rfvPrecio" runat="server"
                            ControlToValidate="txtPrecio"
                            ErrorMessage="El precio es obligatorio"
                            CssClass="error-message"
                            Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label id="lblImagen"
                               runat="server"
                               for="fuImagen"
                               class="form-label"
                               data-translate="image_label">
                            Imagen del Producto (opcional)
                        </label>
                        <asp:FileUpload ID="fuImagen"
                                        runat="server"
                                        CssClass="form-control" />
                    </div>
                </div>

                <!-- Botón para guardar -->
                <div class="d-grid gap-2">
                    <asp:Button ID="btnGuardarProducto"
                                runat="server"
                                Text="Guardar Producto"
                                CssClass="btn btn-primary"
                                data-translate="save_product_button"
                                OnClick="btnGuardarProducto_Click" />
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
