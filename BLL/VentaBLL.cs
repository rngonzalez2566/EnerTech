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

        public List<Detalle_VentaBE> GetDetalleVenta(int venta)
        {
            List<Detalle_VentaBE> ventas = ventalDAL.GetDetalleVenta(venta);

            return ventas;
        }
    }
}
