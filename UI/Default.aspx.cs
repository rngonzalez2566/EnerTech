using BLL;
using Services;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _Default : System.Web.UI.Page, IIdiomaObserver
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // 1) Registrar observer
                if (!IsPostBack)
                {
                    IdiomaManager.Instance.RegistrarObservador(this);
                }

                // 2) Leer idioma (?lang=es / ?lang=en)
                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                // 3) Aplicar traducciones a todo lo que tenga data-translate
                AplicarTraducciones(this);
            }
            catch
            {
                // opcional log
            }
        }

        protected void AplicarTraducciones(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                // <a runat="server"> (por si después lo usás)
                if (childControl is System.Web.UI.HtmlControls.HtmlAnchor anchor &&
                    anchor.Attributes["data-translate"] != null)
                {
                    string clave = anchor.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion))
                        anchor.InnerHtml = traduccion;
                }
                // HTML genéricos (h1, p, span, h2, etc.)
                else if (childControl is System.Web.UI.HtmlControls.HtmlGenericControl generic &&
                         generic.Attributes["data-translate"] != null)
                {
                    string clave = generic.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion))
                        generic.InnerText = traduccion;
                }
                // WebControls (por si agregás luego)
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
