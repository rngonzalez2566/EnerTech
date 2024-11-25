<%@ Page Title="Carrito de Compras" Language="C#" AutoEventWireup="true" CodeBehind="120-Carrito.aspx.cs" Inherits="UI._120_Carrito" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Carrito de Compras</title>
 
    <style>
        .cart-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .cart-header {
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
        }
        .cart-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #ddd;
        }
        .cart-item img {
            width: 60px;
            height: auto;
            border-radius: 5px;
            margin-right: 15px;
        }
        .cart-item-info {
            flex: 1;
        }
        .cart-item-name {
            font-weight: bold;
            font-size: 16px;
        }
        .cart-item-price {
            font-weight: bold;
            color: #333;
        }
        .cart-quantity {
            display: flex;
            align-items: center;
        }
        .quantity-input {
            width: 40px;
            text-align: center;
            margin: 0 10px;
            font-size: 16px;
        }
        .btn-remove {
            color: #ff6b6b;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-remove:hover {
            color: #ff5252;
        }
        .cart-summary {
            margin-top: 20px;
            text-align: right;
            font-size: 18px;
            font-weight: bold;
        }
        .btn-checkout {
            background-color: #00796b;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            text-align: center;
            border: none;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }
        .btn-checkout:hover {
            background-color: #004d40;
        }
    </style>
</head>
<body>
       <!-- Incluir el Navbar -->
      <uc:Navbar ID="navigationBar" runat="server" />
    <form id="form1" runat="server">
     
     

        <div class="cart-container">
            <h1 class="cart-header">Carrito de Compras</h1>
            
            <!-- Repeater para mostrar los productos en el carrito -->
            <asp:Repeater ID="rptCarrito" runat="server">
                <ItemTemplate>
                    <div class="cart-item">
                        <img src='<%# Eval("Producto.Imagen") != null && !string.IsNullOrEmpty(Eval("Producto.Imagen").ToString()) ? ResolveUrl(Eval("Producto.Imagen").ToString()) : ResolveUrl("~/Images/default.jpg") %>' alt="Imagen del Producto" style="width:80px; height:auto;" />
                        
                        <div class="cart-item-info">
                            <div class="cart-item-name"><%# Eval("Producto.Descripcion") %></div>
                            <span class="cart-item-price">$ <%# String.Format(new System.Globalization.CultureInfo("es-AR"), "{0:C}", Eval("Producto.Precio")) %></span>
                        </div>

                        <div class="cart-quantity">
                            <asp:Button ID="btnDecrease" runat="server" Text="-" CommandArgument='<%# Eval("Producto.Id") %>' OnClick="btnDecrease_Click" />
                            <asp:TextBox ID="txtCantidad" runat="server" CssClass="quantity-input" Text='<%# Eval("Cantidad") %>' Enabled="false" />
                            <asp:Button ID="btnIncrease" runat="server" Text="+" CommandArgument='<%# Eval("Producto.Id") %>' OnClick="btnIncrease_Click" />
                        </div>

                        <asp:LinkButton ID="btnRemove" runat="server" Text="Eliminar" CommandArgument='<%# Eval("Producto.Id") %>' OnClick="btnRemove_Click" CssClass="btn-remove" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!-- Resumen del carrito -->
            <div class="cart-summary">
                Subtotal: $<asp:Label ID="lblSubtotal" runat="server" Text="0.00" />
            </div>

            <!-- Botón para continuar a la compra -->
            <asp:Button ID="btnCheckout" runat="server" Text="Finalizar Compra" CssClass="btn-checkout" OnClick="btnCheckout_Click" />
        </div>
    </form>
</body>
</html>
