<%@ Page Title="Catálogo de Productos" Language="C#" AutoEventWireup="true" CodeBehind="90-Catalogo.aspx.cs" Inherits="UI._90_Catalogo" %>

<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Catálogo de Productos</title>
    <!-- Bootstrap 5 CDN -->


    <style>
        body {
            background-color: #f0f4f7;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .main-container { max-width: 1200px; margin: 40px auto; padding: 20px; }
        .filters-container { display: flex; justify-content: space-between; gap: 20px; padding: 20px; background-color: #ffffff; border-radius: 10px; }
        .catalog-container { display: flex; flex-wrap: wrap; gap: 20px; justify-content: center; }
        .product-card { background-color: #ffffff; border-radius: 15px; box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1); padding: 20px; text-align: center; width: calc(25% - 20px); }
        .product-card img { max-width: 100%; height: 150px; object-fit: cover; border-radius: 10px; }
        .btn-add-cart { background-color: #ff9800 !important; color: white !important; border-radius: 10px; padding: 10px 20px; }
        .no-stock { color: gray; font-weight: bold; }
    </style>
</head>
<body>
    <!-- Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />

        <div class="main-container">
            <!-- Filtros -->
            <div class="filters-container">
                <h3>Filtrar Productos</h3>
                <div>
                    <label>Marca:</label>
                    <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="AplicarFiltros"></asp:DropDownList>
                </div>
                <div>
                    <label>Categoría:</label>
                    <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="AplicarFiltros"></asp:DropDownList>
                </div>
                <div class="d-flex align-items-center">
                    <label class="me-2">Precio Mín:</label>
                    <asp:TextBox ID="txtPrecioMin" runat="server" CssClass="form-control me-2" TextMode="Number" />
                    <label class="me-2">Precio Máx:</label>
                    <asp:TextBox ID="txtPrecioMax" runat="server" CssClass="form-control me-2" TextMode="Number" />
                    <asp:Button ID="btnAplicarFiltroPrecio" runat="server" CssClass="btn btn-success" Text="Aplicar" OnClick="AplicarFiltros" />
                </div>
            </div>

            <!-- Catálogo con UpdatePanel -->
            <asp:UpdatePanel ID="UpdatePanelCatalogo" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="catalog-container">
                        <asp:Repeater ID="rptCatalogo" runat="server">
                            <ItemTemplate>
                                <div class="product-card">
                                    <img src='<%# Eval("Imagen") != null && !string.IsNullOrEmpty(Eval("Imagen").ToString()) ? ResolveUrl(Eval("Imagen").ToString()) : ResolveUrl("~/Images/default.jpg") %>' alt="Imagen del Producto" />
                                    <h3><%# Eval("Descripcion") %></h3>
                                    <p>Precio: <%# String.Format(new System.Globalization.CultureInfo("es-AR"), "{0:C}", Eval("Precio")) %></p>
                                    <asp:Button 
                                        ID="btnAgregarCarrito"
                                        runat="server"
                                        Text="Agregar al Carrito"
                                        CommandArgument='<%# Eval("id_producto") %>'
                                        OnClick="btnAgregarCarrito_Click"
                                        CssClass="btn-add-cart"
                                        Visible='<%# Convert.ToInt32(Eval("Cantidad")) > 0 %>' />
                                    <asp:Label ID="lblSinStock" runat="server" Text="Sin stock" CssClass="no-stock" Visible='<%# Convert.ToInt32(Eval("Cantidad")) <= 0 %>' />
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <!-- Toast Notification -->
        <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11;">
            <div id="cartToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="2000">
                <div class="d-flex">
                    <div class="toast-body">
                        ¡Producto agregado al carrito con éxito!
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>
    </form>

    <script>
        function showCartToast() {
            var toastElement = document.getElementById('cartToast');
            var toast = new bootstrap.Toast(toastElement);
            toast.show();
        }
    </script>
</body>
</html>
