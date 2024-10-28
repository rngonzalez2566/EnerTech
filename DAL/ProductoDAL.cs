using BE;
using Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace DAL
{
    public class ProductoDAL: Acceso
    {
        public ProductoBE GetProductoCodigo(string codigo)
        {

            try
            {
                xCommandText = Querys.ProductoQuerys.GetProduct_code;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@code", codigo);
                DataSet ds = ExecuteReader();


                BE.ProductoBE Producto = ds.Tables[0].Rows.Count <= 0 ? null : Tools.ProductoTools.FillObjectProducto(ds.Tables[0].Rows[0]);

                return Producto;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public ProductoBE GetProductoID(int id)
        {

            try
            {
                xCommandText = Querys.ProductoQuerys.GetProduct_ID;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@id", id);
                DataSet ds = ExecuteReader();


                BE.ProductoBE Producto = ds.Tables[0].Rows.Count <= 0 ? null : Tools.ProductoTools.FillObjectProducto(ds.Tables[0].Rows[0]);

                return Producto;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public List<ProductoBE> GetProductos()
        {

            try
            {
                xCommandText = Querys.ProductoQuerys.GetProducts;
                DataSet ds = ExecuteReader();

                List<BE.ProductoBE> productos = new List<BE.ProductoBE>();
                if (ds.Tables[0].Rows.Count > 0)
                    productos = Tools.ProductoTools.FillListProducto(ds);

                return productos;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public List<ProductoBE> GetCatalogo()
        {

            try
            {
                xCommandText = Querys.ProductoQuerys.GetCatalogo;
                DataSet ds = ExecuteReader();

                List<BE.ProductoBE> productos = new List<BE.ProductoBE>();
                if (ds.Tables[0].Rows.Count > 0)
                    productos = Tools.ProductoTools.FillListProducto(ds);

                return productos;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public int RegistrarProducto(ProductoBE producto)
        {
            try
            {
                xCommandText = Querys.ProductoQuerys.addProduct;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@codigo", producto.Codigo);
                xParameters.Parameters.AddWithValue("@descripcion", producto.Descripcion);
                xParameters.Parameters.AddWithValue("@marca", producto.Marca.Id);
                xParameters.Parameters.AddWithValue("@categoria", producto.Categoria.Id);
                xParameters.Parameters.AddWithValue("@imagen", producto.Imagen);
                xParameters.Parameters.AddWithValue("@catalogo", false);
                xParameters.Parameters.AddWithValue("@cantidad", producto.Cantidad);
                xParameters.Parameters.AddWithValue("@iva", producto.codigoIVA.Codigo);




                return ExecuteNonEscalar();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public void PublicarCatalogo(List<ProductoBE> productos)
        {
            try
                
            {
                foreach (ProductoBE producto in productos)
                {
                    int catalogoValue = producto.Catalogo ? 1 : 0;
                    xCommandText = Querys.ProductoQuerys.Publicar_Catalogo;

                    xParameters.Parameters.Clear();
                    xParameters.Parameters.AddWithValue("@code", producto.Codigo);
                    xParameters.Parameters.AddWithValue("@catalogo", catalogoValue);

                    executeNonQuery();
                }

            }
        
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }


    }
}
