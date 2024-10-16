using BE;
using Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class MarcaDAL : Acceso
    {
        public MarcaBE GetMarcaID(int id)
        {

            try
            {
                xCommandText = Querys.MarcaQuerys.GetMarca;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@id", id);
                DataSet ds = ExecuteReader();


                BE.MarcaBE marca = ds.Tables[0].Rows.Count <= 0 ? null : Tools.MarcaTools.FillObjectMarca(ds.Tables[0].Rows[0]);

                return marca;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }
        public List<MarcaBE> GetMarcas()
        {

            try
            {
                xCommandText = Querys.MarcaQuerys.GetMarcas;
                DataSet ds = ExecuteReader();

                List<BE.MarcaBE> marcas = new List<BE.MarcaBE>();
                if (ds.Tables[0].Rows.Count > 0)
                    marcas = Tools.MarcaTools.FillListMarca(ds);

                return marcas;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }
    }
}
