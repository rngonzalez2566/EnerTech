<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="ValidarPago.ascx.cs"
    Inherits="UI.controls.ValidarPago" %>

<div class="payment-group">
    <label runat="server" data-translate="card_type">Tipo de Tarjeta</label>
    <asp:DropDownList ID="ddlCardType" runat="server" CssClass="form-control"
        ValidationGroup="Pago">
        <asp:ListItem Value="">Seleccione</asp:ListItem>
        <asp:ListItem Value="Visa">Visa</asp:ListItem>
        <asp:ListItem Value="MasterCard">MasterCard</asp:ListItem>
        <asp:ListItem Value="Amex">Amex</asp:ListItem>
        <asp:ListItem Value="PayPal">PayPal</asp:ListItem>
    </asp:DropDownList>

    <asp:RequiredFieldValidator runat="server"
        ControlToValidate="ddlCardType"
        InitialValue=""
        ErrorMessage="Seleccione un medio de pago"
        CssClass="text-danger"
        ValidationGroup="Pago" />
</div>

<div class="payment-group">
    <label runat="server" data-translate="card_name">Nombre en la Tarjeta</label>
    <asp:TextBox ID="txtCardName" runat="server" CssClass="form-control"
        ValidationGroup="Pago" />

    <asp:RequiredFieldValidator runat="server"
        ControlToValidate="txtCardName"
        ErrorMessage="El nombre es obligatorio"
        CssClass="text-danger"
        ValidationGroup="Pago" />
</div>

<div class="payment-group">
    <label runat="server" data-translate="card_number">Número de Tarjeta</label>
    <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control"
        MaxLength="16" TextMode="Number" ValidationGroup="Pago" />

    <asp:RequiredFieldValidator runat="server"
        ControlToValidate="txtCardNumber"
        ErrorMessage="La tarjeta es obligatoria"
        CssClass="text-danger"
        ValidationGroup="Pago" />

    <asp:RegularExpressionValidator runat="server"
        ControlToValidate="txtCardNumber"
        ValidationExpression="^\d{16}$"
        ErrorMessage="Debe tener 16 dígitos"
        CssClass="text-danger"
        ValidationGroup="Pago" />
</div>

<div class="payment-group">
    <label runat="server" data-translate="expiration_date">Fecha Expiración</label>
    <asp:TextBox ID="txtExpDate" runat="server" CssClass="form-control"
        Placeholder="MM/YY" ValidationGroup="Pago" />

    <asp:RequiredFieldValidator runat="server"
        ControlToValidate="txtExpDate"
        ErrorMessage="Fecha requerida"
        CssClass="text-danger"
        ValidationGroup="Pago" />
</div>

<div class="payment-group">
    <label runat="server" data-translate="cvv">CVV</label>
    <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control"
        MaxLength="3" TextMode="Number" ValidationGroup="Pago" />

    <asp:RequiredFieldValidator runat="server"
        ControlToValidate="txtCVV"
        ErrorMessage="CVV requerido"
        CssClass="text-danger"
        ValidationGroup="Pago" />

    <asp:RegularExpressionValidator runat="server"
        ControlToValidate="txtCVV"
        ValidationExpression="^\d{3}$"
        ErrorMessage="CVV inválido"
        CssClass="text-danger"
        ValidationGroup="Pago" />
</div>
