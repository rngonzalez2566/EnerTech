<%@ Page Title="Catálogo de Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="90-Catalogo.aspx.cs" Inherits="UI._90_Catalogo" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #f0f4f7;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Contenedor principal */
        .main-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }

        /* Filtros horizontales */
        .filters-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            animation: fadeIn 0.5s ease-in-out;
        }

        .filters-container h3 {
            color: #00796b;
            font-size: 20px;
        }

        .filter-group select,
        .filter-group input {
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .btn-filter {
            background-color: #00796b;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
        }

        .btn-filter:hover {
            background-color: #005f56;
        }

        /* Catálogo */
        .catalog-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .product-card {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            width: calc(25% - 20px);
            transition: transform 0.3s ease;
            animation: fadeIn 0.5s ease-in-out;
        }

        .product-card:hover {
            transform: translateY(-10px);
        }

        .product-card img {
            max-width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
        }

        .product-card h3 {
            color: #00796b;
            font-size: 18px;
            margin: 15px 0;
        }

        .product-card p {
            color: #666;
            font-size: 16px;
        }

        /* Botón de "Agregar al Carrito" */
        .btn-add-cart {
            background-color: #ff9800 !important;
            color: white !important;
            border: none;
            border-radius: 10px;
            padding: 10px 20px;
            transition: background-color 0.3s ease;
            cursor: pointer;
            display: block;
            margin: 10px auto 0;
        }

        .btn-add-cart:hover {
            background-color: #e65100 !important;
        }

        .no-stock {
            color: gray;
            font-weight: bold;
            margin-top: 10px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>

    <!-- Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <div class="main-container">
        <!-- Filtros horizontales -->
        <div class="filters-container">
            <h3>Filtrar Productos</h3>
            <div class="filter-group">
                <label for="ddlMarca">Marca:</label>
                <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="AplicarFiltros">
                    <asp:ListItem Text="Todas las Marcas" Value="" />
                </asp:DropDownList>
            </div>
            <div class="filter-group">
                <label for="ddlCategoria">Categoría:</label>
                <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="AplicarFiltros">
                    <asp:ListItem Text="Todas las Categorías" Value="" />
                </asp:DropDownList>
            </div>
            <div class="filter-group d-flex align-items-center">
                <label for="txtPrecioMin" class="me-2">Precio Mín:</label>
                <asp:TextBox ID="txtPrecioMin" runat="server" CssClass="form-control" TextMode="Number" />
                <label for="txtPrecioMax" class="mx-2">Precio Máx:</label>
                <asp:TextBox ID="txtPrecioMax" runat="server" CssClass="form-control" TextMode="Number" />
                <asp:Button ID="btnAplicarFiltroPrecio" runat="server" CssClass="btn btn-filter ms-2" Text="Aplicar" OnClick="AplicarFiltros" />
            </div>
        </div>

        <!-- Catálogo de Productos -->
        <div class="catalog-container">
            <asp:Repeater ID="rptCatalogo" runat="server">
                <ItemTemplate>
                    <div class="product-card">
                        <img src='<%# Eval("Imagen") != null && !string.IsNullOrEmpty(Eval("Imagen").ToString()) ? ResolveUrl(Eval("Imagen").ToString()) : ResolveUrl("~/Images/default.jpg") %>' 
                             alt="Imagen del Producto" />
                        <h3><%# Eval("Descripcion") %></h3>
                        <p>Precio: <%# String.Format(new System.Globalization.CultureInfo("es-AR"), "{0:C}", Eval("Precio")) %></p>

                        <asp:Button ID="btnAgregarCarrito" runat="server" Text="Agregar al Carrito" 
                                    CommandArgument='<%# Eval("Id") %>' OnClick="btnAgregarCarrito_Click" CssClass="btn-add-cart" 
                                    Visible='<%# Convert.ToInt32(Eval("Cantidad")) > 0 %>' />

                        <asp:Label ID="lblSinStock" runat="server" Text="Sin stock" CssClass="no-stock"
                                   Visible='<%# Convert.ToInt32(Eval("Cantidad")) <= 0 %>' />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
