using BE;
using BE.AFIP;
using BLL;
using System;
using System.Collections.Generic;
using System.IO;
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
        VentaBLL _serviceVenta = new VentaBLL();
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

            try
            {
                VentaBE venta = new VentaBE();

                
                decimal Base = 0;
                decimal IVA = 0;

                var taxGroups = carrito
               .GroupBy(item => item.producto.codigoIVA.Codigo)
               .Select(g =>
               {
                   var codigoIVA = CodigoIVA.ObtenerTipoIVA(g.Key);
                   decimal tasaIVA = codigoIVA.Porcentaje / 100;
                   decimal baseImponible = Math.Round(g.Sum(item => (item.producto.Precio * item.Cantidad) / (1 + tasaIVA)), 2);
                   decimal totalIVA = Math.Round(g.Sum(item => (item.producto.Precio * item.Cantidad)) - baseImponible, 2);
                   Base += baseImponible;
                   IVA += totalIVA;

                   return new RelatedTaxesBE
                   {
                       codigoIVA = codigoIVA.Codigo,
                       TasaIVA = codigoIVA.Porcentaje,
                       BaseImponible = baseImponible,
                       TotalIVA = totalIVA
                   };
               })
               .ToList();

               
                venta.RelatedTaxes = taxGroups;
                venta.Fecha = DateTime.Now;
                venta.Detalle = "Venta";
                venta.usuario = usuario;
                venta.TotalGravado = Math.Round(Base,2);
                venta.IVA = Math.Round(IVA, 2);
                venta.Total = carrito.Sum(p => p.producto.Precio * p.Cantidad);

                List<Detalle_VentaBE> listDetalle = new List<Detalle_VentaBE>();
                foreach (var item in carrito)
                {
                    decimal baseImponible = Math.Round((item.producto.Precio * item.Cantidad) / (1 + (item.producto.codigoIVA.Porcentaje/100)), 2);
                    decimal totalIVA = Math.Round((item.producto.Precio * item.Cantidad) - baseImponible, 2);
                    Detalle_VentaBE detalle = new BE.Detalle_VentaBE
                    {

                        Producto = item.producto,
                        Descripcion = item.producto.Descripcion,
                        Codigo = item.producto.Codigo,  
                        Cantidad = item.Cantidad,
                        PrecioUnitario = item.producto.Precio,
                        Total = item.Cantidad * item.producto.Precio,
                        IVA = totalIVA,
                        codigoIVA = item.producto.codigoIVA
                    };
                    listDetalle.Add(detalle);
                }

                venta.Items = listDetalle;



                _serviceVenta.RegistrarVenta(venta);
                Response.Redirect("90-Catalogo.aspx");
            }
            catch (Exception ex)
            {
               
            }
        }

        //public List<RelatedTaxesBE> CalcularRelatedTaxes(List<CarritoBE> carrito)
        //{
        //    var taxGroups = carrito
        //        .GroupBy(item => item.producto.codigoIVA.Codigo)
        //        .Select(g =>
        //        {
        //            var codigoIVA = CodigoIVA.ObtenerTipoIVA(g.Key);
        //            decimal tasaIVA = codigoIVA.Porcentaje / 100;
        //            decimal baseImponible = Math.Round(g.Sum(item => (item.producto.Precio * item.Cantidad) / (1 + tasaIVA)), 2);
        //            decimal totalIVA = Math.Round(g.Sum(item => (item.producto.Precio * item.Cantidad)) - baseImponible, 2);

        //            return new RelatedTaxesBE
        //            {
        //                codigoIVA = codigoIVA.Codigo,
        //                TasaIVA = codigoIVA.Porcentaje,
        //                BaseImponible = baseImponible,
        //                TotalIVA = totalIVA
        //            };
        //        })
        //        .ToList();
        //    return taxGroups;
        //    //RelatedTax = taxGroups;
        //}
    }
}