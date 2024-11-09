using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.AFIP.Querys
{
    public class AfipQuerys
    {
        public const string getToken = "SELECT TOP 1 * FROM tokenAFIP ORDER BY FechaExpiracion DESC";
        public const string addToken = "INSERT INTO tokenAFIP (codigo,sign,token,FechaExpiracion,FechaGeneracion) VALUES (@cod,@sign,@token,@fe,@fg)";
    }
}
