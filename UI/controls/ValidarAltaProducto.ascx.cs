using BE;
using BE.AFIP;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web.UI;

namespace UI.controls
{
    public partial class ValidarAltaProducto : UserControl
    {
        // === Valores de lectura ===
        public string CodigoValue => txtCodigo.Text.Trim();
        public string DescripcionValue => txtDescripcion.Text.Trim();

        public int CategoriaId => int.Parse(ddlCategoria.SelectedValue);
        public string CategoriaNombre => ddlCategoria.SelectedItem?.Text;

        public int MarcaId => int.Parse(ddlMarca.SelectedValue);
        public string MarcaNombre => ddlMarca.SelectedItem?.Text;

        public int IvaCodigo => int.Parse(ddlIVA.SelectedValue);

        public int CantidadValue => int.Parse(txtCantidad.Text.Trim());

        public decimal PrecioValue
        {
            get
            {
                // soporta "123,45" o "123.45"
                var raw = txtPrecio.Text.Trim().Replace(",", ".");
                return decimal.Parse(raw, CultureInfo.InvariantCulture);
            }
        }

        public bool ImagenHasFile => fuImagen.HasFile;
        public string ImagenFileName => fuImagen.HasFile ? System.IO.Path.GetFileName(fuImagen.FileName) : null;

        // === Binding de combos desde la página ===
        public void BindCombos(List<MarcaBE> marcas, List<CategoriaBE> categorias, List<CodigoIVA> ivas)
        {
            ddlMarca.DataSource = marcas;
            ddlMarca.DataTextField = "Nombre";
            ddlMarca.DataValueField = "id_marca";
            ddlMarca.DataBind();
            ddlMarca.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Seleccione una marca", ""));

            ddlCategoria.DataSource = categorias;
            ddlCategoria.DataTextField = "Nombre";
            ddlCategoria.DataValueField = "id_categoria";
            ddlCategoria.DataBind();
            ddlCategoria.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Seleccione una categoría", ""));

            ddlIVA.DataSource = ivas;
            ddlIVA.DataTextField = "Porcentaje";
            ddlIVA.DataValueField = "Codigo";
            ddlIVA.DataBind();
            ddlIVA.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Seleccione una Tasa de IVA", ""));
        }

        // === Guardado de imagen (opcional) ===
        public string GuardarImagenYDevolverRuta(Page page, string virtualFolder = "~/Images/")
        {
            if (!fuImagen.HasFile) return string.Empty;

            string fileName = System.IO.Path.GetFileName(fuImagen.PostedFile.FileName);
            string rutaVirtual = virtualFolder.TrimEnd('/') + "/" + fileName;

            fuImagen.SaveAs(page.Server.MapPath(rutaVirtual));
            return rutaVirtual;
        }
    }
}
