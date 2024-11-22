﻿using BE;
using BLL;
using iText.StyledXmlParser.Jsoup.Nodes;
using Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class NavBar : System.Web.UI.UserControl
    {
        public UsuarioBE usuario { get; set; }
        SessionManager _sessionManager = new SessionManager();
        UsuarioBLL _usuarioService = new UsuarioBLL();
        CarritoBLL _carritoService = new CarritoBLL();
        protected System.Web.UI.HtmlControls.HtmlGenericControl navigationBar;

        public void Page_Load(object sender, EventArgs e)
        {
            try
            {
                int cantidadCarrito = 0;
                //usuario = _usuarioService.Login("UAC@gmail.com", "S@nlorenzo2566");
                //_sessionManager.Set("Usuario", usuario);
                usuario = _sessionManager.Get<UsuarioBE>("Usuario");
              

              
                if (usuario == null)
                {
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    //usuario.Email = Encriptador.Descencriptar(usuario.Email);
                    cantidadCarrito = _carritoService.GetCantidadCarrito(usuario.Id);
                    bool xEntro = false;
                    foreach (var permiso in usuario.Permisos)
                    {
                        if (permiso.Permiso == BE.Enums.Permiso.EsFamilia && permiso.Nombre == "Webmaster")
                        {
                            xEntro = true;
                            SetWebmasterNavigation();
                            break;
                        }
                        else if (permiso.Permiso == BE.Enums.Permiso.EsFamilia && permiso.Nombre == "Cliente")
                        {
                            xEntro = true;
                            SetClientNavigation(cantidadCarrito);
                            break;
                        }
                        else if(permiso.Permiso == BE.Enums.Permiso.EsFamilia && permiso.Nombre == "Administrador Financiero Contable")
                        {
                            xEntro = true;
                            SetUACNavigation(cantidadCarrito);
                            break;
                        }

                        if(xEntro == false)
                        {
                            SetDefaultNavigation();
                        }
                   
                    }

                    //switch (usuario.Email)
                    //{
                    //    case "webmaster@gmail.com":
                    //        SetWebmasterNavigation();
                    //        break;

                    //    case "UAC@gmail.com":
                    //        SetUACNavigation(cantidadCarrito);
                    //        break;

                    //    case "Cliente@gmail.com":
                    //        SetClientNavigation(cantidadCarrito);
                    //        break;

                    //    default:
                    //        SetDefaultNavigation();
                    //        break;
                    //}


                }

            }
            catch (Exception)
            {
                Response.Redirect("Default.aspx");
            }
        }

        private void SetWebmasterNavigation()
        {
            navigationBar.InnerHtml = @"
<nav class='navbar navbar-expand-lg navbar-dark bg-primary'>
    <div class='container-fluid'>
        <a class='navbar-brand' href='Home.aspx'>EnerTech</a>
        <button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarWebmaster' aria-controls='navbarWebmaster' aria-expanded='false'>
            <span class='navbar-toggler-icon'></span>
        </button>
        <div class='collapse navbar-collapse' id='navbarWebmaster'>
            <ul class='navbar-nav mx-auto'>
                <li class='nav-item dropdown'>
                    <a class='nav-link dropdown-toggle' href='#' data-bs-toggle='dropdown'>Usuarios</a>
                    <ul class='dropdown-menu'>
                        <li><a class='dropdown-item' href='21-AltaUsuario'>Alta Usuario</a></li>
                        <li><a class='dropdown-item' href='#'>Modificación Usuario</a></li>
                        <li><a class='dropdown-item' href='#'>Cambiar Contraseña</a></li>
                        <li><a class='dropdown-item' href='#'>Baja Usuario</a></li>
                    </ul>
                </li>
                <li class='nav-item dropdown'>
                    <a class='nav-link dropdown-toggle' href='#' data-bs-toggle='dropdown'>Permisos</a>
                    <ul class='dropdown-menu'>
                        <li><a class='dropdown-item' href='40-Familias.aspx'>Administracion Familias</a></li>
                        <li><a class='dropdown-item' href='31-AsignarPermiso.aspx'>Asignar Permiso usuario</a></li>
                        <li><a class='dropdown-item' href='32-AsignarPermisoPatente.aspx'>Asignar Familia usuario</a></li>
                        <li><a class='dropdown-item' href='33-DesasignarPermiso'>Desasignar Permiso usuario</a></li>
                        <li><a class='dropdown-item' href='34-DesasignarPermisoPatente'>Desasignar Familia usuario</a></li>
                    </ul>
                </li>
                <li class='nav-item'><a class='nav-link' href='50-Backup.aspx'>Backup</a></li>
                <li class='nav-item'><a class='nav-link' href='60-Bitacora.aspx'>Bitácora</a></li>
            </ul>
            <div class='dropdown profile-icon'>
                <a href='#' data-bs-toggle='dropdown'><img src='https://cdn-icons-png.flaticon.com/512/149/149071.png' alt='Profile'></a>
                <ul class='dropdown-menu dropdown-menu-end'>
                    <li><a class='dropdown-item' href='#'>Ver Perfil</a></li>
                    <li><a class='dropdown-item btn-logout' href='14-Logout.aspx'>Cerrar Sesión</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>";
        }

        private void SetUACNavigation(int cantidadCarrito)
        {


            navigationBar.InnerHtml = $@"
<asp:UpdatePanel ID='UpdatePanelCarritoUAC' runat='server' UpdateMode='Always'>
    <ContentTemplate>
        <nav class='navbar navbar-expand-lg navbar-dark bg-success'>
            <div class='container-fluid'>
                <a class='navbar-brand' href='Home.aspx'>EnerTech</a>
                <button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarUAC' aria-controls='navbarUAC' aria-expanded='false'>
                    <span class='navbar-toggler-icon'></span>
                </button>
                <div class='collapse navbar-collapse' id='navbarUAC'>
                    <ul class='navbar-nav mx-auto'>
                        <li class='nav-item dropdown'>
                            <a class='nav-link dropdown-toggle' href='#' data-bs-toggle='dropdown'>Productos</a>
                            <ul class='dropdown-menu'>
                                <li><a class='dropdown-item' href='70-Productos.aspx'>Ver Productos</a></li>
                                <li><a class='dropdown-item' href='71-AltaProducto.aspx'>Alta Producto</a></li>
                            </ul>
                        </li>
                        <li class='nav-item'><a class='nav-link' href='90-Catalogo.aspx'>Catálogo</a></li>
                        <li class='nav-item'><a class='nav-link' href='100-Ventas.aspx'>Ventas</a></li>
                    </ul>
                    {GetProfileMenu()}
                </div>
            </div>
        </nav>
    </ContentTemplate>
</asp:UpdatePanel>";
        }




        private void SetClientNavigation(int cantidadCarrito)
        {


            navigationBar.InnerHtml = $@"
<asp:UpdatePanel ID='UpdatePanelCarritoClient' runat='server' UpdateMode='Always'>
    <ContentTemplate>
           <nav class='navbar navbar-expand-lg navbar-dark bg-success'>
            <div class='container-fluid'>
                <a class='navbar-brand' href='Home.aspx'>EnerTech</a>
                <button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarClient' aria-controls='navbarClient' aria-expanded='false'>
                    <span class='navbar-toggler-icon'></span>
                </button>
                <div class='collapse navbar-collapse' id='navbarClient'>
                    <ul class='navbar-nav mx-auto'>
                        <li class='nav-item'><a class='nav-link' href='90-Catalogo.aspx'>Catálogo</a></li>

                        <!-- Enlace al Carrito con contador de artículos -->
                                       <li class='nav-item position-relative'>
    <a class='nav-link d-flex align-items-center' href='120-Carrito.aspx'>
        Carrito
        <span class='badge bg-warning text-dark position-absolute top-0 start-100 translate-middle rounded-circle' style='transform: translate(-50%, -30%); min-width: 24px; min-height: 24px;'>
            {cantidadCarrito}
        </span>
    </a>
</li>

                        <li class='nav-item'><a class='nav-link' href='122-MisCompras.aspx'>Mis Compras</a></li>
                    </ul>
                    {GetProfileMenu()}
                </div>
            </div>
        </nav>
    </ContentTemplate>
</asp:UpdatePanel>";
        }

        



        private string GetProfileMenu()
        {
            return @"
<div class='dropdown profile-icon'>
    <a href='#' class='d-flex align-items-center' data-bs-toggle='dropdown'>
        <img src='https://cdn-icons-png.flaticon.com/512/149/149071.png' alt='Profile' class='rounded-circle' style='width: 40px; height: 40px;'>
    </a>
    <ul class='dropdown-menu dropdown-menu-end'>
        <li><a class='dropdown-item' href='#'>Ver Perfil</a></li>
        <li><a class='dropdown-item' href='14-Logout.aspx'>Cerrar Sesión</a></li>
    </ul>
</div>";
        }

        private void SetDefaultNavigation()
        {
            navigationBar.InnerHtml = $@"
           <nav class='navbar navbar-expand-lg navbar-dark bg-success'>
            <div class='container-fluid'>
                <a class='navbar-brand' href='Home.aspx'>EnerTech</a>
                  
                    {GetProfileMenu()}
                </div>
            </div>
        </nav>";

        }




    }


    
}