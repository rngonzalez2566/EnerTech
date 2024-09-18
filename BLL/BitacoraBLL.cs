using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using BE;
using System.Transactions;
using Services;

namespace BLL
{
    public class BitacoraBLL
    {

        BitacoraDAL BitacoraDAL = new BitacoraDAL();

        public int RegistrarBitacora(string detalle, string criticidad, UsuarioBE usuario)
        {
            try
            {
                int id = 0;

                using (TransactionScope scope = new TransactionScope())
                {
                    BitacoraBE bitacora = new BitacoraBE()
                    {
                        usuario = usuario,
                        Detalle = detalle,
                        Criticidad = criticidad,
                        Fecha = DateHandler.Now(),
                    };

                    id = BitacoraDAL.RegistrarBitacora(bitacora);
                    scope.Complete();
                }

                return id;


            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }

        }

        public List<BitacoraBE> GetBitacora()
        {
            List<BitacoraBE> bitacora = BitacoraDAL.GetBitacora();

            return bitacora;
        }
    }
}
