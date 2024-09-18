using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BE;
using BLL;
using Services;

namespace UI
{
    public partial class _13_MenuPrincipal : System.Web.UI.Page
    {
        public UsuarioBE usuario { get; set; }
        SessionManager _sessionManager = new SessionManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                usuario = _sessionManager.Get<UsuarioBE>("Usuario");

                if (usuario == null)
                {
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    usuario.Email = Encriptador.Descencriptar(usuario.Email);
                }
                    

             
            }
            catch (Exception ex)
            {
                Response.Redirect("Default.aspx");
            }
        }
    }
}