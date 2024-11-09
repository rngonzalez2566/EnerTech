using BE;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Xml;

namespace UI.WebServices
{
    
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]

    public class GeneraXmlAfip : System.Web.Services.WebService
    {

        [WebMethod]
        public string GenerarXmlAfip(VentaBE venta)
        {
            if (venta == null)
            {
                return "Error: VentaBE es nulo.";
            }

            try
            {
                // Generar el XML en formato AFIP WSFE
                string xmlGenerado = GenerarXML(venta);
                return xmlGenerado;
            }
            catch (Exception ex)
            {
                return $"Error al generar el XML: {ex.Message}";
            }
        }

        private string GenerarXML(VentaBE venta)
        {
            string mon = "PES";
            int cot = 1;
            StringBuilder xmlBuilder = new StringBuilder();
            using (StringWriter stringWriter = new StringWriter(xmlBuilder))
            {
                using (XmlTextWriter writer = new XmlTextWriter(stringWriter))
                {
                    writer.Formatting = Formatting.Indented;
                    writer.WriteStartDocument();

                    // Nodo raíz
                    writer.WriteStartElement("FeCAEReq");

                    // Encabezado del XML
                    writer.WriteStartElement("FeCabReq");
                    writer.WriteElementString("CantReg", "1");
                    writer.WriteElementString("PtoVta", venta.PuntoDeVenta.ToString());
                    writer.WriteElementString("CbteTipo", venta.TipoComprobante.ToString()); // Tipo de comprobante
                    writer.WriteEndElement();

                    // Detalle del comprobante
                    writer.WriteStartElement("FeDetReq");

                    writer.WriteStartElement("FECAEDetRequest");
                    writer.WriteElementString("Concepto", 1.ToString());
                    writer.WriteElementString("DocTipo", venta.usuario.TipoDocumento.ToString());
                    writer.WriteElementString("DocNro", venta.usuario.Identificacion.ToString());
                    writer.WriteElementString("CbteDesde", venta.NumeroVenta.ToString());
                    writer.WriteElementString("CbteHasta", venta.NumeroVenta.ToString());
                    writer.WriteElementString("CbteFch", venta.Fecha.ToString("yyyyMMdd"));
                    writer.WriteElementString("ImpTotal", venta.Total.ToString("F2"));
                    writer.WriteElementString("ImpNeto", venta.TotalGravado.ToString("F2"));
                    writer.WriteElementString("ImpIVA", venta.IVA.ToString("F2"));
                    writer.WriteElementString("MonId", mon);
                    writer.WriteElementString("MonCotiz", cot.ToString("F2"));

                    // Agregar detalles de IVA si existen
                    if (venta.RelatedTaxes != null && venta.RelatedTaxes.Count > 0)
                    {
                        writer.WriteStartElement("Iva");
                        foreach (var item in venta.RelatedTaxes)
                        {
                            writer.WriteStartElement("AlicIva");
                            writer.WriteElementString("Id", item.codigoIVA.ToString());
                            writer.WriteElementString("BaseImp", item.BaseImponible.ToString("F2"));
                            writer.WriteElementString("Importe", item.TotalIVA.ToString("F2"));
                            writer.WriteEndElement(); // AlicIva
                        }
                        writer.WriteEndElement(); // Iva
                    }

                    writer.WriteEndElement(); // FECAEDetRequest
                    writer.WriteEndElement(); // FeDetReq
                    writer.WriteEndElement(); // FeCAEReq

                    writer.WriteEndDocument();
                }
            }

            return xmlBuilder.ToString();
        }
    }
}
