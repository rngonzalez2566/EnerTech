<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleCompra.aspx.cs" Inherits="UI.DetalleCompra" %>


<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Detalle de Compra</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <asp:Literal ID="LiteralTitulo" runat="server"></asp:Literal>

            <div class="card mt-4 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Detalles de la Compra</h5>
                    <p><strong>Fecha:</strong> <asp:Literal ID="LiteralFecha" runat="server"></asp:Literal></p>
                    <p><strong>Total:</strong> $<asp:Literal ID="LiteralTotal" runat="server"></asp:Literal></p>
                </div>
            </div>

            <div class="mt-4">
                <h5>Productos</h5>
                <table class="table table-bordered table-striped mt-2">
                    <thead>
                        <tr>
                            <th>Descripción</th>
                            <th>Cantidad</th>
                            <th>Precio Unitario</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="ProductosRepeater" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("Descripcion") %></td>
                                    <td><%# Eval("Cantidad") %></td>
                                    <td>$<%# Eval("PrecioUnitario", "{0:N2}") %></td>
                                    <td>$<%# Eval("Total", "{0:N2}") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>
    </form>

    <!-- Bootstrap and jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
