<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="12-RestablecerPassword.aspx.cs" Inherits="UI._12_RestablecerPassword" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Restablecer Contraseña</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f7f9fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
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

        .btn-primary {
            width: 100%;
            border-radius: 5px;
            font-size: 1rem;
            padding: 10px;
        }
    </style>
</head>
<body>
    
    <div class="form-wrapper">
        <form id="formRestablecerPassword" runat="server">
            <div class="form-container">
                <h1 class="form-title" data-translate="reset_password_title">Restablecer Contraseña</h1>
                <div class="mb-3">
                    <label for="txtEmail" class="form-label" data-translate="email">Correo Electrónico</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" Placeholder="Ingrese su correo electrónico" />
                </div>
                <asp:Button ID="btnResetPassword" runat="server" CssClass="btn btn-primary" Text="Enviar" OnClick="btnResetPassword_Click" data-translate="reset_password_button" />
            </div>
        </form>
    </div>
</body>
</html>
