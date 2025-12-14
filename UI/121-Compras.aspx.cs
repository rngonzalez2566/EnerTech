using BE;
using BE.AFIP;
using BLL;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Services;

namespace UI
{
    public partial class _121_Compras : System.Web.UI.Page, IIdiomaObserver
    {
        private static List<CarritoBE> carrito;
        CarritoBLL _carritoService = new CarritoBLL();
        UsuarioBLL _usuarioService = new UsuarioBLL();
        public UsuarioBE usuario { get; set; }
        SessionManager _sessionManager = new SessionManager();
        VentaBLL _serviceVenta = new VentaBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
          
           usuario = _sessionManager.Get<UsuarioBE>("Usuario");

            if (usuario == null)
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!PermisoCheck.VerificarPermiso(usuario.Permisos, BE.Enums.Permiso.MisCompras))
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            try
            {
                if (!IsPostBack)
                {
                    // Registrar como observador del idioma
                    IdiomaManager.Instance.RegistrarObservador(this);

                    CargarCarrito();
                    CalcularTotales();
                }

                // Leer el idioma del querystring (?lang=es / ?lang=en)
                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                // Aplicar traducciones
                AplicarTraducciones(this);
            }
            catch (Exception ex)
            {
                // Manejo simple de error
                Console.WriteLine($"Error en 121-Compras: {ex.Message}");
                Response.Redirect("Default.aspx");
            }
        }

        private void CargarCarrito()
        {

            carrito = _carritoService.GetCarrito(usuario.id_usuario);

            // Enlaza el carrito al Repeater
            rptCarrito.DataSource = carrito;
            rptCarrito.DataBind();

        }

        private void CalcularTotales()
        {
            decimal subtotal = carrito.Sum(p => p.producto.Precio * p.Cantidad);


            lblTotal.Text = (subtotal).ToString("N2");
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            try
            {
                VentaBE venta = new VentaBE();

                
                venta.RelatedTaxes = new List<RelatedTaxesBE>();
                venta.Items = new List<Detalle_VentaBE>();

                decimal Base = 0;
                decimal IVA = 0;

                var taxGroups = carrito
                    .GroupBy(item => item.producto.codigoIVA.Codigo)
                    .Select(g =>
                    {
                        var codigoIVA = CodigoIVA.ObtenerTipoIVA(g.Key);
                        decimal tasaIVA = codigoIVA.Porcentaje / 100;

                        decimal baseImponible = Math.Round(
                            g.Sum(item => (item.producto.Precio * item.Cantidad) / (1 + tasaIVA)), 2);

                        decimal totalIVA = Math.Round(
                            g.Sum(item => (item.producto.Precio * item.Cantidad)) - baseImponible, 2);

                        Base += baseImponible;
                        IVA += totalIVA;

                        return new RelatedTaxesBE
                        {
                            codigoIVA = codigoIVA.Codigo,
                            TasaIVA = codigoIVA.Porcentaje,
                            BaseImponible = baseImponible,
                            TotalIVA = totalIVA
                        };
                    })
                    .ToList();

                
                venta.RelatedTaxes.AddRange(taxGroups);

                venta.Fecha = DateTime.Now;
                venta.Detalle = "Venta";
                venta.usuario = usuario;
                venta.TotalGravado = Math.Round(Base, 2);
                venta.IVA = Math.Round(IVA, 2);
                venta.Total = carrito.Sum(p => p.producto.Precio * p.Cantidad);

                foreach (var item in carrito)
                {
                    decimal baseImponible = Math.Round(
                        (item.producto.Precio * item.Cantidad) /
                        (1 + (item.producto.codigoIVA.Porcentaje / 100)), 2);

                    decimal totalIVA = Math.Round(
                        (item.producto.Precio * item.Cantidad) - baseImponible, 2);

                    Detalle_VentaBE detalle = new Detalle_VentaBE
                    {
                        Producto = item.producto,
                        Descripcion = item.producto.Descripcion,
                        Codigo = item.producto.Codigo,
                        Cantidad = item.Cantidad,
                        PrecioUnitario = item.producto.Precio,
                        Total = item.Cantidad * item.producto.Precio,
                        IVA = totalIVA,
                        codigoIVA = item.producto.codigoIVA
                    };

                    venta.Items.Add(detalle);
                }

                _serviceVenta.RegistrarVenta(venta);

                Response.Redirect("90-Catalogo.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al procesar la compra: " + ex.Message);
            }
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
                // 2) Controles HTML genéricos (span, div, h3, label, etc.)
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
                // 3) Controles ASP.NET clásicos (Label, Button, TextBox, etc.)
                else if (childControl is WebControl webControl &&
                         webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        // Label, Literal, TextBox, etc.
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
            // Cuando cambia el idioma, vuelvo a aplicar traducciones
            AplicarTraducciones(this);
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }

    }


}