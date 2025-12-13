<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="31-AsignarPermiso.aspx.cs" Inherits="UI._31_AsignarPermiso" %>

<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Asignar Permisos</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        .card-header-custom {
            background-color: #007bff;
            color: white;
        }

        .submit-btn {
            background-color: #28a745;
            color: white;
        }

        .table-responsive {
            max-height: 300px;
            overflow-y: auto;
        }
    </style>
</head>


<uc:Navbar ID="navigationBar" runat="server" />

<body>
    <div class="container my-5">

  
        <h2 class="text-center mb-5">
            <i class="bi bi-shield-lock"></i>
            <span runat="server" data-translate="perm_assign_title">Asignación de Permisos</span>
        </h2>

        <form id="form1" runat="server" class="mb-5">

         
            <div class="mb-4">
                <label for="selectUsuario" class="form-label">
                    <i class="bi bi-person"></i>
                    <span runat="server" data-translate="perm_select_user_label">Seleccionar Usuario</span>
                </label>

                <select id="selectUsuario" name="usuarioSeleccionado" class="form-select" onchange="this.form.submit()">
                    <option value="">
                        Selecciona un usuario
                    </option>

                    <% foreach (var usuario in Usuarios)
                        { %>
                    <option value="<%= usuario.id_usuario %>" <%= usuario.id_usuario == UsurioSeleccionadoId ? "selected" : "" %>>
                        <%= usuario.RazonSocial %>
                    </option>
                    <% } %>
                </select>
            </div>

            <!-- Patentes Asignadas -->
            <div class="card shadow mb-4">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0">
                        <i class="bi bi-check-circle"></i>
                        <span runat="server" data-translate="perm_assigned_title">Patentes Asignadas</span>
                    </h5>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                            <tr>
                                <th><span runat="server" data-translate="perm_col_patent_name">Nombre de Patente</span></th>
                                <th><span runat="server" data-translate="perm_col_description">Descripción</span></th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var patente in PatentesAsignadas)
                                { %>
                            <tr>
                                <td><%= patente.Nombre %></td>
                                <td><%= patente.Permiso %></td>
                                <input type="hidden" class="id-patente-asignada" value="<%= patente.id_componente %>">
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Patentes Disponibles -->
            <div class="card shadow mb-5">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0">
                        <i class="bi bi-plus-circle"></i>
                        <span runat="server" data-translate="perm_available_title">Patentes Disponibles</span>
                    </h5>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th><span runat="server" data-translate="perm_col_select">Seleccionar</span></th>
                                <th><span runat="server" data-translate="perm_col_patent_name">Nombre de Patente</span></th>
                                <th><span runat="server" data-translate="perm_col_description">Descripción</span></th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var patente in PatentesDisponibles)
                                { %>
                            <tr>
                                <td>
                                    <input type="checkbox" class="form-check-input select-patente" value="<%= patente.id_componente %>"></td>
                                <td><%= patente.Nombre %></td>
                                <td><%= patente.Permiso %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <input type="hidden" id="patentesSeleccionadas" name="patentesSeleccionadas" />
            <input type="hidden" id="patentesAsignadas" name="patentesAsignadas" />



            <asp:Button ID="btnGuardar" runat="server"
                Text="Asignar Patentes"
                CssClass="btn submit-btn btn-success"
                data-translate="perm_assign_btn"
                OnClientClick="return prepararEnvio();"
                OnClick="btnGuardar_Click" />
        </form>
    </div>
    <script>
        function prepararEnvio() {
            const patentesSeleccionadasIds = [];
            document.querySelectorAll('.select-patente:checked').forEach(input => {
                patentesSeleccionadasIds.push(input.value);
            });
            document.getElementById('patentesSeleccionadas').value = patentesSeleccionadasIds.join(',');

            const patentesAsignadasIds = [];
            document.querySelectorAll('.id-patente-asignada').forEach(input => {
                patentesAsignadasIds.push(input.value);
            });
            document.getElementById('patentesAsignadas').value = patentesAsignadasIds.join(',');
            return true;
        }
    </script>
</body>
</html>
