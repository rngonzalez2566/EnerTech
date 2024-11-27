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


            if (dr.Table.Columns.Contains("id_marca") && !Convert.IsDBNull(dr["id_marca"]))
                marca.id_marca = Convert.ToInt32(dr["id_marca"]);

            if (dr.Table.Columns.Contains("Nombre") && !Convert.IsDBNull(dr["Nombre"]))
                marca.Nombre = Convert.ToString(dr["Nombre"]);

            if (dr.Table.Columns.Contains("DVH") && !Convert.IsDBNull(dr["DVH"]))
                marca.DVH = Convert.ToInt32(dr["DVH"]);

            return marca;
        }

        public static List<MarcaBE> FillListMarca(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectMarca(dr)).ToList();
        }
    }
}

