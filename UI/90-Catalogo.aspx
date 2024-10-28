<%@ Page Title="Catálogo de Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="90-Catalogo.aspx.cs" Inherits="UI._90_Catalogo" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* Contenedor principal dividido en dos columnas */
        .main-container {
            display: flex;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            gap: 20px;
        }

        /* Estilos para la sección de filtros */
        .filters-container {
            width: 250px;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            background-color: #f9f9f9;
        }

        .filters-container h3 {
            font-size: 18px;
            color: #333;
            margin-bottom: 15px;
        }

        .filter-group {
            margin-bottom: 20px;
        }

        .filter-group label {
            display: block;
            font-size: 14px;
            color: #555;
            margin-bottom: 5px;
        }

        .filter-group select, .filter-group input {
            width: 100%;
            padding: 8px;
            font-size: 14px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        /* Estilos de las tarjetas de producto */
        .catalog-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            flex-grow: 1;
        }

        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            width: calc(25% - 20px); /* Ajuste para mostrar 4 tarjetas por fila */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }

        .product-card img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }

        .product-card h3 {
            font-size: 16px;
            margin: 10px 0;
            color: #333;
        }

        .product-card p {
            font-size: 14px;
            color: #666;
            margin: 5px 0;
        }

         .btn {
        background-color: #00796b; /* Verde */
        color: white;
        border: none;
        padding: 10px 15px;
        font-size: 14px;
        cursor: pointer;
        border-radius: 5px;
        margin-top: 10px;
        display: inline-block;
    }

    .btn:hover {
        background-color: #004d40; /* Verde más oscuro para efecto hover */
    }
    </style>

    <div class="main-container">
        
     
        <div class="filters-container">
            <h3>Filtrar Productos</h3>

         
            <div class="filter-group">
                <label for="ddlMarca">Marca:</label>
                <asp:DropDownList ID="ddlMarca" runat="server" AutoPostBack="true" OnSelectedIndexChanged="AplicarFiltros">
                    <asp:ListItem Text="Todas las Marcas" Value="" />
                </asp:DropDownList>
            </div>

            <div class="filter-group">
                <label for="ddlCategoria">Categoría:</label>
                <asp:DropDownList ID="ddlCategoria" runat="server" AutoPostBack="true" OnSelectedIndexChanged="AplicarFiltros">
                    <asp:ListItem Text="Todas las Categorías" Value="" />
                </asp:DropDownList>
            </div>

        
            <div class="filter-group">
                <label for="txtPrecioMin">Precio Mínimo:</label>
                <asp:TextBox ID="txtPrecioMin" runat="server" TextMode="Number" />
                <label for="txtPrecioMax">Precio Máximo:</label>
                <asp:TextBox ID="txtPrecioMax" runat="server" TextMode="Number" />
                <asp:Button ID="btnAplicarFiltroPrecio" runat="server" Text="Aplicar" CssClass="btn" OnClick="AplicarFiltros" />
            </div>
        </div>

      
        <div class="catalog-container">
            <asp:Repeater ID="rptCatalogo" runat="server">
                <ItemTemplate>
                    <div class="product-card">
                                  <img src='<%# Eval("Imagen") != null && !string.IsNullOrEmpty(Eval("Imagen").ToString()) ? ResolveUrl(Eval("Imagen").ToString()) : ResolveUrl("~/Images/default.jpg") %>' 
alt="Imagen del Producto" style="width:80px; height:auto;" />
                        <h3><%# Eval("Descripcion") %></h3>
                       <p>Precio: <%# String.Format(new System.Globalization.CultureInfo("es-AR"), "{0:C}", Eval("Precio")) %></p>
                        
          <asp:Button ID="btnAgregarCarrito" runat="server" Text="Agregar al Carrito" 
            CommandArgument='<%# Eval("Id") %>' OnClick="btnAgregarCarrito_Click" CssClass="btn" 
                        Visible='<%# Convert.ToInt32(Eval("Cantidad")) > 0 %>' />

            <!-- Texto "Sin stock" cuando no hay disponibilidad -->
            <asp:Label ID="lblSinStock" runat="server" Text="Sin stock" 
                       Style="color: gray; font-weight: bold;" 
                       Visible='<%# Convert.ToInt32(Eval("Cantidad")) <= 0 %>' />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

</asp:Content>
