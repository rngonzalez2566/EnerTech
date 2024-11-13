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
    public partial class _13_MenuPrincipal : System.Web.UI.Page
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
                    usuario.Email = Encriptador.Descencriptar(usuario.Email);


                    //switch (usuario.Email)
                    //{
                    //    case "webmaster@gmail.com":

                    //        imgUser.ImageUrl = "Images/Webmaster_image.jpg"; // Imagen de webmaster
                    //        break;

                    //    case "UAC@gmail.com":

                    //        imgUser.ImageUrl = "Images/UAC_image.jpg"; // Imagen de UAC
                    //        break;

                    //    case "Cliente@gmail.com":

                    //        imgUser.ImageUrl = "Images/Client_image.jpg"; // Imagen de Cliente
                    //        break;

                    //    default:

                    //        imgUser.ImageUrl = "Images/Default_image.jpg"; // Imagen por defecto
                    //        break;
                    //}
                    try
                    {
                        usuario = _sessionManager.Get<UsuarioBE>("Usuario");

                        if (usuario == null)
                        {
                            Response.Redirect("Default.aspx");
                        }
                        else
                        {

                            lblUsuarioEmail.Text = "Hola, " + usuario.Email;
                        }
                    }
                    catch (Exception)
                    {
                        Response.Redirect("Default.aspx");
                    }

                }
                    
            }
            catch (Exception)
            {
                Response.Redirect("Default.aspx");
            }
        }


       

    }
}