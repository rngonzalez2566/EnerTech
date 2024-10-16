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
    public class CategoriaDAL : Acceso
    {
        public CategoriaBE GetCategoriaID(int id)
        {

            try
            {
                xCommandText = Querys.CategoriaQuerys.GetCategoria;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@id", id);
                DataSet ds = ExecuteReader();


                BE.CategoriaBE categoria = ds.Tables[0].Rows.Count <= 0 ? null : Tools.CategoriaTools.FillObjectCategoria(ds.Tables[0].Rows[0]);

                return categoria;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }
        public List<CategoriaBE> GetCategorias()
        {

            try
            {
                xCommandText = Querys.CategoriaQuerys.GetCategorias;
                DataSet ds = ExecuteReader();

                List<BE.CategoriaBE> categorias = new List<BE.CategoriaBE>();
                if (ds.Tables[0].Rows.Count > 0)
                    categorias = Tools.CategoriaTools.FillListCategoria(ds);

                return categorias;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }
    }
}
