<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="ValidarCrearFamilia.ascx.cs"
    Inherits="UI.controls.ValidarCrearFamilia" %>

<div class="mb-3">
    <label class="form-label" runat="server" data-translate="family_create_name_label">
        Nombre de Familia
    </label>

    <asp:TextBox ID="txtNombreFamilia"
                 runat="server"
                 CssClass="form-control"
                 ValidationGroup="CrearFamilia" />

    <asp:RequiredFieldValidator ID="rfvNombreFamilia"
        runat="server"
        ControlToValidate="txtNombreFamilia"
        ErrorMessage="El nombre de la familia es obligatorio"
        CssClass="text-danger"
        Display="Dynamic"
        ValidationGroup="CrearFamilia" />
</div>
