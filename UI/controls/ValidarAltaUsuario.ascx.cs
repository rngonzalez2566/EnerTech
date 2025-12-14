using System;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI.controls
{
    public partial class ValidarAltaUsuario : UserControl
    {
        public string EmailValue => txtEmail.Text.Trim();
        public string PasswordValue => txtPassword.Text;

        public string RazonSocialValue => txtRazonSocial.Text.Trim();
        public string IdentificacionValue => txtIdentificacion.Text.Trim();
        public string NombreValue => txtNombre.Text.Trim();
        public string ApellidoValue => txtApellido.Text.Trim();

        public string TipoDocumentoValue => ddlTipoDocumento.SelectedValue;
        public string TipoClienteValue => ddlTipoCliente.SelectedValue;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void ValidatePassword(object source, ServerValidateEventArgs args)
        {
            // 8+ chars, 1 mayúscula, 1 especial
            args.IsValid = Regex.IsMatch(args.Value ?? "", @"^(?=.*[A-Z])(?=.*[\W_]).{8,}$");
        }

        public void LimpiarCampos()
        {
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtRazonSocial.Text = "";
            txtIdentificacion.Text = "";
            txtNombre.Text = "";
            txtApellido.Text = "";

            if (ddlTipoDocumento.Items.Count > 0) ddlTipoDocumento.SelectedIndex = 0;
            if (ddlTipoCliente.Items.Count > 0) ddlTipoCliente.SelectedIndex = 0;
        }
    }
}
