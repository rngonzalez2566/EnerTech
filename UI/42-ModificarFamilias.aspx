<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="42-ModificarFamilias.aspx.cs" Inherits="UI._42_ModificarFamilias" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Modificar Familia</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        .card-header-custom { background-color: #007bff; color: white; }
        .submit-btn { background-color: #28a745; color: white; }
        .form-label { font-weight: bold; }
    </style>
</head>

<body>
    <!-- Navbar SIEMPRE dentro del body -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <div class="container my-5">

        <!-- Título -->
        <h2 class="text-center mb-5" runat="server" data-translate="family_edit_title">
            <i class="bi bi-pencil-square"></i>
            <span>Modificar Familia</span>
        </h2>

        <form id="form1" runat="server">

            <!-- Datos -->
            <div class="card shadow-lg border-0 mb-5">
                <div class="card-body">
                    <h4 class="mb-4" runat="server" data-translate="family_edit_details">
                        Detalles de la Familia
                    </h4>

                    <div class="mb-3">
                        <label class="form-label" runat="server" data-translate="family_name_label">
                            Nombre de la Familia
                        </label>
                        <input type="text" id="nombreFamilia" name="nombreFamilia"
                               class="form-control"
                               value="<%= Familia.Nombre %>" required />
                    </div>
                </div>
            </div>

            <!-- Patentes existentes -->
            <div class="card shadow-lg border-0 mb-5">
                <div class="card-header card-header-custom">
                    <h5 runat="server" data-translate="family_existing_permissions">
                        Patentes Existentes
                    </h5>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th runat="server" data-translate="select">Seleccionar</th>
                                <th runat="server" data-translate="permission_name">Nombre de Patente</th>
                                <th runat="server" data-translate="description">Descripción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var patente in PatentesExistentes) { %>
                            <tr>
                                <td>
                                    <input type="checkbox" class="form-check-input select-patente">
                                    <input type="hidden" class="id-patente" value="<%= patente.id_componente %>">
                                </td>
                                <td><%= patente.Nombre %></td>
                                <td><%= patente.Permiso %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <button type="button"
                        runat="server"
                        class="btn btn-success mt-3"
                        data-translate="family_add_permission"
                        onclick="agregarPatente()">
                    Agregar Patente
                </button>
            </div>

            <!-- Patentes asignadas -->
            <div class="card shadow-lg border-0 mb-5">
                <div class="card-header card-header-custom">
                    <h5 runat="server" data-translate="family_assigned_permissions">
                        Patentes Asignadas
                    </h5>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped" id="tablaAgregadas">
                        <thead>
                            <tr>
                                <th runat="server" data-translate="permission_name">Nombre</th>
                                <th runat="server" data-translate="description">Descripción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var patente in Patentes) { %>
                            <tr>
                                <td><%= patente.Nombre %></td>
                                <td><%= patente.Permiso %></td>
                                <input type="hidden" class="id-patente" value="<%= patente.id_componente %>">
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <input type="hidden" id="patentesSeleccionadas" name="patentesSeleccionadas" />

            <!-- Guardar -->
            <asp:Button ID="btnGuardar"
                runat="server"
                CssClass="btn submit-btn btn-success"
                Text="Guardar"
                data-translate="save"
                OnClientClick="return prepararEnvio();"
                OnClick="btnGuardar_Click" />
        </form>
    </div>
</body>
</html>
