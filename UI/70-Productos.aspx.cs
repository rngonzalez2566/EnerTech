using BLL;
using BE;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace UI
{
    public partial class _70_Productos : System.Web.UI.Page, IIdiomaObserver
    {
        private static List<ProductoBE> productos;
        protected global::System.Web.UI.WebControls.GridView gvProductos;
        ProductoBLL _productoService = new ProductoBLL();
        private IdiomaManager _idiomaManager = IdiomaManager.Instance;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                _idiomaManager.RegistrarObservador(this);
                CargarProductos();
                AplicarTraducciones();
            }
        }

        // Método para cargar productos en la grilla
        private void CargarProductos()
        {

          productos = _productoService.GetProductos();

      
            gvProductos.DataSource = productos;
            gvProductos.DataBind();
        }

        // Evento para buscar productos
        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            string textoBusqueda = txtBuscar.Text.ToLower();

            // Filtrar los productos por descripción, código o marca
            var productosFiltrados = productos.Where(p =>
                p.Descripcion.ToLower().Contains(textoBusqueda) ||
                p.Codigo.ToLower().Contains(textoBusqueda));

            gvProductos.DataSource = productosFiltrados;
            gvProductos.DataBind();
        }

        // Botón para agregar un nuevo producto
        protected void btnNuevoProducto_Click(object sender, EventArgs e)
        {
            // Lógica para agregar un nuevo producto
            Response.Redirect("71-AltaProducto.aspx");
        }

        // Botón para eliminar un producto
        protected void btnEliminarProducto_Click(object sender, EventArgs e)
        {
            // Lógica para eliminar un producto
        }

       

        // Botón para modificar un producto
        protected void btnModificarProducto_Click(object sender, EventArgs e)
        {
            Button btnEditar = (Button)sender;
            string codigo = btnEditar.CommandArgument;

            // Redirigir a la página de modificación con el código del producto como parámetro en la URL
            Response.Redirect($"73-ModificacionProducto.aspx?codigo={codigo}");
        }
        protected void SelectAll_Click(object sender, EventArgs e)
        {
            CheckBox chkSelectAll = (CheckBox)gvProductos.HeaderRow.FindControl("chkSelectAll");

            foreach (GridViewRow row in gvProductos.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkCatalogo");
                if (chk != null)
                {
                    chk.Checked = chkSelectAll.Checked;
                }
            }
        }

        protected void btnPublicarCatalogo_Click(object sender, EventArgs e)
        {
            
            List<ProductoBE> listaProductos = new List<ProductoBE>();

           
            foreach (GridViewRow row in gvProductos.Rows)
            {
              
                string codigoProducto = gvProductos.DataKeys[row.RowIndex].Value.ToString();

               
                CheckBox chkCatalogo = (CheckBox)row.FindControl("chkCatalogo");
                bool estaEnCatalogo = chkCatalogo != null && chkCatalogo.Checked;

                
                ProductoBE producto = new ProductoBE
                {
                    Codigo = codigoProducto,
                    Catalogo = estaEnCatalogo  
                };

                listaProductos.Add(producto);
            }


            _productoService.PublicarCatalogo(listaProductos);
            ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "showMessageModal('El catálogo ha sido publicado con éxito.');", true);

            //lblMessage.Visible = true;
            //lblMessage.ForeColor = System.Drawing.Color.Red;
            //lblMessage.Text = "Catálogo publicado con éxito.";
            //lblMessage.CssClass = "success-message";
        }

        private void AplicarTraducciones()
        {
            IdiomaManager idiomaManager = IdiomaManager.Instance;

            foreach (Control control in Page.Controls)
            {
                AplicarTraduccionesRecursivo(control, idiomaManager);
            }
        }

        private void AplicarTraduccionesRecursivo(Control control, IdiomaManager idiomaManager)
        {
            if (control is WebControl webControl)
            {
                // Busca el atributo data-translate
                string claveTraduccion = webControl.Attributes["data-translate"];
                if (!string.IsNullOrEmpty(claveTraduccion))
                {
                    if (webControl is IButtonControl buttonControl)
                    {
                        // Botones
                        buttonControl.Text = idiomaManager.GetTraduccion(claveTraduccion);
                    }
                    else if (webControl is TextBox textBox)
                    {
                        // Placeholders
                        textBox.Attributes["placeholder"] = idiomaManager.GetTraduccion(claveTraduccion);
                    }
                }
            }

            // Iterar sobre los hijos del control
            foreach (Control childControl in control.Controls)
            {
                AplicarTraduccionesRecursivo(childControl, idiomaManager);
            }
        }

        public void UpdateIdioma(string idioma)
        {
            AplicarTraducciones();
        }

        protected override void OnUnload(EventArgs e)
        {
            _idiomaManager.EliminarObservador(this);
            base.OnUnload(e);
        }


    }
 }
