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
using System.Web.UI.WebControls;
using System.Xml;
using UI.WebServices;



namespace UI
{
    public partial class _100_Ventas : System.Web.UI.Page
    {
        FacturacionAFIP _facturaacionService = new FacturacionAFIP();
        VentaBLL _ventaService = new VentaBLL();
        SessionManager _sessionManager = new SessionManager();
        UsuarioBLL _usuarioService = new UsuarioBLL();
        public UsuarioBE usuario { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            //usuario = _usuarioService.Login("UAC@gmail.com", "S@nlorenzo2566");
            //_sessionManager.Set("Usuario", usuario);
            usuario = _sessionManager.Get<UsuarioBE>("Usuario");
            if (!IsPostBack)
            {
                CargarVentas();
            }
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
    }


    }
