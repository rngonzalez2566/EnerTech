using BE;
using BLL;
using Services;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _23_CambiarPassword : System.Web.UI.Page, IIdiomaObserver
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // 1) Registrar observer una sola vez
                if (!IsPostBack)
                {
                    IdiomaManager.Instance.RegistrarObservador(this);
                }

                // 2) Leer idioma del querystring (?lang=es / ?lang=en)
                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                // 3) Aplicar traducciones
                AplicarTraducciones(this);
            }
            catch
            {
                // opcional log
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string currentPassword = txtCurrentPassword.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(currentPassword) ||
                string.IsNullOrEmpty(newPassword) ||
                string.IsNullOrEmpty(confirmPassword))
            {
                ScriptManager.RegisterStartupScript(this, GetType(),
                    "alert", "alert('Por favor complete todos los campos');", true);
                return;
            }

            if (newPassword != confirmPassword)
            {
                ScriptManager.RegisterStartupScript(this, GetType(),
                    "alert", "alert('La nueva contraseña no coincide');", true);
                return;
            }

            try
            {
                var usuario = (UsuarioBE)Session["Usuario"];
                if (usuario == null)
                    throw new Exception("Sesión expirada");

                UsuarioBLL bll = new UsuarioBLL();

                bll.CambiarPassword(
                    usuario.id_usuario,
                    currentPassword,
                    newPassword
                );

                ScriptManager.RegisterStartupScript(this, GetType(),
                    "alert", "alert('Contraseña cambiada correctamente');", true);

                txtCurrentPassword.Text = "";
                txtNewPassword.Text = "";
                txtConfirmPassword.Text = "";
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(),
                    "alert", $"alert('{ex.Message}');", true);
            }
        }

        protected void AplicarTraducciones(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                // 1) <a runat="server">
                if (childControl is System.Web.UI.HtmlControls.HtmlAnchor anchor &&
                    anchor.Attributes["data-translate"] != null)
                {
                    string clave = anchor.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion)) anchor.InnerHtml = traduccion;
                }
                // 2) HTML genéricos
                else if (childControl is System.Web.UI.HtmlControls.HtmlGenericControl generic &&
                         generic.Attributes["data-translate"] != null)
                {
                    string clave = generic.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion)) generic.InnerText = traduccion;
                }
                // 3) WebControls
                else if (childControl is WebControl webControl &&
                         webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        if (childControl is ITextControl textControl) textControl.Text = traduccion;
                        else if (childControl is IButtonControl buttonControl) buttonControl.Text = traduccion;
                    }
                }

                if (childControl.HasControls())
                    AplicarTraducciones(childControl);
            }
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }
    }
}
