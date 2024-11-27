using BE;
using Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class DigitoVerificadorDAL : Acceso
    {
        UsuarioDAL user = new UsuarioDAL(); 
        BitacoraDAL bitacoraDAL = new BitacoraDAL();
        CarritoDAL cart = new CarritoDAL();
        VentaDAL ventaDAL = new VentaDAL();
        ProductoDAL prod = new ProductoDAL();
        MarcaDAL marca = new MarcaDAL();
        CategoriaDAL categoria = new CategoriaDAL();
        
       
        public int AltaDVV(string xTabla)
        {
            try
            {

                long dvv = existeDVV(xTabla);

                long dvh = CalcularDVH(xTabla);


                if (dvv == 0) xCommandText = Querys.DVQuerys.alta_DVV;
                else xCommandText = Querys.DVQuerys.actualizar_DVV;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@tabla", xTabla);
                xParameters.Parameters.AddWithValue("@dvv", dvh);

                return ExecuteNonEscalar();
            }
            catch
            {
                throw new Exception("Error en la base de datos.");
            }
        }

        public long CalcularDVH(string xTabla)
        {
            long xDVH = 0;

            xCommandText = String.Format(Querys.DVQuerys.get_DVH, xTabla);

            DataSet ds = new DataSet();
            ds = ExecuteReader();

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                xDVH = long.Parse(ds.Tables[0].Rows[0]["DVH"].ToString());
            }

            return xDVH;
        }

       
        public DataSet GetTablaDigitos()
        {
            try
            {
                xCommandText = Querys.DVQuerys.get_Tabla_Digitos;

                DataSet ds = new DataSet();
                ds = ExecuteReader(); // Método para obtener un DataSet en lugar de un DataTable
                return ds; 
            }
            catch
            {
                throw new Exception(ErrorMessages.ERR001);
            }
        }
        public void RecalcularDigitos()
        {
            Services.DigitoVerificador dv = new Services.DigitoVerificador();

            try
            {
                xCommandText = Querys.DVQuerys.get_Tabla_Digitos;

                DataSet ds = ExecuteReader(); // Método para obtener un DataSet en lugar de un DataTable

                if (ds.Tables[0].Rows.Count > 0) // Acceder a la primera tabla del DataSet
                {
                    foreach (DataRow fila in ds.Tables[0].Rows)
                    {
                        string tabla = fila[0].ToString();
                        switch (tabla)
                        {
                            case "Usuario":
                                RecalcularDigitosUsuario(tabla, dv);
                                break;

                            case "Bitacora":
                                RecalcularDigitosBitacora(tabla, dv);
                                break;
                            case "Carrito":
                                RecalcularDigitosCarrito(tabla, dv);
                                break;
                            case "Venta":
                                RecalcularDigitosVenta(tabla, dv);
                                break;
                            case "Producto":
                                RecalcularDigitosProducto(tabla, dv);
                                break;
                        }
                    }
                }
            }
            catch
            {
                throw new Exception("Error al recalcular digitos verificadores");
            }
        }

        public void RecalcularDigitosUsuario(string tabla, Services.DigitoVerificador dv)
        {
            xCommandText = String.Format(Querys.DVQuerys.get_Recalcula_Digitos, tabla);
            DataSet dsU = ExecuteReader();

            if (dsU.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow fila in dsU.Tables[0].Rows)
                {
                    int xid = int.Parse(fila[0].ToString());
                    UsuarioBE usuario = user.GetUsuarioID(xid);

                    usuario.DVH = dv.CalcularDV(usuario);

                    string xQuery = "update usuario set DVH = {0} where id_usuario = {1}";
                    xCommandText = String.Format(xQuery, usuario.DVH, usuario.id_usuario);
                    executeNonQuery();
                }
                AltaDVV("Usuario");
            }
        }

        public void RecalcularDigitosBitacora(string tabla, Services.DigitoVerificador dv)
        {
            xCommandText = String.Format(Querys.DVQuerys.get_Recalcula_Digitos, tabla);
            DataSet dsB = ExecuteReader();

            if (dsB.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow fila in dsB.Tables[0].Rows)
                {
                    int xid = int.Parse(fila[0].ToString());
                    BitacoraBE bit = bitacoraDAL.GetBitacoraID(xid);

                    bit.DVH = dv.CalcularDV(bit);

                    string xQuery = "update Bitacora set DVH = {0} where id_bitacora = {1}";
                    xCommandText = String.Format(xQuery, bit.DVH, bit.id_bitacora);
                    executeNonQuery();
                }
                AltaDVV("Bitacora");
            }
        }

        public void RecalcularDigitosCarrito(string tabla, Services.DigitoVerificador dv)
        {
            xCommandText = String.Format(Querys.DVQuerys.get_Recalcula_Digitos, tabla);
            DataSet dsB = ExecuteReader();

            if (dsB.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow fila in dsB.Tables[0].Rows)
                {
                    int xid = int.Parse(fila[0].ToString());
                    CarritoBE ca = cart.GetCarritoID(xid);

                    ca.DVH = dv.CalcularDV(ca);

                    string xQuery = "update carrito set DVH = {0} where id_carrito = {1}";
                    xCommandText = String.Format(xQuery, ca.DVH, ca.id_carrito);
                    executeNonQuery();
                }
                AltaDVV("Carrito");
            }
        }

        public void RecalcularDigitosVenta(string tabla, Services.DigitoVerificador dv)
        {
            xCommandText = String.Format(Querys.DVQuerys.get_Recalcula_Digitos, tabla);
            DataSet dsB = ExecuteReader();

            if (dsB.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow fila in dsB.Tables[0].Rows)
                {
                    int xid = int.Parse(fila[0].ToString());
                    VentaBE ca = ventaDAL.GetVenta(xid);

                    ca.DVH = dv.CalcularDV(ca);

                    string xQuery = "update venta set DVH = {0} where id_venta = {1}";
                    xCommandText = String.Format(xQuery, ca.DVH, ca.id_venta);
                    executeNonQuery();
                }
                AltaDVV("Venta");

            }
            RecalcularDigitosDetalleVenta("Detalle_Venta", dv);
            RecalcularDigitosRelatedTaxes("RelatedTaxes", dv);
        }

        public void RecalcularDigitosDetalleVenta(string tabla, Services.DigitoVerificador dv)
        {
            xCommandText = String.Format(Querys.DVQuerys.get_Recalcula_Digitos, tabla);
            DataSet dsB = ExecuteReader();

            if (dsB.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow fila in dsB.Tables[0].Rows)
                {
                    int xid = int.Parse(fila[0].ToString());
                    Detalle_VentaBE ca = ventaDAL.GetDetalleVentasID(xid);

                    ca.DVH = dv.CalcularDV(ca);

                    string xQuery = "update Detalle_Venta set DVH = {0} where id_detalle_venta = {1}";
                    xCommandText = String.Format(xQuery, ca.DVH, ca.id_detalle_venta);
                    executeNonQuery();
                }
                AltaDVV("Detalle_Venta");
            }
        }

        public void RecalcularDigitosRelatedTaxes(string tabla, Services.DigitoVerificador dv)
        {
            xCommandText = String.Format(Querys.DVQuerys.get_Recalcula_Digitos, tabla);
            DataSet dsB = ExecuteReader();

            if (dsB.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow fila in dsB.Tables[0].Rows)
                {
                    int xid = int.Parse(fila[0].ToString());
                    RelatedTaxesBE ca = ventaDAL.GetTaxesID(xid);

                    ca.DVH = dv.CalcularDV(ca);

                    string xQuery = "update RelatedTaxes set DVH = {0} where id_relatedTaxes = {1}";
                    xCommandText = String.Format(xQuery, ca.DVH, ca.id_relatedtaxes);
                    executeNonQuery();
                }
                AltaDVV("RelatedTaxes");
            }
        }

        public void RecalcularDigitosProducto(string tabla, Services.DigitoVerificador dv)
        {
            xCommandText = String.Format(Querys.DVQuerys.get_Recalcula_Digitos, tabla);
            DataSet dsB = ExecuteReader();

            if (dsB.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow fila in dsB.Tables[0].Rows)
                {
                    int xid = int.Parse(fila[0].ToString());
                    ProductoBE ca = prod.GetProductoID(xid);

                    ca.DVH = dv.CalcularDV(ca);

                    string xQuery = "update PRODUCTO set DVH = {0} where id_producto = {1}";
                    xCommandText = String.Format(xQuery, ca.DVH, ca.id_producto);
                    executeNonQuery();
                }
                AltaDVV("Producto");
            }
            RecalcularDigitosMarca("Marca", dv);
            RecalcularDigitosCategoria("Categoria", dv);
        }

        public void RecalcularDigitosMarca(string tabla, Services.DigitoVerificador dv)
        {
            xCommandText = String.Format(Querys.DVQuerys.get_Recalcula_Digitos, tabla);
            DataSet dsB = ExecuteReader();

            if (dsB.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow fila in dsB.Tables[0].Rows)
                {
                    int xid = int.Parse(fila[0].ToString());
                    MarcaBE ca = marca.GetMarcaID(xid);

                    ca.DVH = dv.CalcularDV(ca);

                    string xQuery = "update Marca set DVH = {0} where id_marca = {1}";
                    xCommandText = String.Format(xQuery, ca.DVH, ca.id_marca);
                    executeNonQuery();
                }
                AltaDVV("Marca");
            }
          
        }

        public void RecalcularDigitosCategoria(string tabla, Services.DigitoVerificador dv)
        {
            xCommandText = String.Format(Querys.DVQuerys.get_Recalcula_Digitos, tabla);
            DataSet dsB = ExecuteReader();

            if (dsB.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow fila in dsB.Tables[0].Rows)
                {
                    int xid = int.Parse(fila[0].ToString());
                    CategoriaBE ca = categoria.GetCategoriaID(xid);

                    ca.DVH = dv.CalcularDV(ca);

                    string xQuery = "update Categoria set DVH = {0} where id_categoria = {1}";
                    xCommandText = String.Format(xQuery, ca.DVH, ca.id_categoria);
                    executeNonQuery();
                }
                AltaDVV("Categoria");
            }
        }
        public long existeDVV(string xTabla)
        {
            long xDVV = 0;

            xCommandText = Querys.DVQuerys.exist_DVV;
            xParameters.Parameters.Clear();
            xParameters.Parameters.AddWithValue("@tabla", xTabla);

            DataSet ds = new DataSet();
            ds = ExecuteReader();

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                xDVV = long.Parse(ds.Tables[0].Rows[0]["DVV"].ToString());
            }

            return xDVV;
        }

        public List<String> VerificarDV()
        {
            UsuarioBE usuario = new UsuarioBE();
            usuario.id_usuario = 1;
            usuario.Nombre = "Sistema";
            var lista = new List<String>();


            string xConsulta = "SELECT D.nombre_tabla TABLA, D.valorDVV DV FROM DigitoVerificador D";
            xCommandText = xConsulta;
            DataSet tb = new DataSet();
            tb = ExecuteReader();

            foreach (DataRow fila in tb.Tables[0].Rows)
            {
                long xDV = long.Parse(fila[1].ToString());
                string xTabla = fila[0].ToString();



                string xConsulta1 = "SELECT ISNULL(SUM(DVH),0) DVH FROM {0}";
                xCommandText = String.Format(xConsulta1, xTabla);
                DataSet tb1 = new DataSet();
                tb1 = ExecuteReader();

                long xValor = long.Parse(tb1.Tables[0].Rows[0]["DVH"].ToString());

                if (xValor != xDV)
                {

                    lista.Add("Error en la validacion de la suma de digitos horizontales con el Digito Vertical de la tabla: " + xTabla);
                }

            }
            return lista;
        }
    }
}
