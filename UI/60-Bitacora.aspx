<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="60-Bitacora.aspx.cs" Inherits="UI._60_Bitacora" %>


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
    </style>
</head>
<body>
    <form id="mainForm" runat="server">
        <div class="bitacora-container">
            <h1>Bitácora</h1>

            <div class="filter-form">
                <div>
                    <label for="txtUsuario">Usuario</label>
                    <asp:TextBox ID="txtUsuario" runat="server" Placeholder="Usuario"></asp:TextBox>
                </div>
                <div>
                    <label for="ddlCriticidad">Criticidad</label>
                    <asp:DropDownList ID="ddlCriticidad" runat="server">
                        <asp:ListItem Value="">Seleccionar</asp:ListItem>
                        <asp:ListItem Value="Baja">Baja</asp:ListItem>
                        <asp:ListItem Value="Media">Media</asp:ListItem>
                        <asp:ListItem Value="Alta">Alta</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div>
                    <label for="txtFechaDesde">Fecha Desde</label>
                    <asp:TextBox ID="txtFechaDesde" runat="server" TextMode="Date"></asp:TextBox>
                </div>
                <div>
                    <label for="txtFechaHasta">Fecha Hasta</label>
                    <asp:TextBox ID="txtFechaHasta" runat="server" TextMode="Date"></asp:TextBox>
                </div>
                <div style="flex-basis: 100%; text-align: center;">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" />
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Usuario</th>
                        <th>Criticidad</th>
                        <th>Detalle</th>
                    </tr>
                </thead>
                <tbody>
                    <% foreach (var movimiento in Registros) { %>
                    <tr>
                        <td><%= movimiento.Fecha.ToString("dd/MM/yyyy HH:mm") %></td>
                        <td><%= movimiento.usuario.Nombre %></td>
                        <td><%= movimiento.Criticidad.ToString() %></td>
                        <td><%= movimiento.Detalle %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <!-- Contenedor para la paginación -->
            <asp:Label runat="server" Text="Label" ForeColor="Red" ID="lblErrorMessage" Visible="False"></asp:Label>
            <div class="pagination-container">
                <!-- Información de la página actual y total -->
                <div class="page-info">
                    Página <asp:Label ID="lblCurrentPage" runat="server" Text="1"></asp:Label> de <asp:Label ID="lblTotalPages" runat="server" Text="1"></asp:Label>
                </div>

                <!-- Botones de Paginación -->
                <div class="pagination-buttons">
                    <asp:Button ID="btnAnterior" runat="server" Text="Anterior" OnClick="btnAnterior_Click" Visible="false" />
                    <asp:Button ID="btnSiguiente" runat="server" Text="Siguiente" OnClick="btnSiguiente_Click" Visible="false" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
