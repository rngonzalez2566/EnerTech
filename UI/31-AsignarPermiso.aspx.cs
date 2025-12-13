using BE;
using BE.Composite;
using BLL;
using Services;                 // IIdiomaObserver / IdiomaManager
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _31_AsignarPermiso : System.Web.UI.Page, IIdiomaObserver
    {
        PermisoBLL _permisoService = new PermisoBLL();
        UsuarioBLL _usarioService = new UsuarioBLL();

        public IList<Componente> PatentesAsignadas { get; set; } = new List<Componente>();
        public IList<Patente> PatentesDisponibles { get; set; } = new List<Patente>();
        public int UsurioSeleccionadoId { get; set; }
        public UsuarioBE UsuarioSeleccionado { get; set; }
        public List<UsuarioBE> Usuarios { get; set; } = new List<UsuarioBE>();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // 1) Cambiar idioma si viene por querystring ANTES de traducir
                string idioma = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idioma))
                    IdiomaManager.Instance.CambiarIdioma(idioma);

                if (!IsPostBack)
                {
                    IdiomaManager.Instance.RegistrarObservador(this);
                }

                Usuarios = _usarioService.GetUsuarios();

                // Mantener el usuario seleccionado entre postbacks
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
                        CargarPatentes(UsurioSeleccionadoId);
                }
                else
                {
                    // Si querés, al cargar inicial, también podrías recuperar el ViewState
                    if (ViewState["UsuarioSeleccionadoId"] != null)
                    {
                        UsurioSeleccionadoId = (int)ViewState["UsuarioSeleccionadoId"];
                        if (UsurioSeleccionadoId > 0)
                            CargarPatentes(UsurioSeleccionadoId);
                    }
                }

                // 2) Aplicar traducciones siempre (así también traduce luego de postback)
                AplicarTraducciones(this);

                // 3) (Opcional) traducir el texto del botón ASP si usás data-translate
                TraducirBotonGuardar();
            }
            catch (Exception)
            {
                Response.Redirect("Default.aspx");
            }
        }

        private void CargarPatentes(int usuarioId)
        {
            UsuarioSeleccionado = _usarioService.GetUsuarioID(usuarioId);
            PatentesAsignadas = UsuarioSeleccionado.Permisos.Where(p => !p.Hijos.Any()).ToList();

            var todasLasPatentes = _permisoService.GetPatentes();
            PatentesDisponibles = todasLasPatentes
                .Where(p => !PatentesAsignadas.Any(pa => pa.id_componente == p.id_componente))
                .ToList();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                var patentesSeleccionadas = Request.Form["patentesSeleccionadas"];
                var idsPatentesSeleccionadas = patentesSeleccionadas?
                    .Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                    .Select(int.Parse)
                    .ToList() ?? new List<int>();

                if (UsurioSeleccionadoId <= 0) return;

                // Asegurar que UsuarioSeleccionado esté cargado
                if (UsuarioSeleccionado == null || UsuarioSeleccionado.id_usuario != UsurioSeleccionadoId)
                    UsuarioSeleccionado = _usarioService.GetUsuarioID(UsurioSeleccionadoId);

                var nuevasPatentes = _permisoService.GetPatentes()
                    .Where(p => idsPatentesSeleccionadas.Contains(p.id_componente))
                    .ToList();

                UsuarioSeleccionado.Permisos.AddRange(nuevasPatentes);

                _permisoService.GuardarPermiso(UsuarioSeleccionado);

                CargarPatentes(UsuarioSeleccionado.id_usuario);

                // Reaplicar traducciones
                AplicarTraducciones(this);
                TraducirBotonGuardar();
            }
            catch (Exception)
            {
                // manejar si querés
            }
        }

        // ===== TRADUCCIONES =====

        private void TraducirBotonGuardar()
        {
            // Si el botón tiene data-translate, lo traducimos acá
            string key = btnGuardar.Attributes["data-translate"];
            if (!string.IsNullOrEmpty(key))
            {
                var t = IdiomaManager.Instance.GetTraduccion(key);
                if (!string.IsNullOrEmpty(t))
                    btnGuardar.Text = t;
            }
        }

        private void AplicarTraducciones(Control control)
        {
            foreach (Control child in control.Controls)
            {
                // HtmlGenericControl (span, div, etc.) con data-translate
                if (child is HtmlGenericControl html && html.Attributes["data-translate"] != null)
                {
                    string key = html.Attributes["data-translate"];
                    string translated = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(translated))
                        html.InnerText = translated;
                }
                // WebControls
                else if (child is WebControl web && web.Attributes["data-translate"] != null)
                {
                    string key = web.Attributes["data-translate"];
                    string translated = IdiomaManager.Instance.GetTraduccion(key);

                    if (!string.IsNullOrEmpty(translated))
                    {
                        if (child is IButtonControl btn) btn.Text = translated;
                        else if (child is ITextControl txt) txt.Text = translated;
                        else if (child is TextBox t) t.Attributes["placeholder"] = translated;
                    }
                }

                if (child.HasControls())
                    AplicarTraducciones(child);
            }
        }

        // Observer
        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
            TraducirBotonGuardar();
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }
    }
}
