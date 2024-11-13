using BE;
using Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class CarritoDAL : Acceso
    {
        public List<CarritoBE> GetCarrito(int user)
        {

            try
            {
                xCommandText = Querys.CarritoQuerys.GetCarrito_User;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", user);
                DataSet ds = ExecuteReader();

                List<BE.CarritoBE> carrito = new List<BE.CarritoBE>();
                if (ds.Tables[0].Rows.Count > 0)
                    carrito = Tools.CarritoTools.FillListCarrito(ds);

                return carrito;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public int GetCantidadCarrito(int user)
        {
            try
            {
                xCommandText = Querys.CarritoQuerys.GetCantidad_Carrito;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", user);

                // Ejecutar el comando y obtener el DataSet
                DataSet ds = ExecuteReader();

                // Verificar si el DataSet tiene datos
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    // Extraer el valor de la primera fila y primera columna
                    int cantidad = Convert.ToInt32(ds.Tables[0].Rows[0][0]);
                    return cantidad;
                }

                // Si no hay datos, retornar 0
                return 0;
            }
            catch
            {
                throw new Exception(ErrorMessages.ERR001);
            }
        }


        public CarritoBE GetCarritoUserProduct(int user, int prod)
        {

            try
            {
                xCommandText = Querys.CarritoQuerys.GetCarrito_User_Product;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", user);
                xParameters.Parameters.AddWithValue("@prod", prod);
                DataSet ds = ExecuteReader();

                BE.CarritoBE carrito = ds.Tables[0].Rows.Count <= 0 ? null : Tools.CarritoTools.FillObjectCarrito(ds.Tables[0].Rows[0]);

                return carrito;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }
        public int RegistrarCarrito(CarritoBE carrito)
        {
            try
            {
                xCommandText = Querys.CarritoQuerys.add_Carrito;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", carrito.usuario.Id);
                xParameters.Parameters.AddWithValue("@cantidad", carrito.Cantidad);
                xParameters.Parameters.AddWithValue("@prod", carrito.producto.Id);

                return ExecuteNonEscalar();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public void ActualizarCarrito(CarritoBE carrito)
        {
            try
            {
                xCommandText = Querys.CarritoQuerys.update_Carrito;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", carrito.usuario.Id);
                xParameters.Parameters.AddWithValue("@cantidad", carrito.Cantidad);
                xParameters.Parameters.AddWithValue("@prod", carrito.producto.Id);

                executeNonQuery();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public void BorrarCarrito(int user)
        {
            try

            {
               
                    xCommandText = Querys.CarritoQuerys.delete_Carrito;

                    xParameters.Parameters.Clear();
                    xParameters.Parameters.AddWithValue("@user", user);
          
                    executeNonQuery();
 
            }

            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public void BorrarCarritoProducto(int user, int prod)
        {
            try

            {

                xCommandText = Querys.CarritoQuerys.delete_Product_Carrito;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", user);
                xParameters.Parameters.AddWithValue("@prod", prod);
                executeNonQuery();

            }

            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }
    }
}
