<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="41-CrearFamilias.aspx.cs" Inherits="UI._41_CrearFamilias" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>


<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Crear Familias</title>
   
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
    </style>
</head>
      <!-- Incluir el Navbar -->
 <uc:Navbar ID="navigationBar" runat="server" />
<body>
    <div class="container my-5">
        <!-- Título de la página -->
        <h2 class="text-center mb-5"><i class="bi bi-folder-plus"></i> Alta de Familia</h2>

        <!-- Formulario de registro -->
        <form id="form1" runat="server" class="mb-5">
            <div class="card shadow-lg border-0 mb-5">
                <div class="card-body">
                    <h4 class="mb-4">Detalles de la Familia</h4>
                    <div class="mb-3">
                        <label for="nombreFamilia" class="form-label">Nombre de Familia</label>
                        <input type="text" id="nombreFamilia" name="nombreFamilia" class="form-control" required />
                    </div>
                </div>
            </div>

            <!-- Tabla de Patentes Existentes -->
            <div class="card shadow-lg border-0 mb-5">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0"><i class="bi bi-shield-check"></i> Patentes Existentes</h5>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mt-0">
                        <thead>
                            <tr>
                                <th>Seleccionar</th>
                                <th>Nombre de Patente</th>
                                <th>Descripción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var patente in Patentes) { %>
                            <tr>
                                <td>
                                    <input type="checkbox" class="form-check-input select-patente">
                                    <input type="hidden" class="id-patente" value="<%= patente.Id %>">
                                </td>
                                <td><%= patente.Nombre %></td>
                                <td><%= patente.Permiso %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <button type="button" class="btn btn-primary mt-3" onclick="agregarPatente()">Agregar Patente</button>
            </div>

            <!-- Tabla de Patentes Agregadas -->
            <div class="card shadow-lg border-0 mb-5">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0"><i class="bi bi-plus-circle"></i> Patentes Agregadas</h5>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped align-middle mt-0" id="tablaAgregadas">
                        <thead>
                            <tr>
                                <th>Nombre de Patente</th>
                                <th>Descripción</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>

            <input type="hidden" id="patentesSeleccionadas" name="patentesSeleccionadas" />

            <!-- Botón de Crear -->
            <asp:Button ID="btnCrear" runat="server" Text="Crear" CssClass="btn submit-btn" OnClientClick="return prepararEnvio();" OnClick="btnCrear_Click" />

        </form>
    </div>



    <script>
        function agregarPatente() {
            const checkboxes = document.querySelectorAll('.select-patente:checked');
            const tablaAgregadas = document.getElementById('tablaAgregadas').querySelector('tbody');

            checkboxes.forEach(checkbox => {
                const fila = checkbox.closest('tr');
                const nuevaFila = fila.cloneNode(true);
                
                const inputHidden = fila.querySelector('.id-patente').outerHTML;
                nuevaFila.deleteCell(0);
                nuevaFila.innerHTML += `<td style="display: none;">${inputHidden}</td>`;
                
                tablaAgregadas.appendChild(nuevaFila);
                
                checkbox.checked = false;
                checkbox.disabled = true;
            });
        }

        function prepararEnvio() {
            const patentesIds = [];
            document.querySelectorAll('#tablaAgregadas .id-patente').forEach(input => {
                patentesIds.push(input.value);
            });

            document.getElementById('patentesSeleccionadas').value = patentesIds.join(',');

            return patentesIds.length > 0;
        }
    </script>
</body>
</html>
