using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using BE.AFIP;

namespace DAL.Tools
{
    public class VentaTools
    {
        public static VentaBE FillObjectVenta(DataRow dr)
        {
            VentaBE venta = new VentaBE();
            UsuarioDAL usuarioDAL = new UsuarioDAL();
            VentaDAL ventaDAL = new VentaDAL();
            venta.usuario = new UsuarioBE();


            if (dr.Table.Columns.Contains("id_venta") && !Convert.IsDBNull(dr["id_venta"]))
                venta.id_venta = Convert.ToInt32(dr["id_venta"]);

            if (dr.Table.Columns.Contains("DVH") && !Convert.IsDBNull(dr["DVH"]))
                venta.DVH = Convert.ToInt32(dr["DVH"]);

            if (dr.Table.Columns.Contains("Fecha") && !Convert.IsDBNull(dr["Fecha"]))
                venta.Fecha = Convert.ToDateTime(dr["Fecha"]);

            if (dr.Table.Columns.Contains("Detalle") && !Convert.IsDBNull(dr["Detalle"]))
                venta.Detalle = Convert.ToString(dr["Detalle"]);

            if (dr.Table.Columns.Contains("Estado") && !Convert.IsDBNull(dr["Estado"]))
                venta.Estado = Convert.ToString(dr["Estado"]);


            if (dr.Table.Columns.Contains("QRData") && !Convert.IsDBNull(dr["QRData"]))
                venta.QRData = Convert.ToString(dr["QRData"]);

            if (dr.Table.Columns.Contains("Observaciones") && !Convert.IsDBNull(dr["Observaciones"]))
                venta.Observaciones = Convert.ToString(dr["Observaciones"]);

            if (dr.Table.Columns.Contains("CodigoAutorizacion") && !Convert.IsDBNull(dr["CodigoAutorizacion"]))
                venta.CodigoAutorizacion = Convert.ToInt64(dr["CodigoAutorizacion"]);

            if (dr.Table.Columns.Contains("FechaVtoCae") && !Convert.IsDBNull(dr["FechaVtoCae"]))
                venta.FechaVtoCae = Convert.ToDateTime(dr["FechaVtoCae"]);

            if (dr.Table.Columns.Contains("PuntoDeVenta") && !Convert.IsDBNull(dr["PuntoDeVenta"]))
                venta.PuntoDeVenta = Convert.ToInt32(dr["PuntoDeVenta"]);

            if (dr.Table.Columns.Contains("NumeroVenta") && !Convert.IsDBNull(dr["NumeroVenta"]))
                venta.NumeroVenta = Convert.ToInt32(dr["NumeroVenta"]);

            if (dr.Table.Columns.Contains("Facturado") && !Convert.IsDBNull(dr["Facturado"]))
                venta.Facturado = Convert.ToBoolean(dr["Facturado"]);

            if (dr.Table.Columns.Contains("TipoComprobante") && !Convert.IsDBNull(dr["TipoComprobante"]))
                venta.TipoComprobante = Convert.ToString(dr["TipoComprobante"]);

            if (dr.Table.Columns.Contains("Total") && !Convert.IsDBNull(dr["Total"]))
                venta.Total = Convert.ToDecimal(dr["Total"]);

            if (dr.Table.Columns.Contains("IVA") && !Convert.IsDBNull(dr["IVA"]))
                venta.IVA = Convert.ToDecimal(dr["IVA"]);

            if (dr.Table.Columns.Contains("TotalGravado") && !Convert.IsDBNull(dr["TotalGravado"]))
                venta.TotalGravado = Convert.ToDecimal(dr["TotalGravado"]);

            if (dr.Table.Columns.Contains("TipoAutorizacion") && !Convert.IsDBNull(dr["TipoAutorizacion"]))
                venta.TipoAutorizacion = Convert.ToString(dr["TipoAutorizacion"]);

            if (dr.Table.Columns.Contains("id_usuario") && !Convert.IsDBNull(dr["id_usuario"]))
                venta.usuario = usuarioDAL.GetUsuarioID(Convert.ToInt32(dr["id_usuario"]));

            venta.Items = ventaDAL.GetDetalleVenta(venta.id_venta);
            venta.RelatedTaxes = ventaDAL.GetTaxesVenta(venta.id_venta);

            return venta;
        }

        public static List<VentaBE> FillListVentas(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectVenta(dr)).ToList();
        }
    }
}
