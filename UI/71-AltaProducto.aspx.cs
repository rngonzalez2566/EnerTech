using BE;
using BE.AFIP;
using BLL;
using Services;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace UI
{
    public partial class _71_AltaProducto : System.Web.UI.Page, IIdiomaObserver
    {
        MarcaBLL _serviceMarca = new MarcaBLL();
        CategoriaBLL _serviceCategoria = new CategoriaBLL();
        ProductoBLL _serviceProducto = new ProductoBLL();

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

            if (!PermisoCheck.VerificarPermiso(usuario.Permisos, BE.Enums.Permiso.AltaProducto))
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

                    // Cargo combos y los “inyecto” al control
                    CargarCombosEnControl();
                }

                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                AplicarTraducciones(this);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error en Alta de Producto: " + ex.Message;
                lblMessage.CssClass = "error-message";
            }
        }

        private void CargarCombosEnControl()
        {
            List<MarcaBE> listMarca = _serviceMarca.GetMarcas();
            List<CategoriaBE> listCategoria = _serviceCategoria.GetCategorias();
            List<CodigoIVA> listIVA = CodigoIVA.ObtenerListaIVA();

            ValidarAltaProductoControl.BindCombos(listMarca, listCategoria, listIVA);
        }

        protected void btnGuardarProducto_Click(object sender, EventArgs e)
        {
            try
            {
                lblMessage.Text = "";

                // ✅ Si falla, los validators del ASCX muestran el error debajo del campo
                if (!Page.IsValid)
                    return;

                // Imagen (opcional)
                string rutaImagen = ValidarAltaProductoControl.GuardarImagenYDevolverRuta(this);

                int codIva = ValidarAltaProductoControl.IvaCodigo;

                ProductoBE nuevoProducto = new ProductoBE
                {
                    Codigo = ValidarAltaProductoControl.CodigoValue,
                    Descripcion = ValidarAltaProductoControl.DescripcionValue,
                    Categoria = new CategoriaBE
                    {
                        id_categoria = ValidarAltaProductoControl.CategoriaId,
                        Nombre = ValidarAltaProductoControl.CategoriaNombre
                    },
                    Marca = new MarcaBE
                    {
                        id_marca = ValidarAltaProductoControl.MarcaId,
                        Nombre = ValidarAltaProductoControl.MarcaNombre
                    },
                    Cantidad = ValidarAltaProductoControl.CantidadValue,
                    Imagen = rutaImagen,
                    codigoIVA = CodigoIVA.ObtenerTipoIVA(codIva),
                    Precio = ValidarAltaProductoControl.PrecioValue
                };

                _serviceProducto.RegistrarProducto(nuevoProducto);

                Response.Redirect("70-Productos.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Ocurrió un error al guardar el producto: " + ex.Message;
                lblMessage.CssClass = "error-message";
            }
        }

        private void AplicarTraducciones(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                if (childControl is HtmlAnchor anchor &&
                    anchor.Attributes["data-translate"] != null)
                {
                    string clave = anchor.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion)) anchor.InnerText = traduccion;
                }
                else if (childControl is HtmlGenericControl generic &&
                         generic.Attributes["data-translate"] != null)
                {
                    string clave = generic.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion)) generic.InnerText = traduccion;
                }
                else if (childControl is WebControl webControl &&
                         webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        if (childControl is IButtonControl buttonControl)
                            buttonControl.Text = traduccion;
                        else if (childControl is TextBox textBox)
                            textBox.Attributes["placeholder"] = traduccion;
                        else if (childControl is ITextControl textControl)
                            textControl.Text = traduccion;
                    }
                }

                if (childControl.HasControls())
                    AplicarTraducciones(childControl);
            }
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }
    }
}
