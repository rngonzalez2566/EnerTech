<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="122-MisCompras.aspx.cs" Inherits="UI._122_MisCompras" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Mis Compras</title>
    <!-- Bootstrap 5 CSS -->

    <style>
        .card-status {
            font-weight: bold;
            border-radius: 0.5rem;
            padding: 0.25rem 0.5rem;
        }
        .status-facturado { background-color: #28a745; color: white; }
        .status-shipping { background-color: #ffc107; color: black; }
        .status-canceled { background-color: #dc3545; color: white; }
        .status-pending { background-color: #17a2b8; color: white; }
    </style>
    <link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />
</head>
<body>
    <!-- Incluir el Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <form id="form1" runat="server">
        <div class="container my-5">
            <h2 class="text-center mb-5" runat="server" data-translate="my_purchases_title">
                 Mis Compras
            </h2>

            <!-- Compras List -->
         <asp:Repeater ID="ComprasRepeater" runat="server" OnItemDataBound="ComprasRepeater_ItemDataBound">
    <HeaderTemplate>
        <div class="row gy-4">
    </HeaderTemplate>

    <ItemTemplate>
        <div class="col-md-6 col-lg-4">
            <div class="card shadow-lg border-0 h-100">
                <div class="card-body d-flex flex-column">
                    <!-- Información de la compra -->
                    <h5 class="card-title">
                        <span runat="server" data-translate="purchase_label">Compra #</span>
                        <%# Eval("id_venta") %>
                    </h5>

                    <span id="lblEstado" runat="server" class="card-status"></span>

                    <hr />

                    <!-- Detalles -->
                    <p class="mb-1">
                        <i class="bi bi-calendar-event"></i>
                        <span runat="server" data-translate="date_label">Fecha:</span>
                        <%# Eval("Fecha", "{0:dd/MM/yyyy}") %>
                    </p>

                    <p class="mb-1">
                        <i class="bi bi-currency-dollar"></i>
                        <span runat="server" data-translate="total_label">Total:</span>
                        $<%# Eval("Total", "{0:N2}") %>
                    </p>

                    <!-- Botones siempre visibles -->
                    <div class="d-flex justify-content-between mt-auto">
                        <asp:HyperLink runat="server"
                            NavigateUrl='<%# "DetalleCompra.aspx?ventaId=" + Eval("id_venta") + "&fecha=" + Eval("Fecha", "{0:yyyy-MM-dd}") + "&total=" + Eval("Total", "{0:N2}") %>'
                            CssClass="btn btn-primary btn-sm">
                            <i class="bi bi-eye"></i>
                            <span runat="server" data-translate="view_details"> Ver Detalles</span>
                        </asp:HyperLink>

                        <asp:Button runat="server"
                            CssClass="btn btn-outline-secondary btn-sm"
                            CommandArgument='<%# Eval("id_venta") %>'
                            OnClick="btnPDF_Click"
                            Visible='<%# Eval("Estado").ToString() == "Facturado" %>'
                            Text="Descargar Factura"
                            data-translate="download_invoice" />
                    </div>
                </div>
            </div>
        </div>
    </ItemTemplate>

    <FooterTemplate>
        </div> <!-- Cierre del row -->
    </FooterTemplate>
</asp:Repeater>
        </div>
    </form>

   
</body>
</html>
