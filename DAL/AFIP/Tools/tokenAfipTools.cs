using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE.AFIP;

namespace DAL.AFIP.Tools
{
    public class tokenAfipTools
    {
        public static tokenAFIP FillObjectToken(DataRow dr)
        {
            tokenAFIP token = new tokenAFIP();


            if (dr.Table.Columns.Contains("codigo") && !Convert.IsDBNull(dr["codigo"]))
                token.codigo = Convert.ToUInt32(dr["codigo"]);

            if (dr.Table.Columns.Contains("token") && !Convert.IsDBNull(dr["token"]))
                token.token = Convert.ToString(dr["token"]);

            if (dr.Table.Columns.Contains("sign") && !Convert.IsDBNull(dr["sign"]))
                token.sign = Convert.ToString(dr["sign"]);

            if (dr.Table.Columns.Contains("FechaGeneracion") && !Convert.IsDBNull(dr["FechaGeneracion"]))
                token.FechaGeneracion = Convert.ToDateTime(dr["FechaGeneracion"]);

            if (dr.Table.Columns.Contains("FechaExpiracion") && !Convert.IsDBNull(dr["FechaExpiracion"]))
                token.FechaExpiracion = Convert.ToDateTime(dr["FechaExpiracion"]);

            return token;
        }

       
    }
}
