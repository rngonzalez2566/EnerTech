using BE;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Tools
{
    public class CarritoTools
    {
        public static CarritoBE FillObjectCarrito(DataRow dr)
        {
            CarritoBE carrito = new CarritoBE();
            ProductoDAL producto = new ProductoDAL();
            UsuarioDAL usuario = new UsuarioDAL();
        
            carrito.usuario = new UsuarioBE();
            carrito.producto = new ProductoBE();


            if (dr.Table.Columns.Contains("id_carrito") && !Convert.IsDBNull(dr["id_carrito"]))
                carrito.id_carrito = Convert.ToInt32(dr["id_carrito"]);

            if (dr.Table.Columns.Contains("DVH") && !Convert.IsDBNull(dr["DVH"]))
                carrito.DVH = Convert.ToInt32(dr["DVH"]);

            if (dr.Table.Columns.Contains("Cantidad") && !Convert.IsDBNull(dr["Cantidad"]))
                carrito.Cantidad = Convert.ToInt32(dr["Cantidad"]);

            if (dr.Table.Columns.Contains("id_usuario") && !Convert.IsDBNull(dr["id_usuario"]))
                carrito.usuario = usuario.GetUsuarioID(Convert.ToInt32(dr["id_usuario"]));

            if (dr.Table.Columns.Contains("id_producto") && !Convert.IsDBNull(dr["id_producto"]))
                carrito.producto = producto.GetProductoID(Convert.ToInt32(dr["id_producto"]));

            return carrito;
        }

        public static List<CarritoBE> FillListCarrito(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectCarrito(dr)).ToList();
        }
    }
}
