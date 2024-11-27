using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Querys
{
    public class DVQuerys
    {
        public const string alta_DVV = "INSERT INTO DigitoVerificador (nombre_tabla, valorDVV) " +
                                         " OUTPUT inserted.id_DV VALUES (@tabla, @dvv) ";
        public const string get_DVH = "SELECT ISNULL(SUM(DVH),0) DVH FROM {0}";
        public const string exist_DVV = "SELECT COUNT(*) DVV FROM digitoVerificador where nombre_tabla = @tabla";
        public const string actualizar_DVV = "update DigitoVerificador set valorDVV = @dvv OUTPUT inserted.id_DV where nombre_tabla = @tabla";
        public const string get_Tabla_Digitos = "select nombre_tabla from DigitoVerificador";
        public const string get_Recalcula_Digitos = "select * from {0}";

    }
}
