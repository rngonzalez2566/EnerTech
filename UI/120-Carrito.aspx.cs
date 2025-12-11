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
    public partial class _120_Carrito : System.Web.UI.Page, IIdiomaObserver
    {
        private static List<CarritoBE> carrito;
        CarritoBLL _carritoService = new CarritoBLL();
        UsuarioBLL _usuarioService = new UsuarioBLL();
        public UsuarioBE usuario { get; set; }
        SessionManager _sessionManager = new SessionManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            //usuario = _usuarioService.Login("UAC@gmail.com", "S@nlorenzo2566");
            //_sessionManager.Set("Usuario", usuario);
            usuario = _sessionManager.Get<UsuarioBE>("Usuario");
            if (usuario == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            try
            {
                if (!IsPostBack)
                {
                    // Registrar como observador del idioma
                    IdiomaManager.Instance.RegistrarObservador(this);

                    CargarCarrito();
                    CalcularSubtotal();
                }

                // Leer idioma del querystring (?lang=es / ?lang=en)
                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                // Aplicar traducciones a todos los controles de la página
                AplicarTraducciones(this);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en 120-Carrito: {ex.Message}");
                Response.Redirect("Default.aspx");
            }
        }

        private void CargarCarrito()
        {
            // Obtener el carrito actualizado desde la base de datos
            carrito = _carritoService.GetCarrito(usuario.id_usuario);

            // Enlazar el carrito al Repeater
            rptCarrito.DataSource = carrito;
            rptCarrito.DataBind();
        }


        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            Button btnIncrease = (Button)sender;
            int codigo = Convert.ToInt32(btnIncrease.CommandArgument);
            ActualizarCantidad(codigo, 1);
            Response.Redirect(Request.RawUrl);
        }
        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            Button btnDecrease = (Button)sender;
            int codigo = Convert.ToInt32(btnDecrease.CommandArgument);
            ActualizarCantidad(codigo, -1);
            Response.Redirect(Request.RawUrl);
        }

        private void ActualizarCantidad(int codigo, int cambio)
        {
            // Obtén el producto en el carrito
            var carritoBE = carrito.FirstOrDefault(p => p.producto.id_producto == codigo);

            if (carritoBE != null)
            {
                carritoBE.Cantidad += cambio;

                if (carritoBE.Cantidad <= 0)
                {
                    // Si la cantidad es 0 o menor, elimina el producto del carrito
                    _carritoService.BorrarCarritoProducto(usuario.id_usuario, codigo);
                }
                else
                {
                    // Actualiza la cantidad en la base de datos
                    _carritoService.ActualizarCarrito(carritoBE);
                }
            }

            // Recargar el carrito desde la base de datos después de actualizar
            CargarCarrito();
            CalcularSubtotal();
        }





        protected void btnRemove_Click(object sender, EventArgs e)
        {
            LinkButton btnRemove = (LinkButton)sender;
            int codigo = Convert.ToInt32(btnRemove.CommandArgument);

            // Eliminar el producto del carrito
            _carritoService.BorrarCarritoProducto(usuario.id_usuario, codigo);

            // Recargar el carrito y el subtotal
            CargarCarrito();
            CalcularSubtotal();
            Response.Redirect(Request.RawUrl);
        }

        private void CalcularSubtotal()
        {
            
            decimal subtotal = carrito.Sum(p => p.producto.Precio * p.Cantidad);

            lblSubtotal.Text = subtotal.ToString("N2");
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            // Redirigir a la página de finalización de compra
            Response.Redirect("121-Compras.aspx");
        }

        protected void AplicarTraducciones(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                // 1) Anchor <a runat="server">
                if (childControl is System.Web.UI.HtmlControls.HtmlAnchor anchor &&
                    anchor.Attributes["data-translate"] != null)
                {
                    string clave = anchor.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        anchor.InnerHtml = traduccion;
                    }
                }
                // 2) Controles HTML genéricos (span, div, h1, label, etc.)
                else if (childControl is System.Web.UI.HtmlControls.HtmlGenericControl generic &&
                         generic.Attributes["data-translate"] != null)
                {
                    string clave = generic.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        generic.InnerText = traduccion;
                    }
                }
                // 3) Controles ASP.NET clásicos (Label, Button, LinkButton, TextBox, etc.)
                else if (childControl is WebControl webControl &&
                         webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        // Label, TextBox, Literal, etc.
                        if (childControl is ITextControl textControl)
                        {
                            textControl.Text = traduccion;
                        }
                        // Button, LinkButton, etc.
                        else if (childControl is IButtonControl buttonControl)
                        {
                            buttonControl.Text = traduccion;
                        }
                    }
                }

                // Recursivo
                if (childControl.HasControls())
                {
                    AplicarTraducciones(childControl);
                }
            }
        }


        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }

    }
}