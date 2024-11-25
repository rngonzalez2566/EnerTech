using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BE;
using BLL;
using Newtonsoft.Json;
using Services;

namespace UI
{
    public partial class _13_MenuPrincipal :  BasePage
    {
        public UsuarioBE usuario { get; set; }
        SessionManager _sessionManager = new SessionManager();
        VentaBLL _ventaService = new VentaBLL();
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
                 

                    if (!usuario.Email.Contains("@")) // Si no contiene un '@', se asume que está encriptado
                    {
                        usuario.Email = Encriptador.Descencriptar(usuario.Email);
                    }
                    lblUsuarioEmail.Text = "Hola, " + usuario.Email;

                   

                }
                    
            }
            catch (Exception)
            {
                Response.Redirect("Default.aspx");
            }
        }
 

    }
}