using BE.Composite;
using BLL;
using Services; // IIdiomaObserver + IdiomaManager
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _41_CrearFamilias : System.Web.UI.Page, IIdiomaObserver
    {
        PermisoBLL _permisoService = new PermisoBLL();
        public List<Patente> Patentes { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1) Cambiar idioma si viene por querystring
            string idioma = Request.QueryString["lang"];
            if (!string.IsNullOrEmpty(idioma))
                IdiomaManager.Instance.CambiarIdioma(idioma);

            if (!IsPostBack)
            {
                IdiomaManager.Instance.RegistrarObservador(this);

                try
                {
                    Patentes = _permisoService.GetPatentes();
                }
                catch { }
            }

            // 2) Aplicar traducciones siempre
            AplicarTraducciones(this);
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
        }

        private void AplicarTraducciones(Control control)
        {
            foreach (Control child in control.Controls)
            {
                // HtmlGenericControl (div, h2, span, label, etc.)
                if (child is HtmlGenericControl html && html.Attributes["data-translate"] != null)
                {
                    string key = html.Attributes["data-translate"];
                    string t = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(t))
                        html.InnerText = t;
                }
                // HtmlButton (por si algún día usás <button runat="server">)
                else if (child is HtmlButton htmlBtn && htmlBtn.Attributes["data-translate"] != null)
                {
                    string key = htmlBtn.Attributes["data-translate"];
                    string t = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(t))
                        htmlBtn.InnerText = t;
                }
                // WebControls (asp:Button, asp:Label, etc.)
                else if (child is WebControl web && web.Attributes["data-translate"] != null)
                {
                    string key = web.Attributes["data-translate"];
                    string t = IdiomaManager.Instance.GetTraduccion(key);

                    if (!string.IsNullOrEmpty(t))
                    {
                        if (child is IButtonControl btn)
                            btn.Text = t;
                        else if (child is Label lbl)
                            lbl.Text = t;
                        else if (child is TextBox tb)
                            tb.Attributes["placeholder"] = t;
                    }
                }

                if (child.HasControls())
                    AplicarTraducciones(child);
            }
        }

        protected void btnCrear_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                string nombreFamilia = ValidarCrearFamiliaControl.NombreFamilia;

                if (!string.IsNullOrEmpty(nombreFamilia))
                {
                    GuardarFamilia(nombreFamilia, new string[0]);
                    ValidarCrearFamiliaControl.Limpiar();
                }
            }
            catch (Exception ex)
            {
                
            }
        }


        private void GuardarFamilia(string nombreFamilia, string[] patentesIds)
        {
            var familia = new Familia() { Nombre = nombreFamilia };

            // si no hay patentes, no agrega hijos (ok)
            foreach (string id in patentesIds)
            {
                if (int.TryParse(id, out int idInt))
                {
                    var patente = new Patente { id_componente = idInt };
                    familia.AgregarHijo(patente);
                }
            }

            int familiaId = _permisoService.GuardarPatenteFamilia(familia, true);

            if (familiaId > 0)
            {
                familia.id_componente = familiaId;
                _permisoService.GuardarFamiliaCreada(familia);
            }
        }
    }
}
