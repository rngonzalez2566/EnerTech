using BE;
using Services;
using System;
using System.Collections.Generic;
using System.Data;
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
                xParameters.Parameters.AddWithValue("@user", venta.usuario.id_usuario);
                xParameters.Parameters.AddWithValue("@total", venta.Total);
                xParameters.Parameters.AddWithValue("@iva", venta.IVA);
                xParameters.Parameters.AddWithValue("@gravado", venta.TotalGravado);
                xParameters.Parameters.AddWithValue("@fac", false);


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
                xParameters.Parameters.AddWithValue("@prod", venta.Producto.id_producto);
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
        public void BorrarCarrito(VentaBE venta)
        {
            try
            {
                xCommandText = Querys.CarritoQuerys.delete_Carrito;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", venta.usuario.id_usuario);
 

                 executeNonQuery();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public List<VentaBE> GetVentaUser(int user)
        {
            try
            {

             
                xCommandText = Querys.VentaQuerys.Get_Venta_User;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", user);
                DataSet ds = ExecuteReader();

                List<VentaBE> ventas = new List<VentaBE>();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ventas = Tools.VentaTools.FillListVentas(ds);
                }
                   

                return ventas;

                
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public List<Detalle_VentaBE> GetDetalleVenta(int venta)
        {
            try
            {


                xCommandText = Querys.VentaQuerys.Get_Detalle_Venta;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@venta", venta);
                DataSet ds = ExecuteReader();

                List<Detalle_VentaBE> ventas = new List<Detalle_VentaBE>();
                if (ds.Tables[0].Rows.Count > 0)
                    ventas = Tools.Detalle_VentaTools.FillListVentas(ds);

                return ventas;


            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public List<RelatedTaxesBE> GetTaxesVenta(int venta)
        {
            try
            {


                xCommandText = Querys.VentaQuerys.Get_Taxes_Venta;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@venta", venta);
                DataSet ds = ExecuteReader();

                List<RelatedTaxesBE> taxes = new List<RelatedTaxesBE>();
                if (ds.Tables[0].Rows.Count > 0)
                    taxes = Tools.TaxesTools.FillListTaxes(ds);

                return taxes;


            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public VentaBE GetVenta(int idVenta)
        {
            try
            {
                xCommandText = Querys.VentaQuerys.Get_Venta;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@venta", idVenta);
                DataSet ds = ExecuteReader();


                VentaBE venta = ds.Tables[0].Rows.Count <= 0 ? null : Tools.VentaTools.FillObjectVenta(ds.Tables[0].Rows[0]);

                return venta;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
          
        }

        public List<VentaBE> GetVentas()
        {
            try
            {
                xCommandText = Querys.VentaQuerys.Get_Ventas;

                DataSet ds = ExecuteReader();

                List<VentaBE> ventas = new List<VentaBE>();
                if (ds.Tables[0].Rows.Count > 0)
                    ventas = Tools.VentaTools.FillListVentas(ds);

                return ventas;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }

        }

        public void ActualizarVenta(VentaBE venta)
        {
            try
            {
                xCommandText = Querys.VentaQuerys.update_Venta;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@pv", venta.PuntoDeVenta);
                xParameters.Parameters.AddWithValue("@nro", venta.NumeroVenta);
                xParameters.Parameters.AddWithValue("@estado", venta.Estado);
                xParameters.Parameters.AddWithValue("@obs", venta.Observaciones);
                xParameters.Parameters.AddWithValue("@cod", venta.CodigoAutorizacion);
                xParameters.Parameters.AddWithValue("@fc", venta.FechaVtoCae.ToString("yyyy-MM-dd HH:mm:ss"));
                xParameters.Parameters.AddWithValue("@ta", venta.TipoAutorizacion);
                xParameters.Parameters.AddWithValue("@venta", venta.id_venta);
                xParameters.Parameters.AddWithValue("@fac", venta.Facturado);
                xParameters.Parameters.AddWithValue("@tc", venta.TipoComprobante);
                xParameters.Parameters.AddWithValue("@qr", venta.QRData);

                executeNonQuery();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public void ActualizarVentaRechazada(VentaBE venta)
        {
            try
            {
                xCommandText = Querys.VentaQuerys.update_Venta_rechazada;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@estado", venta.Estado);
                xParameters.Parameters.AddWithValue("@obs", venta.Observaciones);
                xParameters.Parameters.AddWithValue("@venta", venta.id_venta);


                executeNonQuery();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public void ReprocesarRechazo(int idVenta)
        {
            try
            {
                xCommandText = Querys.VentaQuerys.update_reprocesar;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@venta", idVenta);


                executeNonQuery();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public List<VentaBE> GetVentasFiltradas(DateTime? fd, DateTime? fh, bool? fact)
        {
            try
            {


                xCommandText = Querys.VentaQuerys.filtro_fechas;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@fd", fd.HasValue ? (object)fd.Value : DBNull.Value);
                xParameters.Parameters.AddWithValue("@fh", fh.HasValue ? (object)fh.Value : DBNull.Value);
                xParameters.Parameters.AddWithValue("@fac", fact.HasValue ? (object)fact.Value : DBNull.Value);
                DataSet ds = ExecuteReader();

                List<VentaBE> ventas = new List<VentaBE>();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ventas = Tools.VentaTools.FillListVentas(ds);
                }


                return ventas;


            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
          
        }

        public List<VentaBE> VentasPorMes()
        {
            try
            {


                xCommandText = Querys.VentaQuerys.Get_Ventas_PorMes;

                xParameters.Parameters.Clear();
                DataSet ds = ExecuteReader();

                List<VentaBE> ventas = new List<VentaBE>();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ventas = Tools.VentaTools.FillListVentas(ds);
                }


                return ventas;


            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public List<VentaBE> VentasPorCategoria()
        {
            try
            {


                xCommandText = Querys.VentaQuerys.Get_Ventas_PorCategoria;

                xParameters.Parameters.Clear();
                DataSet ds = ExecuteReader();

                List<VentaBE> ventas = new List<VentaBE>();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ventas = Tools.VentaTools.FillListVentas(ds);
                }


                return ventas;


            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }


    }
}
