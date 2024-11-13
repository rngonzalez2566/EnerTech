using BE;
using BE.AFIP;
using BLL;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _73_ModificacionProducto : System.Web.UI.Page
    {
        ProductoBLL _productoService = new ProductoBLL();
           MarcaBLL _serviceMarca = new MarcaBLL();
        CategoriaBLL _serviceCategoria = new CategoriaBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string codigo = Request.QueryString["codigo"];
            if (!string.IsNullOrEmpty(codigo))
            {
                CargarProducto(codigo);
            }
            }
        }

        private void CargarProducto(string codigo)
        {
            var producto = _productoService.GetProductoCodigo(codigo);
            if (producto != null)
            {
                txtCodigo.Text = producto.Codigo;
                txtDescripcion.Text = producto.Descripcion;
             
                txtCantidad.Text = producto.Cantidad.ToString();
                txtPrecio.Text = producto.Precio.ToString("0.00");
                // Puedes cargar las categorías y marcas desde la base de datos aquí si es necesario
                List<MarcaBE> listMarca = new List<MarcaBE>();
                List<CategoriaBE> listCategoria = new List<CategoriaBE>();

                listMarca = _serviceMarca.GetMarcas();
                listCategoria = _serviceCategoria.GetCategorias();
                List<CodigoIVA> listIVA = CodigoIVA.ObtenerListaIVA();

                // Cargar las marcas en el DropDownList de Marca
                ddlMarca.DataSource = listMarca;
                ddlMarca.DataTextField = "Nombre";  // Propiedad que se mostrará
                ddlMarca.DataValueField = "Id";     // Valor que se enviará
                ddlMarca.DataBind();

                // Agregar un ítem por defecto para seleccionar una opción
                ddlMarca.Items.Insert(0, new ListItem("Seleccione una marca", ""));

                // Cargar las categorías en el DropDownList de Categoría
                ddlCategoria.DataSource = listCategoria;
                ddlCategoria.DataTextField = "Nombre";  // Propiedad que se mostrará
                ddlCategoria.DataValueField = "Id";     // Valor que se enviará
                ddlCategoria.DataBind();

                // Agregar un ítem por defecto para seleccionar una opción
                ddlCategoria.Items.Insert(0, new ListItem("Seleccione una categoría", ""));

                ddlCategoria.DataSource = listCategoria;
                ddlCategoria.DataTextField = "Nombre";  // Propiedad que se mostrará
                ddlCategoria.DataValueField = "Id";     // Valor que se enviará
                ddlCategoria.DataBind();


                ddlIVA.DataSource = listIVA;
                ddlIVA.DataTextField = "Porcentaje";
                ddlIVA.DataValueField = "Codigo";
                ddlIVA.DataBind();

                ddlCategoria.SelectedValue = producto.Categoria.Id.ToString();
                ddlMarca.SelectedValue = producto.Marca.Id.ToString();

                if (!string.IsNullOrEmpty(producto.Imagen))
                {
                    imgProducto.ImageUrl = producto.Imagen;
                    imgProducto.Visible = true;
                }


            }
        }

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            int codIva = Convert.ToInt32(ddlIVA.SelectedValue);

            // Manejar la imagen
            string imagenPath = null;
            if (fuImagen.HasFile)
            {
                // Guardar la nueva imagen en el servidor
                string fileName = Path.GetFileName(fuImagen.FileName);
                string filePath = Server.MapPath("~/Images/") + fileName;
                fuImagen.SaveAs(filePath);
                imagenPath = "~/Images/" + fileName;
            }
            else if (imgProducto.ImageUrl != null)
            {
                // Si no se sube una nueva imagen, mantener la existente
                imagenPath = imgProducto.ImageUrl;
            }

            var producto = new ProductoBE
            {
                Codigo = txtCodigo.Text,
                Descripcion = txtDescripcion.Text,
                Categoria = new CategoriaBE { Id = int.Parse(ddlCategoria.SelectedValue) },
                Marca = new MarcaBE { Id = int.Parse(ddlMarca.SelectedValue) },
                codigoIVA = CodigoIVA.ObtenerTipoIVA(codIva),
                Cantidad = int.Parse(txtCantidad.Text),
                Precio = decimal.Parse(txtPrecio.Text),
                Imagen = imagenPath
            };

            _productoService.EditarProducto(producto);
            Response.Redirect("70-Productos.aspx");

        }
    }
}