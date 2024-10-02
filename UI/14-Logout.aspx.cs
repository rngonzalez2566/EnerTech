using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _14_Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("Usuario");
            Session.Abandon();
            Response.Redirect("Default.aspx"); // Redirige a la página de inicio de sesión
        }
    }
}