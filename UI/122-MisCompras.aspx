<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="122-MisCompras.aspx.cs" Inherits="UI._122_MisCompras" %>


<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Mis Compras</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Mis Compras</h2>

            <!-- Compras List -->
            <asp:Repeater ID="ComprasRepeater" runat="server">
                <HeaderTemplate>
                    <div class="row">
                </HeaderTemplate>

                <ItemTemplate>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card shadow-sm h-100">
                            <div class="card-body">
                                <h5 class="card-title">Compra #<%# Eval("Id") %></h5>
                                <p class="card-text">Fecha: <%# Eval("Fecha", "{0:dd/MM/yyyy}") %></p>
                                <p class="card-text">Total: $<%# Eval("Total", "{0:N2}") %></p>
                                <a href="DetalleCompra.aspx?ventaId=<%# Eval("Id") %>&fecha=<%# Eval("Fecha", "{0:yyyy-MM-dd}") %>&total=<%# Eval("Total", "{0:N2}") %>"
   class="btn btn-success btn-block">Ver Detalles</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>

                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </form>

    <!-- Bootstrap and jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

