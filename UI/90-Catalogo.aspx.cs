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
            usuario = _usuarioService.Login("UAC@gmail.com", "S@nlorenzo2566");
            _sessionManager.Set("Usuario", usuario);
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
            ddlMarca.DataValueField = "Id";
            ddlMarca.DataBind();
            ddlMarca.Items.Insert(0, new ListItem("Todas las Marcas", ""));

            // Cargar categorías en el DropDownList
            List<CategoriaBE> categorias = _categoriaService.GetCategorias();
            ddlCategoria.DataSource = categorias;
            ddlCategoria.DataTextField = "Nombre";
            ddlCategoria.DataValueField = "Id";
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
                .Where(p => (!marcaId.HasValue || p.Marca.Id == marcaId) &&
                            (!categoriaId.HasValue || p.Categoria.Id == categoriaId) &&
                            (!precioMin.HasValue || p.Precio >= precioMin) &&
                            (!precioMax.HasValue || p.Precio <= precioMax)).ToList();

            // Cargar los productos filtrados en el Repeater
            rptCatalogo.DataSource = productos;
            rptCatalogo.DataBind();
        }


        protected void btnAgregarCarrito_Click(object sender, EventArgs e)
        {
            //usuario = _usuarioService.Login("UAC@gmail.com", "S@nlorenzo2566");
            //_sessionManager.Set("Usuario", usuario);
            //usuario = _sessionManager.Get<UsuarioBE>("Usuario");

            if (usuario == null)
            {
                Response.Redirect("Default.aspx");
            }

            // Obtener el código del producto desde el CommandArgument del botón
            Button btnAgregarCarrito = (Button)sender;
            int productoId = Convert.ToInt32(btnAgregarCarrito.CommandArgument);

            // Crear el objeto CarritoBE con los detalles necesarios
            CarritoBE carritoItem = new CarritoBE
            {
                usuario = new UsuarioBE { Id = usuario.Id }, 
                producto = new ProductoBE { Id = productoId }, 
                Cantidad = 1 
            };

            // Llamar a setCarrito para agregar o actualizar el producto en el carrito
            _carritoService.setCarrito(carritoItem);

            // Opcional: Mostrar mensaje de confirmación
            //lblMessage.Text = "Producto agregado al carrito.";
            //lblMessage.CssClass = "success-message";
        }

    }

  
    
}
