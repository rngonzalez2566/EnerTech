using BE;
using BE.Composite;
using BLL;
using Services; // IIdiomaObserver + IdiomaManager
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _34_DesasignarPermisoPatente : System.Web.UI.Page, IIdiomaObserver
    {
        public List<UsuarioBE> Usuarios { get; set; } = new List<UsuarioBE>();
        public IList<Componente> FamiliasAsignadas { get; set; } = new List<Componente>();
        public int UsuarioSeleccionadoId { get; set; }
        public UsuarioBE UsuarioSeleccionado { get; set; }

        UsuarioBLL _usuarioService = new UsuarioBLL();
        PermisoBLL _permisoService = new PermisoBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Cambiar idioma si viene por querystring
            string idioma = Request.QueryString["lang"];
            if (!string.IsNullOrEmpty(idioma))
                IdiomaManager.Instance.CambiarIdioma(idioma);

            if (!IsPostBack)
                IdiomaManager.Instance.RegistrarObservador(this);

            try
            {
                Usuarios = _usuarioService.GetUsuarios();

                if (IsPostBack)
                {
                    // mantener filtro si querés (ya lo estabas guardando)
                    string filtroUsuario = Request.Form["filtroUsuario"];
                    ViewState["FiltroUsuario"] = filtroUsuario;

                    if (int.TryParse(Request.Form["usuarioSeleccionado"], out int usuarioId))
                    {
                        UsuarioSeleccionadoId = usuarioId;
                        ViewState["UsuarioSeleccionadoId"] = usuarioId;
                    }
                    else if (ViewState["UsuarioSeleccionadoId"] != null)
                    {
                        UsuarioSeleccionadoId = (int)ViewState["UsuarioSeleccionadoId"];
                    }

                    if (UsuarioSeleccionadoId > 0)
                        CargarFamilias(UsuarioSeleccionadoId);
                }

                AplicarTraducciones(this);
                TraducirCabeceras();
                TraducirMensajesJs();
            }
            catch
            {
                Response.Redirect("Default.aspx");
            }
        }

        private void CargarFamilias(int usuarioId)
        {
            UsuarioSeleccionado = _usuarioService.GetUsuarioID(usuarioId);
            FamiliasAsignadas = UsuarioSeleccionado.Permisos
                .Where(f => f.Hijos.Any())
                .GroupBy(f => f.Nombre)
                .Select(g => g.First())
                .ToList();
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                var familiasSeleccionadas = Request.Form["familiasSeleccionadas"];
                var ids = familiasSeleccionadas?
                    .Split(',')
                    .Where(x => !string.IsNullOrWhiteSpace(x))
                    .Select(int.Parse)
                    .ToList() ?? new List<int>();

                UsuarioSeleccionado.EliminarPermisosPorId(ids);
                _permisoService.GuardarPermiso(UsuarioSeleccionado);

                CargarFamilias(UsuarioSeleccionadoId);

                AplicarTraducciones(this);
                TraducirCabeceras();
                TraducirMensajesJs();
            }
            catch
            {
            }
        }

        // === TRADUCCIONES ===

        private void AplicarTraducciones(Control control)
        {
            foreach (Control child in control.Controls)
            {
                if (child is HtmlGenericControl html && html.Attributes["data-translate"] != null)
                {
                    string key = html.Attributes["data-translate"];
                    string translated = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(translated))
                        html.InnerText = translated;
                }
                else if (child is WebControl web && web.Attributes["data-translate"] != null)
                {
                    string key = web.Attributes["data-translate"];
                    string translated = IdiomaManager.Instance.GetTraduccion(key);

                    if (!string.IsNullOrEmpty(translated))
                    {
                        if (child is IButtonControl btn) btn.Text = translated;
                        else if (child is TextBox t) t.Attributes["placeholder"] = translated;
                        else if (child is ITextControl txt) txt.Text = translated;
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
            thFamilyDesc.InnerText = IdiomaManager.Instance.GetTraduccion("perm_col_description");
        }

        private void TraducirMensajesJs()
        {
            // hidden para alert (opcional)
            msgSelectAtLeastOneFamily.Value = IdiomaManager.Instance.GetTraduccion("unassign_family_select_one_alert");
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
