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
            usuario = _usuarioService.Login("UAC@gmail.com", "S@nlorenzo2566");
            _sessionManager.Set("Usuario", usuario);
            usuario = _sessionManager.Get<UsuarioBE>("Usuario");
            if (!IsPostBack)
            {
                CargarCarrito();
                CalcularSubtotal();
            }
        }

        private void CargarCarrito()
        {
            // Obtén el carrito de la sesión
            carrito = _carritoService.GetCarrito(usuario.Id);

            // Enlaza el carrito al Repeater
            rptCarrito.DataSource = carrito;
            rptCarrito.DataBind();
        }

        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            // Aumentar la cantidad de un producto en el carrito
            Button btnIncrease = (Button)sender;
            int codigo = Convert.ToInt32(btnIncrease.CommandArgument);

            ActualizarCantidad(codigo, 1);
        }
        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            // Disminuir la cantidad de un producto en el carrito
            Button btnDecrease = (Button)sender;
            int codigo = Convert.ToInt32(btnDecrease.CommandArgument);

            ActualizarCantidad(codigo, -1);
        }

        private void ActualizarCantidad(int codigo, int cambio)
        {

            var carritoBE = carrito.FirstOrDefault(p => p.producto.Id == codigo);
            //CarritoBE carritoBE = new CarritoBE();
            //carritoBE.usuario = usuario;
            //carritoBE.producto = new ProductoBE();
            //carritoBE.producto.Id = codigo;
            carritoBE.Cantidad += cambio;

            if (carritoBE.Cantidad <= 0)
            {
               _carritoService.BorrarCarritoProducto(usuario.Id, codigo);
            }
            else
            {
               _carritoService.ActualizarCarrito(carritoBE);
            }

            CargarCarrito();
            CalcularSubtotal();
        }

           
            
        

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            // Eliminar un producto del carrito
            LinkButton btnRemove = (LinkButton)sender;
           int codigo = Convert.ToInt32(btnRemove.CommandArgument);

            _carritoService.BorrarCarritoProducto(usuario.Id,codigo);

       
            CargarCarrito();
            CalcularSubtotal();
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