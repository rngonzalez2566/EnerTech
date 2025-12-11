using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Services;

namespace UI
{
    public partial class _90_Catalogo : System.Web.UI.Page, IIdiomaObserver
    {
        ProductoBLL _productoService = new ProductoBLL();
        MarcaBLL _marcaService = new MarcaBLL();
        CategoriaBLL _categoriaService = new CategoriaBLL();
        public UsuarioBE usuario { get; set; }
        SessionManager _sessionManager = new SessionManager();
        UsuarioBLL _usuarioService = new UsuarioBLL();
        CarritoBLL _carritoService = new CarritoBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            //usuario = _usuarioService.Login("UAC@gmail.com", "S@nlorenzo2566");
            //_sessionManager.Set("Usuario", usuario);
            //usuario = _sessionManager.Get<UsuarioBE>("Usuario");
            //if (!IsPostBack)
            //{
            //    CargarCatalogo();
            //    CargarFiltros();
            //}

            usuario = _sessionManager.Get<UsuarioBE>("Usuario");

            if (usuario == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            try
            {
                if (!IsPostBack)
                {
                    // Registrar como observador del idioma (igual que NavBar)
                    IdiomaManager.Instance.RegistrarObservador(this);

                    // Cargar datos iniciales
                    CargarCatalogo();
                    CargarFiltros();
                }

                // Leer el idioma del querystring (ej: ?lang=es)
                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                // Aplicar traducciones a todos los controles de la página
                AplicarTraducciones(this);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en 90-Catalogo: {ex.Message}");
                Response.Redirect("Default.aspx");
            }
        }

        private void CargarFiltros()
        {
            // Cargar marcas en el DropDownList
            List<MarcaBE> marcas = _marcaService.GetMarcas();
            ddlMarca.DataSource = marcas;
            ddlMarca.DataTextField = "Nombre";
            ddlMarca.DataValueField = "id_marca";
            ddlMarca.DataBind();
            ddlMarca.Items.Insert(0, new ListItem("Todas las Marcas", ""));

            // Cargar categorías en el DropDownList
            List<CategoriaBE> categorias = _categoriaService.GetCategorias();
            ddlCategoria.DataSource = categorias;
            ddlCategoria.DataTextField = "Nombre";
            ddlCategoria.DataValueField = "id_categoria";
            ddlCategoria.DataBind();
            ddlCategoria.Items.Insert(0, new ListItem("Todas las Categorías", ""));
        }
        private void CargarCatalogo()
        {
            // Obtener los productos del catálogo desde la base de datos o servicio
            List<ProductoBE> productos = _productoService.GetCatalogo();

            // Configurar el Repeater con los productos
            rptCatalogo.DataSource = productos;
            rptCatalogo.DataBind();
        }

        protected void AplicarFiltros(object sender, EventArgs e)
        {
            // Obtener los valores de los filtros
            int? marcaId = string.IsNullOrEmpty(ddlMarca.SelectedValue) ? (int?)null : int.Parse(ddlMarca.SelectedValue);
            int? categoriaId = string.IsNullOrEmpty(ddlCategoria.SelectedValue) ? (int?)null : int.Parse(ddlCategoria.SelectedValue);
            decimal? precioMin = string.IsNullOrEmpty(txtPrecioMin.Text) ? (decimal?)null : decimal.Parse(txtPrecioMin.Text);
            decimal? precioMax = string.IsNullOrEmpty(txtPrecioMax.Text) ? (decimal?)null : decimal.Parse(txtPrecioMax.Text);

            // Filtrar productos según los filtros seleccionados
            List<ProductoBE> productos = _productoService.GetProductos()
                .Where(p => (!marcaId.HasValue || p.Marca.id_marca == marcaId) &&
                            (!categoriaId.HasValue || p.Categoria.id_categoria == categoriaId) &&
                            (!precioMin.HasValue || p.Precio >= precioMin) &&
                            (!precioMax.HasValue || p.Precio <= precioMax)).ToList();

            // Cargar los productos filtrados en el Repeater
            rptCatalogo.DataSource = productos;
            rptCatalogo.DataBind();

            // Reaplicar traducciones después del DataBind
            AplicarTraducciones(this);
        }


        protected void btnAgregarCarrito_Click(object sender, EventArgs e)
        {
            if (usuario == null)
            {
                Response.Redirect("Default.aspx");
            }

            Button btnAgregarCarrito = (Button)sender;
            int productoId = Convert.ToInt32(btnAgregarCarrito.CommandArgument);

            CarritoBE carritoItem = new CarritoBE
            {
                usuario = new UsuarioBE { id_usuario = usuario.id_usuario },
                producto = new ProductoBE { id_producto = productoId },
                Cantidad = 1
            };

            _carritoService.setCarrito(carritoItem);

            // Actualizar el NavBar directamente
            //var navBarControl = (NavBar)this.FindControl("navigationBar");
            //if (navBarControl != null)
            //{
            //    navBarControl.Page_Load(null, null); // Actualizar la cantidad en el carrito
            //}
            //UpdatePanelCatalogo.Update();
            Response.Redirect(Request.RawUrl);
            // Mostrar el toast sin refrescar la página completa
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showToast", "showCartToast();", true);



        }



        protected void AplicarTraducciones(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                // Controles ASP.NET con atributo data-translate
                if (childControl is WebControl webControl && webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        // 1) Controles con Text (Label, TextBox, Literal, etc.)
                        if (childControl is ITextControl textControl)
                        {
                            textControl.Text = traduccion;
                        }
                        // 2) Botones (asp:Button, LinkButton, ImageButton)
                        else if (childControl is IButtonControl buttonControl)
                        {
                            buttonControl.Text = traduccion;
                        }
                        // 3) Controles HTML genéricos con runat="server" (h3, label, div, etc.)
                        else if (childControl is System.Web.UI.HtmlControls.HtmlGenericControl genericControl)
                        {
                            genericControl.InnerText = traduccion;
                        }
                    }
                }
                // Controles HTML genéricos puros (no WebControl) con data-translate
                else if (childControl is System.Web.UI.HtmlControls.HtmlGenericControl genericControl &&
                         genericControl.Attributes["data-translate"] != null)
                {
                    string clave = genericControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        genericControl.InnerText = traduccion;
                    }
                }

                // Recursivo para hijos
                if (childControl.HasControls())
                {
                    AplicarTraducciones(childControl);
                }
            }
        }


        // Implementación del observer
        public void UpdateIdioma(string nuevoIdioma)
        {
            // Cuando cambia el idioma, vuelvo a aplicar traducciones
            AplicarTraducciones(this);
        }

        // Desregistrar el observer al descargar la página
        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }


    }
    }
