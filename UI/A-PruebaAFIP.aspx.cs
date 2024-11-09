using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BE;
using BE.AFIP;
using BLL;
using BLL.AFIP;

namespace UI
{
    public partial class A_PruebaAFIP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }

        protected async void btnObtenerToken_Click(object sender, EventArgs e)
        {
            try
            {
                BLL.AFIP.FacturacionAFIP fac = new BLL.AFIP.FacturacionAFIP();

                // Llamada asíncrona al método
                //BE.AFIP.tokenAFIP afipToken = await token.ObtenerOActualizarTokenAsync();
                VentaBE venta = await fac.GenerarFacturaAFIP(6);
                // Mostrar el resultado en un control de texto
                //txtResultado.Text = "Token obtenido: " + afipToken.token;
            }
            catch (Exception ex)
            {
                txtResultado.Text = "Error: " + ex.Message;
            }
        }
    }
}