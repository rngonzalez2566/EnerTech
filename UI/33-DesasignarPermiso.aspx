<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="33-DesasignarPermiso.aspx.cs" Inherits="UI._33_DesasignarPermiso" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Desasignar Patentes</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        .card-header-custom {
            background-color: #007bff;
            color: white;
        }
        .submit-btn {
            background-color: #dc3545;
            color: white;
        }
        .table-responsive {
            max-height: 300px;
            overflow-y: auto;
        }
        .form-label {
            font-weight: bold;
        }
    </style>
</head>
      <!-- Incluir el Navbar -->
 <uc:Navbar ID="navigationBar" runat="server" />
<body>
    <div class="container my-5">
        <!-- Título de la página -->
        <h2 class="text-center mb-5"><i class="bi bi-shield-x"></i> Desasignar Patentes a Usuario</h2>

        <!-- Formulario de eliminación de patentes -->
        <form id="form1" runat="server" class="mb-5">
            

            <!-- Seleccionar Usuario -->
            <div class="mb-4">
                <label for="selectUsuario" class="form-label"><i class="bi bi-person"></i> Seleccionar Usuario</label>
                <select id="selectUsuario" name="usuarioSeleccionado" class="form-select" onchange="this.form.submit()">
                    <option value="">Selecciona un usuario</option>
                    <% foreach (var usuario in Usuarios) { %>
                        <option value="<%= usuario.Id %>" <%= usuario.Id == UsuarioSeleccionadoId ? "selected" : "" %>>
                            <%= usuario.RazonSocial %>
                        </option>
                    <% } %>
                </select>
            </div>

            <!-- Tabla de Patentes Asignadas -->
            <div class="card shadow mb-5">
                <div class="card-header card-header-custom">
                    <h5><i class="bi bi-check-circle"></i> Patentes Asignadas</h5>
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
                            <% foreach (var patente in PatentesAsignadas) { %>
                                <tr>
                                    <td>
                                        <input type="checkbox" class="form-check-input select-patente" value="<%= patente.Id %>">
                                    </td>
                                    <td><%= patente.Nombre %></td>
                                    <td><%= patente.Permiso %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <input type="hidden" id="patentesSeleccionadas" name="patentesSeleccionadas" />

            <!-- Botón de eliminación -->
            <asp:Button ID="btnEliminar" runat="server" Text="Desasignar Patentes" CssClass="btn submit-btn btn-danger" OnClientClick="return prepararEnvio();" OnClick="btnEliminar_Click" />
        </form>
    </div>



    <script>
        function prepararEnvio() {
            const patentesIds = [];
            document.querySelectorAll('.select-patente:checked').forEach(input => {
                patentesIds.push(input.value);
            });

            document.getElementById('patentesSeleccionadas').value = patentesIds.join(',');
            
            // Validar que al menos una patente esté seleccionada
            if (patentesIds.length === 0) {
                alert("Por favor, selecciona al menos una patente para desasignar.");
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
