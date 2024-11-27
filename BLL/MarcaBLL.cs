using BE;
using DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class MarcaBLL
    {
        MarcaDAL marcaDAL = new MarcaDAL();
        public List<MarcaBE> GetMarcas()
        {
            try
            {
                List<MarcaBE> marcas = marcaDAL.GetMarcas();

                return marcas;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }
        }

        public MarcaBE GetMarcaID(int xid)
        {
            try
            {
                MarcaBE marcas = marcaDAL.GetMarcaID(xid);

                return marcas;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }
        }
    }
}
