<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="40-Familias.aspx.cs" Inherits="UI._40_Familias" %>

<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Administración de Familias</title>

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

<body>
    <!-- Incluir el Navbar -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <div class="container my-5">
        <!-- Título de la página -->
        <h2 class="text-center mb-5" runat="server" data-translate="families_admin_title">
            <i class="bi bi-people-fill"></i>Administración de Familias
        </h2>

        <!-- Tabla de Familias -->
        <div class="table-container">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0" runat="server" data-translate="families_list_title">
                        <i class="bi bi-table"></i>Lista de Familias
                    </h5>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle mt-0">
                        <thead>
                            <tr>
                                <th id="thSelect" runat="server">Seleccionar</th>
                                <th id="thFamilyName" runat="server">Nombre de Familia</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var familia in Familias)
                                { %>
                            <tr>
                                <td>
                                    <input type="radio" name="selectFamilia" class="form-check-input select-familia">
                                    <input type="hidden" class="id-familia" value="<%= familia.id_componente %>">
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
    <button type="button" class="btn btn-danger" onclick="darBaja()" runat="server">
    <i class="bi bi-trash"></i>
    <span runat="server" data-translate="families_btn_delete">Baja</span>
</button>

<button type="button" class="btn btn-warning text-white" onclick="modificarFamilia()" runat="server">
    <i class="bi bi-pencil-square"></i>
    <span runat="server" data-translate="families_btn_edit">Modificar</span>
</button>

<button type="button" class="btn btn-success" onclick="altaFamilia()" runat="server">
    <i class="bi bi-plus-circle"></i>
    <span runat="server" data-translate="families_btn_add">Alta</span>
</button>
        </div>
    </div>

    <!-- Mensajes JS traducibles -->
    <input type="hidden" id="msgSelectFamily" runat="server" />
    <input type="hidden" id="msgConfirmDelete" runat="server" />
    <input type="hidden" id="msgDeletedOk" runat="server" />
    <input type="hidden" id="msgSelectFamilyEdit" runat="server" />

    <script>
        function darBaja() {
            const seleccionada = document.querySelector('input[name="selectFamilia"]:checked');
            if (seleccionada) {
                const nombreFamilia = seleccionada.parentElement.nextElementSibling.textContent.trim();

                const tplConfirm = document.getElementById('msgConfirmDelete')?.value
                    || '¿Estás seguro de dar de baja la familia "{0}"?';
                const confirmar = confirm(tplConfirm.replace('{0}', nombreFamilia));

                if (confirmar) {
                    seleccionada.parentElement.parentElement.remove();

                    const tplOk = document.getElementById('msgDeletedOk')?.value
                        || 'La familia "{0}" ha sido dada de baja.';
                    alert(tplOk.replace('{0}', nombreFamilia));
                }
            } else {
                alert(document.getElementById('msgSelectFamily')?.value
                    || "Por favor, selecciona una familia para dar de baja.");
            }
        }

        function modificarFamilia() {
            const seleccionada = document.querySelector('input[name="selectFamilia"]:checked');
            if (seleccionada) {
                const idFamilia = seleccionada.nextElementSibling.value;
                window.location.href = `42-ModificarFamilias.aspx?id=${idFamilia}`;
            } else {
                alert(document.getElementById('msgSelectFamilyEdit')?.value
                    || "Por favor, selecciona una familia para modificar.");
            }
        }

        function altaFamilia() {
            window.location.href = '41-CrearFamilias.aspx';
        }
    </script>
</body>
</html>
