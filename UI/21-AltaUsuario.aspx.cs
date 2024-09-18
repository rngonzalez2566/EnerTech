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
    public partial class _21_AltaUsuario : System.Web.UI.Page
    {
        UsuarioBLL usuarioBLL = new UsuarioBLL();   
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
               

                UsuarioBE usuario = new UsuarioBE()
                {
                    Nombre = txtNombre.Text,
                    Apellido = txtApellido.Text,
                    Email = txtEmail.Text,
                    Password = txtPassword.Text,
                    RazonSocial = txtRazonSocial.Text,
                    Identificacion = int.Parse(txtIdentificacion.Text),
                    TipoCliente = ddlTipoCliente.Text,
                    TipoDocumento = ddlTipoDocumento.Text,

                };

                usuarioBLL.RegistrarUsuario(usuario);

                Response.Redirect("11-Login.aspx");
            }
            catch (Exception ex)
            {
                lblError.Text = $"Error al registrar cliente: {ex.Message}";
                lblError.Visible = true;
            }
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

        protected void txtEmail_TextChanged(object sender, EventArgs e)
        {

        }
    }
}