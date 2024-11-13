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
    public partial class _31_AsignarPermiso : System.Web.UI.Page
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
            //var clienteLogueado = _sessionManager.Get<Cliente>("Usuario");
            //var idioma = _sessionManager.Get<IIdioma>("Idioma");

            //if (clienteLogueado == null || !PermisoCheck.VerificarPermiso(clienteLogueado.Permisos, Entities.Enums.Permiso.AsignarPatentes))
            //    Response.Redirect("Default.aspx");

            try
            {
                Usuarios = _usarioService.GetUsuarios();

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
                        CargarPatentes(UsurioSeleccionadoId);
                    }
                }
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
            PatentesDisponibles = todasLasPatentes.Where(p => !PatentesAsignadas.Any(pa => pa.Id == p.Id)).ToList();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            //var idioma = _sessionManager.Get<IIdioma>("Idioma");

            try
            {
                var patentesSeleccionadas = Request.Form["patentesSeleccionadas"];
                var patentesAsignadas = Request.Form["patentesAsignadas"];

                //if (patentesSeleccionadas == null || string.IsNullOrEmpty(patentesSeleccionadas) || ClienteSeleccionado == null)
                //    return;

                var idsPatentesSeleccionadas = patentesSeleccionadas?.Split(',').Select(int.Parse).ToList() ?? new List<int>();

                var nuevasPatentes = _permisoService.GetPatentes().Where(p => idsPatentesSeleccionadas.Contains(p.Id)).ToList();

                UsuarioSeleccionado.Permisos.AddRange(nuevasPatentes);

                _permisoService.GuardarPermiso(UsuarioSeleccionado);

                CargarPatentes(UsuarioSeleccionado.Id);

               
            }
           
            catch (Exception)
            {
               
            }
        }
    }
}