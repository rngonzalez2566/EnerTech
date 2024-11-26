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
</head>
<body>
    <!-- Incluir el Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <form id="form1" runat="server">
        <div class="container my-5">
            <h2 class="text-center mb-5">Mis Compras</h2>

            <!-- Compras List -->
            <asp:Repeater ID="ComprasRepeater" runat="server">
                <HeaderTemplate>
                    <div class="row gy-4">
                </HeaderTemplate>

                <ItemTemplate>
                    <div class="col-md-6 col-lg-4">
                        <div class="card shadow-lg border-0 h-100">
                            <div class="card-body d-flex flex-column">
                                <!-- Información de la compra -->
                                <h5 class="card-title">Compra #<%# Eval("id_venta") %></h5>
                                <span class="card-status <%# Eval("Estado").ToString() == "Facturado" ? "status-facturado" : Eval("Estado").ToString() == "En camino" ? "status-shipping" : Eval("Estado").ToString() == "Cancelado" ? "status-canceled" : "status-pending" %>">
                                    <%# Eval("Estado") %>
                                </span>
                                <hr />

                                <!-- Detalles -->
                                <p class="mb-1"><i class="bi bi-calendar-event"></i> Fecha: <%# Eval("Fecha", "{0:dd/MM/yyyy}") %></p>
                                <p class="mb-1"><i class="bi bi-currency-dollar"></i> Total: $<%# Eval("Total", "{0:N2}") %></p>

                                <!-- Botones siempre visibles -->
                                <div class="d-flex justify-content-between mt-auto">
                                    <!-- Botón Ver Detalles (siempre visible) -->
                                    <asp:HyperLink runat="server"
                                        NavigateUrl='<%# "DetalleCompra.aspx?ventaId=" + Eval("id_venta") + "&fecha=" + Eval("Fecha", "{0:yyyy-MM-dd}") + "&total=" + Eval("Total", "{0:N2}") %>'
                                        CssClass="btn btn-primary btn-sm">
                                        <i class="bi bi-eye"></i> Ver Detalles
                                    </asp:HyperLink>

                                    <!-- Botón Descargar Factura (solo visible si está facturado) -->
                                    <asp:Button runat="server"
                                        CssClass="btn btn-outline-secondary btn-sm"
                                        CommandArgument='<%# Eval("id_venta") %>'
                                        OnClick="btnPDF_Click"
                                        Visible='<%# Eval("Estado").ToString() == "Facturado" %>'
                                        Text="Descargar Factura" />
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

    <!-- Bootstrap 5 JS and Icons -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.js"></script>
</body>
</html>
