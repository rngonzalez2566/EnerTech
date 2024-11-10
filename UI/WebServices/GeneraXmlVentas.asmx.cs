using BE;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Xml;

namespace UI.WebServices
{
    /// <summary>
    /// Summary description for GeneraXmlVentas
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class GeneraXmlVentas : System.Web.Services.WebService
    {

        [WebMethod]
        public string GenerarXmlVentas(List<VentaBE> ventas)
        {
            try
            {
                // Crear un DataTable para almacenar los datos de ventas
                DataTable dt = new DataTable("Ventas");
                dt.Columns.Add("Fecha");
                dt.Columns.Add("Cliente");
                dt.Columns.Add("Total");
                dt.Columns.Add("PV");
                dt.Columns.Add("NroVenta");
                dt.Columns.Add("CAE");
                dt.Columns.Add("Estado");
                dt.Columns.Add("Observaciones");

                // Llenar el DataTable con la lista de ventas
                foreach (var venta in ventas)
                {
                    DataRow row = dt.NewRow();
                    row["Fecha"] = venta.Fecha.ToString("yyyy-MM-dd");
                    row["Cliente"] = venta.usuario.Identificacion;
                    row["Total"] = venta.Total;
                    row["PV"] = venta.PuntoDeVenta;
                    row["NroVenta"] = venta.NumeroVenta;
                    row["CAE"] = venta.CodigoAutorizacion;
                    row["Estado"] = venta.Estado;
                    row["Observaciones"] = venta.Observaciones;
                    dt.Rows.Add(row);
                }

                // Generar el archivo XML
                using (StringWriter sw = new StringWriter())
                {
                    dt.WriteXml(sw, XmlWriteMode.WriteSchema);
                    return sw.ToString();
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }
    }
}

