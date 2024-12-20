﻿<%@ Page Title="Productos" Language="C#" AutoEventWireup="true" CodeBehind="70-Productos.aspx.cs" Inherits="UI._70_Productos" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>
<%@ Register Src="~/GenericModal.ascx" TagPrefix="uc" TagName="GenericModal" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestión de Productos</title>
    <!-- Incluir Bootstrap 5 -->
 

    <style>
           body {
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f4f4;
    }

    .content {
        max-width: 1200px;
        margin: 60px auto;
        padding: 20px;
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .table thead th {
        background-color: #00695c; /* Color del encabezado */
        color: white;
        text-align: center;
    }

    .table tbody tr:nth-child(even) {
        background-color: #e0f7fa; /* Color de las filas pares */
    }

    .table tbody tr:nth-child(odd) {
        background-color: #ffffff; /* Color de las filas impares */
    }

    .table tbody tr:hover {
        background-color: #b2dfdb; /* Color al pasar el mouse */
    }

    .product-grid td img {
        width: 80px;
        height: auto;
        border-radius: 5px;
    }

    .btn-warning {
        background-color: #ffb74d;
        border-color: #ffb74d;
    }

    .btn-warning:hover {
        background-color: #ff9800;
        border-color: #ff9800;
    }

    .btn-danger {
        background-color: #e57373;
        border-color: #e57373;
    }

    .btn-danger:hover {
        background-color: #d32f2f;
        border-color: #d32f2f;
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
    </style>
    <script type="text/javascript">
        function toggleSelectAll(chkSelectAll) {
            var grid = document.getElementById('<%= gvProductos.ClientID %>');
            var checkBoxes = grid.getElementsByTagName('input');
            for (var i = 0; i < checkBoxes.length; i++) {
                if (checkBoxes[i].type === 'checkbox' && checkBoxes[i].id.indexOf('chkCatalogo') !== -1) {
                    checkBoxes[i].checked = chkSelectAll.checked;
                }
            }
        }
    </script>
</head>
        <!-- Incluir el Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />
<body>
    <form runat="server">
        <div class="content">
            <h2 class="text-center text-success mb-4">Gestión de Productos</h2>

            <!-- Barra de búsqueda -->
            <div class="search-container">
                <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control search-box" AutoPostBack="true" OnTextChanged="txtBuscar_TextChanged" placeholder="Buscar productos..." />
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-outline-success" />
            </div>

            <!-- Botones de acciones -->
            <div class="d-flex justify-content-end mb-4">
                <asp:Button ID="btnNuevoProducto" runat="server" Text="Agregar Nuevo Producto" CssClass="btn btn-primary me-2" OnClick="btnNuevoProducto_Click" />
                <asp:Button ID="btnPublicarCatalogo" runat="server" Text="Publicar Catálogo" CssClass="btn btn-success" OnClick="btnPublicarCatalogo_Click" />

            </div>

       <asp:GridView 
    ID="gvProductos" 
    runat="server" 
    AutoGenerateColumns="False" 
    CssClass="table table-bordered table-hover product-grid" 
    DataKeyNames="Codigo"
    RowStyle-CssClass="table-row"
    AlternatingRowStyle-CssClass="table-row-alternate"
    HeaderStyle-CssClass="table-header">

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
                <img src='<%# Eval("Imagen") != null && !string.IsNullOrEmpty(Eval("Imagen").ToString()) ? ResolveUrl(Eval("Imagen").ToString()) : ResolveUrl("~/Images/default.jpg") %>' alt="Imagen del Producto" />
            </ItemTemplate>
        </asp:TemplateField>

      
        <asp:BoundField DataField="Codigo" HeaderText="Código" />
        <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />

        
        <asp:TemplateField HeaderText="Opciones">
            <ItemTemplate>
                <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn btn-warning me-2"  CommandArgument='<%# Eval("Codigo") %>'    OnClick="btnModificarProducto_Click"/>
                <asp:Button ID="btnEliminar" runat="server" Text="Dar de Baja" CssClass="btn btn-danger" CommandName="Delete" CommandArgument='<%# Eval("Codigo") %>' OnClick="btnEliminarProducto_Click" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

        </div>

        <uc:GenericModal ID="genericModal" runat="server" />
    </form>

    <footer class="text-center py-4 bg-dark text-white">
        &copy; 2024 EnerTech | Energías Renovables - Todos los derechos reservados.
    </footer>
</body>
</html>
