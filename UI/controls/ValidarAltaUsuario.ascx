<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="ValidarAltaUsuario.ascx.cs"
    Inherits="UI.controls.ValidarAltaUsuario" %>

<style>
    .field-error {
        color: #dc3545;
        font-size: 0.85rem;
        margin-top: 4px;
        display: block;
        text-align: left;
    }
</style>

<!-- EMAIL -->
<div class="mb-2">
    <asp:TextBox ID="txtEmail" runat="server"
        CssClass="form-control"
        Placeholder="Email"
        TextMode="Email" />

    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
        ControlToValidate="txtEmail"
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="El email es obligatorio."
        ValidationGroup="AltaUsuario" />

    <asp:RegularExpressionValidator ID="revEmail" runat="server"
        ControlToValidate="txtEmail"
        Display="Dynamic"
        CssClass="field-error"
        ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
        ErrorMessage="El formato del email no es válido."
        ValidationGroup="AltaUsuario" />
</div>

<!-- PASSWORD -->
<div class="mb-2">
    <asp:TextBox ID="txtPassword" runat="server"
        CssClass="form-control"
        Placeholder="Contraseña"
        TextMode="Password" />

    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
        ControlToValidate="txtPassword"
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="La contraseña es obligatoria."
        ValidationGroup="AltaUsuario" />

    <asp:CustomValidator ID="cvPassword" runat="server"
        ControlToValidate="txtPassword"
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="La contraseña debe tener al menos 8 caracteres, una mayúscula y un carácter especial."
        OnServerValidate="ValidatePassword"
        ValidationGroup="AltaUsuario" />
</div>

<!-- RAZON SOCIAL -->
<div class="mb-2">
    <asp:TextBox ID="txtRazonSocial" runat="server"
        CssClass="form-control"
        Placeholder="Razón Social" />

    <asp:RequiredFieldValidator ID="rfvRazonSocial" runat="server"
        ControlToValidate="txtRazonSocial"
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="La razón social es obligatoria."
        ValidationGroup="AltaUsuario" />

    <asp:RegularExpressionValidator ID="revRazonSocial" runat="server"
        ControlToValidate="txtRazonSocial"
        Display="Dynamic"
        CssClass="field-error"
        ValidationExpression="^.{1,30}$"
        ErrorMessage="La razón social no debe superar los 30 caracteres."
        ValidationGroup="AltaUsuario" />
</div>

<!-- IDENTIFICACION -->
<div class="mb-2">
    <asp:TextBox ID="txtIdentificacion" runat="server"
        CssClass="form-control"
        Placeholder="Identificación" />

    <asp:RequiredFieldValidator ID="rfvIdentificacion" runat="server"
        ControlToValidate="txtIdentificacion"
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="La identificación es obligatoria."
        ValidationGroup="AltaUsuario" />

    <asp:RegularExpressionValidator ID="revIdentificacion" runat="server"
        ControlToValidate="txtIdentificacion"
        Display="Dynamic"
        CssClass="field-error"
        ValidationExpression="^\d{7,11}$"
        ErrorMessage="La identificación debe tener solo números (7 a 11 dígitos)."
        ValidationGroup="AltaUsuario" />
</div>

<!-- NOMBRE -->
<div class="mb-2">
    <asp:TextBox ID="txtNombre" runat="server"
        CssClass="form-control"
        Placeholder="Nombre" />

    <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
        ControlToValidate="txtNombre"
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="El nombre es obligatorio."
        ValidationGroup="AltaUsuario" />

    <asp:RegularExpressionValidator ID="revNombre" runat="server"
        ControlToValidate="txtNombre"
        Display="Dynamic"
        CssClass="field-error"
        ValidationExpression="^[A-Za-zÀ-ÿ\s]{2,30}$"
        ErrorMessage="El nombre debe tener solo letras (2 a 30 caracteres)."
        ValidationGroup="AltaUsuario" />
</div>

<!-- APELLIDO -->
<div class="mb-2">
    <asp:TextBox ID="txtApellido" runat="server"
        CssClass="form-control"
        Placeholder="Apellido" />

    <asp:RequiredFieldValidator ID="rfvApellido" runat="server"
        ControlToValidate="txtApellido"
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="El apellido es obligatorio."
        ValidationGroup="AltaUsuario" />

    <asp:RegularExpressionValidator ID="revApellido" runat="server"
        ControlToValidate="txtApellido"
        Display="Dynamic"
        CssClass="field-error"
        ValidationExpression="^[A-Za-zÀ-ÿ\s]{2,30}$"
        ErrorMessage="El apellido debe tener solo letras (2 a 30 caracteres)."
        ValidationGroup="AltaUsuario" />
</div>

<!-- TIPO DOCUMENTO -->
<div class="mb-2">
    <asp:DropDownList ID="ddlTipoDocumento" runat="server" CssClass="form-select">
        <asp:ListItem Value="DNI">DNI</asp:ListItem>
        <asp:ListItem Value="CUIT">CUIT</asp:ListItem>
        <asp:ListItem Value="Pasaporte">Pasaporte</asp:ListItem>
    </asp:DropDownList>
</div>

<!-- TIPO CLIENTE -->
<div class="mb-2">
    <asp:DropDownList ID="ddlTipoCliente" runat="server" CssClass="form-select">
        <asp:ListItem Value="Consumidor Final">Consumidor Final</asp:ListItem>
        <asp:ListItem Value="Responsable Inscripto">Responsable Inscripto</asp:ListItem>
    </asp:DropDownList>
</div>
