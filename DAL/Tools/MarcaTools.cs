using BE;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Tools
{
    public class MarcaTools
    {
        public static MarcaBE FillObjectMarca(DataRow dr)
        {
            MarcaBE marca = new MarcaBE();


            if (dr.Table.Columns.Contains("Id") && !Convert.IsDBNull(dr["Id"]))
                marca.Id = Convert.ToInt32(dr["Id"]);

            if (dr.Table.Columns.Contains("Nombre") && !Convert.IsDBNull(dr["Nombre"]))
                marca.Nombre = Convert.ToString(dr["Nombre"]);


            return marca;
        }

        public static List<MarcaBE> FillListMarca(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectMarca(dr)).ToList();
        }
    }
}

