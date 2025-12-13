using BLL;
using Services;                    // IIdiomaObserver + IdiomaManager
using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _111_EditarDatos : System.Web.UI.Page, IIdiomaObserver
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1) Cambiar idioma primero (antes de traducir)
            string idioma = Request.QueryString["lang"];
            if (!string.IsNullOrEmpty(idioma))
                IdiomaManager.Instance.CambiarIdioma(idioma);

            if (!IsPostBack)
            {
                IdiomaManager.Instance.RegistrarObservador(this);

                // Si querés cargar datos existentes, hacelo acá:
                // CargarDatosNegocio();
            }

            // 2) Aplicar traducciones siempre
            AplicarTraducciones(this);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Guardar datos...
        }

        // === TRADUCCIONES ===
        private void AplicarTraducciones(Control control)
        {
            foreach (Control child in control.Controls)
            {
                // HTML genérico: h2, div, span, a...
                if (child is HtmlGenericControl html &&
                    html.Attributes["data-translate"] != null)
                {
                    string key = html.Attributes["data-translate"];
                    string translated = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(translated))
                        html.InnerText = translated;
                }
                // WebControls: Button, TextBox, etc.
                else if (child is WebControl web &&
                         web.Attributes["data-translate"] != null)
                {
                    string key = web.Attributes["data-translate"];
                    string translated = IdiomaManager.Instance.GetTraduccion(key);

                    if (!string.IsNullOrEmpty(translated))
                    {
                        if (child is IButtonControl btn)
                            btn.Text = translated;

                        // IMPORTANTE: placeholder no es TextBox.Text
                        if (child is TextBox txt)
                            txt.Attributes["placeholder"] = translated;
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
