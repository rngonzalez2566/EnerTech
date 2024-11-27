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
        public const string RegisterBitacora = "insert into Bitacora (id_usuario, Criticidad, Detalle, Fecha,dvh) OUTPUT inserted.id_bitacora values (@user,@crit,@Det,@Fecha,@dv)";
        public const string GetBitacora_id = "SELECT TOP 1 * FROM Bitacora WHERE id_bitacora = @bit";
    }
}
