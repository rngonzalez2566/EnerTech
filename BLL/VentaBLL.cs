using BE;
using DAL;
using Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace BLL
{
    public class VentaBLL
    {
        VentaDAL ventalDAL =  new VentaDAL();
       DigitoVerificadorDAL dv = new DigitoVerificadorDAL();
        Services.DigitoVerificador sdv = new Services.DigitoVerificador();
        public int RegistrarVenta(VentaBE venta)
        {

            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    int _id = ventalDAL.AltaVenta(venta);
                    
                    foreach (var item in venta.Items)
                    {
                        ventalDAL.AltaDetalleVenta(item, _id);
                    }

                    foreach (var itemtax in venta.RelatedTaxes)
                    {
                        ventalDAL.AltaTaxes(itemtax, _id);
                    }

                    ventalDAL.BorrarCarrito(venta);
                    //bitacora.RegistrarBitacora($"{usuario.Identificacion} - Se registro un nuevo usuario correctamente", "Media", usuario);
                    dv.RecalcularDigitosCarrito("Carrito",sdv);
                    dv.RecalcularDigitosVenta("Venta", sdv);
                    scope.Complete();

                    return _id;
                }

            }
            catch
            {
                throw new Exception(ErrorMessages.ERR001);
            }
        }

       

        public List<VentaBE> GetVentaUser(int user)
        {
            List<VentaBE> ventas = ventalDAL.GetVentaUser(user);

            return ventas;
        }

        public List<VentaBE> VentasPorCategoria()
        {
            List<VentaBE> ventas = ventalDAL.VentasPorCategoria();

            return ventas;
        }

        public List<VentaBE> VentasPorMes()
        {
            List<VentaBE> ventas = ventalDAL.VentasPorMes();

            return ventas;
        }
        public List<Detalle_VentaBE> GetDetalleVenta(int venta)
        {
            List<Detalle_VentaBE> ventas = ventalDAL.GetDetalleVenta(venta);

            return ventas;
        }

        public List<VentaBE> GetVentas()
        {
            List<VentaBE> ventas = ventalDAL.GetVentas();

            return ventas;
        }

        public List<Detalle_VentaBE> GetDetalleVentas()
        {
            List<Detalle_VentaBE> ventas = ventalDAL.GetDetalleVentas();

            return ventas;
        }

        public List<RelatedTaxesBE> GetTaxes()
        {
            List<RelatedTaxesBE> ventas = ventalDAL.GetTaxes();

            return ventas;
        }

        public VentaBE GetVenta(int idVenta)
        {
            VentaBE venta = ventalDAL.GetVenta(idVenta);

            return venta;
        }

        public void ReprocesarRechazo(int idVenta)
        {
          ventalDAL.ReprocesarRechazo(idVenta);
          dv.RecalcularDigitosCarrito("Venta", sdv);

        }

        public List<VentaBE> GetVentasFiltradas(DateTime? fd, DateTime? fh, bool? fact)
        {
            List<VentaBE> ventas = ventalDAL.GetVentasFiltradas(fd,fh,fact);

            return ventas;
        }


    }
}
