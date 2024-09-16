using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _21_AltaUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
        
        }
        public partial class Register
        {
            protected global::System.Web.UI.WebControls.TextBox txtEmail;
            protected global::System.Web.UI.WebControls.TextBox txtPassword;
            protected global::System.Web.UI.WebControls.TextBox txtRazonSocial;
            protected global::System.Web.UI.WebControls.TextBox txtIdentificacion;
            protected global::System.Web.UI.WebControls.TextBox txtNombre;
            protected global::System.Web.UI.WebControls.TextBox txtApellido;
            protected global::System.Web.UI.WebControls.DropDownList ddlTipoDocumento;
            protected global::System.Web.UI.WebControls.DropDownList ddlTipoCliente;
            protected global::System.Web.UI.WebControls.Button btnRegister;
        }
    }
}