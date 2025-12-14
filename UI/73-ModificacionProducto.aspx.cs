using BE;
using BE.AFIP;
using BLL;
using Services;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace UI
{
    public partial class _73_ModificacionProducto : System.Web.UI.Page, IIdiomaObserver
    {
        ProductoBLL _productoService = new ProductoBLL();
        MarcaBLL _serviceMarca = new MarcaBLL();
        CategoriaBLL _serviceCategoria = new CategoriaBLL();

        protected void Page_Load(object sender, EventArgs e)
        {

            var session = new SessionManager();
            UsuarioBE usuario = session.Get<UsuarioBE>("Usuario");

            if (usuario == null)
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!PermisoCheck.VerificarPermiso(usuario.Permisos, BE.Enums.Permiso.ModificarProducto))
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            try
            {
                if (!IsPostBack)
                {
                    IdiomaManager.Instance.RegistrarObservador(this);

                    string codigo = Request.QueryString["codigo"];
                    if (!string.IsNullOrEmpty(codigo))
                        CargarProducto(codigo);
                }

                string idioma = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idioma))
                    IdiomaManager.Instance.CambiarIdioma(idioma);

                AplicarTraducciones(this);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
        }

        private void CargarProducto(string codigo)
        {
            var producto = _productoService.GetProductoCodigo(codigo);
            if (producto == null)
                return;

            // Cargar combos
            List<MarcaBE> marcas = _serviceMarca.GetMarcas();
            List<CategoriaBE> categorias = _serviceCategoria.GetCategorias();
            List<CodigoIVA> ivas = CodigoIVA.ObtenerListaIVA();

            // Marcas
            ValidarModificacionProductoControl.DdlMarca.DataSource = marcas;
            ValidarModificacionProductoControl.DdlMarca.DataTextField = "Nombre";
            ValidarModificacionProductoControl.DdlMarca.DataValueField = "id_marca";
            ValidarModificacionProductoControl.DdlMarca.DataBind();
            ValidarModificacionProductoControl.DdlMarca.Items.Insert(0, new ListItem("Seleccione una marca", ""));

            // Categorias
            ValidarModificacionProductoControl.DdlCategoria.DataSource = categorias;
            ValidarModificacionProductoControl.DdlCategoria.DataTextField = "Nombre";
            ValidarModificacionProductoControl.DdlCategoria.DataValueField = "id_categoria";
            ValidarModificacionProductoControl.DdlCategoria.DataBind();
            ValidarModificacionProductoControl.DdlCategoria.Items.Insert(0, new ListItem("Seleccione una categoría", ""));

            // IVA
            ValidarModificacionProductoControl.DdlIVA.DataSource = ivas;
            ValidarModificacionProductoControl.DdlIVA.DataTextField = "Porcentaje";
            ValidarModificacionProductoControl.DdlIVA.DataValueField = "Codigo";
            ValidarModificacionProductoControl.DdlIVA.DataBind();
            ValidarModificacionProductoControl.DdlIVA.Items.Insert(0, new ListItem("Seleccione una Tasa de IVA", ""));

            // Setear valores
            ValidarModificacionProductoControl.CodigoValue = producto.Codigo;
            ValidarModificacionProductoControl.DescripcionValue = producto.Descripcion;
            ValidarModificacionProductoControl.CantidadValue = producto.Cantidad.ToString();
            ValidarModificacionProductoControl.PrecioValue = producto.Precio.ToString(System.Globalization.CultureInfo.InvariantCulture);

            ValidarModificacionProductoControl.MarcaValue = producto.Marca.id_marca.ToString();
            ValidarModificacionProductoControl.CategoriaValue = producto.Categoria.id_categoria.ToString();

            // Si tu ProductoBE tiene codigoIVA con Codigo, podés setearlo así:
            // (si no coincide, decime cómo viene tu producto.codigoIVA)
            if (producto.codigoIVA != null)
                ValidarModificacionProductoControl.IvaValue = producto.codigoIVA.Codigo.ToString();

            if (!string.IsNullOrEmpty(producto.Imagen))
            {
                ValidarModificacionProductoControl.ImgProducto.ImageUrl = producto.Imagen;
                ValidarModificacionProductoControl.ImgProducto.Visible = true;
            }
        }

        

    protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            if (!Page.IsValid)
                return;

            try
            {
                int codIva = Convert.ToInt32(ValidarModificacionProductoControl.IvaValue);

                string imagenPath = ValidarModificacionProductoControl.ImgProducto.ImageUrl;

                if (ValidarModificacionProductoControl.FuImagen.HasFile)
                {
                    string fileName = Path.GetFileName(ValidarModificacionProductoControl.FuImagen.FileName);
                    string path = Server.MapPath("~/Images/") + fileName;
                    ValidarModificacionProductoControl.FuImagen.SaveAs(path);
                    imagenPath = "~/Images/" + fileName;
                }

                var producto = new ProductoBE
                {
                    Codigo = ValidarModificacionProductoControl.CodigoValue,
                    Descripcion = ValidarModificacionProductoControl.DescripcionValue,
                    Categoria = new CategoriaBE { id_categoria = int.Parse(ValidarModificacionProductoControl.CategoriaValue) },
                    Marca = new MarcaBE { id_marca = int.Parse(ValidarModificacionProductoControl.MarcaValue) },
                    codigoIVA = CodigoIVA.ObtenerTipoIVA(codIva),
                    Cantidad = int.Parse(ValidarModificacionProductoControl.CantidadValue),
                    Precio = decimal.Parse(ValidarModificacionProductoControl.PrecioValue),
                    Imagen = imagenPath
                };

                _productoService.EditarProducto(producto);
                Response.Redirect("70-Productos.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
        }



        private void AplicarTraducciones(Control control)
        {
            foreach (Control child in control.Controls)
            {
                // <a runat="server">
                if (child is HtmlAnchor anchor &&
                    anchor.Attributes["data-translate"] != null)
                {
                    string key = anchor.Attributes["data-translate"];
                    string text = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(text))
                        anchor.InnerText = text;
                }
                // Html genérico
                else if (child is HtmlGenericControl generic &&
                         generic.Attributes["data-translate"] != null)
                {
                    string key = generic.Attributes["data-translate"];
                    string text = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(text))
                        generic.InnerText = text;
                }
                // WebControls (Button, TextBox, Label)
                else if (child is WebControl wc &&
                         wc.Attributes["data-translate"] != null)
                {
                    string key = wc.Attributes["data-translate"];
                    string text = IdiomaManager.Instance.GetTraduccion(key);

                    if (child is IButtonControl btn)
                        btn.Text = text;

                    else if (child is TextBox txt)
                        txt.Attributes["placeholder"] = text;

                    else if (child is ITextControl lbl)
                        lbl.Text = text;
                }

                if (child.HasControls())
                    AplicarTraducciones(child);
            }
        }

        public void UpdateIdioma(string idioma)
        {
            AplicarTraducciones(this);
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }
    }
}
