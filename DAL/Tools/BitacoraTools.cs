using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using System.Data;

namespace DAL.Tools
{
    public class BitacoraTools
    {

        public static BitacoraBE FillObjectBitacora(DataRow dr)
        {
            BitacoraBE Bitacora = new BitacoraBE();
            Bitacora.usuario = new UsuarioBE();

            if (dr.Table.Columns.Contains("Id") && !Convert.IsDBNull(dr["Id"]))
                Bitacora.Id = Convert.ToInt32(dr["Id"]);

            if (dr.Table.Columns.Contains("Criticidad") && !Convert.IsDBNull(dr["Criticidad"]))
                Bitacora.Criticidad = Convert.ToString(dr["Criticidad"]);

            if (dr.Table.Columns.Contains("Detalle") && !Convert.IsDBNull(dr["Detalle"]))
                Bitacora.Detalle = Convert.ToString(dr["Detalle"]);

            if (dr.Table.Columns.Contains("Fecha") && !Convert.IsDBNull(dr["Fecha"]))
                Bitacora.Fecha = Convert.ToDateTime(dr["Fecha"]);

            if (dr.Table.Columns.Contains("id_usuario") && !Convert.IsDBNull(dr["id_usuario"]))
                Bitacora.usuario.Id = Convert.ToInt32(dr["id_usuario"]);



            return Bitacora;
        }

        public static List<BitacoraBE> FillListBitacora(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectBitacora(dr)).ToList();
        }
    }
}
