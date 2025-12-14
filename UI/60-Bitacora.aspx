<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="60-Bitacora.aspx.cs" Inherits="UI._60_Bitacora" %>

<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bitácora</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
        }

        .bitacora-container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .filter-form {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }

            .filter-form div {
                flex: 1 1 250px;
            }

            .filter-form input[type="text"],
            .filter-form input[type="date"],
            .filter-form select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
            }

            .filter-form input[type="submit"] {
                background-color: #00796b;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
            }

                .filter-form input[type="submit"]:hover {
                    background-color: #005f56;
                }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

            table th, table td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }

            table th {
                background-color: #00796b;
                color: white;
            }

            table tr:nth-child(even) {
                background-color: #f2f2f2;
            }

        /* Estilos para los botones de paginación */
        .pagination-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }

        .pagination-buttons {
            display: flex;
            gap: 10px;
        }

            .pagination-buttons input[type="button"] {
                background-color: #00796b;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

                .pagination-buttons input[type="button"]:hover {
                    background-color: #005f56;
                }

        .page-info {
            font-size: 16px;
            color: #333;
        }

        .actions-row {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }

        /* Botón compacto */
        .btn-action {
            width: auto !important; /* evita que ocupen todo el ancho */
            min-width: 140px; /* tamaño parejo */
            padding: 8px 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            color: #fff;
        }

        /* Colores */
        .btn-search {
            background: #00796b;
        }
            /* tu verde actual */
            .btn-search:hover {
                background: #005f56;
            }

        .btn-export {
            background: #0d6efd;
        }
            /* azul */
            .btn-export:hover {
                background: #0b5ed7;
            }

        .btn-danger {
            background: #dc3545;
        }
            /* rojo */
            .btn-danger:hover {
                background: #bb2d3b;
            }

        /* Checkbox inline prolijo */
        .purge-confirm {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 6px 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            background: #fff;
            font-size: 14px;
            color: #333;
        }
    </style>
</head>
<body>
    <uc:Navbar ID="navigationBar" runat="server" />

    <form id="mainForm" runat="server">
        <div class="bitacora-container">

            <h1 runat="server" data-translate="bitacora">Bitácora</h1>

            <div class="filter-form">
                <div>
                    <label runat="server" for="txtUsuario" data-translate="bitacora_user_label">Usuario</label>
                    <asp:TextBox ID="txtUsuario" runat="server"></asp:TextBox>
                </div>

                <div>
                    <label runat="server" for="ddlCriticidad" data-translate="bitacora_severity_label">Criticidad</label>
                    <asp:DropDownList ID="ddlCriticidad" runat="server" />
                </div>

                <div>
                    <label runat="server" for="txtFechaDesde" data-translate="date_from">Fecha Desde</label>
                    <asp:TextBox ID="txtFechaDesde" runat="server" TextMode="Date"></asp:TextBox>
                </div>

                <div>
                    <label runat="server" for="txtFechaHasta" data-translate="date_to">Fecha Hasta</label>
                    <asp:TextBox ID="txtFechaHasta" runat="server" TextMode="Date"></asp:TextBox>
                </div>

                <div class="actions-row">
                    <asp:Button ID="btnBuscar" runat="server"
                        Text="Buscar"
                        CssClass="btn-action btn-search"
                        data-translate="search_button"
                        OnClick="btnBuscar_Click" />

                    <asp:Button ID="btnExportJson" runat="server"
                        Text="Exportar JSON"
                        CssClass="btn-action btn-export"
                        OnClick="btnExportJson_Click" />

                    <asp:Button ID="btnExportXml" runat="server"
                        Text="Exportar XML"
                        CssClass="btn-action btn-export"
                        OnClick="btnExportXml_Click" />

                    <div class="purge-confirm">
                        <asp:CheckBox ID="chkConfirmPurge" runat="server" />
                        <span>Confirmo borrar el rango</span>
                    </div>

                    <asp:Button ID="btnDepurar" runat="server"
                        Text="Depurar"
                        CssClass="btn-action btn-danger"
                        OnClick="btnDepurar_Click"
                        OnClientClick="return confirm('¿Seguro? Se exportará y luego se borrará la bitácora en el rango seleccionado.');" />
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th><span runat="server" data-translate="date_header">Fecha</span></th>
                        <th><span runat="server" data-translate="users">Usuario</span></th>
                        <th><span runat="server" data-translate="bitacora_severity_header">Criticidad</span></th>
                        <th><span runat="server" data-translate="bitacora_detail_header">Detalle</span></th>
                    </tr>
                </thead>
                <tbody>
                    <% foreach (var movimiento in Registros)
                        { %>
                    <tr>
                        <td><%= movimiento.Fecha.ToString("dd/MM/yyyy HH:mm") %></td>
                        <td><%= movimiento.usuario.Nombre %></td>
                        <td><%= movimiento.Criticidad.ToString() %></td>
                        <td><%= movimiento.Detalle %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <asp:Label runat="server" ForeColor="Red" ID="lblErrorMessage" Visible="False"></asp:Label>

            <div class="pagination-container">
                <div class="page-info">
                    <span runat="server" data-translate="page_label">Página</span>
                    <asp:Label ID="lblCurrentPage" runat="server" Text="1"></asp:Label>
                    <span runat="server" data-translate="of_label">de</span>
                    <asp:Label ID="lblTotalPages" runat="server" Text="1"></asp:Label>
                </div>

                <div class="pagination-buttons">
                    <asp:Button ID="btnAnterior" runat="server" Text="Anterior" data-translate="prev_button" OnClick="btnAnterior_Click" Visible="false" />
                    <asp:Button ID="btnSiguiente" runat="server" Text="Siguiente" data-translate="next_button" OnClick="btnSiguiente_Click" Visible="false" />
                </div>
            </div>

        </div>
    </form>
</body>
</html>
