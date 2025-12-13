using BE.Composite;
using BLL;
using Services; // IIdiomaObserver + IdiomaManager
using System;
using System.Collections.Generic;
using System.Web.UI;


namespace UI
{
    public partial class _40_Familias : System.Web.UI.Page, IIdiomaObserver
    {
        PermisoBLL _permisoService = new PermisoBLL();
        public IList<Familia> Familias { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // cambiar idioma si viene en querystring
            string idioma = Request.QueryString["lang"];
            if (!string.IsNullOrEmpty(idioma))
                IdiomaManager.Instance.CambiarIdioma(idioma);

            if (!IsPostBack)
                IdiomaManager.Instance.RegistrarObservador(this);

            try
            {
                Familias = _permisoService.GetFamilias();

                // aplicar traducciones siempre (después de cargar datos)
                AplicarTraducciones(this);
                TraducirCabeceras();
                TraducirMensajesJs();
            }
            catch (Exception)
            {
            }
        }

        private void AplicarTraducciones(Control control)
        {
            foreach (Control child in control.Controls)
            {
                if (child is System.Web.UI.HtmlControls.HtmlGenericControl html &&
                    html.Attributes["data-translate"] != null)
                {
                    string key = html.Attributes["data-translate"];
                    string translated = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(translated))
                        html.InnerText = translated;
                }
                else if (child is System.Web.UI.WebControls.WebControl web &&
                         web.Attributes["data-translate"] != null)
                {
                    string key = web.Attributes["data-translate"];
                    string translated = IdiomaManager.Instance.GetTraduccion(key);

                    if (!string.IsNullOrEmpty(translated))
                    {
                        if (child is System.Web.UI.WebControls.IButtonControl btn)
                            btn.Text = translated;
                        else if (child is System.Web.UI.ITextControl txt)
                            txt.Text = translated;
                    }
                }

                if (child.HasControls())
                    AplicarTraducciones(child);
            }
        }

        private void TraducirCabeceras()
        {
            thSelect.InnerText = IdiomaManager.Instance.GetTraduccion("perm_col_select");
            thFamilyName.InnerText = IdiomaManager.Instance.GetTraduccion("perm_col_family_name");
        }

        private void TraducirMensajesJs()
        {
            msgSelectFamily.Value = IdiomaManager.Instance.GetTraduccion("families_msg_select_for_delete");
            msgConfirmDelete.Value = IdiomaManager.Instance.GetTraduccion("families_msg_confirm_delete_tpl");
            msgDeletedOk.Value = IdiomaManager.Instance.GetTraduccion("families_msg_deleted_ok_tpl");
            msgSelectFamilyEdit.Value = IdiomaManager.Instance.GetTraduccion("families_msg_select_for_edit");
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
            TraducirCabeceras();
            TraducirMensajesJs();
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }
    }
}
