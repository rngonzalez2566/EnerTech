using BE;
using BLL;
using Services;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class DetalleCompra : System.Web.UI.Page, IIdiomaObserver
    {
        public UsuarioBE usuario { get; set; }
        SessionManager _sessionManager = new SessionManager();
        VentaBLL _serviceVenta = new VentaBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            var session = new SessionManager();
            UsuarioBE usuario = session.Get<UsuarioBE>("Usuario");

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
                // 1) Primero leemos y aplicamos el idioma si viene por query
                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                if (!IsPostBack)
                {
                    // 2) Registrar observer
                    IdiomaManager.Instance.RegistrarObservador(this);

                    // 3) Cargar datos de la compra
                    if (int.TryParse(Request.QueryString["ventaId"], out int ventaId))
                    {
                        CargarDetalleCompra(ventaId);

                        if (DateTime.TryParse(Request.QueryString["fecha"], out DateTime fecha))
                        {
                            LiteralFecha.Text = fecha.ToString("dd/MM/yyyy");
                        }

                        if (decimal.TryParse(Request.QueryString["total"], out decimal total))
                        {
                            LiteralTotal.Text = total.ToString("N2");
                        }
                    }
                    else
                    {
                        // Compra no encontrada (texto se traduce con IdiomaManager)
                        string msg = IdiomaManager.Instance.GetTraduccion("purchase_not_found")
                                      ?? "Compra no encontrada";
                        LiteralTitulo.Text = $"<h2 class='text-center'>{msg}</h2>";
                    }
                }

                // 4) Aplicar traducciones a todos los controles con data-translate
                AplicarTraducciones(this);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en DetalleCompra: {ex.Message}");
                Response.Redirect("Default.aspx");
            }
        }

        private void CargarDetalleCompra(int ventaId)
        {
            List<Detalle_VentaBE> compra = _serviceVenta.GetDetalleVenta(ventaId);

            if (compra != null)
            {
                ProductosRepeater.DataSource = compra;
                ProductosRepeater.DataBind();
            }
            else
            {
                string msg = IdiomaManager.Instance.GetTraduccion("purchase_not_found")
                              ?? "Compra no encontrada";
                LiteralTitulo.Text = $"<h2 class='text-center'>{msg}</h2>";
            }
        }

        // === Traducciones genéricas, igual que en otras páginas ===
        protected void AplicarTraducciones(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                // 1) <a runat="server">
                if (childControl is HtmlAnchor anchor &&
                    anchor.Attributes["data-translate"] != null)
                {
                    string clave = anchor.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        anchor.InnerHtml = traduccion;
                    }
                }
                // 2) Controles HTML genéricos (div, span, h1, etc.)
                else if (childControl is HtmlGenericControl generic &&
                         generic.Attributes["data-translate"] != null)
                {
                    string clave = generic.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        generic.InnerText = traduccion;
                    }
                }
                // 2.b) Encabezados de tabla <th> (HtmlTableCell)
                else if (childControl is HtmlTableCell cell &&
                         cell.Attributes["data-translate"] != null)
                {
                    string clave = cell.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        cell.InnerText = traduccion;
                    }
                }
                // 3) WebControls (Label, Button, etc.)
                else if (childControl is WebControl webControl &&
                         webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        if (childControl is ITextControl textControl)
                        {
                            textControl.Text = traduccion;
                        }
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
