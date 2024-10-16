using BE;
using DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class CategoriaBLL
    {

        CategoriaDAL categoriaDAL = new CategoriaDAL();
        public List<CategoriaBE> GetCategorias()
        {
            try
            {
                List<CategoriaBE> categorias = categoriaDAL.GetCategorias();

                return categorias;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }
        }
    }
}
