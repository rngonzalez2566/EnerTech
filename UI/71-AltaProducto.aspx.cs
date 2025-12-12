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
    public partial class _71_AltaProducto : System.Web.UI.Page, IIdiomaObserver
    {
        MarcaBLL _serviceMarca = new MarcaBLL();
        CategoriaBLL _serviceCategoria = new CategoriaBLL();
        ProductoBLL _serviceProducto = new ProductoBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    // Me registro como observador del idioma
                    IdiomaManager.Instance.RegistrarObservador(this);

                    // Cargo combos
                    CargarCombos();
                }

                // Leer idioma seleccionado (?lang=es / ?lang=en)
                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                // Aplico traducciones siempre
                AplicarTraducciones(this);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error en Alta de Producto: " + ex.Message;
                lblMessage.CssClass = "error-message";
            }
        }

        private void CargarCombos()
        {
            List<MarcaBE> listMarca = _serviceMarca.GetMarcas();
            List<CategoriaBE> listCategoria = _serviceCategoria.GetCategorias();
            List<CodigoIVA> listIVA = CodigoIVA.ObtenerListaIVA();

            // Marcas
            ddlMarca.DataSource = listMarca;
            ddlMarca.DataTextField = "Nombre";
            ddlMarca.DataValueField = "id_marca";
            ddlMarca.DataBind();
            ddlMarca.Items.Insert(0, new ListItem("Seleccione una marca", ""));

            // Categorías
            ddlCategoria.DataSource = listCategoria;
            ddlCategoria.DataTextField = "Nombre";
            ddlCategoria.DataValueField = "id_categoria";
            ddlCategoria.DataBind();
            ddlCategoria.Items.Insert(0, new ListItem("Seleccione una categoría", ""));

            // IVA
            ddlIVA.DataSource = listIVA;
            ddlIVA.DataTextField = "Porcentaje";
            ddlIVA.DataValueField = "Codigo";
            ddlIVA.DataBind();
            ddlIVA.Items.Insert(0, new ListItem("Seleccione una Tasa de IVA", ""));
        }

        protected void btnGuardarProducto_Click(object sender, EventArgs e)
        {
            try
            {
                string codigo = txtCodigo.Text;
                string descripcion = txtDescripcion.Text;
                string categoria = ddlCategoria.SelectedValue;
                string marca = ddlMarca.SelectedValue;
                int cantidad = int.Parse(txtCantidad.Text);
                int codIva = Convert.ToInt32(ddlIVA.SelectedValue);
                decimal precio = decimal.Parse(txtPrecio.Text);

                // Imagen
                string rutaImagen = string.Empty;
                if (fuImagen.HasFile)
                {
                    string fileName = Path.GetFileName(fuImagen.PostedFile.FileName);
                    rutaImagen = "~/Images/" + fileName;
                    fuImagen.SaveAs(Server.MapPath(rutaImagen));
                }

                ProductoBE nuevoProducto = new ProductoBE
                {
                    Codigo = codigo,
                    Descripcion = descripcion,
                    Categoria = new CategoriaBE { id_categoria = int.Parse(categoria), Nombre = ddlCategoria.SelectedItem.Text },
                    Marca = new MarcaBE { id_marca = int.Parse(marca), Nombre = ddlMarca.SelectedItem.Text },
                    Cantidad = cantidad,
                    Imagen = rutaImagen,
                    codigoIVA = CodigoIVA.ObtenerTipoIVA(codIva),
                    Precio = precio
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

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                       
                        anchor.InnerText = traduccion;
                    }
                }
                
                else if (childControl is HtmlGenericControl generic &&
                         generic.Attributes["data-translate"] != null)
                {
                    string clave = generic.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        generic.InnerText = traduccion;
                    }
                }
            
                else if (childControl is WebControl webControl &&
                         webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        if (childControl is IButtonControl buttonControl)
                        {
                            buttonControl.Text = traduccion;
                        }
                        else if (childControl is TextBox textBox)
                        {
                            textBox.Attributes["placeholder"] = traduccion;
                        }
                        else if (childControl is ITextControl textControl)
                        {
                            textControl.Text = traduccion;
                        }
                    }
                }

              
                if (childControl.HasControls())
                {
                    AplicarTraducciones(childControl);
                }
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
