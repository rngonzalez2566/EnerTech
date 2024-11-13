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
    public partial class _120_Carrito : System.Web.UI.Page
    {
        private static List<CarritoBE> carrito;
        CarritoBLL _carritoService = new CarritoBLL();
        UsuarioBLL _usuarioService = new UsuarioBLL();
        public UsuarioBE usuario { get; set; }
        SessionManager _sessionManager = new SessionManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            //usuario = _usuarioService.Login("UAC@gmail.com", "S@nlorenzo2566");
            //_sessionManager.Set("Usuario", usuario);
            usuario = _sessionManager.Get<UsuarioBE>("Usuario");
            if (usuario == null)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                CargarCarrito();
                CalcularSubtotal();
            }
        }

        private void CargarCarrito()
        {
            // Obtener el carrito actualizado desde la base de datos
            carrito = _carritoService.GetCarrito(usuario.Id);

            // Enlazar el carrito al Repeater
            rptCarrito.DataSource = carrito;
            rptCarrito.DataBind();
        }


        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            Button btnIncrease = (Button)sender;
            int codigo = Convert.ToInt32(btnIncrease.CommandArgument);
            ActualizarCantidad(codigo, 1);
            Response.Redirect(Request.RawUrl);
        }
        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            Button btnDecrease = (Button)sender;
            int codigo = Convert.ToInt32(btnDecrease.CommandArgument);
            ActualizarCantidad(codigo, -1);
            Response.Redirect(Request.RawUrl);
        }

        private void ActualizarCantidad(int codigo, int cambio)
        {
            // Obtén el producto en el carrito
            var carritoBE = carrito.FirstOrDefault(p => p.producto.Id == codigo);

            if (carritoBE != null)
            {
                carritoBE.Cantidad += cambio;

                if (carritoBE.Cantidad <= 0)
                {
                    // Si la cantidad es 0 o menor, elimina el producto del carrito
                    _carritoService.BorrarCarritoProducto(usuario.Id, codigo);
                }
                else
                {
                    // Actualiza la cantidad en la base de datos
                    _carritoService.ActualizarCarrito(carritoBE);
                }
            }

            // Recargar el carrito desde la base de datos después de actualizar
            CargarCarrito();
            CalcularSubtotal();
        }





        protected void btnRemove_Click(object sender, EventArgs e)
        {
            LinkButton btnRemove = (LinkButton)sender;
            int codigo = Convert.ToInt32(btnRemove.CommandArgument);

            // Eliminar el producto del carrito
            _carritoService.BorrarCarritoProducto(usuario.Id, codigo);

            // Recargar el carrito y el subtotal
            CargarCarrito();
            CalcularSubtotal();
            Response.Redirect(Request.RawUrl);
        }

        private void CalcularSubtotal()
        {
            
            decimal subtotal = carrito.Sum(p => p.producto.Precio * p.Cantidad);

            lblSubtotal.Text = subtotal.ToString("N2");
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            // Redirigir a la página de finalización de compra
            Response.Redirect("121-Compras.aspx");
        }
    }
}