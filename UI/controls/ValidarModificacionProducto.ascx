<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="ValidarModificacionProducto.ascx.cs"
    Inherits="UI.controls.ValidarModificacionProducto" %>

<style>
    .field-error {
        color: #dc3545;
        font-size: 0.85rem;
        margin-top: 4px;
        display: block;
        text-align: left;
    }
</style>

<!-- CODIGO (solo lectura) -->
<div class="col-md-6 mb-3">
    <label runat="server" data-translate="product_code_label" class="form-label">Código del Producto</label>
    <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control" ReadOnly="True" />
</div>

<!-- DESCRIPCION -->
<div class="col-md-6 mb-3">
    <label runat="server" data-translate="description_label" class="form-label">Descripción</label>
    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control"
        placeholder="Ingrese la descripción" data-translate="description_placeholder" />

    <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server"
        ControlToValidate="txtDescripcion"
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="La descripción es obligatoria."
        ValidationGroup="ModificacionProducto" />

    <asp:RegularExpressionValidator ID="revDescripcion" runat="server"
        ControlToValidate="txtDescripcion"
        Display="Dynamic"
        CssClass="field-error"
        ValidationExpression="^.{1,200}$"
        ErrorMessage="La descripción no debe superar los 200 caracteres."
        ValidationGroup="ModificacionProducto" />
</div>

<!-- CATEGORIA -->
<div class="col-md-6 mb-3">
    <label runat="server" data-translate="category_label" class="form-label">Categoría</label>
    <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select" />
    <asp:RequiredFieldValidator ID="rfvCategoria" runat="server"
        ControlToValidate="ddlCategoria"
        InitialValue=""
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="Debe seleccionar una categoría."
        ValidationGroup="ModificacionProducto" />
</div>

<!-- MARCA -->
<div class="col-md-6 mb-3">
    <label runat="server" data-translate="brand_label" class="form-label">Marca</label>
    <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-select" />
    <asp:RequiredFieldValidator ID="rfvMarca" runat="server"
        ControlToValidate="ddlMarca"
        InitialValue=""
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="Debe seleccionar una marca."
        ValidationGroup="ModificacionProducto" />
</div>

<!-- IVA -->
<div class="col-md-6 mb-3">
    <label runat="server" data-translate="iva_label" class="form-label">IVA</label>
    <asp:DropDownList ID="ddlIVA" runat="server" CssClass="form-select" />
    <asp:RequiredFieldValidator ID="rfvIVA" runat="server"
        ControlToValidate="ddlIVA"
        InitialValue=""
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="Debe seleccionar el IVA."
        ValidationGroup="ModificacionProducto" />
</div>

<!-- CANTIDAD -->
<div class="col-md-6 mb-3">
    <label runat="server" data-translate="quantity_label" class="form-label">Cantidad</label>
    <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control"
        TextMode="Number" placeholder="Ingrese la cantidad" data-translate="quantity_placeholder" />

    <asp:RequiredFieldValidator ID="rfvCantidad" runat="server"
        ControlToValidate="txtCantidad"
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="La cantidad es obligatoria."
        ValidationGroup="ModificacionProducto" />

    <asp:RegularExpressionValidator ID="revCantidad" runat="server"
        ControlToValidate="txtCantidad"
        Display="Dynamic"
        CssClass="field-error"
        ValidationExpression="^\d{1,9}$"
        ErrorMessage="La cantidad debe ser un número entero válido."
        ValidationGroup="ModificacionProducto" />
</div>

<!-- PRECIO -->
<div class="col-md-6 mb-3">
    <label runat="server" data-translate="price_label" class="form-label">Precio</label>
    <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control"
        TextMode="Number" placeholder="Ingrese el precio" data-translate="price_placeholder" />

    <asp:RequiredFieldValidator ID="rfvPrecio" runat="server"
        ControlToValidate="txtPrecio"
        Display="Dynamic"
        CssClass="field-error"
        ErrorMessage="El precio es obligatorio."
        ValidationGroup="ModificacionProducto" />

    <asp:RegularExpressionValidator ID="revPrecio" runat="server"
        ControlToValidate="txtPrecio"
        Display="Dynamic"
        CssClass="field-error"
        ValidationExpression="^\d+([.,]\d{1,2})?$"
        ErrorMessage="El precio debe ser numérico (hasta 2 decimales)."
        ValidationGroup="ModificacionProducto" />
</div>

<!-- IMAGEN NUEVA (opcional) -->
<div class="col-md-6 mb-3">
    <label runat="server" data-translate="image_label" class="form-label">Imagen del Producto (opcional)</label>
    <asp:FileUpload ID="fuImagen" runat="server" CssClass="form-control" />
</div>

<!-- IMAGEN ACTUAL -->
<div class="col-md-6 mb-3">
    <label class="form-label">Imagen Actual</label>
    <asp:Image ID="imgProducto" runat="server" CssClass="img-thumbnail" Visible="false" Width="200px" />
</div>
