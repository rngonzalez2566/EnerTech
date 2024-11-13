using BE;
using BE.Composite;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _32_AsignarPermisoPatente : System.Web.UI.Page
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
            //var clienteLogueado = _sessionManager.Get<Cliente>("Usuario");
            //var idioma = _sessionManager.Get<IIdioma>("Idioma");

            //if (clienteLogueado == null || !PermisoCheck.VerificarPermiso(clienteLogueado.Permisos, Entities.Enums.Permiso.AsignarFamilias))
            //    Response.Redirect("Default.aspx");

            try
            {
                Usuarios = _usuarioService.GetUsuarios();

                if (IsPostBack)
                {
                    string filtroUsuario = Request.Form["filtroUsuario"];
                    ViewState["FiltroUsuario"] = filtroUsuario;

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
                    {
                        CargarFamilias(UsurioSeleccionadoId);
                    }
                }
            }
            catch (Exception)
            {

                Response.Redirect("Default.aspx");
            }
        }

        private void CargarFamilias(int usuarioId)
        {
            UsuarioSeleccionado = _usuarioService.GetUsuarioID(usuarioId);
            //FamiliasAsignadas = UsuarioSeleccionado.Permisos.Where(f => f.Hijos.Any()).ToList();
            FamiliasAsignadas = UsuarioSeleccionado.Permisos
    .Where(f => f.Hijos.Any())
    .GroupBy(f => f.Nombre)
    .Select(g => g.First())
    .ToList();

            var todasLasFamilias = _permisoService.GetFamilias();
            FamiliasDisponibles = todasLasFamilias.Where(f => !FamiliasAsignadas.Any(fa => fa.Id == f.Id)).ToList();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            //var idioma = _sessionManager.Get<IIdioma>("Idioma");

            try
            {
                var familiasSeleccionadas = Request.Form["familiasSeleccionadas"];
                var familiasAsignadas = Request.Form["familiasAsignadas"];

                if (string.IsNullOrEmpty(familiasSeleccionadas) || UsuarioSeleccionado == null || string.IsNullOrEmpty(familiasSeleccionadas))
                    return;

                var idsFamiliasSeleccionadas = familiasSeleccionadas?.Split(',').Select(int.Parse).ToList() ?? new List<int>();

                var nuevasFamilias = _permisoService.GetFamilias().Where(f => idsFamiliasSeleccionadas.Contains(f.Id)).ToList();

                UsuarioSeleccionado.Permisos.AddRange(nuevasFamilias);

                _permisoService.GuardarPermiso(UsuarioSeleccionado);

                CargarFamilias(UsuarioSeleccionado.Id);


            }
            catch (Exception)
            {

            }
        }
    }
}