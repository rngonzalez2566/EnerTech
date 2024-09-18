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

        /* Contenedor de la bitácora */
        .bitacora-container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        /* Estilos del formulario de filtro */
        .filter-form {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }

        .filter-form div {
            flex: 1 1 250px; /* Asegura que los filtros ocupen el mismo ancho */
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

        /* Estilos de la tabla */
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
    </style>
</head>
<body>
    <div class="bitacora-container">
        <h1>Bitácora</h1>
        <!-- Formulario de filtros -->
        <form id="filterForm" class="filter-form" runat="server">
            <!-- Filtro por Usuario -->
            <div>
                <label for="txtUsuario">Usuario</label>
                <asp:TextBox ID="txtUsuario" runat="server" Placeholder="Usuario"></asp:TextBox>
            </div>

            <!-- Filtro por Criticidad -->
            <div>
                <label for="ddlCriticidad">Criticidad</label>
                <asp:DropDownList ID="ddlCriticidad" runat="server">
                    <asp:ListItem Value="">Seleccionar</asp:ListItem>
                    <asp:ListItem Value="Baja">Baja</asp:ListItem>
                    <asp:ListItem Value="Media">Media</asp:ListItem>
                    <asp:ListItem Value="Alta">Alta</asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Filtro por Fecha Desde -->
            <div>
                <label for="txtFechaDesde">Fecha Desde</label>
                <asp:TextBox ID="txtFechaDesde" runat="server" TextMode="Date"></asp:TextBox>
            </div>

            <!-- Filtro por Fecha Hasta -->
            <div>
                <label for="txtFechaHasta">Fecha Hasta</label>
                <asp:TextBox ID="txtFechaHasta" runat="server" TextMode="Date"></asp:TextBox>
            </div>

            <!-- Botón Buscar -->
            <div style="flex-basis: 100%; text-align: center;">
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" />
            </div>
        </form>

        <!-- Tabla para mostrar los resultados filtrados -->
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
                <% foreach (var movimiento in Registros)
                    { %>
                <tr>
                    <td><%= movimiento.Fecha.ToString("dd/MM/yyyy HH:mm") %></td>
                    <td><%= movimiento.usuario.Id %></td>
                    <td><%= movimiento.Criticidad.ToString() %></td>
                    <td><%= movimiento.Detalle %></td>
                </tr>


                <% } %>
              </tbody>
        </table>
    </div>
</body>
</html>
