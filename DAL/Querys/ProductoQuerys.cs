using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Querys
{
    public class ProductoQuerys
    {
        public const string GetProducts = "SELECT  * FROM Producto";
        public const string GetProduct_code = "SELECT  * FROM Producto where codigo =@code";
        public const string addProduct = "INSERT INTO Producto(Codigo,Descripcion,id_marca,id_categoria,Imagen,Catalogo,Cantidad) " +
                                            "OUTPUT inserted.Id VALUES (@codigo, @descripcion,@marca,@categoria,@imagen,@catalogo,@cantidad)";
        public const string Publicar_Catalogo = "UPDATE Producto SET Catalogo = @catalogo WHERE codigo = @code ";
    }
}
