using BE;
using BLL;
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
        protected System.Web.UI.HtmlControls.HtmlGenericControl navigationBar;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
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


                    switch (Encriptador.Descencriptar(usuario.Email))
                    {
                        case "webmaster@gmail.com":
                            SetWebmasterNavigation();
                            break;

                        case "UAC@gmail.com":
                            SetUACNavigation();
                            break;

                        case "Cliente@gmail.com":
                            SetClientNavigation();
                            break;

                        default:
                            SetDefaultNavigation();
                            break;
                    }


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
        <div class='collapse navbar-collapse justify-content-between' id='navbarWebmaster'>
            <!-- Menú centrado -->
            <ul class='navbar-nav mx-auto'>
                <li class='nav-item dropdown'>
                    <a class='nav-link dropdown-toggle' href='#' data-bs-toggle='dropdown'>Usuarios</a>
                    <ul class='dropdown-menu'>
                        <li><a class='dropdown-item' href='#'>Alta Usuario</a></li>
                        <li><a class='dropdown-item' href='#'>Modificación Usuario</a></li>
                        <li><a class='dropdown-item' href='#'>Cambiar Contraseña</a></li>
                        <li><a class='dropdown-item' href='#'>Baja Usuario</a></li>
                    </ul>
                </li>
                <li class='nav-item dropdown'>
                    <a class='nav-link dropdown-toggle' href='#' data-bs-toggle='dropdown'>Permisos</a>
                    <ul class='dropdown-menu'>
                        <li><a class='dropdown-item' href='#'>Asignar Permiso</a></li>
                        <li><a class='dropdown-item' href='#'>Asignar Permiso a Familia</a></li>
                    </ul>
                </li>
                <li class='nav-item'><a class='nav-link' href='#'>Backup</a></li>
                <li class='nav-item'><a class='nav-link' href='60-Bitacora.aspx'>Bitácora</a></li>
            </ul>

            <!-- Icono de perfil alineado a la derecha -->
            <div class='d-flex align-items-center'>
                <div class='dropdown profile-icon'>
                    <a href='#' class='d-flex align-items-center' data-bs-toggle='dropdown'>
                        <img src='https://cdn-icons-png.flaticon.com/512/149/149071.png' alt='Profile' class='rounded-circle' style='width: 40px; height: 40px;'>
                    </a>
                    <ul class='dropdown-menu dropdown-menu-end'>
                        <li><a class='dropdown-item' href='#'>Ver Perfil</a></li>
                        <li><a class='dropdown-item' href='14-Logout.aspx'>Cerrar Sesión</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>";
        }


        private void SetUACNavigation()
        {
            navigationBar.InnerHtml = @"
<nav class='navbar navbar-expand-lg navbar-dark bg-success'>
    <div class='container-fluid'>
        <a class='navbar-brand' href='Home.aspx'>EnerTech</a>
        <button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarUAC' aria-controls='navbarUAC' aria-expanded='false'>
            <span class='navbar-toggler-icon'></span>
        </button>
        <div class='collapse navbar-collapse justify-content-between' id='navbarUAC'>
            <!-- Menú centrado -->
            <ul class='navbar-nav mx-auto'>
                <li class='nav-item dropdown'>
                    <a class='nav-link dropdown-toggle' href='#' data-bs-toggle='dropdown'>Productos</a>
                    <ul class='dropdown-menu'>
                        <li><a class='dropdown-item' href='71-AltaProducto.aspx'>Alta Producto</a></li>
                        <li><a class='dropdown-item' href='#'>Baja Producto</a></li>
                        <li><a class='dropdown-item' href='#'>Modificación Producto</a></li>
                    </ul>
                </li>
                <li class='nav-item'><a class='nav-link' href='90-Catalogo.aspx'>Catálogo</a></li>
                <li class='nav-item'><a class='nav-link' href='120-Carrito.aspx'>Carrito</a></li>
                <li class='nav-item'><a class='nav-link' href='100-Ventas.aspx'>Ventas</a></li>
            </ul>
            
            <!-- Icono de perfil alineado a la derecha -->
            <div class='d-flex align-items-center'>
                <div class='dropdown profile-icon'>
                    <a href='#' class='d-flex align-items-center' data-bs-toggle='dropdown'>
                        <img src='https://cdn-icons-png.flaticon.com/512/149/149071.png' alt='Profile' class='rounded-circle' style='width: 40px; height: 40px;'>
                    </a>
                    <ul class='dropdown-menu dropdown-menu-end'>
                        <li><a class='dropdown-item' href='#'>Ver Perfil</a></li>
                        <li><a class='dropdown-item' href='14-Logout.aspx'>Cerrar Sesión</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>";
        }


        private void SetClientNavigation()
        {
            navigationBar.InnerHtml = @"
<nav class='navbar navbar-expand-lg navbar-dark bg-warning'>
    <div class='container-fluid'>
        <a class='navbar-brand' href='Home.aspx'>EnerTech</a>
        <button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarClient' aria-controls='navbarClient' aria-expanded='false'>
            <span class='navbar-toggler-icon'></span>
        </button>
        <div class='collapse navbar-collapse justify-content-between' id='navbarClient'>
            <!-- Menú centrado -->
            <ul class='navbar-nav mx-auto'>
                <li class='nav-item'><a class='nav-link' href='90-Catalogo'>Catálogo</a></li>
                <li class='nav-item'><a class='nav-link' href='120-Carrito.aspx'>Carrito</a></li>
                <li class='nav-item'><a class='nav-link' href='122-MisCompras.aspx'>Mis Compras</a></li>
            </ul>

            <!-- Icono de perfil alineado a la derecha -->
            <div class='d-flex align-items-center'>
                <div class='dropdown profile-icon'>
                    <a href='#' class='d-flex align-items-center' data-bs-toggle='dropdown'>
                        <img src='https://cdn-icons-png.flaticon.com/512/149/149071.png' alt='Profile' class='rounded-circle' style='width: 40px; height: 40px;'>
                    </a>
                    <ul class='dropdown-menu dropdown-menu-end'>
                        <li><a class='dropdown-item' href='#'>Ver Perfil</a></li>
                        <li><a class='dropdown-item' href='14-Logout.aspx'>Cerrar Sesión</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>";
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
            navigationBar.InnerHtml = "<a href='Default.aspx' class='btn btn-primary'>Inicio</a>";
        }


    }
}