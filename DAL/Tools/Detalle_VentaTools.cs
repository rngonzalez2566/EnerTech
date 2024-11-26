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
    public class Detalle_VentaTools
    {
        public static Detalle_VentaBE FillObjectDetalleVenta(DataRow dr)
        {
            Detalle_VentaBE detalleVenta = new Detalle_VentaBE();
            ProductoDAL prod = new ProductoDAL();
            detalleVenta.venta = new VentaBE();
            detalleVenta.Producto = new ProductoBE();


            if (dr.Table.Columns.Contains("id_detalle_venta") && !Convert.IsDBNull(dr["id_detalle_venta"]))
                detalleVenta.id_detalle_venta = Convert.ToInt32(dr["id_detalle_venta"]);

            if (dr.Table.Columns.Contains("Codigo") && !Convert.IsDBNull(dr["Codigo"]))
                detalleVenta.Codigo = Convert.ToString(dr["Codigo"]);

            if (dr.Table.Columns.Contains("Descripcion") && !Convert.IsDBNull(dr["Descripcion"]))
                detalleVenta.Descripcion = Convert.ToString(dr["Descripcion"]);

            if (dr.Table.Columns.Contains("Cantidad") && !Convert.IsDBNull(dr["Cantidad"]))
                detalleVenta.Cantidad = Convert.ToInt32(dr["Cantidad"]);

            if (dr.Table.Columns.Contains("PrecioUnitario") && !Convert.IsDBNull(dr["PrecioUnitario"]))
                detalleVenta.PrecioUnitario = Convert.ToDecimal(dr["PrecioUnitario"]);

            if (dr.Table.Columns.Contains("Total") && !Convert.IsDBNull(dr["Total"]))
                detalleVenta.Total = Convert.ToDecimal(dr["Total"]);

            if (dr.Table.Columns.Contains("IVA") && !Convert.IsDBNull(dr["IVA"]))
                detalleVenta.IVA = Convert.ToDecimal(dr["IVA"]);

            if (dr.Table.Columns.Contains("CodigoIVA") && !Convert.IsDBNull(dr["CodigoIVA"]))
                detalleVenta.codigoIVA = CodigoIVA.ObtenerTipoIVA(Convert.ToInt32(dr["CodigoIVA"]));

            //if (dr.Table.Columns.Contains("id_venta") && !Convert.IsDBNull(dr["id_venta"]))
            //    detalleVenta.venta = Convert.ToInt32(dr["id_venta"]);

            if (dr.Table.Columns.Contains("id_producto") && !Convert.IsDBNull(dr["id_producto"]))
                detalleVenta.Producto = prod.GetProductoID(Convert.ToInt32(dr["id_producto"]));

            return detalleVenta;
        }

        public static List<Detalle_VentaBE> FillListVentas(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectDetalleVenta(dr)).ToList();
        }
    }
}
