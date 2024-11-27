using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using BE;
using System.Data;
using System.Web.UI.WebControls;

namespace BLL
{
    public class DigitoVerificadorBLL
    {
        DigitoVerificadorDAL dv = new DigitoVerificadorDAL();
        UsuarioBLL user = new UsuarioBLL();
        BitacoraBLL bit = new BitacoraBLL();
        CarritoBLL CarritoBLL = new CarritoBLL();
        VentaBLL ventaBLL = new VentaBLL();
        ProductoBLL productoBLL = new ProductoBLL();
        MarcaBLL marcaBLL = new MarcaBLL();
        CategoriaBLL categoriaBLL = new CategoriaBLL();
        
        public void RecalcularDigitos()
        {

            dv.RecalcularDigitos();
        }

        public bool VerificarDV()
        {
            try
            {
                UsuarioBE usuario = new UsuarioBE();
                usuario.id_usuario = 1;
                usuario.Nombre = "Sistema";
                bool xValido = true;


                var lista = new List<String>();
                lista = dv.VerificarDV();

                foreach (var registro in lista)
                {
                    bit.RegistrarBitacora(registro.ToString(), "ALTA", usuario);
                    dv.AltaDVV("Bitacora");
                    xValido = false;
                }

                DataSet ds = dv.GetTablaDigitos();
                if (ds.Tables[0].Rows.Count > 0) // Acceder a la primera tabla del DataSet
                {
                    foreach (DataRow fila in ds.Tables[0].Rows)
                    {
                        string tabla;
                        tabla = fila[0].ToString();
                        if (!ValidarDVH(tabla))
                        {
                            xValido = false;
                        }
                    }
                }


                return xValido;
            }
            catch
            {
                return false;
            }

        }

        public bool ValidarDVH(string xTabla)
        {
            UsuarioBE us = new UsuarioBE();
            us.id_usuario = 1;
            us.Nombre = "Sistema";

            bool xValido = true;
            switch (xTabla)
            {
                case "Usuario":
                    {
                        List<UsuarioBE> usuarios = user.GetUsuarios();
                        Services.DigitoVerificador dvs = new Services.DigitoVerificador();

                        foreach (var usuario in usuarios)
                        {
                            int dvhCalculado = dvs.CalcularDV(usuario);

                            if (usuario.DVH != dvhCalculado)
                            {
                                bit.RegistrarBitacora($"El registro con id = {usuario.id_usuario} de la tabla usuario no es válido su DVH", "ALTA", us);
                                dv.AltaDVV("Usuario");
                                xValido = false;
                            }
                        }
                        break;
                    }

                case "Bitacora":
                    {
                        List<BitacoraBE> bitacoras = bit.GetBitacora();
                        Services.DigitoVerificador dvs = new Services.DigitoVerificador();

                        foreach (var bitacora in bitacoras)
                        {
                            int dvhCalculado = dvs.CalcularDV(bitacora);

                            if (bitacora.DVH != dvhCalculado)
                            {
                                bit.RegistrarBitacora($"El registro con id = {bitacora.id_bitacora} de la tabla bitacora no es válido su DVH", "ALTA", us);
                                xValido = false;
                            }
                        }
                        break;
                    }

                case "Carrito":
                    {
                        List<CarritoBE> carts = CarritoBLL.GetCarritos();
                        Services.DigitoVerificador dvs = new Services.DigitoVerificador();

                        foreach (var cart in carts)
                        {
                            int dvhCalculado = dvs.CalcularDV(cart);

                            if (cart.DVH != dvhCalculado)
                            {
                                bit.RegistrarBitacora($"El registro con id = {cart.id_carrito} de la tabla Carrito no es válido su DVH", "ALTA", us);
                                xValido = false;
                            }
                        }
                        break;
                    }
                case "Venta":
                    {
                        List<VentaBE> carts = ventaBLL.GetVentas();
                        Services.DigitoVerificador dvs = new Services.DigitoVerificador();

                        foreach (var cart in carts)
                        {
                            int dvhCalculado = dvs.CalcularDV(cart);

                            if (cart.DVH != dvhCalculado)
                            {
                                bit.RegistrarBitacora($"El registro con id = {cart.id_venta} de la tabla Venta no es válido su DVH", "ALTA", us);
                                xValido = false;
                            }
                        }
                        break;
                    }
                case "Detalle_Venta":
                    {
                        List<Detalle_VentaBE> carts = ventaBLL.GetDetalleVentas();
                        Services.DigitoVerificador dvs = new Services.DigitoVerificador();

                        foreach (var cart in carts)
                        {
                            int dvhCalculado = dvs.CalcularDV(cart);

                            if (cart.DVH != dvhCalculado)
                            {
                                bit.RegistrarBitacora($"El registro con id = {cart.id_detalle_venta} de la tabla Detalle Venta no es válido su DVH", "ALTA", us);
                                xValido = false;
                            }
                        }
                        break;
                    }
                case "RelatedTaxes":
                    {
                        List<RelatedTaxesBE> carts = ventaBLL.GetTaxes();
                        Services.DigitoVerificador dvs = new Services.DigitoVerificador();

                        foreach (var cart in carts)
                        {
                            int dvhCalculado = dvs.CalcularDV(cart);

                            if (cart.DVH != dvhCalculado)
                            {
                                bit.RegistrarBitacora($"El registro con id = {cart.id_relatedtaxes} de la tabla Taxes no es válido su DVH", "ALTA", us);
                                xValido = false;
                            }
                        }
                        break;
                    }
                case "Producto":
                    {
                        List<ProductoBE> carts = productoBLL.GetProductos();
                        Services.DigitoVerificador dvs = new Services.DigitoVerificador();

                        foreach (var cart in carts)
                        {
                            int dvhCalculado = dvs.CalcularDV(cart);

                            if (cart.DVH != dvhCalculado)
                            {
                                bit.RegistrarBitacora($"El registro con id = {cart.id_producto} de la tabla Producto no es válido su DVH", "ALTA", us);
                                xValido = false;
                            }
                        }
                        break;
                    }
                case "Marca":
                    {
                        List<MarcaBE> carts = marcaBLL.GetMarcas();
                        Services.DigitoVerificador dvs = new Services.DigitoVerificador();

                        foreach (var cart in carts)
                        {
                            int dvhCalculado = dvs.CalcularDV(cart);

                            if (cart.DVH != dvhCalculado)
                            {
                                bit.RegistrarBitacora($"El registro con id = {cart.id_marca} de la tabla Marcas no es válido su DVH", "ALTA", us);
                                xValido = false;
                            }
                        }
                        break;
                    }
                case "Categoria":
                    {
                        List<CategoriaBE> carts = categoriaBLL.GetCategorias();
                        Services.DigitoVerificador dvs = new Services.DigitoVerificador();

                        foreach (var cart in carts)
                        {
                            int dvhCalculado = dvs.CalcularDV(cart);

                            if (cart.DVH != dvhCalculado)
                            {
                                bit.RegistrarBitacora($"El registro con id = {cart.id_categoria} de la tabla Categoria no es válido su DVH", "ALTA", us);
                                xValido = false;
                            }
                        }
                        break;
                    }
            }
            return xValido;
        }


    }
}
