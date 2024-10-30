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
    public partial class DetalleCompra : System.Web.UI.Page
    {

        public UsuarioBE usuario { get; set; }
        SessionManager _sessionManager = new SessionManager();
        VentaBLL _serviceVenta = new VentaBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (int.TryParse(Request.QueryString["ventaId"], out int ventaId))
            {
                CargarDetalleCompra(ventaId);
                if (DateTime.TryParse(Request.QueryString["fecha"], out DateTime fecha))
                {
                    LiteralFecha.Text = fecha.ToString("dd/MM/yyyy");
                }

                if (decimal.TryParse(Request.QueryString["total"], out decimal total))
                {
                    LiteralTotal.Text = total.ToString("N2");
                }

            }
            else
            {
                // Maneja el caso en el que no se proporcione un Id válido
                LiteralTitulo.Text = "<h2 class='text-center'>Compra no encontrada</h2>";
            }

        }

        private void CargarDetalleCompra(int ventaId)
        {
            // Obtener la compra desde la base de datos o servicio
            List<Detalle_VentaBE> compra = _serviceVenta.GetDetalleVenta(ventaId);

            if (compra != null)
            {
                //// Asignar datos de la compra a los controles
                //LiteralTitulo.Text = $"<h2 class='text-center'>Compra #{compra.NumeroVenta}</h2>";
                //LiteralFecha.Text = compra.Fecha.ToString("dd/MM/yyyy");
                //LiteralTotal.Text = compra.Total.ToString("N2");

                // Enlazar la lista de productos al Repeater
                ProductosRepeater.DataSource = compra;
                ProductosRepeater.DataBind();
            }
            else
            {
                LiteralTitulo.Text = "<h2 class='text-center'>Compra no encontrada</h2>";
            }
        }


    }
}
