using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UI.WebServices;
using Services;
using System.Web.UI.HtmlControls;

namespace UI
{
    public partial class _122_MisCompras : System.Web.UI.Page, IIdiomaObserver
    {
        SessionManager _sessionManager = new SessionManager();
        VentaBLL _serviceVenta = new VentaBLL();
        public UsuarioBE usuario { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

            usuario = _sessionManager.Get<UsuarioBE>("Usuario");
            if (usuario == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            try
            {
                // 1) Primero leemos y cambiamos el idioma
                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                // 2) Luego registramos el observer y cargamos datos
                if (!IsPostBack)
                {
                    IdiomaManager.Instance.RegistrarObservador(this);
                    CargarCompras();              // ✅ Ahora se bindea con el idioma correcto
                }

                // 3) Aplicar traducciones a controles con data-translate
                AplicarTraducciones(this);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en 122-MisCompras: {ex.Message}");
                Response.Redirect("Default.aspx");
            }
        }

        private void CargarCompras()
        {
        

            // Llamada al servicio o a la base de datos para obtener las compras del usuario
            List<VentaBE> compras = _serviceVenta.GetVentaUser(usuario.id_usuario);

            // Enlaza la lista de compras al Repeater
            ComprasRepeater.DataSource = compras;
            ComprasRepeater.DataBind();
        }

        protected void btnPDF_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string ventaId = btn.CommandArgument;

            if (!string.IsNullOrEmpty(ventaId))
            {
                // Obtener la venta por ID
                VentaBE venta = _serviceVenta.GetVenta(int.Parse(ventaId));

                if (venta != null)
                {

                    GeneraPdfAfip.BusinessInfo businessInfo = new GeneraPdfAfip.BusinessInfo
                    {
                        BusinessName = "ENERTECH",
                        Address = "Av. Varlos Pellegrini 218",
                        IVACondition = "Responsable Inscripto",
                        CUIT = 20358545492,
                        GrossIncome = "Exento",
                        InitialActivities = new DateTime(2024, 05, 01),
                        PathImage = Server.MapPath("~/Images/afip_logo.png") // Ruta del logo
                    };

                    GeneraPdfAfip.ClientInfo clientInfo = new GeneraPdfAfip.ClientInfo
                    {
                        BusinessName = venta.usuario.RazonSocial,
                        FirstName = venta.usuario.Nombre,
                        LastName = venta.usuario.Apellido,
                        Address = "Laprida 231",
                        IVACondition = "Monotributista",
                        CUIT = venta.usuario.Identificacion,
                        SaleCondition = "Tarjeta"
                    };
                    // Generar el PDF
                    byte[] pdfBytes = GeneraPdfAfip.ReceipToPdf(businessInfo, clientInfo, venta);

                    // Configurar la respuesta para mostrar el PDF en el navegador
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AppendHeader("Content-Disposition", "inline; filename=Factura.pdf");
                    Response.BinaryWrite(pdfBytes);
                    Response.Flush();
                    Response.End();
                }
            }
        }

        protected void AplicarTraducciones(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                // 1) <a runat="server">
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
                // 2) Controles HTML genéricos (span, div, h1, h2, p, etc.)
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
                // 3) WebControls (Label, Button, LinkButton, etc.)
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


        protected void ComprasRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item &&
                e.Item.ItemType != ListItemType.AlternatingItem)
            {
                return;
            }

            var venta = (VentaBE)e.Item.DataItem;
            string estadoOriginal = venta.Estado; // "Facturado", "En camino", etc.

            string claveTraduccion;
            string cssEstado;
            string icono;

            switch (estadoOriginal)
            {
                case "Facturado":
                    claveTraduccion = "status_billed";
                    cssEstado = "status-facturado";
                    icono = "bi-file-earmark-check-fill";
                    break;

                case "En camino":
                    claveTraduccion = "status_shipping";
                    cssEstado = "status-shipping";
                    icono = "bi-truck";
                    break;

                case "Cancelado":
                    claveTraduccion = "status_canceled";
                    cssEstado = "status-canceled";
                    icono = "bi-x-circle-fill";
                    break;

                default:
                    claveTraduccion = "status_pending";
                    cssEstado = "status-pending";
                    icono = "bi-hourglass-split";
                    break;
            }

            // Texto traducido según el idioma actual
            string textoEstado = IdiomaManager.Instance.GetTraduccion(claveTraduccion) ?? estadoOriginal;

            var lblEstado = (HtmlGenericControl)e.Item.FindControl("lblEstado");
            if (lblEstado != null)
            {
                // Aplicar clase base + clase de color
                lblEstado.Attributes["class"] = $"card-status {cssEstado}";

                // Icono + texto
                lblEstado.InnerHtml = $"<i class='bi {icono}'></i> {textoEstado}";
            }
        }

    }
}