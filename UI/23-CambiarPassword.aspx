<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="23-CambiarPassword.aspx.cs" Inherits="UI._23_CambiarPassword" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cambiar Contraseña</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
        }

        /* wrapper solo para centrar la card, sin afectar navbar */
        .page-wrapper {
            min-height: calc(100vh - 70px);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 15px;
        }

        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.10);
            width: 100%;
            max-width: 420px;
        }

        .form-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-label {
            display: block;
            font-size: 14px;
            margin-bottom: 6px;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box;
            margin-bottom: 16px;
        }

        /* botón estilo similar a tu look */
        .btn-primary {
            width: 100%;
            background-color: #0d6efd;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 10px;
            font-size: 15px;
            cursor: pointer;
        }

        .btn-primary:hover {
            background-color: #0b5ed7;
        }
    </style>
</head>

<body>
    <uc:Navbar ID="navigationBar" runat="server" />

    <form id="formCambiarPassword" runat="server">
        <div class="page-wrapper">
            <div class="form-container">

                <h1 class="form-title" runat="server" data-translate="change_password_title">Cambiar Contraseña</h1>

                <label class="form-label" runat="server" for="txtCurrentPassword" data-translate="current_password">Contraseña Actual</label>
                <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password" />

                <label class="form-label" runat="server" for="txtNewPassword" data-translate="new_password">Nueva Contraseña</label>
                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" />

                <label class="form-label" runat="server" for="txtConfirmPassword" data-translate="confirm_password">Confirmar Nueva Contraseña</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" />

                <asp:Button ID="btnChangePassword"
                    runat="server"
                    CssClass="btn-primary"
                    Text="Cambiar Contraseña"
                    data-translate="change_password_button"
                    OnClick="btnChangePassword_Click" />
            </div>
        </div>
    </form>
</body>
</html>
