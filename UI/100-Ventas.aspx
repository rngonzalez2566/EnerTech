<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="100-Ventas.aspx.cs" Inherits="UI._100_Ventas" Async="true" %>

<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Ventas</title>
    <!-- Incluir Bootstrap 5 -->

    <style>
        /* Estilos generales */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa; /* Fondo color pastel */
            margin: 0;
            padding: 0;
        }

        .table-container {
            max-height: 500px;
            overflow-y: auto;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        /* Estilos para la tabla */
        .table {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
        }

            .table th {
                background-color: #0066cc; /* Encabezado color azul */
                color: white;
                text-align: center;
                vertical-align: middle;
                padding: 12px;
                border-top: 2px solid #004a99;
                border-bottom: 3px solid #004a99;
            }

            .table td {
                text-align: center;
                vertical-align: middle;
                padding: 10px;
                background-color: #f7f9fc;
                border-bottom: 1px solid #e1e5eb;
            }

            .table tr:nth-child(even) td {
                background-color: #edf3f8; /* Alternar color para filas pares */
            }

            .table tr:hover td {
                background-color: #d0e7f9; /* Resaltado al pasar el mouse */
            }

        /* Asegura que los estilos de los botones se apliquen correctamente */
        .btn-facturar {
            background-color: #28a745 !important; /* Verde */
            color: white !important;
            border-radius: 4px;
            padding: 5px 10px;
            font-size: 14px;
            border: none;
        }

            .btn-facturar:hover {
                background-color: #218838 !important;
            }

        .btn-reprocesar {
            background-color: #dc3545 !important; /* Rojo */
            color: white !important;
            border-radius: 4px;
            padding: 5px 10px;
            font-size: 14px;
            border: none;
        }

            .btn-reprocesar:hover {
                background-color: #c82333 !important;
            }

        .cart-header {
            font-size: 1.75rem;
            text-align: center;
            margin-bottom: 30px;
            color: #00796b; /* Verde oscuro */
        }
    </style>
</head>
<uc:Navbar ID="navigationBar" runat="server" />

<body>
    <!-- Overlay de carga -->
<div id="emailOverlay" style="display:none; position:fixed; inset:0; background:rgba(255,255,255,.85); z-index:2000;">
    <div class="d-flex flex-column justify-content-center align-items-center h-100">
        <div class="spinner-border text-primary mb-3" role="status"></div>
        <div class="fw-semibold text-secondary">Enviando email…</div>
    </div>
</div>

<!-- Toast Bootstrap -->
<div class="toast-container position-fixed top-0 end-0 p-3">
    <div id="emailToast" class="toast align-items-center text-bg-success border-0" role="alert">
        <div class="d-flex">
            <div class="toast-body">
                Email enviado correctamente.
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>
    <form id="mainForm" runat="server">
        <div class="container mt-5">
            <h2 class="cart-header" runat="server" data-translate="sales_list_title">Listado de Ventas</h2>


            <!-- Filtros de búsqueda -->
            <div class="row g-3 mb-4">
                <div class="col-md-3">
                    <label runat="server" data-translate="date_from">Fecha Desde</label>
                    <asp:TextBox ID="txtFechaDesde" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label runat="server" data-translate="date_to">Fecha Hasta</label>
                    <asp:TextBox ID="txtFechaHasta" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label runat="server" data-translate="invoiced">Facturado</label>
                    <asp:DropDownList ID="ddlFacturado" runat="server" CssClass="form-select">
                        <asp:ListItem Value="" data-translate="all">Todos</asp:ListItem>
                        <asp:ListItem Value="true" data-translate="yes">Sí</asp:ListItem>
                        <asp:ListItem Value="false" data-translate="no">No</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar"
                        data-translate="filter_button"
                        CssClass="btn btn-primary w-100" />
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <asp:Button ID="btnExportarXML" runat="server" Text="Exportar a XML"
                        data-translate="export_xml_button"
                        CssClass="btn btn-secondary w-100" />
                </div>
            </div>

            <!-- Tabla de Ventas -->
            <div class="table-responsive table-container">
                <asp:GridView ID="gvVentas" runat="server"
                    CssClass="table table-hover align-middle"
                    AutoGenerateColumns="False"
                    OnRowCommand="gvVentas_RowCommand"
                    OnRowDataBound="gvVentas_RowDataBound"
                    OnRowCreated="gvVentas_RowCreated">

                    <Columns>
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:yyyy-MM-dd}" ItemStyle-Width="120px" />
                        <asp:BoundField DataField="Usuario.Identificacion" HeaderText="Cliente" ItemStyle-Width="150px" />
                        <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" ItemStyle-Width="100px" />
                        <asp:BoundField DataField="PuntoDeVenta" HeaderText="PV" ItemStyle-Width="50px" />
                        <asp:BoundField DataField="NumeroVenta" HeaderText="Nro" ItemStyle-Width="70px" />
                        <asp:BoundField DataField="CodigoAutorizacion" HeaderText="CAE" ItemStyle-Width="120px" />
                        <asp:BoundField DataField="Estado" HeaderText="Estado" />
                        <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <!-- Botón Facturar -->
                                <asp:Button ID="btnFacturar" runat="server" Text="Facturar"
                                    CssClass="btn btn-success btn-sm"
                                    OnClick="btnFacturar_Click"
                                    data-translate="bill_button"
                                    CommandArgument='<%# Eval("id_venta") != null ? Eval("id_venta").ToString() : "" %>'
                                    Visible='<%# Eval("Estado") != null && Eval("Estado").ToString() == "" %>' />

                                <!-- Botón Reprocesar -->
                                <asp:Button ID="btnReprocesar" runat="server" Text="Reprocesar"
                                    CssClass="btn btn-danger btn-sm"
                                    OnClick="btnReprocesar_Click"
                                    data-translate="retry_button"
                                    CommandArgument='<%# Eval("id_venta") != null ? Eval("id_venta").ToString() : "" %>'
                                    Visible='<%# Eval("Estado") != null && Eval("Estado").ToString() == "R" %>' />

                                <!-- Botones PDF y XML -->
                                <asp:Button ID="btnPDF" runat="server" Text="PDF"
                                    CssClass="btn btn-info btn-sm"
                                    OnClick="btnPDF_Click"
                                    CommandArgument='<%# Eval("id_venta") != null ? Eval("id_venta").ToString() : "" %>'
                                    Visible='<%# Eval("Estado") != null && Eval("Estado").ToString() == "A" %>' />

                                <asp:Button ID="btnXML" runat="server" Text="XML"
                                    CssClass="btn btn-secondary btn-sm"
                                    OnClick="btnXML_Click"
                                    CommandArgument='<%# Eval("id_venta") != null ? Eval("id_venta").ToString() : "" %>'
                                    Visible='<%# Eval("Estado") != null && Eval("Estado").ToString() == "A" %>' />

                          <asp:Button ID="Button1" runat="server" Text="EMAIL"
                                    CssClass="btn btn-warning btn-sm"
                                    OnClientClick="showEmailOverlay();"
                                    OnClick="Button1_Click"
                                    CommandArgument='<%# Eval("id_venta") %>' 
                                    Visible='<%# Eval("Estado") != null && Eval("Estado").ToString() == "A" %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
<script>
    function showEmailOverlay() {
        document.getElementById("emailOverlay").style.display = "block";
    }

    function hideEmailOverlay() {
        document.getElementById("emailOverlay").style.display = "none";
    }

    function showEmailToast() {
        const toastEl = document.getElementById('emailToast');
        const toast = new bootstrap.Toast(toastEl);
        toast.show();
    }
</script>