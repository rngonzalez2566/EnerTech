using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _90_Catalogo : System.Web.UI.Page
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
            usuario = _sessionManager.Get<UsuarioBE>("Usuario");
            if (!IsPostBack)
            {
                CargarCatalogo();
                CargarFiltros();
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

    }

  
    
}
