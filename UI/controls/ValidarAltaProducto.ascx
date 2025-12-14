<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="ValidarAltaProducto.ascx.cs"
    Inherits="UI.controls.ValidarAltaProducto" %>

<style>
    .field-error {
        color: #dc3545;
        font-size: 0.85rem;
        margin-top: 4px;
        display: block;
        text-align: left;
    }
</style>

<!-- CÓDIGO -->
<div class="col-md-6 mb-3">
    <label runat="server" for="txtCodigo" class="form-label" data-translate="product_code_label">Código del Producto</label>

    <asp:TextBox ID="txtCodigo" runat="server"
        CssClass="form-control"
        placeholder="Ingrese el código"
        data-translate="product_code_placeholder" />

    <asp:RequiredFieldValidator ID="rfvCodigo" runat="server"
        ControlToValidate="txtCodigo"
        ErrorMessage="El código es obligatorio"
        CssClass="field-error"
        Display="Dynamic"
        ValidationGroup="AltaProducto" />
</div>

<!-- DESCRIPCIÓN -->
<div class="col-md-6 mb-3">
    <label runat="server" for="txtDescripcion" class="form-label" data-translate="description_label">Descripción</label>

    <asp:TextBox ID="txtDescripcion" runat="server"
        CssClass="form-control"
        placeholder="Ingrese la descripción"
        data-translate="description_placeholder" />

    <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server"
        ControlToValidate="txtDescripcion"
        ErrorMessage="La descripción es obligatoria"
        CssClass="field-error"
        Display="Dynamic"
        ValidationGroup="AltaProducto" />

    <asp:RegularExpressionValidator ID="revDescripcion" runat="server"
        ControlToValidate="txtDescripcion"
        ValidationExpression="^.{1,100}$"
        ErrorMessage="La descripción no debe superar los 100 caracteres."
        CssClass="field-error"
        Display="Dynamic"
        ValidationGroup="AltaProducto" />
</div>

<!-- CATEGORÍA -->
<div class="col-md-6 mb-3">
    <label runat="server" for="ddlCategoria" class="form-label" data-translate="category_label">Categoría</label>

    <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select" />

    <asp:RequiredFieldValidator ID="rfvCategoria" runat="server"
        ControlToValidate="ddlCategoria"
        InitialValue=""
        ErrorMessage="Debe seleccionar una categoría"
        CssClass="field-error"
        Display="Dynamic"
        ValidationGroup="AltaProducto" />
</div>

<!-- MARCA -->
<div class="col-md-6 mb-3">
    <label runat="server" for="ddlMarca" class="form-label" data-translate="brand_label">Marca</label>

    <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-select" />

    <asp:RequiredFieldValidator ID="rfvMarca" runat="server"
        ControlToValidate="ddlMarca"
        InitialValue=""
        ErrorMessage="Debe seleccionar una marca"
        CssClass="field-error"
        Display="Dynamic"
        ValidationGroup="AltaProducto" />
</div>

<!-- IVA -->
<div class="col-md-6 mb-3">
    <label runat="server" for="ddlIVA" class="form-label" data-translate="iva_label">IVA</label>

    <asp:DropDownList ID="ddlIVA" runat="server" CssClass="form-select" />

    <asp:RequiredFieldValidator ID="rfvIVA" runat="server"
        ControlToValidate="ddlIVA"
        InitialValue=""
        ErrorMessage="Debe seleccionar el IVA"
        CssClass="field-error"
        Display="Dynamic"
        ValidationGroup="AltaProducto" />
</div>

<!-- CANTIDAD -->
<div class="col-md-6 mb-3">
    <label runat="server" for="txtCantidad" class="form-label" data-translate="quantity_label">Cantidad</label>

    <asp:TextBox ID="txtCantidad" runat="server"
        CssClass="form-control"
        TextMode="Number"
        placeholder="Ingrese la cantidad"
        data-translate="quantity_placeholder" />

    <asp:RequiredFieldValidator ID="rfvCantidad" runat="server"
        ControlToValidate="txtCantidad"
        ErrorMessage="La cantidad es obligatoria"
        CssClass="field-error"
        Display="Dynamic"
        ValidationGroup="AltaProducto" />

    <asp:RegularExpressionValidator ID="revCantidad" runat="server"
        ControlToValidate="txtCantidad"
        ValidationExpression="^\d+$"
        ErrorMessage="La cantidad debe ser un número entero."
        CssClass="field-error"
        Display="Dynamic"
        ValidationGroup="AltaProducto" />
</div>

<!-- PRECIO -->
<div class="col-md-6 mb-3">
    <label runat="server" for="txtPrecio" class="form-label" data-translate="price_label">Precio</label>

    <asp:TextBox ID="txtPrecio" runat="server"
        CssClass="form-control"
        TextMode="SingleLine"
        placeholder="Ingrese el precio"
        data-translate="price_placeholder" />

    <asp:RequiredFieldValidator ID="rfvPrecio" runat="server"
        ControlToValidate="txtPrecio"
        ErrorMessage="El precio es obligatorio"
        CssClass="field-error"
        Display="Dynamic"
        ValidationGroup="AltaProducto" />

    <asp:RegularExpressionValidator ID="revPrecio" runat="server"
        ControlToValidate="txtPrecio"
        ValidationExpression="^\d+([.,]\d{1,2})?$"
        ErrorMessage="El precio debe ser un número válido (hasta 2 decimales)."
        CssClass="field-error"
        Display="Dynamic"
        ValidationGroup="AltaProducto" />
</div>

<!-- IMAGEN (opcional) -->
<div class="col-md-6 mb-3">
    <label runat="server" for="fuImagen" class="form-label" data-translate="image_label">Imagen del Producto (opcional)</label>
    <asp:FileUpload ID="fuImagen" runat="server" CssClass="form-control" />
</div>
