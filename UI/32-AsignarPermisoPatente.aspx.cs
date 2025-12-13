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
    public partial class _32_AsignarPermisoPatente : System.Web.UI.Page, IIdiomaObserver
    {
        PermisoBLL _permisoService = new PermisoBLL();
        UsuarioBLL _usuarioService = new UsuarioBLL();

        public int UsurioSeleccionadoId { get; set; }
        public UsuarioBE UsuarioSeleccionado { get; set; }
        public List<UsuarioBE> Usuarios { get; set; } = new List<UsuarioBE>();
        public IList<Componente> FamiliasAsignadas { get; set; } = new List<Componente>();
        public IList<Familia> FamiliasDisponibles { get; set; } = new List<Familia>();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Cambiar idioma si viene en querystring
            string idioma = Request.QueryString["lang"];
            if (!string.IsNullOrEmpty(idioma))
                IdiomaManager.Instance.CambiarIdioma(idioma);

            if (!IsPostBack)
            {
                IdiomaManager.Instance.RegistrarObservador(this);
            }

            try
            {
                Usuarios = _usuarioService.GetUsuarios();

                if (IsPostBack)
                {
                    if (int.TryParse(Request.Form["usuarioSeleccionado"], out int usuarioId))
                    {
                        UsurioSeleccionadoId = usuarioId;
                        ViewState["UsuarioSeleccionadoId"] = usuarioId;
                    }
                    else if (ViewState["UsuarioSeleccionadoId"] != null)
                    {
                        UsurioSeleccionadoId = (int)ViewState["UsuarioSeleccionadoId"];
                    }

                    if (UsurioSeleccionadoId > 0)
                        CargarFamilias(UsurioSeleccionadoId);
                }

                // aplicar traducciones SIEMPRE
                AplicarTraducciones(this);
                TraducirCabeceras();
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

            var todasLasFamilias = _permisoService.GetFamilias();
            FamiliasDisponibles = todasLasFamilias
                .Where(f => !FamiliasAsignadas.Any(fa => fa.id_componente == f.id_componente))
                .ToList();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                var familiasSeleccionadas = Request.Form["familiasSeleccionadas"];
                if (string.IsNullOrEmpty(familiasSeleccionadas) || UsuarioSeleccionado == null)
                    return;

                var idsFamiliasSeleccionadas = familiasSeleccionadas.Split(',')
                    .Where(x => !string.IsNullOrWhiteSpace(x))
                    .Select(int.Parse)
                    .ToList();

                var nuevasFamilias = _permisoService.GetFamilias()
                    .Where(f => idsFamiliasSeleccionadas.Contains(f.id_componente))
                    .ToList();

                UsuarioSeleccionado.Permisos.AddRange(nuevasFamilias);
                _permisoService.GuardarPermiso(UsuarioSeleccionado);

                CargarFamilias(UsuarioSeleccionado.id_usuario);

                // refrescar textos por si cambió idioma
                AplicarTraducciones(this);
                TraducirCabeceras();
            }
            catch
            {
                // opcional: mostrar mensaje
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
            // Familias Asignadas
            thAssignedFamilyName.InnerText = IdiomaManager.Instance.GetTraduccion("family_col_name");
            thAssignedFamilyDesc.InnerText = IdiomaManager.Instance.GetTraduccion("family_col_description");

            // Familias Disponibles
            thAvailableSelect.InnerText = IdiomaManager.Instance.GetTraduccion("family_col_select");
            thAvailableFamilyName.InnerText = IdiomaManager.Instance.GetTraduccion("family_col_name");
            thAvailableFamilyDesc.InnerText = IdiomaManager.Instance.GetTraduccion("family_col_description");
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
            TraducirCabeceras();
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }
    }
}
