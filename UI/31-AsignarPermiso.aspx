<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="31-AsignarPermiso.aspx.cs" Inherits="UI._31_AsignarPermiso" %>


<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Asignar Permisos</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
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

<body>
    <div class="container my-5">
        <!-- Título de la página -->
        <h2 class="text-center mb-5"><i class="bi bi-shield-lock"></i> Asignación de Permisos</h2>

        <!-- Formulario de Asignación -->
        <form id="form1" runat="server" class="mb-5">
            
         
            <!-- Seleccionar Usuario -->
            <div class="mb-4">
                <label for="selectUsuario" class="form-label"><i class="bi bi-person"></i> Seleccionar Usuario</label>
                <select id="selectUsuario" name="usuarioSeleccionado" class="form-select" onchange="this.form.submit()">
                    <option value="">Selecciona un usuario</option>
                    <% foreach (var usuario in Usuarios) { %>
                        <option value="<%= usuario.Id %>" <%= usuario.Id == UsurioSeleccionadoId ? "selected" : "" %>>
                            <%= usuario.RazonSocial %>
                        </option>
                    <% } %>
                </select>
            </div>

            <!-- Patentes Asignadas -->
            <div class="card shadow mb-4">
                <div class="card-header card-header-custom">
                    <h5><i class="bi bi-check-circle"></i> Patentes Asignadas</h5>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                            <tr>
                                <th>Nombre de Patente</th>
                                <th>Descripción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var patente in PatentesAsignadas) { %>
                                <tr>
                                    <td><%= patente.Nombre %></td>
                                    <td><%= patente.Permiso %></td>
                                    <input type="hidden" class="id-patente-asignada" value="<%= patente.Id %>">
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Patentes Disponibles -->
            <div class="card shadow mb-5">
                <div class="card-header card-header-custom">
                    <h5><i class="bi bi-plus-circle"></i> Patentes Disponibles</h5>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>Seleccionar</th>
                                <th>Nombre de Patente</th>
                                <th>Descripción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var patente in PatentesDisponibles) { %>
                                <tr>
                                    <td><input type="checkbox" class="form-check-input select-patente" value="<%= patente.Id %>"></td>
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

            <!-- Botón Guardar -->
            <asp:Button ID="btnGuardar" runat="server" Text="Asignar Patentes" CssClass="btn submit-btn" OnClientClick="return prepararEnvio();" OnClick="btnGuardar_Click" />
        </form>
    </div>

    <!-- Bootstrap 5 JS and Bootstrap Icons -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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
