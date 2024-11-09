using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Services;
using iTextSharp.text;
using iTextSharp.text.pdf;
using BE;

namespace UI.WebServices
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class GeneraPdfAfip : System.Web.Services.WebService
    {
        [WebMethod]
        public byte[] GenerarFacturaPDF(VentaBE venta)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                // Crear documento PDF
                Document document = new Document(PageSize.A4);
                PdfWriter writer = PdfWriter.GetInstance(document, ms);
                document.Open();

                // Encabezado de la factura
                Font headerFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16);
                Paragraph header = new Paragraph("Factura Electrónica", headerFont)
                {
                    Alignment = Element.ALIGN_CENTER
                };
                document.Add(header);
                document.Add(new Paragraph(" ")); // Espacio

                // Información del cliente
                Font infoFont = FontFactory.GetFont(FontFactory.HELVETICA, 12);
                document.Add(new Paragraph($"Fecha: {venta.Fecha:yyyy-MM-dd}", infoFont));
                document.Add(new Paragraph($"Cliente: {venta.usuario.Identificacion}", infoFont));
                document.Add(new Paragraph($"Total: {venta.Total:C}", infoFont));
                document.Add(new Paragraph(" ")); // Espacio

                // Crear tabla de productos
                PdfPTable table = new PdfPTable(4)
                {
                    WidthPercentage = 100
                };
                table.AddCell("Cantidad");
                table.AddCell("Descripción");
                table.AddCell("Precio Unitario");
                table.AddCell("Total");

                foreach (var item in venta.Items)
                {
                    table.AddCell(item.Cantidad.ToString());
                    table.AddCell(item.Descripcion);
                    table.AddCell(item.PrecioUnitario.ToString("C"));
                    table.AddCell(item.Total.ToString("C"));
                }

                document.Add(table);
                document.Close();

                // Devolver el PDF como byte array
                return ms.ToArray();
            }
        }
    }
}
