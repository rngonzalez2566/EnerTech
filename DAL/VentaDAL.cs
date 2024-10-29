using BE;
using Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class VentaDAL : Acceso
    {
        public int AltaVenta(VentaBE venta)
        {
            try
            {
                xCommandText = Querys.VentaQuerys.addVenta;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@fecha", venta.Fecha.ToString("yyyy-MM-dd HH:mm:ss"));
                xParameters.Parameters.AddWithValue("@detalle", venta.Detalle);
                xParameters.Parameters.AddWithValue("@user", venta.usuario.Id);
                xParameters.Parameters.AddWithValue("@total", venta.Total);
                xParameters.Parameters.AddWithValue("@iva", venta.IVA);
                xParameters.Parameters.AddWithValue("@gravado", venta.TotalGravado);
  
                
                return ExecuteNonEscalar();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public int AltaDetalleVenta(Detalle_VentaBE venta, int idVenta)
        {
            try
            {
                xCommandText = Querys.VentaQuerys.addDetalle_Venta;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@venta", idVenta);
                xParameters.Parameters.AddWithValue("@prod", venta.Producto.Id);
                xParameters.Parameters.AddWithValue("@cod", venta.Producto.Codigo);
                xParameters.Parameters.AddWithValue("@descripcion", venta.Producto.Descripcion);
                xParameters.Parameters.AddWithValue("@cant", venta.Cantidad);
                xParameters.Parameters.AddWithValue("@PU", venta.PrecioUnitario);
                xParameters.Parameters.AddWithValue("@tot", venta.Total);
                xParameters.Parameters.AddWithValue("@iva", venta.IVA);
                xParameters.Parameters.AddWithValue("@codIVA", venta.codigoIVA.Codigo);

                return ExecuteNonEscalar();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public int AltaTaxes(RelatedTaxesBE taxes, int venta)
        {
            try
            {
                xCommandText = Querys.VentaQuerys.addRelated_Taxes;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@cod", taxes.codigoIVA);
                xParameters.Parameters.AddWithValue("@tasa", taxes.TasaIVA);
                xParameters.Parameters.AddWithValue("@base", taxes.BaseImponible);
                xParameters.Parameters.AddWithValue("@iva", taxes.TotalIVA);
                xParameters.Parameters.AddWithValue("@venta", venta);

               
                return ExecuteNonEscalar();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }
    }
}
