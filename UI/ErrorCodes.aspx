<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorCodes.aspx.cs" Inherits="UI.ErrorCodes" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <title>Códigos de Error - EnerTech</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(45deg, #00796b, #00c4a7);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .error-container {
            background-color: #ffffff;
            padding: 30px;
            margin: 50px auto;
            border-radius: 15px;
            box-shadow: 0px 8px 30px rgba(0, 0, 0, 0.15);
            max-width: 600px;
        }
        .error-container h2 {
            color: #00796b;
            margin-bottom: 20px;
            text-align: center;
        }
        .error-item {
            color: #d9534f;
            font-size: 1rem;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="error-container">
                <h2>Códigos de Error</h2>
                <asp:Repeater ID="rptErrorCodes" runat="server">
                    <ItemTemplate>
                        <div class="error-item">
                            <%# Container.DataItem %>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
