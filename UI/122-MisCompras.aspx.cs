using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UI.WebServices;

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
            List<VentaBE> compras = _serviceVenta.GetVentaUser(usuario.id_usuario);

            // Enlaza la lista de compras al Repeater
            ComprasRepeater.DataSource = compras;
            ComprasRepeater.DataBind();
        }

        protected void btnPDF_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string ventaId = btn.CommandArgument;

            if (!string.IsNullOrEmpty(ventaId))
            {
                // Obtener la venta por ID
                VentaBE venta = _serviceVenta.GetVenta(int.Parse(ventaId));

                if (venta != null)
                {

                    GeneraPdfAfip.BusinessInfo businessInfo = new GeneraPdfAfip.BusinessInfo
                    {
                        BusinessName = "ENERTECH",
                        Address = "Av. Varlos Pellegrini 218",
                        IVACondition = "Responsable Inscripto",
                        CUIT = 20358545492,
                        GrossIncome = "Exento",
                        InitialActivities = new DateTime(2024, 05, 01),
                        PathImage = Server.MapPath("~/Images/afip_logo.png") // Ruta del logo
                    };

                    GeneraPdfAfip.ClientInfo clientInfo = new GeneraPdfAfip.ClientInfo
                    {
                        BusinessName = venta.usuario.RazonSocial,
                        FirstName = venta.usuario.Nombre,
                        LastName = venta.usuario.Apellido,
                        Address = "Laprida 231",
                        IVACondition = "Monotributista",
                        CUIT = venta.usuario.Identificacion,
                        SaleCondition = "Tarjeta"
                    };
                    // Generar el PDF
                    byte[] pdfBytes = GeneraPdfAfip.ReceipToPdf(businessInfo, clientInfo, venta);

                    // Configurar la respuesta para mostrar el PDF en el navegador
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AppendHeader("Content-Disposition", "inline; filename=Factura.pdf");
                    Response.BinaryWrite(pdfBytes);
                    Response.Flush();
                    Response.End();
                }
            }
        }
    }
}