<%@ Page Title="Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="70-Productos.aspx.cs" Inherits="UI._70_Productos" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
        }

        /* Barra de navegación */
        nav {
            background-color: #00796b;
            color: white;
            padding: 20px;
            text-align: center;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }

            nav a {
                color: white;
                text-decoration: none;
                margin: 0 15px;
                font-size: 18px;
                transition: color 0.3s;
            }

                nav a:hover {
                    color: #aed581;
                }

        /* Contenedor principal */
        .content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 100px 20px;
            background-color: white;
        }

        /* Estilos para la grilla */
        .product-grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

            .product-grid th, .product-grid td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: center;
            }

            .product-grid th {
                background-color: #00796b;
                color: white;
            }

            .product-grid td img {
                width: 80px;
                height: auto;
                border-radius: 5px;
            }

        /* Botones */
        .btn-container {
            text-align: right;
            margin-bottom: 20px;
        }

        .btn {
            background-color: #00796b;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            margin-left: 10px;
        }

            .btn:hover {
                background-color: #004d40;
            }

        /* Caja de búsqueda */
        .search-container {
            text-align: right;
            margin-bottom: 20px;
        }

        .search-box {
            padding: 10px;
            font-size: 16px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
    </style>
    <script type="text/javascript">
        function toggleSelectAll(chkSelectAll) {
            var grid = document.getElementById('<%= gvProductos.ClientID %>');
            var checkBoxes = grid.getElementsByTagName('input');

            for (var i = 0; i < checkBoxes.length; i++) {
                if (checkBoxes[i].type == 'checkbox' && checkBoxes[i].id.indexOf('chkCatalogo') != -1) {
                    checkBoxes[i].checked = chkSelectAll.checked;
                }
            }
        }
</script>

  <uc:Navbar ID="navigationBar" runat="server" />

    <div class="content">

        <h1>Gestión de Productos</h1>


        <div class="search-container">
            <asp:TextBox ID="txtBuscar" runat="server" CssClass="search-box"
                AutoPostBack="true" OnTextChanged="txtBuscar_TextChanged"
                placeholder="Buscar productos..."></asp:TextBox>
        </div>


        <div class="btn-container">
            <asp:Button ID="btnNuevoProducto" runat="server" Text="Agregar Nuevo Producto" CssClass="btn" OnClick="btnNuevoProducto_Click" />
        </div>
        <asp:Label runat="server" Text="Label" ID="lblMessage" Visible="False"></asp:Label>
         <div class="btn-container">
            <asp:Button ID="btnPublicarCatalogo" runat="server" Text="Publicar Catálogo" CssClass="btn" OnClick="btnPublicarCatalogo_Click" />
        </div>

        <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False" CssClass="product-grid" DataKeyNames="Codigo">
            <Columns>

                <asp:TemplateField HeaderText="Catálogo">
    <HeaderTemplate>
        <asp:CheckBox ID="chkSelectAll" runat="server" onclick="toggleSelectAll(this);" />
    </HeaderTemplate>
    <ItemTemplate>
        <asp:CheckBox ID="chkCatalogo" runat="server" Checked='<%# Eval("Catalogo") != null && Convert.ToBoolean(Eval("Catalogo")) %>' />
    </ItemTemplate>
</asp:TemplateField>

                <asp:TemplateField HeaderText="Imagen">
                    <ItemTemplate>
                         <img src='<%# Eval("Imagen") != null && !string.IsNullOrEmpty(Eval("Imagen").ToString()) ? ResolveUrl(Eval("Imagen").ToString()) : ResolveUrl("~/Images/default.jpg") %>' 
             alt="Imagen del Producto" style="width:80px; height:auto;" />
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:BoundField DataField="Codigo" HeaderText="Código" />


                <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />

               <asp:TemplateField HeaderText="Categoría">
    <ItemTemplate>
        <%# Eval("Categoria.Nombre") %>
    </ItemTemplate>
</asp:TemplateField>


               <asp:TemplateField HeaderText="Marca">
    <ItemTemplate>
        <%# Eval("Marca.Nombre") %>
    </ItemTemplate>
</asp:TemplateField>


                <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />


                <asp:TemplateField HeaderText="Opciones">
                    <ItemTemplate>

                        <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn" CommandName="Edit" CommandArgument='<%# Eval("Codigo") %>' />


                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn" CommandName="Delete" CommandArgument='<%# Eval("Codigo") %>' OnClick="btnEliminarProducto_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <footer>
        &copy; 2024 EnerTech | Energías Renovables - Todos los derechos reservados.
    </footer>

</asp:Content>
