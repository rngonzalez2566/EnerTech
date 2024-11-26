using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Services;
namespace UI
{
    public partial class _61_DigitosVerificadores : System.Web.UI.Page
    {
        DigitoVerificadorBLL _digitoService = new DigitoVerificadorBLL();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnRecalcular_Click(object sender, EventArgs e)
        {
            try
            {
                // Llama al método del negocio para recalcular los dígitos verificadores
                _digitoService.RecalcularDigitos();

                // Muestra un mensaje de éxito
                lblResultado.Text = "Dígitos verificadores recalculados correctamente.";
                lblResultado.CssClass = "status-label text-success"; // Clase CSS para éxito
                lblResultado.Visible = true;
            }
            catch
            {
                // Maneja cualquier error y muestra un mensaje al usuario
                lblResultado.Text = ErrorMessages.ERR027;
                lblResultado.CssClass = "status-label text-danger"; // Clase CSS para error
                lblResultado.Visible = true;
            }
        }
    }
}