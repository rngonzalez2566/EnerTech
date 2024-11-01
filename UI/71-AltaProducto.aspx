<%@ Page Title="Alta de Producto" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="71-AltaProducto.aspx.cs" Inherits="UI._71_AltaProducto" %>

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
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-size: 18px;
            color: #333;
            display: block;
            margin-bottom: 5px;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .btn-container {
            text-align: right;
        }

        .btn {
            background-color: #00796b;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn:hover {
            background-color: #004d40;
        }

    </style>

    <nav>
        <a href="Home.aspx">Inicio</a>
        <a href="70-Productos.aspx">Volver a Productos</a>
    </nav>

    <div class="content">
        <h1>Alta de Producto</h1>

      
             <asp:Panel ID="PanelAltaProducto" runat="server">
            <div class="form-group">
                <label for="txtCodigo">Código del Producto:</label>
                <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCodigo" runat="server" ControlToValidate="txtCodigo" ErrorMessage="El código es obligatorio" CssClass="error-message" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label for="txtDescripcion">Descripción:</label>
                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" ControlToValidate="txtDescripcion" ErrorMessage="La descripción es obligatoria" CssClass="error-message" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label for="ddlCategoria">Categoría:</label>
                <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCategoria" runat="server" ControlToValidate="ddlCategoria" InitialValue="" ErrorMessage="Debe seleccionar una categoría" CssClass="error-message" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label for="ddlMarca">Marca:</label>
                <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvMarca" runat="server" ControlToValidate="ddlMarca" InitialValue="" ErrorMessage="Debe seleccionar una marca" CssClass="error-message" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label for="ddlIVA">IVA:</label>
                <asp:DropDownList ID="ddlIVA" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlIVA" InitialValue="" ErrorMessage="Debe seleccionar el IVA" CssClass="error-message" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label for="txtCantidad">Cantidad:</label>
                <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCantidad" runat="server" ControlToValidate="txtCantidad" ErrorMessage="La cantidad es obligatoria" CssClass="error-message" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label for="txtPrecio">Precio:</label>
                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPrecio" ErrorMessage="El precio es obligatorio" CssClass="error-message" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label for="fuImagen">Imagen del Producto (opcional):</label>
                <asp:FileUpload ID="fuImagen" runat="server" CssClass="form-control" />
            </div>

            <div class="btn-container">
                <asp:Button ID="btnGuardarProducto" runat="server" Text="Guardar Producto" CssClass="btn" OnClick="btnGuardarProducto_Click" />
            </div>
        </asp:Panel>
         <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>
    </div>

</asp:Content>
