<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="23-CambiarPassword.aspx.cs" Inherits="UI._23_CambiarPassword" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cambiar Contraseña</title>

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
    <uc:Navbar ID="navigationBar" runat="server" />
    <div class="form-wrapper">
        <form id="formCambiarPassword" runat="server">
            <div class="form-container">
                <h1 class="form-title" data-translate="change_password_title">Cambiar Contraseña</h1>
                <div class="mb-3">
                    <label for="txtCurrentPassword" class="form-label" data-translate="current_password">Contraseña Actual</label>
                    <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password" />
                </div>
                <div class="mb-3">
                    <label for="txtNewPassword" class="form-label" data-translate="new_password">Nueva Contraseña</label>
                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" />
                </div>
                <div class="mb-3">
                    <label for="txtConfirmPassword" class="form-label" data-translate="confirm_password">Confirmar Nueva Contraseña</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" />
                </div>
                <asp:Button ID="btnChangePassword" runat="server" CssClass="btn btn-primary" Text="Cambiar Contraseña" OnClick="btnChangePassword_Click" data-translate="change_password_button" />
            </div>
        </form>
    </div>
</body>
</html>
