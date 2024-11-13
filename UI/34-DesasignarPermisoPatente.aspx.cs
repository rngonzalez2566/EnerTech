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
    public partial class _34_DesasignarPermisoPatente : System.Web.UI.Page
    {
        public List<UsuarioBE> Usuarios { get; set; } = new List<UsuarioBE>();
        public IList<Componente> FamiliasAsignadas { get; set; } = new List<Componente>();
        public int UsuarioSeleccionadoId { get; set; }
        public UsuarioBE UsuarioSeleccionado { get; set; }
        UsuarioBLL _usuarioService = new UsuarioBLL();
        PermisoBLL _permisoService = new PermisoBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Usuarios = _usuarioService.GetUsuarios();

                if (IsPostBack)
                {
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
                    {
                        CargarFamilias(UsuarioSeleccionadoId);
                    }
                }
            }
            catch (Exception)
            {
                //AlertHelper.MostrarMensaje(this, $"Error al cargar la página: {ex.Message}.");
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
                var idsFamiliasSeleccionadas = familiasSeleccionadas?.Split(',').Select(int.Parse).ToList() ?? new List<int>();

                UsuarioSeleccionado.EliminarPermisosPorId(idsFamiliasSeleccionadas);

                _permisoService.GuardarPermiso(UsuarioSeleccionado);

                CargarFamilias(UsuarioSeleccionadoId);

                
            }
            catch (Exception)
            {
                
            }
        }
    }
}