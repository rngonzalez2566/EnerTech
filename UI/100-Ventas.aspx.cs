using BE;
using BLL;
using BLL.AFIP;

using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml;
using UI.WebServices;



namespace UI
{
    public partial class _100_Ventas : System.Web.UI.Page, IIdiomaObserver
    {
        FacturacionAFIP _facturaacionService = new FacturacionAFIP();
        VentaBLL _ventaService = new VentaBLL();
        SessionManager _sessionManager = new SessionManager();
        UsuarioBLL _usuarioService = new UsuarioBLL();
        Services.EmailService _emailService = new Services.EmailService();
        public UsuarioBE usuario { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string idioma = Request.QueryString["lang"];
            if (!string.IsNullOrEmpty(idioma))
                IdiomaManager.Instance.CambiarIdioma(idioma);

            
            if (!IsPostBack)
            {
                IdiomaManager.Instance.RegistrarObservador(this);
                CargarVentas();         
            }

          
            AplicarTraducciones(this);

                    }
        private void CargarVentas()
        {
            List<VentaBE> ventas = _ventaService.GetVentas();
            gvVentas.DataSource = ventas;
            gvVentas.DataBind();
           
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            DateTime? fechaDesde = string.IsNullOrEmpty(txtFechaDesde.Text) ? (DateTime?)null : Convert.ToDateTime(txtFechaDesde.Text);
            DateTime? fechaHasta = string.IsNullOrEmpty(txtFechaHasta.Text) ? (DateTime?)null : Convert.ToDateTime(txtFechaHasta.Text);
            string facturado = ddlFacturado.SelectedValue;
            bool? esFacturado = null;

            if (facturado == "true")
                esFacturado = true;
            else if (facturado == "false")
                esFacturado = false;

            List<VentaBE> ventasFiltradas = _ventaService.GetVentasFiltradas(fechaDesde, fechaHasta, esFacturado);
            gvVentas.DataSource = ventasFiltradas;
            gvVentas.DataBind();
                    }
        protected void gvVentas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Obtener los botones
                Button btnFacturar = (Button)e.Row.FindControl("btnFacturar");
                Button btnReprocesar = (Button)e.Row.FindControl("btnReprocesar");

                // Obtener el estado
                string estado = DataBinder.Eval(e.Row.DataItem, "Estado")?.ToString();

                // Configurar la visibilidad de los botones según el estado
                if (btnFacturar != null && btnReprocesar != null)
                {
                    if (string.IsNullOrEmpty(estado))
                    {
                        btnFacturar.Visible = true;
                        btnReprocesar.Visible = false;
                    }
                    else if (estado == "R")
                    {
                        btnFacturar.Visible = false;
                        btnReprocesar.Visible = true;
                    }
                    else if (estado == "A")
                    {
                        btnFacturar.Visible = false;
                        btnReprocesar.Visible = false;
                    }
                }
            }
        }


        protected void gvVentas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int ventaId = Convert.ToInt32(e.CommandArgument);
   
        }

        protected async void btnFacturar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtener el botón que fue clickeado y su argumento (ID de la venta)
                Button btnFacturar = (Button)sender;
                int ventaId = Convert.ToInt32(btnFacturar.CommandArgument);

                // Lógica para facturar la venta
                var venta = await _facturaacionService.GenerarFacturaAFIP(ventaId);

                CargarVentas();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Ocurrió un error: " + ex.Message + "');</script>");
            }
        }

        protected void btnReprocesar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtener el botón que fue clickeado y su argumento (ID de la venta)
                Button btnReprocesar = (Button)sender;
                int ventaId = Convert.ToInt32(btnReprocesar.CommandArgument);

                // Lógica para reprocesar la venta
               _ventaService.ReprocesarRechazo(ventaId);

                CargarVentas();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Ocurrió un error: " + ex.Message + "');</script>");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                string ventaId = btn.CommandArgument;

                if (string.IsNullOrEmpty(ventaId))
                    throw new Exception("No se recibió el id de la venta.");

                VentaBE venta = _ventaService.GetVenta(int.Parse(ventaId));
                if (venta == null)
                    throw new Exception("No se encontró la venta.");

                // 📌 Email destino: usá el mail del usuario de la venta
                // Ajustá esta propiedad si en tu BE se llama distinto
                string toEmail = "rngonzalez2566@gmail.com";

                if (string.IsNullOrWhiteSpace(toEmail))
                    throw new Exception("El cliente no tiene Email cargado.");

                // Genero PDF como bytes
                byte[] pdfBytes = GenerarPdfVenta(venta);

                // Asunto/cuerpo simples (demo)
                string subject = $"Factura Venta #{venta.NumeroVenta} - EnerTech";
                string bodyHtml =
                    $"<h3>Factura EnerTech</h3>" +
                    $"<p>Adjuntamos la factura de la venta <b>#{venta.NumeroVenta}</b>.</p>" +
                    $"<p>Total: <b>{venta.Total:C}</b></p>" +
                    $"<p>Gracias.</p>";

                string fileName = $"Factura_{venta.PuntoDeVenta}_{venta.NumeroVenta}.pdf";

                // Enviar
                _emailService.EnviarFacturaPdf(toEmail, subject, bodyHtml, pdfBytes, fileName);

                // Mensaje ok
                ScriptManager.RegisterStartupScript(this, GetType(), "ok",
                    "hideEmailOverlay(); showEmailToast();", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "err",
                      "hideEmailOverlay(); alert('Error enviando email');", true);
            }
        }
        protected void btnPDF_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string ventaId = btn.CommandArgument;

            if (!string.IsNullOrEmpty(ventaId))
            {
                // Obtener la venta por ID
                VentaBE venta = _ventaService.GetVenta(int.Parse(ventaId));

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


        protected void btnXML_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string ventaId = btn.CommandArgument;

            if (!string.IsNullOrEmpty(ventaId))
            {
                // Obtener la venta desde tu servicio o base de datos
                VentaBE venta = _ventaService.GetVenta(int.Parse(ventaId));

                if (venta != null)
                {
                    try
                    {
                        // Instanciar el Web Service
                        GeneraXmlAfip servicioXml = new GeneraXmlAfip();

                        // Generar el XML llamando al método del Web Service
                        string xmlGenerado = servicioXml.GenerarXmlAfip(venta);

                        if (!string.IsNullOrEmpty(xmlGenerado))
                        {
                            // Configurar la respuesta para mostrar el XML en pantalla
                            Response.Clear();
                            Response.ContentType = "application/xml";
                            Response.AddHeader("Content-Disposition", "inline"); // Muestra en el navegador en lugar de descargar

                            // Escribir el XML en la respuesta
                            Response.Write(xmlGenerado.Trim());
                            Response.Flush();
                            Response.SuppressContent = true;
                            HttpContext.Current.ApplicationInstance.CompleteRequest();
                        }
                        else
                        {
                            Response.Write("Error al generar el XML.");
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write($"Error: {ex.Message}");
                    }
                }
                else
                {
                    Response.Write("No se encontró la venta.");
                }
            }
        }

        protected void btnExportarXML_Click(object sender, EventArgs e)
        {
            try
            {
                List<VentaBE> ventas = new List<VentaBE>();
                foreach (GridViewRow row in gvVentas.Rows)
                {
                    VentaBE venta = new VentaBE
                    {
                        Fecha = DateTime.Parse(row.Cells[0].Text),
                        usuario = usuario,
                        Total = decimal.Parse(row.Cells[2].Text.Replace("$", "")),
                        PuntoDeVenta = int.Parse(row.Cells[3].Text),
                        NumeroVenta = int.Parse(row.Cells[4].Text),
                        CodigoAutorizacion = long.Parse(row.Cells[5].Text),
                        Estado = row.Cells[6].Text,
                        Observaciones = row.Cells[7].Text
                    };
                    ventas.Add(venta);
                }

                // Llamar al Web Service para obtener el XML
                GeneraXmlVentas service = new GeneraXmlVentas();
                string xmlData = service.GenerarXmlVentas(ventas);

                // Descargar el XML como un archivo
                byte[] byteArray = System.Text.Encoding.UTF8.GetBytes(xmlData);

                Response.Clear();
                Response.ContentType = "application/xml";
                Response.AddHeader("Content-Disposition", "attachment; filename=ventas.xml");
                Response.BinaryWrite(byteArray);
                Response.Flush();
                Response.Close(); // Cerrar la respuesta de forma segura
            }
            catch (Exception ex)
            {
                Response.Clear();
                Response.ContentType = "text/html";
                Response.Write("<Error>" + ex.Message + "</Error>");
                Response.Flush();
                Response.Close(); // Asegurar que la respuesta se cierre correctamente en caso de error
            }
        }

        private void AplicarTraducciones(Control control)
        {
            foreach (Control child in control.Controls)
            {
                // HTML genérico <span>, <label>, <h2>, <div>, <a>, etc.
                if (child is HtmlGenericControl html &&
                    html.Attributes["data-translate"] != null)
                {
                    string key = html.Attributes["data-translate"];
                    string translated = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(translated))
                        html.InnerText = translated;
                }
                // WebControls (Button, TextBox, DropDownList, etc)
                else if (child is WebControl web &&
                         web.Attributes["data-translate"] != null)
                {
                    string key = web.Attributes["data-translate"];
                    string translated = IdiomaManager.Instance.GetTraduccion(key);

                    if (!string.IsNullOrEmpty(translated))
                    {
                        if (child is IButtonControl btn)
                            btn.Text = translated;
                        else if (child is ITextControl txt)
                            txt.Text = translated;
                        else if (child is TextBox t)
                            t.Attributes["placeholder"] = translated;
                    }
                }

                if (child.HasControls())
                    AplicarTraducciones(child);
            }
        }

        protected void gvVentas_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.Header)
                return;

            // Ojo: el orden de las celdas debe coincidir con las columnas
            e.Row.Cells[0].Text = IdiomaManager.Instance.GetTraduccion("date_header") ?? e.Row.Cells[0].Text;
            e.Row.Cells[1].Text = IdiomaManager.Instance.GetTraduccion("client_header") ?? e.Row.Cells[1].Text;
            e.Row.Cells[2].Text = IdiomaManager.Instance.GetTraduccion("total_header") ?? e.Row.Cells[2].Text;
            e.Row.Cells[3].Text = IdiomaManager.Instance.GetTraduccion("pv_header") ?? e.Row.Cells[3].Text;
            e.Row.Cells[4].Text = IdiomaManager.Instance.GetTraduccion("number_header") ?? e.Row.Cells[4].Text;
            e.Row.Cells[5].Text = IdiomaManager.Instance.GetTraduccion("cae_header") ?? e.Row.Cells[5].Text;
            e.Row.Cells[6].Text = IdiomaManager.Instance.GetTraduccion("status_header") ?? e.Row.Cells[6].Text;
            e.Row.Cells[7].Text = IdiomaManager.Instance.GetTraduccion("notes_header") ?? e.Row.Cells[7].Text;
            e.Row.Cells[8].Text = IdiomaManager.Instance.GetTraduccion("actions_header") ?? e.Row.Cells[8].Text;
        }


        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
            
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }

        private byte[] GenerarPdfVenta(VentaBE venta)
        {
            GeneraPdfAfip.BusinessInfo businessInfo = new GeneraPdfAfip.BusinessInfo
            {
                BusinessName = "ENERTECH",
                Address = "Av. Varlos Pellegrini 218",
                IVACondition = "Responsable Inscripto",
                CUIT = 20358545492,
                GrossIncome = "Exento",
                InitialActivities = new DateTime(2024, 05, 01),
                PathImage = Server.MapPath("~/Images/afip_logo.png")
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

            return GeneraPdfAfip.ReceipToPdf(businessInfo, clientInfo, venta);
        }



    }


}
