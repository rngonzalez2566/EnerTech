﻿using BE;
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
    public partial class _71_AltaProducto : System.Web.UI.Page
    {
        MarcaBLL _serviceMarca = new MarcaBLL();
        CategoriaBLL _serviceCategoria = new CategoriaBLL();
        ProductoBLL _serviceProducto = new ProductoBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Puedes cargar las categorías y marcas desde la base de datos aquí si es necesario
                List<MarcaBE> listMarca = new List<MarcaBE>();
                List<CategoriaBE> listCategoria = new List<CategoriaBE>();

                listMarca = _serviceMarca.GetMarcas();
                listCategoria = _serviceCategoria.GetCategorias();
                List<CodigoIVA> listIVA = CodigoIVA.ObtenerListaIVA();

                // Cargar las marcas en el DropDownList de Marca
                ddlMarca.DataSource = listMarca;
                ddlMarca.DataTextField = "Nombre";  // Propiedad que se mostrará
                ddlMarca.DataValueField = "id_marca";     // Valor que se enviará
                ddlMarca.DataBind();

                // Agregar un ítem por defecto para seleccionar una opción
                ddlMarca.Items.Insert(0, new ListItem("Seleccione una marca", ""));

                // Cargar las categorías en el DropDownList de Categoría
                ddlCategoria.DataSource = listCategoria;
                ddlCategoria.DataTextField = "Nombre";  // Propiedad que se mostrará
                ddlCategoria.DataValueField = "id_categoria";     // Valor que se enviará
                ddlCategoria.DataBind();

                // Agregar un ítem por defecto para seleccionar una opción
                ddlCategoria.Items.Insert(0, new ListItem("Seleccione una categoría", ""));

                ddlCategoria.DataSource = listCategoria;
                ddlCategoria.DataTextField = "Nombre";  // Propiedad que se mostrará
                ddlCategoria.DataValueField = "id_categoria";     // Valor que se enviará
                ddlCategoria.DataBind();


                ddlIVA.DataSource = listIVA;
                ddlIVA.DataTextField = "Porcentaje";
                ddlIVA.DataValueField = "Codigo";
                ddlIVA.DataBind();


                ddlIVA.Items.Insert(0, new ListItem("Seleccione una Tasa de IVA", ""));

            }
        }

        protected void btnGuardarProducto_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtener los valores del formulario
                string codigo = txtCodigo.Text;
                string descripcion = txtDescripcion.Text;
                string categoria = ddlCategoria.SelectedValue;
                string marca = ddlMarca.SelectedValue;
                int cantidad = int.Parse(txtCantidad.Text);
                int codIva = Convert.ToInt32(ddlIVA.SelectedValue);
                decimal precio = decimal.Parse(txtPrecio.Text);

                // Manejar la subida de la imagen
                string rutaImagen = string.Empty;
                if (fuImagen.HasFile)
                {
                    string fileName = Path.GetFileName(fuImagen.PostedFile.FileName);
                    rutaImagen = "~/Images/" + fileName;
                    fuImagen.SaveAs(Server.MapPath(rutaImagen));
                }

                // Aquí puedes insertar el producto en la base de datos o realizar otra lógica de negocio
                // Ejemplo:
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

                // Código para guardar el producto en la base de datos o lógica adicional
                _serviceProducto.RegistrarProducto(nuevoProducto);
                // Redirigir o mostrar mensaje de éxito
                Response.Redirect("70-Productos.aspx");
            }
            catch (Exception ex)
            {
                // Manejo de errores
                lblMessage.Text = "Ocurrió un error al guardar el producto: " + ex.Message;
                lblMessage.CssClass = "error-message";
            }
        }
    }
}