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
    public partial class _121_Compras : System.Web.UI.Page
    {
        private static List<CarritoBE> carrito;
        CarritoBLL _carritoService = new CarritoBLL();
        UsuarioBLL _usuarioService = new UsuarioBLL();
        public UsuarioBE usuario { get; set; }
        SessionManager _sessionManager = new SessionManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = _usuarioService.Login("UAC@gmail.com", "S@nlorenzo2566");
            _sessionManager.Set("Usuario", usuario);
            usuario = _sessionManager.Get<UsuarioBE>("Usuario");
            if (!IsPostBack)
            {
                CargarCarrito();
                CalcularTotales();
            }
        }

        private void CargarCarrito()
        {

            carrito = _carritoService.GetCarrito(usuario.Id);

            // Enlaza el carrito al Repeater
            rptCarrito.DataSource = carrito;
            rptCarrito.DataBind();

        }

        private void CalcularTotales()
        {
            decimal subtotal = carrito.Sum(p => p.producto.Precio * p.Cantidad);


            lblTotal.Text = (subtotal).ToString("N2");
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            // Lógica para procesar el pago y finalizar la compra
            // Redirigir o mostrar mensaje de confirmación
        }
    }
}