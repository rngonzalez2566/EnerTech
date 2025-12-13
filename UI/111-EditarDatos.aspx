<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="111-EditarDatos.aspx.cs" Inherits="UI._111_EditarDatos" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <title>Editar Datos del Negocio - EnerTech</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body {
            background-color: #f7f9fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
        }

        .page-wrapper {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .form-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 10px;
        }

        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .form-container h2 {
            color: #00796b;
            margin-bottom: 30px;
            text-align: center;
        }

        .form-control {
            background-color: #f8f9fa;
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
        }
        .form-control:focus {
            box-shadow: 0 4px 12px rgba(0, 121, 107, 0.2);
        }

        .btn-primary {
            background-color: #00796b;
            border-color: #00796b;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .btn-primary:hover {
            background-color: #005f56;
            transform: translateY(-3px);
        }

        footer {
            text-align: center;
            padding: 10px 0;
            font-size: 0.9rem;
            color: #666;
        }
    </style>
</head>

<body>
    <uc:Navbar ID="navigationBar" runat="server" />

    <form id="form1" runat="server">
        <div class="page-wrapper">
            <div class="form-wrapper">
                <div class="form-container">
                    <h2 runat="server" data-translate="edit_business_title">
                        Editar Datos del Negocio
                    </h2>

                    <div class="mb-3">
                        <asp:TextBox ID="txtRazonSocial" runat="server"
                            CssClass="form-control"
                            Placeholder="Razón Social"
                            data-translate="business_name_placeholder" />
                    </div>

                    <div class="mb-3">
                        <asp:TextBox ID="txtIdentificacion" runat="server"
                            CssClass="form-control"
                            Placeholder="Identificación"
                            data-translate="business_id_placeholder" />
                    </div>

                    <div class="mb-3">
                        <asp:TextBox ID="txtDireccion" runat="server"
                            CssClass="form-control"
                            Placeholder="Dirección"
                            data-translate="business_address_placeholder" />
                    </div>

                    <div class="mb-3">
                        <asp:TextBox ID="txtTelefono" runat="server"
                            CssClass="form-control"
                            Placeholder="Teléfono"
                            TextMode="Phone"
                            data-translate="business_phone_placeholder" />
                    </div>

                    <asp:Button ID="btnGuardar" runat="server"
                        Text="Guardar"
                        CssClass="btn btn-primary w-100 mb-3"
                        data-translate="save_button"
                        OnClick="btnGuardar_Click" />

                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="d-block mb-3"></asp:Label>
                </div>
            </div>

            <footer>
                &copy; 2024 EnerTech | Energías Renovables
            </footer>
        </div>
    </form>
</body>
</html>
