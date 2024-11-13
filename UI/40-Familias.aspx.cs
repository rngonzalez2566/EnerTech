using BE.Composite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;

namespace UI
{
    public partial class _40_Familias : System.Web.UI.Page
    {
        PermisoBLL _permisoService = new PermisoBLL();
      
        public IList<Familia> Familias { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            //var clienteLogueado = _sessionManager.Get<Cliente>("Usuario");
            //var idioma = _sessionManager.Get<IIdioma>("Idioma");

            //if (clienteLogueado == null || !PermisoCheck.VerificarPermiso(clienteLogueado.Permisos, Entities.Enums.Permiso.AdministracionFamilias))
            //    Response.Redirect("Default.aspx");

            try
            {
                Familias = _permisoService.GetFamilias();
            }
            catch (Exception)
            {
                
            }
        }
    }
}