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
    }
}
