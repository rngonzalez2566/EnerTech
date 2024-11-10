<%@ Page Title="Finalizar Compra" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="121-Compras.aspx.cs" Inherits="UI._121_Compras" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #f0f4f7;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
        }

        /* Estilos del carrito de compras */
        .cart-container {
            flex: 2;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 6px 20px rgba(0, 0, 0, 0.1);
        }

        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 24px;
            color: #00796b;
            margin-bottom: 20px;
        }

        .cart-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #ddd;
        }

        .cart-item-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
            margin-right: 20px;
        }

        .cart-item-details {
            flex-grow: 1;
        }

        .cart-item-name {
            font-weight: bold;
            color: #333;
        }

        .cart-item-price, .cart-item-total {
            font-size: 16px;
            color: #555;
        }

        .cart-item-total {
            font-weight: bold;
            color: #00796b;
        }

        .payment-container {
            flex: 1;
            background-color: #004d40;
            color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 6px 20px rgba(0, 0, 0, 0.1);
        }

        .payment-header {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .payment-group {
            margin-bottom: 20px;
        }

        .payment-group label {
            color: #c5e1a5;
        }

        .payment-group input, .payment-group select {
            background-color: #e0f2f1;
            border: none;
            border-radius: 8px;
            padding: 10px;
            margin-top: 5px;
        }

        .order-summary {
            border-top: 1px solid #c5e1a5;
            padding-top: 20px;
            margin-top: 20px;
        }

        .order-summary-item {
            display: flex;
            justify-content: space-between;
            font-size: 18px;
            margin-bottom: 10px;
        }

        .btn-checkout {
            background-color: #4caf50;
            color: white;
            padding: 15px;
            font-size: 18px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        .btn-checkout:hover {
            background-color: #388e3c;
        }

        a {
            color: #00796b;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>

    <!-- Contenedor principal -->
    <div class="main-container">
        <!-- Carrito de compras -->
        <div class="cart-container">
            <div class="cart-header">
                <span>Carrito de Compras</span>
                <span><a href="Catalogo.aspx">Continuar Comprando</a></span>
            </div>

            <asp:Repeater ID="rptCarrito" runat="server">
                <ItemTemplate>
                    <div class="cart-item">
                        <!-- Imagen del producto -->
                        <img src='<%# Eval("Producto.Imagen") != null && !string.IsNullOrEmpty(Eval("Producto.Imagen").ToString()) 
                                  ? ResolveUrl(Eval("Producto.Imagen").ToString()) 
                                  : ResolveUrl("~/Images/default.jpg") %>' 
                             alt="Imagen del Producto" class="cart-item-img" />

                        <!-- Información del producto -->
                        <div class="cart-item-details">
                            <div class="cart-item-name"><%# Eval("Producto.Descripcion") %></div>
                            <div class="cart-item-price">Precio unitario: $<%# Eval("Producto.Precio", "{0:N2}") %></div>
                            <div class="cart-item-quantity">Cantidad: <%# Eval("Cantidad") %></div>
                            <div class="cart-item-total">Total: $<%# String.Format("{0:N2}", Convert.ToDecimal(Eval("Producto.Precio")) * Convert.ToDecimal(Eval("Cantidad"))) %></div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Detalles de pago -->
        <div class="payment-container">
            <div class="payment-header">Detalles de Pago</div>
            <div class="payment-group">
                <label for="cardType">Tipo de Tarjeta</label>
                <asp:DropDownList ID="ddlCardType" runat="server" CssClass="form-control">
                    <asp:ListItem Value="Visa">Visa</asp:ListItem>
                    <asp:ListItem Value="MasterCard">MasterCard</asp:ListItem>
                    <asp:ListItem Value="Amex">Amex</asp:ListItem>
                    <asp:ListItem Value="PayPal">PayPal</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="payment-group">
                <label>Nombre en la Tarjeta</label>
                <asp:TextBox ID="txtCardName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="payment-group">
                <label>Número de la Tarjeta</label>
                <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" MaxLength="16" TextMode="Number"></asp:TextBox>
            </div>
            <div class="payment-group">
                <label>Fecha de Expiración</label>
                <asp:TextBox ID="txtExpDate" runat="server" CssClass="form-control" Placeholder="MM/YY"></asp:TextBox>
            </div>
            <div class="payment-group">
                <label>CVV</label>
                <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" MaxLength="3" TextMode="Number"></asp:TextBox>
            </div>
            <div class="order-summary">
                <div class="order-summary-item"><span>Total (Incl. impuestos)</span> <span>$<asp:Label ID="lblTotal" runat="server" Text="0.00" /></span></div>
            </div>
            <asp:Button ID="btnCheckout" runat="server" Text="Finalizar Compra" CssClass="btn-checkout" OnClick="btnCheckout_Click" />
        </div>
    </div>
</asp:Content>
