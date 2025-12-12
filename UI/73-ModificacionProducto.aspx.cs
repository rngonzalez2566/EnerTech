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

            txtCodigo.Text = producto.Codigo;
            txtDescripcion.Text = producto.Descripcion;
            txtCantidad.Text = producto.Cantidad.ToString();
            txtPrecio.Text = producto.Precio.ToString(System.Globalization.CultureInfo.InvariantCulture);

            // Cargar combos
            List<MarcaBE> marcas = _serviceMarca.GetMarcas();
            List<CategoriaBE> categorias = _serviceCategoria.GetCategorias();
            List<CodigoIVA> ivas = CodigoIVA.ObtenerListaIVA();

            ddlMarca.DataSource = marcas;
            ddlMarca.DataTextField = "Nombre";
            ddlMarca.DataValueField = "id_marca";
            ddlMarca.DataBind();
            ddlMarca.SelectedValue = producto.Marca.id_marca.ToString();

            ddlCategoria.DataSource = categorias;
            ddlCategoria.DataTextField = "Nombre";
            ddlCategoria.DataValueField = "id_categoria";
            ddlCategoria.DataBind();
            ddlCategoria.SelectedValue = producto.Categoria.id_categoria.ToString();

            ddlIVA.DataSource = ivas;
            ddlIVA.DataTextField = "Porcentaje";
            ddlIVA.DataValueField = "Codigo";
            ddlIVA.DataBind();

            if (!string.IsNullOrEmpty(producto.Imagen))
            {
                imgProducto.ImageUrl = producto.Imagen;
                imgProducto.Visible = true;
            }
        }

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            try
            {
                int codIva = Convert.ToInt32(ddlIVA.SelectedValue);

                string imagenPath = imgProducto.ImageUrl;

                if (fuImagen.HasFile)
                {
                    string fileName = Path.GetFileName(fuImagen.FileName);
                    string path = Server.MapPath("~/Images/") + fileName;
                    fuImagen.SaveAs(path);
                    imagenPath = "~/Images/" + fileName;
                }

                var producto = new ProductoBE
                {
                    Codigo = txtCodigo.Text,
                    Descripcion = txtDescripcion.Text,
                    Categoria = new CategoriaBE { id_categoria = int.Parse(ddlCategoria.SelectedValue) },
                    Marca = new MarcaBE { id_marca = int.Parse(ddlMarca.SelectedValue) },
                    codigoIVA = CodigoIVA.ObtenerTipoIVA(codIva),
                    Cantidad = int.Parse(txtCantidad.Text),
                    Precio = decimal.Parse(txtPrecio.Text),
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

        // =====================================
        //       SISTEMA DE TRADUCCIÓN
        // =====================================

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
