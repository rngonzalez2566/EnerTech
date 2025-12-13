using BE;
using BLL;
using Services;
using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _21_AltaUsuario : System.Web.UI.Page, IIdiomaObserver
    {
        UsuarioBLL usuarioBLL = new UsuarioBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1) Cambiar idioma primero
            string idioma = Request.QueryString["lang"];
            if (!string.IsNullOrEmpty(idioma))
                IdiomaManager.Instance.CambiarIdioma(idioma);

            if (!IsPostBack)
            {
                IdiomaManager.Instance.RegistrarObservador(this);
            }

            // 2) Traducir siempre
            AplicarTraducciones(this);
            TraducirCombos();
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
                    TipoCliente = ddlTipoCliente.SelectedValue,
                    TipoDocumento = ddlTipoDocumento.SelectedValue,
                    Estado = "Activo"
                };

                usuarioBLL.RegistrarUsuario(usuario, usuario.Password);
                Response.Redirect("11-Login.aspx");
            }
            catch (Exception ex)
            {
                lblError.Text = $"Error al registrar cliente: {ex.Message}";
                lblError.Visible = true;
            }
        }

        protected void txtEmail_TextChanged(object sender, EventArgs e) { }

        // ==== TRADUCCIONES ====

        private void AplicarTraducciones(Control control)
        {
            foreach (Control child in control.Controls)
            {
                // HTML genérico (h2, div, span, a...)
                if (child is HtmlGenericControl html && html.Attributes["data-translate"] != null)
                {
                    string key = html.Attributes["data-translate"];
                    string t = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(t))
                        html.InnerText = t;
                }
                // WebControls
                else if (child is WebControl web && web.Attributes["data-translate"] != null)
                {
                    string key = web.Attributes["data-translate"];
                    string t = IdiomaManager.Instance.GetTraduccion(key);

                    if (!string.IsNullOrEmpty(t))
                    {
                        if (child is IButtonControl btn)
                            btn.Text = t;

                        if (child is TextBox txt)
                            txt.Attributes["placeholder"] = t;
                    }
                }

                if (child.HasControls())
                    AplicarTraducciones(child);
            }
        }

        private void TraducirCombos()
        {
            // Tipo Documento
            TraducirListItem(ddlTipoDocumento, "DNI", "doc_dni");
            TraducirListItem(ddlTipoDocumento, "CUIT", "doc_cuit");
            TraducirListItem(ddlTipoDocumento, "Pasaporte", "doc_passport");

            // Tipo Cliente
            TraducirListItem(ddlTipoCliente, "Consumidor Final", "client_final_consumer");
            TraducirListItem(ddlTipoCliente, "Responsable Inscripto", "client_registered");
        }

        private void TraducirListItem(DropDownList ddl, string value, string key)
        {
            ListItem item = ddl.Items.FindByValue(value);
            if (item == null) return;

            string t = IdiomaManager.Instance.GetTraduccion(key);
            if (!string.IsNullOrEmpty(t))
                item.Text = t;
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
            TraducirCombos();
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }
    }
}
