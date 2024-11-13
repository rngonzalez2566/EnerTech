<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleCompra.aspx.cs" Inherits="UI.DetalleCompra" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Detalle de Compra</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        .card-header-custom {
            background-color: #17a2b8;
            color: white;
        }
        .table th {
            background-color: #f8f9fa;
        }
    </style>
</head>

<body>
    <!-- Incluir el Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />
    
    <form id="form1" runat="server">
        <div class="container my-5">
             <asp:Literal ID="LiteralTitulo" runat="server"></asp:Literal>
            <!-- Título de la página -->
            <h2 class="text-center mb-5"><i class="bi bi-receipt"></i> Detalle de la Compra</h2>
            
            <!-- Tarjeta con detalles de la compra -->
            <div class="card shadow-lg border-0 mb-5">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0"><i class="bi bi-info-circle"></i> Información de la Compra</h5>
                </div>
                <div class="card-body">
                    <p><strong>Fecha:</strong> <asp:Literal ID="LiteralFecha" runat="server"></asp:Literal></p>
                    <p><strong>Total:</strong> $<asp:Literal ID="LiteralTotal" runat="server"></asp:Literal></p>
                </div>
            </div>

            <!-- Tabla de productos -->
            <div class="card shadow-lg border-0">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0"><i class="bi bi-box-seam"></i> Productos</h5>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mt-0">
                        <thead>
                            <tr>
                                <th>Descripción</th>
                                <th class="text-center">Cantidad</th>
                                <th class="text-end">Precio Unitario</th>
                                <th class="text-end">Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="ProductosRepeater" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("Descripcion") %></td>
                                        <td class="text-center"><%# Eval("Cantidad") %></td>
                                        <td class="text-end">$<%# Eval("PrecioUnitario", "{0:N2}") %></td>
                                        <td class="text-end">$<%# Eval("Total", "{0:N2}") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Botón para volver -->
            <div class="mt-5 text-center">
                <a href="javascript:history.back()" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Volver
                </a>
            </div>
        </div>
    </form>

    <!-- Bootstrap 5 JS and Icons -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
