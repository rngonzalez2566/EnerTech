<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="50-Backup.aspx.cs" Inherits="UI._50_Backup" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>
<%@ Register Src="~/GenericModal.ascx" TagPrefix="uc" TagName="GenericModal" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Administración de Base de Datos</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        .container {
            max-width: 600px;
        }
        .card {
            margin-bottom: 1rem;
            padding: 1rem;
        }
        #backupPage .card-header-custom {
            background-color: #007bff;
            color: white;
        }
        #backupPage .primary-btn {
            background-color: #28a745;
            color: white;
        }
        #backupPage .separator {
            border-top: 1px solid #ddd;
            margin: 1.5rem 0;
        }
        #backupPage .status-container {
            background-color: #f8f9fa;
            padding: 1rem;
            border-radius: 5px;
            font-size: 0.9rem;
        }
        .form-label {
            font-size: 0.9rem;
        }
        .form-control {
            font-size: 0.9rem;
            padding: 0.4rem;
        }
        h2 {
            font-size: 1.5rem;
        }
        h5 {
            font-size: 1.1rem;
        }
    </style>
</head>

<body>
    <uc:Navbar ID="navigationBar" runat="server" />

    <form id="form1" runat="server">
        <div class="container my-4">
            <div id="backupPage" class="container my-4">

                <!-- Título de la página -->
                <h2 class="text-center mb-4" runat="server" data-translate="backup_admin_title">
                    <i class="bi bi-database"></i> Administración de Base de Datos
                </h2>

                <!-- Sección: Generar Backup -->
                <div class="card shadow">
                    <div class="card-header card-header-custom" runat="server" data-translate="backup_generate_section">
                        <i class="bi bi-hdd"></i> Generar Backup
                    </div>
                    <div class="card-body">
                        <div class="mb-2">
                            <label for="txtRutaBackup" class="form-label" runat="server" data-translate="backup_path_label">
                                Ruta para guardar el Backup:
                            </label>
                            <asp:TextBox ID="txtRutaBackup" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <asp:Button ID="btnGenerarBackup"
                            runat="server"
                            Text="Guardar Backup"
                            data-translate="backup_save_button"
                            CssClass="btn primary-btn"
                            OnClick="btnGenerarBackup_Click" />
                    </div>
                </div>

                <!-- Separador -->
                <div class="separator"></div>

                <!-- Sección: Restaurar Base de Datos -->
                <div class="card shadow">
                    <div class="card-header card-header-custom" runat="server" data-translate="backup_restore_section">
                        <i class="bi bi-arrow-repeat"></i> Restaurar Base de Datos
                    </div>
                    <div class="card-body">
                        <div class="mb-2">
                            <label for="fileUploadRestore" class="form-label" runat="server" data-translate="backup_select_file_label">
                                Seleccione el archivo de Backup:
                            </label>
                            <asp:FileUpload ID="fileUploadRestore" runat="server" CssClass="form-control" />
                        </div>

                        <asp:Button ID="btnRestaurarBD"
                            runat="server"
                            Text="Restaurar Base de Datos"
                            data-translate="backup_restore_button"
                            CssClass="btn primary-btn"
                            OnClick="btnRestaurarBD_Click" />
                    </div>
                </div>

                <!-- Separador -->
                <div class="separator"></div>

                <!-- Sección: Dígitos Verificadores -->
                <div class="card shadow">
                    <div class="card-header card-header-custom" runat="server" data-translate="backup_dv_section">
                        <i class="bi bi-shield-check"></i> Dígitos Verificadores
                    </div>
                    <div class="card-body">
                        <div class="status-container">
                            <asp:Literal ID="estadoDVLiteral" runat="server"></asp:Literal>
                        </div>

                        <asp:Button ID="btnRecalcularDV"
                            runat="server"
                            Text="Recalcular Dígitos"
                            data-translate="backup_recalc_dv_button"
                            CssClass="btn primary-btn mt-2"
                            OnClick="btnRecalcularDigitos_Click" />
                    </div>
                </div>

            </div>
        </div>

        <uc:GenericModal ID="genericModal" runat="server" />
    </form>
</body>
</html>
