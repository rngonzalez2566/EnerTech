using BE;
using BLL;
using Services;
using System;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _61_DigitosVerificadores : System.Web.UI.Page, IIdiomaObserver
    {
        DigitoVerificadorBLL _digitoService = new DigitoVerificadorBLL();
        SessionManager session = new SessionManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            UsuarioBE usuario = session.Get<UsuarioBE>("Usuario");

            if (usuario == null)
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            string usuarioEmergencia = ConfigurationManager.AppSettings["usuario"];

            if (
                usuario.Email != usuarioEmergencia &&
                !PermisoCheck.VerificarPermiso(usuario.Permisos, BE.Enums.Permiso.AdministracionBaseDeDatos)
            )
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                IdiomaManager.Instance.RegistrarObservador(this);
            }

            // Idioma por querystring
            string idioma = Request.QueryString["lang"];
            if (!string.IsNullOrEmpty(idioma))
            {
                IdiomaManager.Instance.CambiarIdioma(idioma);
            }

            AplicarTraducciones(this);
        }

        protected void btnRecalcular_Click(object sender, EventArgs e)
        {
            try
            {
                _digitoService.RecalcularDigitos();

                lblResultado.Text = IdiomaManager.Instance.GetTraduccion("dv_success");
                lblResultado.CssClass = "status-label text-success";
                lblResultado.Visible = true;
            }
            catch
            {
                lblResultado.Text = IdiomaManager.Instance.GetTraduccion("dv_error");
                lblResultado.CssClass = "status-label text-danger";
                lblResultado.Visible = true;
            }
        }

        protected void AplicarTraducciones(Control control)
        {
            foreach (Control child in control.Controls)
            {
                // HTML genéricos
                if (child is System.Web.UI.HtmlControls.HtmlGenericControl html &&
                    html.Attributes["data-translate"] != null)
                {
                    string key = html.Attributes["data-translate"];
                    string t = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(t))
                        html.InnerText = t;
                }
                // WebControls
                else if (child is WebControl web &&
                         web.Attributes["data-translate"] != null)
                {
                    string key = web.Attributes["data-translate"];
                    string t = IdiomaManager.Instance.GetTraduccion(key);

                    if (!string.IsNullOrEmpty(t))
                    {
                        if (child is IButtonControl btn)
                            btn.Text = t;
                        else if (child is ITextControl txt)
                            txt.Text = t;
                    }
                }

                if (child.HasControls())
                    AplicarTraducciones(child);
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
