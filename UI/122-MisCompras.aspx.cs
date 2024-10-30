using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _122_MisCompras : System.Web.UI.Page
    {
        SessionManager _sessionManager = new SessionManager();
        VentaBLL _serviceVenta = new VentaBLL();
        public UsuarioBE usuario { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = _sessionManager.Get<UsuarioBE>("Usuario");
            if (usuario == null)
            {
                Response.Redirect("Default.aspx");
            }
            CargarCompras();
        }

        private void CargarCompras()
        {
        

            // Llamada al servicio o a la base de datos para obtener las compras del usuario
            List<VentaBE> compras = _serviceVenta.GetVentaUser(usuario.Id);

            // Enlaza la lista de compras al Repeater
            ComprasRepeater.DataSource = compras;
            ComprasRepeater.DataBind();
        }
    }
}