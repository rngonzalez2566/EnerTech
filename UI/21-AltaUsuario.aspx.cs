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

            // 2) Traducir siempre (incluye el UserControl porque es parte del árbol de controles)
            AplicarTraducciones(this);
            TraducirCombos();
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblError.Visible = false;
            lblError.Text = "";

            // ✅ Si falla, los validators ya muestran el mensaje debajo del campo
            if (!Page.IsValid)
                return;

            try
            {
                UsuarioBE usuario = new UsuarioBE()
                {
                    Nombre = ValidarAltaUsuarioControl.NombreValue,
                    Apellido = ValidarAltaUsuarioControl.ApellidoValue,
                    Email = ValidarAltaUsuarioControl.EmailValue,
                    Password = ValidarAltaUsuarioControl.PasswordValue,
                    RazonSocial = ValidarAltaUsuarioControl.RazonSocialValue,
                    Identificacion = int.Parse(ValidarAltaUsuarioControl.IdentificacionValue),
                    TipoCliente = ValidarAltaUsuarioControl.TipoClienteValue,
                    TipoDocumento = ValidarAltaUsuarioControl.TipoDocumentoValue,
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
            // Tipo Documento (están dentro del UserControl)
            TraducirListItem(ValidarAltaUsuarioControl.FindControl("ddlTipoDocumento") as DropDownList, "DNI", "doc_dni");
            TraducirListItem(ValidarAltaUsuarioControl.FindControl("ddlTipoDocumento") as DropDownList, "CUIT", "doc_cuit");
            TraducirListItem(ValidarAltaUsuarioControl.FindControl("ddlTipoDocumento") as DropDownList, "Pasaporte", "doc_passport");

            // Tipo Cliente
            TraducirListItem(ValidarAltaUsuarioControl.FindControl("ddlTipoCliente") as DropDownList, "Consumidor Final", "client_final_consumer");
            TraducirListItem(ValidarAltaUsuarioControl.FindControl("ddlTipoCliente") as DropDownList, "Responsable Inscripto", "client_registered");
        }

        private void TraducirListItem(DropDownList ddl, string value, string key)
        {
            if (ddl == null) return;

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
