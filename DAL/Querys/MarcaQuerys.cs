using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Querys
{
    public class MarcaQuerys
    {
        public const string GetMarca = "SELECT  * FROM Marca where id_marca = @id";
        public const string GetMarcas = "SELECT  * FROM Marca";
    }
}
