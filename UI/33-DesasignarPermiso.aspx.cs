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
    public partial class _33_DesasignarPermiso : System.Web.UI.Page
    {
        public List<UsuarioBE> Usuarios { get; set; } = new List<UsuarioBE>();
        public IList<Componente> PatentesAsignadas { get; set; } = new List<Componente>();
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
                        CargarPatentes(UsuarioSeleccionadoId);
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
            UsuarioSeleccionado = _usuarioService.GetUsuarioID(usuarioId);
            PatentesAsignadas = UsuarioSeleccionado.Permisos.Where(p => !p.Hijos.Any()).ToList();
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                var patentesSeleccionadas = Request.Form["patentesSeleccionadas"];
                var idsPatentesSeleccionadas = patentesSeleccionadas?.Split(',').Select(int.Parse).ToList() ?? new List<int>();

                UsuarioSeleccionado.EliminarPermisosPorId(idsPatentesSeleccionadas);

                _permisoService.GuardarPermiso(UsuarioSeleccionado);

                CargarPatentes(UsuarioSeleccionadoId);

               
            }
            catch (Exception)
            {
                
            }
        }
    }
}