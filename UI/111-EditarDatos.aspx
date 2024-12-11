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
                display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 70px); /* Ajustar al tamaño del navbar */
        }

        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .form-title {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-container h2 {
            color: #00796b;
            margin-bottom: 30px;
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
            position: absolute;
            bottom: 20px;
            width: 100%;
            text-align: center;
            color: #ffffff;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
     <!-- Incluir el Navbar -->
      <uc:Navbar ID="navigationBar" runat="server" />
    <form id="form1" runat="server">
        <div class="d-flex flex-column align-items-center justify-content-center vh-100">
            <div class="form-container">
                <h2>Editar Datos del Negocio</h2>

                <!-- Campos del formulario -->
                <div class="mb-3">
                    <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="form-control" Placeholder="Razón Social"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <asp:TextBox ID="txtIdentificacion" runat="server" CssClass="form-control" Placeholder="Identificación"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" Placeholder="Dirección"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" Placeholder="Teléfono" TextMode="Phone"></asp:TextBox>
                </div>

                <!-- Botón para guardar los datos -->
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary w-100 mb-3" OnClick="btnGuardar_Click" />

                <!-- Mensaje de confirmación o error -->
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="d-block mb-3"></asp:Label>
            </div>
        </div>
    </form>

    <footer>
        &copy; 2024 EnerTech | Energías Renovables
    </footer>

    
</body>
</html>
