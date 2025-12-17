using BE;
using BLL;
using iText.StyledXmlParser.Jsoup.Nodes;
using Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class NavBar : System.Web.UI.UserControl, IIdiomaObserver
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
                usuario = _sessionManager.Get<UsuarioBE>("Usuario");

                if (!IsPostBack)
                {
                    // Registrar el NavBar como observador del idioma
                    IdiomaManager.Instance.RegistrarObservador(this);
                }
                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }
                // Aplicar traducciones a los elementos del NavBar
                AplicarTraducciones(this);

                if (usuario == null)
                {
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    //usuario.Email = Encriptador.Descencriptar(usuario.Email);
                    cantidadCarrito = _carritoService.GetCantidadCarrito(usuario.id_usuario);
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
                        else if (permiso.Permiso == BE.Enums.Permiso.EsFamilia && permiso.Nombre == "Administrador Financiero Contable")
                        {
                            xEntro = true;
                            SetUACNavigation(cantidadCarrito);
                            break;
                        }

                        if (xEntro == false)
                        {
                            SetDefaultNavigation();
                        }

                    }
                    if (xEntro == false)
                    {
                        SetDefaultNavigation();
                    }

                }


            }
            catch (Exception ex)
            {
                // Log para depurar el error
                Console.WriteLine($"Error en NavBar: {ex.Message}");
                Response.Redirect("Default.aspx");
            }
        }

        private void SetWebmasterNavigation()
        {
            navigationBar.Controls.Clear();

            // Navbar principal
            var navbar = new HtmlGenericControl("nav");
            navbar.Attributes["class"] = "navbar navbar-expand-lg navbar-dark bg-primary";

            var containerDiv = new HtmlGenericControl("div");
            containerDiv.Attributes["class"] = "container-fluid";

            // Brand
            var brandLink = new HtmlAnchor
            {
                HRef = "Default.aspx",
                InnerText = IdiomaManager.Instance.GetTraduccion("brand_name") ?? "EnerTech"
            };
            brandLink.Attributes["class"] = "navbar-brand";
            containerDiv.Controls.Add(brandLink);

            // Botón de colapso para móviles
            var toggleButton = new HtmlGenericControl("button");
            toggleButton.Attributes["class"] = "navbar-toggler";
            toggleButton.Attributes["type"] = "button";
            toggleButton.Attributes["data-bs-toggle"] = "collapse";
            toggleButton.Attributes["data-bs-target"] = "#navbarWebmaster";
            toggleButton.Attributes["aria-controls"] = "navbarWebmaster";
            toggleButton.Attributes["aria-expanded"] = "false";
            toggleButton.Attributes["aria-label"] = "Toggle navigation";

            var togglerIcon = new HtmlGenericControl("span");
            togglerIcon.Attributes["class"] = "navbar-toggler-icon";
            toggleButton.Controls.Add(togglerIcon);
            containerDiv.Controls.Add(toggleButton);

            // Contenedor colapsable
            var collapseDiv = new HtmlGenericControl("div");
            collapseDiv.Attributes["class"] = "collapse navbar-collapse";
            collapseDiv.Attributes["id"] = "navbarWebmaster";

            // Lista centrada (Usuarios, Permisos, Backup, Bitácora)
            var centerList = new HtmlGenericControl("ul");
            centerList.Attributes["class"] = "navbar-nav mx-auto";

            // Usuarios Menu
            var usuariosItem = CreateDropdownMenu(
                "users",
                "Usuarios",
                new List<(string href, string text)>
                {
            ("21-AltaUsuario", "add_user"),
            ("22-ModificacionUsuario", "modify_user"),
            ("12-RestablecerPassword", "change_password"),
            ("#", "delete_user")
                }
            );
            centerList.Controls.Add(usuariosItem);

            // Permisos Menu
            var permisosItem = CreateDropdownMenu(
                "permissions",
                "Permisos",
                new List<(string href, string text)>
                {
            ("40-Familias.aspx", "manage_families"),
            ("31-AsignarPermiso.aspx", "assign_permission"),
            ("32-AsignarPermisoPatente.aspx", "assign_family"),
            ("33-DesasignarPermiso", "unassign_permission"),
            ("34-DesasignarPermisoPatente", "unassign_family")
                }
            );
            centerList.Controls.Add(permisosItem);

            // Backup
            centerList.Controls.Add(CreateNavLink("50-Backup.aspx", "backup", "Backup"));

            // Bitácora
            centerList.Controls.Add(CreateNavLink("60-Bitacora.aspx", "bitacora", "Bitácora"));

            collapseDiv.Controls.Add(centerList);

            // Lista derecha (idioma y perfil)
            var rightList = new HtmlGenericControl("ul");
            rightList.Attributes["class"] = "navbar-nav ms-auto";

            // Dropdown de idiomas
            rightList.Controls.Add(GetLanguageDropdown("idiomaDropdown"));

            // Dropdown de perfil de usuario
            rightList.Controls.Add(GetProfileMenuControl());

            collapseDiv.Controls.Add(rightList);

            containerDiv.Controls.Add(collapseDiv);
            navbar.Controls.Add(containerDiv);

            navigationBar.Controls.Add(navbar);
        }

        // Helper: Crear un dropdown menu
        private HtmlGenericControl CreateDropdownMenu(string key, string defaultText, List<(string href, string text)> options)
        {
            var dropdownItem = new HtmlGenericControl("li");
            dropdownItem.Attributes["class"] = "nav-item dropdown";

            var dropdownLink = new HtmlAnchor
            {
                HRef = "#",
                InnerText = IdiomaManager.Instance.GetTraduccion(key) ?? defaultText
            };
            dropdownLink.Attributes["class"] = "nav-link dropdown-toggle";
            dropdownLink.Attributes["id"] = $"{key}Dropdown";
            dropdownLink.Attributes["role"] = "button";
            dropdownLink.Attributes["data-bs-toggle"] = "dropdown";
            dropdownLink.Attributes["aria-expanded"] = "false";

            var dropdownMenu = new HtmlGenericControl("ul");
            dropdownMenu.Attributes["class"] = "dropdown-menu";
            dropdownMenu.Attributes["aria-labelledby"] = $"{key}Dropdown";

            foreach (var option in options)
            {
                var menuItem = new HtmlGenericControl("li");
                var menuLink = new HtmlAnchor
                {
                    HRef = option.href,
                    InnerText = IdiomaManager.Instance.GetTraduccion(option.text) ?? option.text
                };
                menuLink.Attributes["class"] = "dropdown-item";
                menuItem.Controls.Add(menuLink);
                dropdownMenu.Controls.Add(menuItem);
            }

            dropdownItem.Controls.Add(dropdownLink);
            dropdownItem.Controls.Add(dropdownMenu);

            return dropdownItem;
        }

        // Helper: Crear un enlace directo
        private HtmlGenericControl CreateNavLink(string href, string key, string defaultText)
        {
            var navItem = new HtmlGenericControl("li");
            navItem.Attributes["class"] = "nav-item";

            var navLink = new HtmlAnchor
            {
                HRef = href,
                InnerText = IdiomaManager.Instance.GetTraduccion(key) ?? defaultText
            };
            navLink.Attributes["class"] = "nav-link";
            navItem.Controls.Add(navLink);

            return navItem;
        }



        private void SetUACNavigation(int cantidadCarrito)
        {
            navigationBar.Controls.Clear();

            // Navbar principal
            var navbar = new HtmlGenericControl("nav");
            navbar.Attributes["class"] = "navbar navbar-expand-lg navbar-dark bg-success";

            var containerDiv = new HtmlGenericControl("div");
            containerDiv.Attributes["class"] = "container-fluid";

            // Brand
            var brandLink = new HtmlAnchor
            {
                HRef = "Default.aspx",
                InnerText = IdiomaManager.Instance.GetTraduccion("brand_name") ?? "EnerTech"
            };
            brandLink.Attributes["class"] = "navbar-brand";
            containerDiv.Controls.Add(brandLink);

            // Botón de colapso para móviles
            var toggleButton = new HtmlGenericControl("button");
            toggleButton.Attributes["class"] = "navbar-toggler";
            toggleButton.Attributes["type"] = "button";
            toggleButton.Attributes["data-bs-toggle"] = "collapse";
            toggleButton.Attributes["data-bs-target"] = "#navbarUAC";
            toggleButton.Attributes["aria-controls"] = "navbarUAC";
            toggleButton.Attributes["aria-expanded"] = "false";
            toggleButton.Attributes["aria-label"] = "Toggle navigation";

            var togglerIcon = new HtmlGenericControl("span");
            togglerIcon.Attributes["class"] = "navbar-toggler-icon";
            toggleButton.Controls.Add(togglerIcon);
            containerDiv.Controls.Add(toggleButton);

            // Contenedor colapsable
            var collapseDiv = new HtmlGenericControl("div");
            collapseDiv.Attributes["class"] = "collapse navbar-collapse";
            collapseDiv.Attributes["id"] = "navbarUAC";

            // Lista centrada (Productos, Catálogo, Ventas)
            var centerList = new HtmlGenericControl("ul");
            centerList.Attributes["class"] = "navbar-nav mx-auto";

            // Menú de "Productos"
            var productosItem = new HtmlGenericControl("li");
            productosItem.Attributes["class"] = "nav-item dropdown";

            var productosLink = new HtmlAnchor
            {
                HRef = "#",
                InnerText = IdiomaManager.Instance.GetTraduccion("products") ?? "Productos"
            };
            productosLink.Attributes["class"] = "nav-link dropdown-toggle";
            productosLink.Attributes["id"] = "productosDropdown";
            productosLink.Attributes["role"] = "button";
            productosLink.Attributes["data-bs-toggle"] = "dropdown";
            productosLink.Attributes["aria-expanded"] = "false";
            productosItem.Controls.Add(productosLink);

            var productosMenu = new HtmlGenericControl("ul");
            productosMenu.Attributes["class"] = "dropdown-menu";
            productosMenu.Attributes["aria-labelledby"] = "productosDropdown";

            var verProductosItem = new HtmlGenericControl("li");
            var verProductosLink = new HtmlAnchor
            {
                HRef = "70-Productos.aspx",
                InnerText = IdiomaManager.Instance.GetTraduccion("view_products") ?? "Ver Productos"
            };
            verProductosLink.Attributes["class"] = "dropdown-item";
            verProductosItem.Controls.Add(verProductosLink);

            var altaProductoItem = new HtmlGenericControl("li");
            var altaProductoLink = new HtmlAnchor
            {
                HRef = "71-AltaProducto.aspx",
                InnerText = IdiomaManager.Instance.GetTraduccion("add_product") ?? "Alta Producto"
            };
            altaProductoLink.Attributes["class"] = "dropdown-item";
            altaProductoItem.Controls.Add(altaProductoLink);

            productosMenu.Controls.Add(verProductosItem);
            productosMenu.Controls.Add(altaProductoItem);
            productosItem.Controls.Add(productosMenu);

            centerList.Controls.Add(productosItem);

            // Menú de "Catálogo"
            var catalogoItem = new HtmlGenericControl("li");
            var catalogoLink = new HtmlAnchor
            {
                HRef = "90-Catalogo.aspx",
                InnerText = IdiomaManager.Instance.GetTraduccion("catalog") ?? "Catálogo"
            };
            catalogoLink.Attributes["class"] = "nav-link";
            catalogoItem.Controls.Add(catalogoLink);
            centerList.Controls.Add(catalogoItem);

            // Menú de "Ventas"
            var ventasItem = new HtmlGenericControl("li");
            var ventasLink = new HtmlAnchor
            {
                HRef = "100-Ventas.aspx",
                InnerText = IdiomaManager.Instance.GetTraduccion("sales") ?? "Ventas"
            };
            ventasLink.Attributes["class"] = "nav-link";
            ventasItem.Controls.Add(ventasLink);
            centerList.Controls.Add(ventasItem);

            // Menú de "Negocio" con submenú
            var negocioItem = new HtmlGenericControl("li");
            negocioItem.Attributes["class"] = "nav-item dropdown";

            var negocioLink = new HtmlAnchor
            {
                HRef = "#",
                InnerText = IdiomaManager.Instance.GetTraduccion("business") ?? "Negocio"
            };
            negocioLink.Attributes["class"] = "nav-link dropdown-toggle";
            negocioLink.Attributes["id"] = "negocioDropdown";
            negocioLink.Attributes["role"] = "button";
            negocioLink.Attributes["data-bs-toggle"] = "dropdown";
            negocioLink.Attributes["aria-expanded"] = "false";
            negocioItem.Controls.Add(negocioLink);

            var negocioMenu = new HtmlGenericControl("ul");
            negocioMenu.Attributes["class"] = "dropdown-menu";
            negocioMenu.Attributes["aria-labelledby"] = "negocioDropdown";

            var editarDatosItem = new HtmlGenericControl("li");
            var editarDatosLink = new HtmlAnchor
            {
                HRef = "111-EditarDatos.aspx",
                InnerText = IdiomaManager.Instance.GetTraduccion("edit_data") ?? "Editar Datos"
            };
            editarDatosLink.Attributes["class"] = "dropdown-item";
            editarDatosItem.Controls.Add(editarDatosLink);

            negocioMenu.Controls.Add(editarDatosItem);
            negocioItem.Controls.Add(negocioMenu);

            centerList.Controls.Add(negocioItem);

            collapseDiv.Controls.Add(centerList);

            // Lista derecha (idioma y perfil)
            var rightList = new HtmlGenericControl("ul");
            rightList.Attributes["class"] = "navbar-nav ms-auto";

            // Dropdown de idiomas
            rightList.Controls.Add(GetLanguageDropdown("idiomaDropdownUAC"));

            // Dropdown de perfil de usuario
            rightList.Controls.Add(GetProfileMenuControl());

            collapseDiv.Controls.Add(rightList);

            containerDiv.Controls.Add(collapseDiv);
            navbar.Controls.Add(containerDiv);

            navigationBar.Controls.Add(navbar);
        }








        private void SetClientNavigation(int cantidadCarrito)
        {
            navigationBar.Controls.Clear();

            // Navbar principal
            var navbar = new HtmlGenericControl("nav");
            navbar.Attributes["class"] = "navbar navbar-expand-lg navbar-dark bg-success";

            var containerDiv = new HtmlGenericControl("div");
            containerDiv.Attributes["class"] = "container-fluid";

            // Brand
            var brandLink = new HtmlAnchor
            {
                HRef = "Default.aspx",
                InnerText = IdiomaManager.Instance.GetTraduccion("brand_name") ?? "EnerTech"
            };
            brandLink.Attributes["class"] = "navbar-brand";
            containerDiv.Controls.Add(brandLink);

            // Botón de colapso para móviles
            var toggleButton = new HtmlGenericControl("button");
            toggleButton.Attributes["class"] = "navbar-toggler";
            toggleButton.Attributes["type"] = "button";
            toggleButton.Attributes["data-bs-toggle"] = "collapse";
            toggleButton.Attributes["data-bs-target"] = "#navbarClient";
            toggleButton.Attributes["aria-controls"] = "navbarClient";
            toggleButton.Attributes["aria-expanded"] = "false";
            toggleButton.Attributes["aria-label"] = "Toggle navigation";

            var togglerIcon = new HtmlGenericControl("span");
            togglerIcon.Attributes["class"] = "navbar-toggler-icon";
            toggleButton.Controls.Add(togglerIcon);
            containerDiv.Controls.Add(toggleButton);

            // Contenedor colapsable
            var collapseDiv = new HtmlGenericControl("div");
            collapseDiv.Attributes["class"] = "collapse navbar-collapse";
            collapseDiv.Attributes["id"] = "navbarClient";

            // Lista de navegación centrada
            var navList = new HtmlGenericControl("ul");
            navList.Attributes["class"] = "navbar-nav mx-auto";

            // Menú "Catálogo"
            var catalogoItem = new HtmlGenericControl("li");
            catalogoItem.Attributes["class"] = "nav-item";

            var catalogoLink = new HtmlAnchor
            {
                HRef = "90-Catalogo.aspx",
                InnerText = IdiomaManager.Instance.GetTraduccion("catalog") ?? "Catálogo"
            };
            catalogoLink.Attributes["class"] = "nav-link";
            catalogoItem.Controls.Add(catalogoLink);
            navList.Controls.Add(catalogoItem);

            // Menú "Carrito"
            var carritoItem = new HtmlGenericControl("li");
            carritoItem.Attributes["class"] = "nav-item position-relative";

            var carritoLink = new HtmlAnchor
            {
                HRef = "120-Carrito.aspx",
                InnerHtml = $"{IdiomaManager.Instance.GetTraduccion("cart") ?? "Carrito"} <span class='badge bg-warning text-dark position-absolute top-0 start-100 translate-middle rounded-circle'>{cantidadCarrito}</span>"
            };
            carritoLink.Attributes["class"] = "nav-link";
            carritoItem.Controls.Add(carritoLink);
            navList.Controls.Add(carritoItem);

            // Menú "Mis Compras"
            var comprasItem = new HtmlGenericControl("li");
            comprasItem.Attributes["class"] = "nav-item";

            var comprasLink = new HtmlAnchor
            {
                HRef = "122-MisCompras.aspx",
                InnerText = IdiomaManager.Instance.GetTraduccion("purchases") ?? "Mis Compras"
            };
            comprasLink.Attributes["class"] = "nav-link";
            comprasItem.Controls.Add(comprasLink);
            navList.Controls.Add(comprasItem);

            collapseDiv.Controls.Add(navList);

            // Dropdown de idiomas alineado a la derecha
            collapseDiv.Controls.Add(GetLanguageDropdown("idiomaDropdownClient"));

            // Menú de perfil de usuario alineado a la derecha
            collapseDiv.Controls.Add(GetProfileMenuControl());

            containerDiv.Controls.Add(collapseDiv);
            navbar.Controls.Add(containerDiv);

            navigationBar.Controls.Add(navbar);
        }






        private Control GetProfileMenuControl()
        {
            var dropdownDiv = new HtmlGenericControl("div");
            dropdownDiv.Attributes["class"] = "dropdown profile-icon";

            var profileLink = new HtmlAnchor
            {
                HRef = "#",
                InnerHtml = "<img src='https://cdn-icons-png.flaticon.com/512/149/149071.png' alt='Profile' class='rounded-circle' style='width: 40px; height: 40px;'>"
            };
            profileLink.Attributes["class"] = "d-flex align-items-center";
            profileLink.Attributes["data-bs-toggle"] = "dropdown";
            dropdownDiv.Controls.Add(profileLink);

            var dropdownMenu = new HtmlGenericControl("ul");
            dropdownMenu.Attributes["class"] = "dropdown-menu dropdown-menu-end";

            // Opción de cambiar contraseña
            var changePasswordItem = new HtmlGenericControl("li");
            var changePasswordLink = new HtmlAnchor
            {
                HRef = BuildPreserveQueryUrl("23-CambiarPassword.aspx"),
                InnerText = IdiomaManager.Instance.GetTraduccion("change_password") ?? "Cambiar Contraseña"
            };
            changePasswordLink.Attributes["class"] = "dropdown-item";
            changePasswordItem.Controls.Add(changePasswordLink);

            // Opción de cerrar sesión
            var logoutItem = new HtmlGenericControl("li");
            var logoutLink = new HtmlAnchor
            {
                HRef = "14-Logout.aspx",
                InnerText = IdiomaManager.Instance.GetTraduccion("logout") ?? "Cerrar Sesión"
            };
            logoutLink.Attributes["class"] = "dropdown-item btn-logout";
            logoutItem.Controls.Add(logoutLink);

            // Agregar opciones al menú desplegable
            dropdownMenu.Controls.Add(changePasswordItem);
            dropdownMenu.Controls.Add(logoutItem);

            dropdownDiv.Controls.Add(dropdownMenu);

            return dropdownDiv;
        }



        private void SetDefaultNavigation()
        {
           
                navigationBar.Controls.Clear();

                // Navbar principal
                var navbar = new HtmlGenericControl("nav");
                navbar.Attributes["class"] = "navbar navbar-expand-lg navbar-dark bg-primary";

                var containerDiv = new HtmlGenericControl("div");
                containerDiv.Attributes["class"] = "container-fluid";

                // Brand
                var brandLink = new HtmlAnchor
                {
                    HRef = "#",
                    InnerText = IdiomaManager.Instance.GetTraduccion("brand_name") ?? "EnerTech"
                };
                brandLink.Attributes["class"] = "navbar-brand";
                containerDiv.Controls.Add(brandLink);

                // Botón de colapso para móviles
                var toggleButton = new HtmlGenericControl("button");
                toggleButton.Attributes["class"] = "navbar-toggler";
                toggleButton.Attributes["type"] = "button";
                toggleButton.Attributes["data-bs-toggle"] = "collapse";
                toggleButton.Attributes["data-bs-target"] = "#navbarWebmaster";
                toggleButton.Attributes["aria-controls"] = "navbarWebmaster";
                toggleButton.Attributes["aria-expanded"] = "false";
                toggleButton.Attributes["aria-label"] = "Toggle navigation";

                var togglerIcon = new HtmlGenericControl("span");
                togglerIcon.Attributes["class"] = "navbar-toggler-icon";
                toggleButton.Controls.Add(togglerIcon);
                containerDiv.Controls.Add(toggleButton);

                // Contenedor colapsable
                var collapseDiv = new HtmlGenericControl("div");
                collapseDiv.Attributes["class"] = "collapse navbar-collapse";
                collapseDiv.Attributes["id"] = "navbarWebmaster";

                // Lista centrada (Usuarios, Permisos, Backup, Bitácora)
                var centerList = new HtmlGenericControl("ul");
                centerList.Attributes["class"] = "navbar-nav mx-auto";
     
                // Backup
                centerList.Controls.Add(CreateNavLink("50-Backup.aspx", "backup", "Backup"));

                // Bitácora
                centerList.Controls.Add(CreateNavLink("60-Bitacora.aspx", "bitacora", "Bitácora"));

                // Bitácora
                centerList.Controls.Add(CreateNavLink("61-DigitosVerificadores.aspx", "Recalcular Digitos", "Recalcular Digitos"));

            collapseDiv.Controls.Add(centerList);

                // Lista derecha (idioma y perfil)
                var rightList = new HtmlGenericControl("ul");
                rightList.Attributes["class"] = "navbar-nav ms-auto";

                // Dropdown de idiomas
                rightList.Controls.Add(GetLanguageDropdown("idiomaDropdown"));

                // Dropdown de perfil de usuario
                rightList.Controls.Add(GetProfileMenuControl());

                collapseDiv.Controls.Add(rightList);

                containerDiv.Controls.Add(collapseDiv);
                navbar.Controls.Add(containerDiv);

                navigationBar.Controls.Add(navbar);
            
        }


        protected void CambiarIdioma_Click(object sender, EventArgs e)
        {
            var linkButton = sender as LinkButton;
            if (linkButton != null)
            {
                string idiomaSeleccionado = linkButton.CommandArgument;
                IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);

                // Asegúrate de que no pierdas otros parámetros de la URL al recargar
                Response.Redirect(Request.RawUrl, false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        private Control GetLanguageDropdown(string dropdownId)
        {
            var dropdownDiv = new HtmlGenericControl("div");
            dropdownDiv.Attributes["class"] = "dropdown ms-3";

            var button = new HtmlGenericControl("button");
            button.Attributes["class"] = "btn btn-outline-light dropdown-toggle px-3";
            button.Attributes["type"] = "button";
            button.Attributes["id"] = dropdownId;
            button.Attributes["data-bs-toggle"] = "dropdown";
            button.Attributes["aria-expanded"] = "false";
            button.InnerText = IdiomaManager.Instance.GetTraduccion("language") ?? "Idioma";
            dropdownDiv.Controls.Add(button);

            var menu = new HtmlGenericControl("ul");
            menu.Attributes["class"] = "dropdown-menu dropdown-menu-end";
            menu.Attributes["aria-labelledby"] = dropdownId;

            // ✅ arma URLs preservando querystring (id, etc.)
            string esUrl = BuildLangUrl("es");
            string enUrl = BuildLangUrl("en");

            var españolItem = new HtmlGenericControl("li");
            var españolLink = new HtmlAnchor { HRef = esUrl, InnerText = "Español" };
            españolLink.Attributes["class"] = "dropdown-item";
            españolItem.Controls.Add(españolLink);

            var englishItem = new HtmlGenericControl("li");
            var englishLink = new HtmlAnchor { HRef = enUrl, InnerText = "English" };
            englishLink.Attributes["class"] = "dropdown-item";
            englishItem.Controls.Add(englishLink);

            menu.Controls.Add(españolItem);
            menu.Controls.Add(englishItem);

            dropdownDiv.Controls.Add(menu);
            return dropdownDiv;
        }

        private string BuildLangUrl(string lang)
        {
            var uri = Request.Url; // URL completa actual
            var qs = HttpUtility.ParseQueryString(uri.Query);

            qs.Set("lang", lang); // agrega o reemplaza lang

            string path = uri.AbsolutePath; // /42-ModificarFamilias.aspx
            string newQuery = qs.ToString();

            return string.IsNullOrEmpty(newQuery) ? path : $"{path}?{newQuery}";
        }




        protected void AplicarTraducciones(Control control)
        {
            // Recorrer todos los controles del formulario
            foreach (Control childControl in control.Controls)
            {
                // Verificar si el control tiene el atributo "data-translate"
                if (childControl is WebControl webControl && webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    // Lógica adicional para claves dinámicas como "lblUsuarioEmail"
                    if (clave == "lblUsuarioEmail" && Session["Usuario"] != null)
                    {
                        var usuario = Session["Usuario"] as UsuarioBE;
                        if (usuario != null)
                        {
                            // Reemplazar {0} en la traducción con el correo del usuario
                            traduccion = string.Format(traduccion, usuario.Email);
                        }
                    }

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        if (childControl is ITextControl textControl)
                        {
                            textControl.Text = traduccion; // Para controles ASP.NET que tienen propiedad Text
                        }
                        else if (childControl is HtmlGenericControl genericControl)
                        {
                            genericControl.InnerText = traduccion; // Para controles HTML genéricos
                        }
                    }
                }
                else if (childControl is HtmlGenericControl genericControl && genericControl.Attributes["data-translate"] != null)
                {
                    string clave = genericControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        genericControl.InnerText = traduccion; // Actualizar contenido para HTML genéricos
                    }
                }

                // Recursivamente aplicar traducciones a los controles hijos
                if (childControl.HasControls())
                {
                    AplicarTraducciones(childControl);
                }
            }
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            // Aplicar nuevamente las traducciones al cambiar de idioma
            AplicarTraducciones(this);
        }



        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }

        private string BuildPreserveQueryUrl(string path)
        {
            var qs = HttpUtility.ParseQueryString(Request.Url.Query);
            string newQuery = qs.ToString();
            return string.IsNullOrEmpty(newQuery) ? path : $"{path}?{newQuery}";
        }


    }



}