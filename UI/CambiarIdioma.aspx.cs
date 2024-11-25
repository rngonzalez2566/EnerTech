using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class CambiarIdioma : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var sessionManager = new SessionManager();
            string idioma = Request.QueryString["idioma"]; // Captura el idioma de la solicitud

            if (!string.IsNullOrEmpty(idioma))
            {
                sessionManager.SetIdioma(idioma); // Actualiza el idioma en la sesión
                Response.Write("{\"success\": true}");
            }
            else
            {
                Response.Write("{\"success\": false}");
            }

            Response.End();
        }
    }
}