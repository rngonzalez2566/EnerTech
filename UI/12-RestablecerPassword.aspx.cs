using BLL;
using Services;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _12_RestablecerPassword : System.Web.UI.Page, IIdiomaObserver
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // 1) Cambiar idioma primero
                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                // 2) Registrar observers (Page + Navbar)
                if (!IsPostBack)
                {
                    IdiomaManager.Instance.RegistrarObservador(this);

                    //if (navigationBar != null)
                    //    IdiomaManager.Instance.RegistrarObservador(navigationBar);
                }

                // 3) Traducir página completa
                AplicarTraducciones(this);
                AplicarTraduccionesAdicionales();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en 12-RestablecerPassword: {ex.Message}");
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            

            try
            {
            

                string email = txtEmail.Text.Trim();
                if (string.IsNullOrEmpty(email))
                    return;

                var usuarioBLL = new UsuarioBLL();
                usuarioBLL.RestablecerPasswordYEnviar(email);

                // Mensaje “neutro” (no dice si existe o no)
                string msg = IdiomaManager.Instance.GetTraduccion("reset_password_sent")
                             ?? "Si el email existe, te enviamos una contraseña temporal.";

                ScriptManager.RegisterStartupScript(this, GetType(), "ok",
                   $"showToast('{msg}', 'success');", true);

                txtEmail.Text = "";
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "err",
                    $"showToast('Error: {ex.Message}', 'danger');", true);
            }

        }

        private void AplicarTraduccionesAdicionales()
        {
            // Placeholder
            string ph = IdiomaManager.Instance.GetTraduccion("reset_password_email_placeholder");
            if (!string.IsNullOrEmpty(ph))
                txtEmail.Attributes["placeholder"] = ph;

            // Title
            string title = IdiomaManager.Instance.GetTraduccion("reset_password_title");
            if (!string.IsNullOrEmpty(title))
                Page.Title = title;
        }

        protected void AplicarTraducciones(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                if (childControl is System.Web.UI.HtmlControls.HtmlAnchor anchor &&
                    anchor.Attributes["data-translate"] != null)
                {
                    string clave = anchor.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion))
                        anchor.InnerHtml = traduccion;
                }
                else if (childControl is System.Web.UI.HtmlControls.HtmlGenericControl generic &&
                         generic.Attributes["data-translate"] != null)
                {
                    string clave = generic.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion))
                        generic.InnerText = traduccion;
                }
                else if (childControl is WebControl webControl &&
                         webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        if (childControl is ITextControl textControl)
                            textControl.Text = traduccion;
                        else if (childControl is IButtonControl buttonControl)
                            buttonControl.Text = traduccion;
                    }
                }

                if (childControl.HasControls())
                    AplicarTraducciones(childControl);
            }
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
            AplicarTraduccionesAdicionales();
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);

            //if (navigationBar != null)
            //    IdiomaManager.Instance.EliminarObservador(navigationBar);
        }
    }
}
