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
            venta.usuario = new UsuarioBE();


            if (dr.Table.Columns.Contains("Id") && !Convert.IsDBNull(dr["Id"]))
                venta.Id = Convert.ToInt32(dr["Id"]);

            if (dr.Table.Columns.Contains("Fecha") && !Convert.IsDBNull(dr["Fecha"]))
                venta.Fecha = Convert.ToDateTime(dr["Fecha"]);

            if (dr.Table.Columns.Contains("Detalle") && !Convert.IsDBNull(dr["Detalle"]))
                venta.Detalle = Convert.ToString(dr["Detalle"]);

            if (dr.Table.Columns.Contains("CodigoAutorizacion") && !Convert.IsDBNull(dr["CodigoAutorizacion"]))
                venta.CodigoAutorizacion = Convert.ToInt64(dr["CodigoAutorizacion"]);

            if (dr.Table.Columns.Contains("FechaVtoCae") && !Convert.IsDBNull(dr["FechaVtoCae"]))
                venta.FechaVtoCae = Convert.ToDateTime(dr["FechaVtoCae"]);

            if (dr.Table.Columns.Contains("PuntoDeVenta") && !Convert.IsDBNull(dr["PuntoDeVenta"]))
                venta.PuntoDeVenta = Convert.ToInt32(dr["PuntoDeVenta"]);

            if (dr.Table.Columns.Contains("NumeroVenta") && !Convert.IsDBNull(dr["NumeroVenta"]))
                venta.NumeroVenta = Convert.ToInt32(dr["NumeroVenta"]);


            if (dr.Table.Columns.Contains("TipoComprobante") && !Convert.IsDBNull(dr["TipoComprobante"]))
                venta.TipoComprobante = Convert.ToString(dr["TipoComprobante"]);

            if (dr.Table.Columns.Contains("Total") && !Convert.IsDBNull(dr["Total"]))
                venta.Total = Convert.ToSingle(dr["Total"]);

            if (dr.Table.Columns.Contains("IVA") && !Convert.IsDBNull(dr["IVA"]))
                venta.IVA = Convert.ToSingle(dr["IVA"]);

            if (dr.Table.Columns.Contains("TotalGravado") && !Convert.IsDBNull(dr["TotalGravado"]))
                venta.TotalGravado = Convert.ToSingle(dr["TotalGravado"]);

            if (dr.Table.Columns.Contains("TipoAutorizacion") && !Convert.IsDBNull(dr["TipoAutorizacion"]))
                venta.TipoAutorizacion = TipoPV.ObtenerTipoPV(Convert.ToString(dr["TipoAutorizacion"]));

            if (dr.Table.Columns.Contains("id_usuario") && !Convert.IsDBNull(dr["id_usuario"]))
                venta.usuario = usuarioDAL.GetUsuarioID(Convert.ToInt32(dr["id_usuario"]));

            return venta;
        }

        public static List<VentaBE> FillListVentas(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectVenta(dr)).ToList();
        }
    }
}
