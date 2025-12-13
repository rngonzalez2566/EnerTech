<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="34-DesasignarPermisoPatente.aspx.cs" Inherits="UI._34_DesasignarPermisoPatente" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Desasignar Familias</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        .card-header-custom { background-color: #007bff; color: white; }
        .submit-btn { background-color: #dc3545; color: white; }
        .table-responsive { max-height: 300px; overflow-y: auto; }
        .form-label { font-weight: bold; }
    </style>
</head>

<body>
    <!-- Incluir el Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <div class="container my-5">

        <!-- Título de la página -->
        <h2 class="text-center mb-5" runat="server" data-translate="unassign_families_title">
            <i class="bi bi-people-fill"></i> Desasignar Familias a Usuario
        </h2>

        <form id="form1" runat="server" class="mb-5">

            <!-- Filtro de Usuarios -->
            <div class="mb-4">
                <label for="filtroUsuario" class="form-label" runat="server" id="lblFilterUser" data-translate="filter_user_label">
                    <i class="bi bi-search"></i> Filtrar Usuario
                </label>
                <input type="text" id="filtroUsuario" name="filtroUsuario"
                       class="form-control"
                       placeholder="Escribe para buscar..."
                       data-translate="filter_user_placeholder"
                       oninput="filtrarUsuarios()" />
            </div>

            <!-- Seleccionar Usuario -->
            <div class="mb-4">
                <label for="selectUsuario" class="form-label" runat="server" id="lblSelectUser" data-translate="select_user_label">
                    <i class="bi bi-person"></i> Seleccionar Usuario
                </label>
                <select id="selectUsuario" name="usuarioSeleccionado" class="form-select" onchange="this.form.submit()">
                    <option value="" data-translate="select_user_option">Selecciona un usuario</option>
                    <% foreach (var usuario in Usuarios) { %>
                        <option value="<%= usuario.id_usuario %>" <%= usuario.id_usuario == UsuarioSeleccionadoId ? "selected" : "" %>>
                            <%= usuario.RazonSocial %>
                        </option>
                    <% } %>
                </select>
            </div>

            <!-- Familias Asignadas -->
            <div class="card shadow mb-5">
                <div class="card-header card-header-custom">
                    <h5 runat="server" id="lblAssignedFamilies" data-translate="assigned_families_title">
                        <i class="bi bi-check-circle"></i> Familias Asignadas
                    </h5>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th id="thSelect" runat="server">Seleccionar</th>
                                <th id="thFamilyName" runat="server">Nombre de Familia</th>
                                <th id="thFamilyDesc" runat="server">Descripción</th>
                            </tr>
                        </thead>

                        <tbody>
                            <% foreach (var familia in FamiliasAsignadas) { %>
                                <tr>
                                    <td>
                                        <input type="checkbox" class="form-check-input select-familia" value="<%= familia.id_componente %>">
                                    </td>
                                    <td><%= familia.Nombre %></td>
                                    <td><%= familia.Permiso %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <input type="hidden" id="familiasSeleccionadas" name="familiasSeleccionadas" />

            <!-- mensaje traducible para el alert del JS (opcional) -->
            <input type="hidden" id="msgSelectAtLeastOneFamily" value="Por favor, selecciona al menos una familia para desasignar." runat="server" />

            <!-- Botón de eliminación -->
            <asp:Button ID="btnEliminar" runat="server"
                Text="Desasignar Familias"
                CssClass="btn submit-btn btn-danger"
                data-translate="unassign_families_button"
                OnClientClick="return prepararEnvio();"
                OnClick="btnEliminar_Click" />
        </form>
    </div>

    <script>
        function prepararEnvio() {
            const familiasIds = [];
            document.querySelectorAll('.select-familia:checked').forEach(input => {
                familiasIds.push(input.value);
            });

            document.getElementById('familiasSeleccionadas').value = familiasIds.join(',');

            if (familiasIds.length === 0) {
                // si querés traducido: lo toma del hidden
                const msg = document.getElementById('msgSelectAtLeastOneFamily')?.value
                    || "Por favor, selecciona al menos una familia para desasignar.";
                alert(msg);
                return false;
            }
            return true;
        }

        function filtrarUsuarios() {
            const filtro = document.getElementById('filtroUsuario').value.toLowerCase();
            const selectUsuario = document.getElementById('selectUsuario');
            const opciones = selectUsuario.getElementsByTagName('option');

            for (let i = 1; i < opciones.length; i++) {
                const texto = opciones[i].textContent.toLowerCase();
                opciones[i].style.display = texto.includes(filtro) ? '' : 'none';
            }
        }
    </script>
</body>
</html>
