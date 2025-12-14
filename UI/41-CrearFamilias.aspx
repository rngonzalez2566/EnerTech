<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="41-CrearFamilias.aspx.cs" Inherits="UI._41_CrearFamilias" %>

<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>
<%@ Register Src="~/controls/ValidarCrearFamilia.ascx"
    TagPrefix="uc"
    TagName="ValidarCrearFamilia" %>


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

<body>
    <!-- Navbar debe ir dentro del body -->
    <uc:Navbar ID="navigationBar" runat="server" />

    <div class="container my-5">
        <!-- Título de la página -->
        <h2 class="text-center mb-5" runat="server" data-translate="family_create_title">
            <i class="bi bi-folder-plus"></i>Alta de Familia
        </h2>

        <form id="form1" runat="server" class="mb-5">
            <div class="card shadow-lg border-0 mb-5">
                <div class="card-body">
                    <h4 class="mb-4" runat="server" data-translate="family_create_details_title">Detalles de la Familia
                    </h4>
                    <uc:ValidarCrearFamilia
                        ID="ValidarCrearFamiliaControl"
                        runat="server" />

                </div>
            </div>

            <!-- Botón traducible -->
           <asp:Button ID="btnCrear" runat="server"
    Text="Crear"
    CssClass="btn submit-btn btn-success"
    data-translate="family_create_btn_create"
    ValidationGroup="CrearFamilia"
    OnClick="btnCrear_Click" />
        </form>
    </div>

    <script>
        function prepararEnvio() {
            // OJO: tu JS actual usa patentesSeleccionadas/tablaAgregadas, pero en esta página no existen.
            // Si esta página es solo "crear familia por nombre", entonces devolvé true.
            return true;
        }
    </script>
</body>
</html>
