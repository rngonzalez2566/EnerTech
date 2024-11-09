<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="A-PruebaAFIP.aspx.cs" Inherits="UI.A_PruebaAFIP" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Prueba Token AFIP</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="btnObtenerToken" runat="server" Text="Obtener Token AFIP" OnClick="btnObtenerToken_Click" />
            <br /><br />
            <asp:TextBox ID="txtResultado" runat="server" TextMode="MultiLine" Rows="4" Columns="50" ReadOnly="true"></asp:TextBox>
        </div>
    </form>
</body>
</html>