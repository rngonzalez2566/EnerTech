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
                    //usuario.Email = Encriptador.Descencriptar(usuario.Email);


                    switch (usuario.Email)
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
        <div class='nav-center'>
            <div class='nav-links'>
                <div class='dropdown'>
                    <a href='#'>Usuarios</a>
                    <div class='dropdown-content'>
                        <a href='#'>Alta Usuario</a>
                        <a href='#'>Modificación Usuario</a>
                        <a href='#'>Cambiar Contraseña</a>
                        <a href='#'>Baja Usuario</a>
                    </div>
                </div>
                <div class='dropdown'>
                    <a href='#'>Permisos</a>
                    <div class='dropdown-content'>
                        <a href='#'>Asignar Permiso</a>
                        <a href='#'>Asignar Permiso a Familia</a>
                    </div>
                </div>
                <a href='#'>Backup</a>
                <a href='60-Bitacora.aspx'>Bitácora</a>
            </div>
        </div>
        <div class='profile-container'>
            <div class='profile-icon' onclick='toggleProfileMenu()'>
                <img src='https://cdn-icons-png.flaticon.com/512/149/149071.png' alt='Profile Icon' />
            </div>
        </div>
        <div id='profileMenu' class='profile-dropdown'>
            <a href='#'>Ver Perfil</a>
           <a href='14-Logout.aspx' class='dropdown-link'>Cerrar Sesión</a>
        </div>";

        }

        // Opciones para UAC
        private void SetUACNavigation()
        {
            navigationBar.InnerHtml = @"
        <div class='nav-center'>
            <div class='nav-links'>
                <div class='dropdown'>
                    <a href='70-Productos.aspx'>Productos</a>
                    <div class='dropdown-content'>
                        <a href='71-AltaProducto.aspx'>Alta Producto</a>
                        <a href='#'>Baja Producto</a>
                        <a href='#'>Modificación Producto</a>
                    </div>
                </div>
                <div class='dropdown'>
                    <a href='#'>Ajuste de Stock</a>
                    <div class='dropdown-content'>
                        <a href='#'>Alta Movimiento de Stock</a>
                    </div>
                </div>
                <a href='90-Catalogo'>Catálogo</a>
                <a href='#'>Ventas</a>
                <div class='dropdown'>
                    <a href='#'>Negocio</a>
                    <div class='dropdown-content'>
                        <a href='#'>Editar Datos</a>
                    </div>
                </div>
            </div>
        </div>
        <div class='profile-container'>
            <div class='profile-icon' onclick='toggleProfileMenu()'>
                <img src='https://cdn-icons-png.flaticon.com/512/149/149071.png' alt='Profile Icon' />
            </div>
        </div>
        <div id='profileMenu' class='profile-dropdown'>
            <a href='#'>Ver Perfil</a>
             <a href='14-Logout.aspx' class='dropdown-link'>Cerrar Sesión</a>
        </div>";
        }

        // Opciones para Cliente
        private void SetClientNavigation()
        {
            navigationBar.InnerHtml = @"
        <div class='nav-center'>
            <div class='nav-links'>
                <div class='dropdown'>
                    <a href='#'>Cambiar Contraseña</a>
                    <div class='dropdown-content'>
                        <a href='#'>Modificación Usuario</a>
                    </div>
                </div>
                <div class='dropdown'>
                    <a href='90-Catalogo'>Catalogo</a>
                </div>
                <div class='dropdown'>
                    <a href='120-Carrito.aspx'>Carrito</a>
                </div>
                <div class='dropdown'>
                    <a href='122-MisCompras.aspx'>Mis Compras</a>
                </div>
            </div>
        </div>
        <div class='profile-container'>
            <div class='profile-icon' onclick='toggleProfileMenu()'>
                <img src='https://cdn-icons-png.flaticon.com/512/149/149071.png' alt='Profile Icon' />
            </div>
        </div>
        <div id='profileMenu' class='profile-dropdown'>
            <a href='#'>Ver Perfil</a>
           <a href='14-Logout.aspx' class='dropdown-link'>Cerrar Sesión</a>
        </div>";
        }

        // Opciones por defecto
        private void SetDefaultNavigation()
        {
            navigationBar.InnerHtml = "<a href='Default.aspx'>Inicio</a>";
        }

    }
}