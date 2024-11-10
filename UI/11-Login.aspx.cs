using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Services;
   

namespace UI
{
    public partial class _11_Login : System.Web.UI.Page
    {
        UsuarioBLL usuarioBLL = new UsuarioBLL();

        SessionManager _sessionManager = new SessionManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            var usuario = _sessionManager.Get<UsuarioBE>("Usuario");

            if (usuario != null)
                Response.Redirect("13-MenuPrincipal.aspx");

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {

               UsuarioBE usuario = usuarioBLL.Login(txtEmail.Text, txtPassword.Text);
               if (usuario != null)
               {
                    _sessionManager.Set("Usuario", usuario);
                    Response.Redirect("13-MenuPrincipal.aspx", false);
                    
                }
               else
               {
                    lblMessage.Text = ErrorMessages.ERR012;
                    lblMessage.Visible = true;
                }
                
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.Visible = true;
            }
        }
    }
}