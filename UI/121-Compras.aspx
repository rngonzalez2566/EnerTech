<%@ Page Title="Finalizar Compra"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="121-Compras.aspx.cs"
    Inherits="UI._121_Compras" %>

<%@ Register Src="~/controls/ValidarPago.ascx"
    TagPrefix="uc"
    TagName="ValidarPago" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

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

        .btn-checkout {
            background-color: #4caf50;
            color: white;
            padding: 15px;
            font-size: 18px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
        }

            .btn-checkout:hover {
                background-color: #388e3c;
            }
    </style>

    <div class="main-container">

        <!-- CARRITO -->
        <div class="cart-container">
            <div class="cart-header">
                <span runat="server" data-translate="shopping_cart">Carrito de Compras</span>
                <a runat="server" href="90-Catalogo.aspx" data-translate="continue_shopping">Continuar Comprando
                </a>
            </div>

            <asp:Repeater ID="rptCarrito" runat="server">
                <ItemTemplate>
                    <div class="cart-item">
                        <img class="cart-item-img"
                            src='<%# Eval("Producto.Imagen") != null 
                         && !string.IsNullOrEmpty(Eval("Producto.Imagen").ToString()) 
                         ? ResolveUrl(Eval("Producto.Imagen").ToString()) 
                         : ResolveUrl("~/Images/default.jpg") %>'
                            alt="Imagen del Producto" />
                        <div class="cart-item-details">
                            <div class="cart-item-name">
                                <%# Eval("producto.Descripcion") %>
                            </div>

                            <div>
                                <span runat="server" data-translate="quantity_label">Cantidad:</span>
                                <%# Eval("Cantidad") %>
                            </div>

                            <div class="cart-item-total">
                                $<%# (Convert.ToDecimal(Eval("producto.Precio")) * Convert.ToInt32(Eval("Cantidad"))).ToString("N2") %>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- PAGO -->
        <div class="payment-container">
            <h3 runat="server" data-translate="payment_details">Detalles de Pago</h3>

            <!-- CONTROL DE VALIDACIÓN -->
            <uc:ValidarPago ID="ValidarPagoControl" runat="server" />

            <hr />

            <div>
                <strong runat="server" data-translate="order_total_label">Total</strong>:
            $<asp:Label ID="lblTotal" runat="server" Text="0.00" />
            </div>

            <asp:Button ID="btnCheckout"
                runat="server"
                Text="Finalizar Compra"
                CssClass="btn-checkout"
                data-translate="checkout_button"
                ValidationGroup="Pago"
                OnClick="btnCheckout_Click" />
        </div>

    </div>

</asp:Content>
