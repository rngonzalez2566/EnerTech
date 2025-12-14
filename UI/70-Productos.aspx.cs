using BE;
using BLL;
using Services;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Cryptography;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

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

            var session = new SessionManager();
            UsuarioBE usuario = session.Get<UsuarioBE>("Usuario");

            if (usuario == null)
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!PermisoCheck.VerificarPermiso(usuario.Permisos, BE.Enums.Permiso.AdministracionProductos))
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Leer idioma del querystring, igual que en las otras páginas
            string idiomaSeleccionado = Request.QueryString["lang"];
            if (!string.IsNullOrEmpty(idiomaSeleccionado))
            {
                _idiomaManager.CambiarIdioma(idiomaSeleccionado);
            }

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

            TraducirHeadersGrid(idiomaManager);
        }

        private void AplicarTraduccionesRecursivo(Control control, IdiomaManager idiomaManager)
        {
            // 1) Controles HTML genéricos (h2, div, span, etc.)
            if (control is HtmlGenericControl generic &&
                generic.Attributes["data-translate"] != null)
            {
                string clave = generic.Attributes["data-translate"];
                string traduccion = idiomaManager.GetTraduccion(clave);
                if (!string.IsNullOrEmpty(traduccion))
                {
                    generic.InnerText = traduccion;
                }
            }
            // 2) WebControls (Button, Label, TextBox, etc.)
            else if (control is WebControl webControl)
            {
                string claveTraduccion = webControl.Attributes["data-translate"];

                if (!string.IsNullOrEmpty(claveTraduccion))
                {
                    string traduccion = idiomaManager.GetTraduccion(claveTraduccion);

                    if (webControl is IButtonControl buttonControl)
                    {
                        buttonControl.Text = traduccion;
                    }
                    else if (webControl is TextBox textBox)
                    {
                        // placeholder
                        textBox.Attributes["placeholder"] = traduccion;
                    }
                    else if (webControl is ITextControl textControl)
                    {
                        textControl.Text = traduccion;
                    }
                }
            }

            // Recursivo
            foreach (Control childControl in control.Controls)
            {
                AplicarTraduccionesRecursivo(childControl, idiomaManager);
            }
        }

         private void TraducirHeadersGrid(IdiomaManager idiomaManager)
        {
            // Ojo con los índices: coinciden con el orden de las columnas
            if (gvProductos.Columns.Count >= 6)
            {
                // Columnas 0,1 son template (Catálogo, Imagen) -> se traducen por Label
                gvProductos.Columns[2].HeaderText = idiomaManager.GetTraduccion("code_header")        ?? "Código";
                gvProductos.Columns[3].HeaderText = idiomaManager.GetTraduccion("description_header") ?? "Descripción";
                gvProductos.Columns[4].HeaderText = idiomaManager.GetTraduccion("quantity_header")    ?? "Cantidad";
                gvProductos.Columns[5].HeaderText = idiomaManager.GetTraduccion("options_header")     ?? "Opciones";
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
