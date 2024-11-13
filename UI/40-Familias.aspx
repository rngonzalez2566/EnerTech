<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="40-Familias.aspx.cs" Inherits="UI._40_Familias" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Administración de Familias</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        .table-container {
            max-width: 800px;
            margin: 0 auto;
        }
        .button-group .btn {
            margin: 0.5rem 0.5rem 0 0;
        }
    </style>
</head>
      <!-- Incluir el Navbar -->
 <uc:Navbar ID="navigationBar" runat="server" />
<body>
    <div class="container my-5">
        <!-- Título de la página -->
        <h2 class="text-center mb-5"><i class="bi bi-people-fill"></i> Administración de Familias</h2>

        <!-- Tabla de Familias -->
        <div class="table-container">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-table"></i> Lista de Familias</h5>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mt-0">
                        <thead>
                            <tr>
                                <th scope="col">Seleccionar</th>
                                <th scope="col">Nombre de Familia</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var familia in Familias) { %>
                            <tr>
                                <td>
                                    <input type="radio" name="selectFamilia" class="form-check-input select-familia">
                                    <input type="hidden" class="id-familia" value="<%= familia.Id %>">
                                </td>
                                <td><%= familia.Nombre %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Botones de acción -->
        <div class="d-flex justify-content-center mt-4 button-group">
            <button type="button" class="btn btn-danger" onclick="darBaja()">
                <i class="bi bi-trash"></i> Baja
            </button>
            <button type="button" class="btn btn-warning text-white" onclick="modificarFamilia()">
                <i class="bi bi-pencil-square"></i> Modificar
            </button>
            <button type="button" class="btn btn-success" onclick="altaFamilia()">
                <i class="bi bi-plus-circle"></i> Alta
            </button>
        </div>
    </div>

    <!-- Bootstrap 5 JS and Icons -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function darBaja() {
            const seleccionada = document.querySelector('input[name="selectFamilia"]:checked');
            if (seleccionada) {
                const nombreFamilia = seleccionada.parentElement.nextElementSibling.textContent;
                const confirmar = confirm(`¿Estás seguro de dar de baja la familia "${nombreFamilia}"?`);
                if (confirmar) {
                    // Aquí podrías hacer una solicitud AJAX para eliminar del servidor en lugar de eliminar de la tabla
                    seleccionada.parentElement.parentElement.remove();
                    alert(`La familia "${nombreFamilia}" ha sido dada de baja.`);
                }
            } else {
                alert("Por favor, selecciona una familia para dar de baja.");
            }
        }

        function modificarFamilia() {
            const seleccionada = document.querySelector('input[name="selectFamilia"]:checked');
            if (seleccionada) {
                const idFamilia = seleccionada.nextElementSibling.value;
                window.location.href = `42-ModificarFamilias.aspx?id=${idFamilia}`;
            } else {
                alert("Por favor, selecciona una familia para modificar.");
            }
        }

        function altaFamilia() {
            window.location.href = '41-CrearFamilias.aspx';
        }
    </script>
</body>
</html>
