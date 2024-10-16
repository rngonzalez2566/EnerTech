using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Querys
{
    public class CategoriaQuerys
    {
        public const string GetCategoria = "SELECT  * FROM Categoria where id = @id";
        public const string GetCategorias = "SELECT  * FROM Categoria";
    }
}
