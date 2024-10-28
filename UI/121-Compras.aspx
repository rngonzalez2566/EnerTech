<%@ Page Title="Finalizar Compra" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="121-Compras.aspx.cs" Inherits="UI._121_Compras" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        /* Contenedor principal de la página */
        .main-container {
            display: flex;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            gap: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Sección de lista de productos en el carrito */
        .cart-container {
            flex: 2;
            background-color: #f8f8f8;
            padding: 20px;
            border-radius: 8px;
        }

        .cart-header {
            font-size: 18px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

    .cart-item {
    display: flex;
    align-items: center;
    padding: 15px 0;
    border-bottom: 1px solid #ddd;
    gap: 20px;
}

.cart-item-img-container {
    width: 80px;
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.cart-item-img {
    width: 100%;
    height: auto;
    border-radius: 5px;
    object-fit: cover;
}

.cart-item-details {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.cart-item-name {
    font-weight: bold;
    font-size: 16px;
    color: #333;
}

.cart-item-quantity, .cart-item-price, .cart-item-total {
    font-size: 14px;
    color: #666;
}

.cart-item-total {
    font-weight: bold;
    color: #333;
    margin-top: 5px;
}

        /* Sección de detalles de pago */
        .payment-container {
            flex: 1;
            background-color: #004d40;
            color: white;
            padding: 20px;
            border-radius: 8px;
        }

        .payment-header {
            font-size: 18px;
            margin-bottom: 20px;
        }

        .payment-group {
            margin-bottom: 15px;
        }

        .payment-group label {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
            color: #ddd;
        }

        .payment-group input {
            width: 100%;
            padding: 8px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            margin-bottom: 10px;
        }

        .order-summary {
            border-top: 1px solid #ddd;
            padding-top: 10px;
            margin-top: 15px;
        }

        .order-summary-item {
            display: flex;
            justify-content: space-between;
            font-size: 16px;
        }

        .btn-checkout {
            background-color: #00796b;
            color: white;
            padding: 15px;
            font-size: 16px;
            text-align: center;
            border: none;
            width: 100%;
            border-radius: 5px;
            margin-top: 15px;
            cursor: pointer;
        }

        .btn-checkout:hover {
            background-color: #005b4f;
        }
    </style>

    <div class="main-container">
    
      <div class="cart-container">
    <div class="cart-header">
        <span>Carrito de Compras</span>
        <span><a href="Catalogo.aspx">Continuar Comprando</a></span>
    </div>
    
    <asp:Repeater ID="rptCarrito" runat="server">
        <ItemTemplate>
            <div class="cart-item">
                <!-- Imagen del producto -->
                <div class="cart-item-img-container">
                    <img src='<%# Eval("Producto.Imagen") != null && !string.IsNullOrEmpty(Eval("Producto.Imagen").ToString()) 
                              ? ResolveUrl(Eval("Producto.Imagen").ToString()) 
                              : ResolveUrl("~/Images/default.jpg") %>' 
                         alt="Imagen del Producto" class="cart-item-img" />
                </div>

                <!-- Información del producto -->
                <div class="cart-item-details">
                    <div class="cart-item-name"><%# Eval("Producto.Descripcion") %></div>
                    <div class="cart-item-quantity">Cantidad: <%# Eval("Cantidad") %></div>
                    <div class="cart-item-price">Precio unitario: $<%# Eval("Producto.Precio", "{0:N2}") %></div>
                    <div class="cart-item-total">Total: $<%# String.Format("{0:N2}", Convert.ToDecimal(Eval("Producto.Precio")) * Convert.ToDecimal(Eval("Cantidad"))) %></div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>

      
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
                <label for="cardName">Nombre en la Tarjeta</label>
                <asp:TextBox ID="txtCardName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

         
            <div class="payment-group">
                <label for="cardNumber">Número de la Tarjeta</label>
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
