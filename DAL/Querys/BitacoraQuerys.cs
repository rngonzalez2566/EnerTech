using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Querys
{
    public class BitacoraQuerys
    {
        public const string GetBitacora = "SELECT  * FROM Bitacora order by Fecha desc";
        public const string RegisterBitacora = "insert into Bitacora (id_usuario, Criticidad, Detalle, Fecha) OUTPUT inserted.id_bitacora values (@user,@crit,@Det,@Fecha)";
    }
}
