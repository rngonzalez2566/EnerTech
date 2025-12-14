using System;
using System.Web.UI;

namespace UI.controls
{
    public partial class ValidarModificacionProducto : UserControl
    {
        // Valores para leer desde la page
        public string CodigoValue
        {
            get => txtCodigo.Text.Trim();
            set => txtCodigo.Text = value;
        }

        public string DescripcionValue
        {
            get => txtDescripcion.Text.Trim();
            set => txtDescripcion.Text = value;
        }

        public string CantidadValue
        {
            get => txtCantidad.Text.Trim();
            set => txtCantidad.Text = value;
        }

        public string PrecioValue
        {
            get => txtPrecio.Text.Trim();
            set => txtPrecio.Text = value;
        }

        public string CategoriaValue
        {
            get => ddlCategoria.SelectedValue;
            set => ddlCategoria.SelectedValue = value;
        }

        public string MarcaValue
        {
            get => ddlMarca.SelectedValue;
            set => ddlMarca.SelectedValue = value;
        }

        public string IvaValue
        {
            get => ddlIVA.SelectedValue;
            set => ddlIVA.SelectedValue = value;
        }

        // Controles (para DataBind desde la page si querés)
        public System.Web.UI.WebControls.DropDownList DdlCategoria => ddlCategoria;
        public System.Web.UI.WebControls.DropDownList DdlMarca => ddlMarca;
        public System.Web.UI.WebControls.DropDownList DdlIVA => ddlIVA;

        public System.Web.UI.WebControls.FileUpload FuImagen => fuImagen;
        public System.Web.UI.WebControls.Image ImgProducto => imgProducto;

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}
