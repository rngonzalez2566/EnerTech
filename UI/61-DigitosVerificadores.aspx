<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="61-DigitosVerificadores.aspx.cs" Inherits="UI._61_DigitosVerificadores" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Recalcular Dígitos Verificadores</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .btn-primary {
            background-color: #00796b;
            border-color: #00796b;
        }

        .btn-primary:hover {
            background-color: #005f56;
            border-color: #005f56;
        }

        .status-label {
            margin-top: 20px;
            font-size: 16px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <uc:Navbar ID="navigationBar" runat="server" />
    <form id="form1" runat="server">
        <div class="container">
    <h1>Recalcular Dígitos Verificadores</h1>
    <div class="action-container mt-4">
        <asp:Button 
            ID="btnRecalcular" 
            runat="server" 
            CssClass="btn btn-primary" 
            Text="Recalcular Dígitos Verificadores" 
            OnClick="btnRecalcular_Click" />
        <div class="mt-3">
            <asp:Label 
                ID="lblResultado" 
                runat="server" 
                CssClass="status-label text-success" 
                Visible="false"></asp:Label>
        </div>
    </div>
</div>

    </form>
    
</body>
</html>
