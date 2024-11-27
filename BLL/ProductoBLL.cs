using BE;
using DAL;
using Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace BLL
{
    public class ProductoBLL
    {
        ProductoDAL productoDAL = new ProductoDAL();
        BitacoraBLL bitacora = new BitacoraBLL();
        DigitoVerificadorDAL dv = new DigitoVerificadorDAL();
        Services.DigitoVerificador sdv = new Services.DigitoVerificador();
        public List<ProductoBE> GetProductos()
        {
            try
            {
                List<ProductoBE> productos = productoDAL.GetProductos();

                return productos;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }      
        }

        public List<ProductoBE> GetCatalogo()
        {
            try
            {
                List<ProductoBE> productos = productoDAL.GetCatalogo();

                return productos;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }
        }

        public ProductoBE GetProductoCodigo(string codigo)
        {
            try
            {
                ProductoBE producto = productoDAL.GetProductoCodigo(codigo);

                return producto;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }
        }

        public ProductoBE GetProductoID(int codigo)
        {
            try
            {
                ProductoBE producto = productoDAL.GetProductoID(codigo);

                return producto;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }
        }

        public int RegistrarProducto(ProductoBE producto)
        {
           
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    int _id = productoDAL.RegistrarProducto(producto);
                    //bitacora.RegistrarBitacora($"{usuario.Identificacion} - Se registro un nuevo usuario correctamente", "Media", usuario);
                    dv.RecalcularDigitosProducto("Producto", sdv);
                    scope.Complete();

                    return _id;
                }

            }
            catch
            {
                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public void EditarProducto(ProductoBE producto)
        {

            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    productoDAL.EditarProducto(producto);
                    //bitacora.RegistrarBitacora($"{usuario.Identificacion} - Se registro un nuevo usuario correctamente", "Media", usuario);
                    dv.RecalcularDigitosProducto("Producto", sdv);
                    scope.Complete();

                    
                }

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
                using (TransactionScope scope = new TransactionScope())
                {
                     productoDAL.PublicarCatalogo(productos);
                    //bitacora.RegistrarBitacora($"{usuario.Identificacion} - Se registro un nuevo usuario correctamente", "Media", usuario);
                    dv.RecalcularDigitosProducto("Producto", sdv);
                    scope.Complete();
                }

            }
            catch
            {
                throw new Exception(ErrorMessages.ERR001);
            }
        }
    }
}
