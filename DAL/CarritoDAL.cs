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
