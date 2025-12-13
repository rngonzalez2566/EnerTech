<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="32-AsignarPermisoPatente.aspx.cs" Inherits="UI._32_AsignarPermisoPatente" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Asignar Familias</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        .card-header-custom { background-color: #007bff; color: white; }
        .submit-btn { background-color: #28a745; color: white; }
        .table-responsive { max-height: 300px; overflow-y: auto; }
    </style>
</head>

<body>
    <!-- Incluir el Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <div class="container my-5">
        <!-- Título de la página -->
        <h2 class="text-center mb-5" runat="server" data-translate="families_page_title">
            <i class="bi bi-people-fill"></i> Asignación de Familias a Usuario
        </h2>

        <form id="form1" runat="server" class="mb-5">

            <!-- Seleccionar Usuario -->
            <div class="mb-4">
                <label for="selectUsuario" class="form-label" runat="server" id="lblSelectUser" data-translate="select_user_label">
                    <i class="bi bi-person"></i> Seleccionar Usuario
                </label>

                <select id="selectUsuario" name="usuarioSeleccionado" class="form-select" onchange="this.form.submit()">
                    <option value="" data-translate="select_user_option">Selecciona un usuario</option>
                    <% foreach (var usuario in Usuarios) { %>
                        <option value="<%= usuario.id_usuario %>" <%= usuario.id_usuario == UsurioSeleccionadoId ? "selected" : "" %>>
                            <%= usuario.RazonSocial %>
                        </option>
                    <% } %>
                </select>
            </div>

            <!-- Familias Asignadas -->
            <div class="card shadow mb-4">
                <div class="card-header card-header-custom">
                    <h5 runat="server" id="lblAssignedFamilies" data-translate="assigned_families_title">
                        <i class="bi bi-check-circle"></i> Familias Asignadas
                    </h5>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                            <tr>
                                <th id="thAssignedFamilyName" runat="server">Nombre de Familia</th>
                                <th id="thAssignedFamilyDesc" runat="server">Descripción</th>
                            </tr>
                        </thead>

                        <tbody>
                            <% foreach (var familia in FamiliasAsignadas) { %>
                                <tr>
                                    <td><%= familia.Nombre %></td>
                                    <td><%= familia.Permiso %></td>
                                    <input type="hidden" class="id-familia-asignada" value="<%= familia.id_componente %>">
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Familias Disponibles -->
            <div class="card shadow mb-5">
                <div class="card-header card-header-custom">
                    <h5 runat="server" id="lblAvailableFamilies" data-translate="available_families_title">
                        <i class="bi bi-plus-circle"></i> Familias Disponibles
                    </h5>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th id="thAvailableSelect" runat="server">Seleccionar</th>
                                <th id="thAvailableFamilyName" runat="server">Nombre de Familia</th>
                                <th id="thAvailableFamilyDesc" runat="server">Descripción</th>
                            </tr>
                        </thead>

                        <tbody>
                            <% foreach (var familia in FamiliasDisponibles) { %>
                                <tr>
                                    <td><input type="checkbox" class="form-check-input select-familia" value="<%= familia.id_componente %>"></td>
                                    <td><%= familia.Nombre %></td>
                                    <td><%= familia.Permiso %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <input type="hidden" id="familiasSeleccionadas" name="familiasSeleccionadas" />
            <input type="hidden" id="familiasAsignadas" name="familiasAsignadas" />

            <!-- Botón Guardar -->
            <asp:Button ID="btnGuardar" runat="server"
                Text="Asignar Familias"
                CssClass="btn submit-btn btn-success"
                data-translate="assign_families_button"
                OnClientClick="return prepararEnvio();"
                OnClick="btnGuardar_Click" />
        </form>
    </div>

    <script>
        function prepararEnvio() {
            const familiasSeleccionadasIds = [];
            document.querySelectorAll('.select-familia:checked').forEach(input => {
                familiasSeleccionadasIds.push(input.value);
            });
            document.getElementById('familiasSeleccionadas').value = familiasSeleccionadasIds.join(',');

            const familiasAsignadasIds = [];
            document.querySelectorAll('.id-familia-asignada').forEach(input => {
                familiasAsignadasIds.push(input.value);
            });
            document.getElementById('familiasAsignadas').value = familiasAsignadasIds.join(',');
            return true;
        }
    </script>
</body>
</html>
