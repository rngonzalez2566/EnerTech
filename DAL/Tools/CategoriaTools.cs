using BE;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Tools
{
    public class CategoriaTools
    {
        public static CategoriaBE FillObjectCategoria(DataRow dr)
        {
            CategoriaBE categoria = new CategoriaBE();


            if (dr.Table.Columns.Contains("Id") && !Convert.IsDBNull(dr["Id"]))
                categoria.Id = Convert.ToInt32(dr["Id"]);

            if (dr.Table.Columns.Contains("Nombre") && !Convert.IsDBNull(dr["Nombre"]))
                categoria.Nombre = Convert.ToString(dr["Nombre"]);


            return categoria;
        }

        public static List<CategoriaBE> FillListCategoria(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectCategoria(dr)).ToList();
        }
    }
}
