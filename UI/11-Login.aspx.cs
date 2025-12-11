using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Services;
using System.Configuration;

namespace UI
{
    public partial class _11_Login : System.Web.UI.Page
    {
        UsuarioBLL usuarioBLL = new UsuarioBLL();

        SessionManager _sessionManager = new SessionManager();
        DigitoVerificadorBLL dv = new DigitoVerificadorBLL();
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

            
               if(dv.VerificarDV())
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
                else
                {
                    var user = ConfigurationManager.AppSettings["usuario"];
                    var password = ConfigurationManager.AppSettings["password"];

                    if (txtEmail.Text == user && txtPassword.Text == password)
                    {
                        UsuarioBE userBE = new UsuarioBE();
                        userBE.Email = txtEmail.Text;
                       

                        _sessionManager.Set("Usuario", userBE);

                        Response.Redirect("13-MenuPrincipal.aspx", false);
                        
                    }
                    else
                    {
                        lblMessage.Text = ErrorMessages.ERR014;
                        lblMessage.Visible = true;
                    }
                 

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