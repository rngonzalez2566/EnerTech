﻿using BE;
using DAL;
using Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace BLL
{
    public class CarritoBLL
    {
        CarritoDAL carritoDAL = new CarritoDAL();
        BitacoraBLL bitacora = new BitacoraBLL();
        DigitoVerificadorDAL dv = new DigitoVerificadorDAL();
        DigitoVerificador sdv = new DigitoVerificador();


        public List<CarritoBE> GetCarrito(int user)
        {
            try
            {
                List<CarritoBE> carrito = carritoDAL.GetCarrito(user);

                return carrito;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }
        }

        public List<CarritoBE> GetCarritos()
        {
            try
            {
                List<CarritoBE> carrito = carritoDAL.GetCarritos();

                return carrito;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }
        }

        public int GetCantidadCarrito(int user)
        {
            try
            {
                int cantidad = carritoDAL.GetCantidadCarrito(user);

                return cantidad;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }
        }

        public CarritoBE GetCarritoUserProduct(int user, int prod)
        {

            try
            {

                return carritoDAL.GetCarritoUserProduct(user, prod);

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
                using (TransactionScope scope = new TransactionScope())
                {
                    int _id = carritoDAL.RegistrarCarrito(carrito);
                    //bitacora.RegistrarBitacora($"{usuario.Identificacion} - Se registro un nuevo usuario correctamente", "Media", usuario);
                    dv.RecalcularDigitosCarrito("Carrito",sdv);
                    scope.Complete();

                    return _id;
                }

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
                using (TransactionScope scope = new TransactionScope())
                {
                    carritoDAL.ActualizarCarrito(carrito);
                    //bitacora.RegistrarBitacora($"{usuario.Identificacion} - Se registro un nuevo usuario correctamente", "Media", usuario);
                    dv.RecalcularDigitosCarrito("Carrito", sdv);
                    scope.Complete();

                }

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
                using (TransactionScope scope = new TransactionScope())
                {
                    carritoDAL.BorrarCarrito(user);
                    //bitacora.RegistrarBitacora($"{usuario.Identificacion} - Se registro un nuevo usuario correctamente", "Media", usuario);
                    dv.RecalcularDigitosCarrito("Carrito", sdv);
                    scope.Complete();

                }

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
                using (TransactionScope scope = new TransactionScope())
                {
                    carritoDAL.BorrarCarritoProducto(user, prod);
                    //bitacora.RegistrarBitacora($"{usuario.Identificacion} - Se registro un nuevo usuario correctamente", "Media", usuario);
                    dv.RecalcularDigitosCarrito("Carrito", sdv);
                    scope.Complete();

                }

            }
            catch
            {
                throw new Exception(ErrorMessages.ERR001);
            }
        }
        public void setCarrito(CarritoBE carrito)
        {
            CarritoBE cart = GetCarritoUserProduct(carrito.usuario.id_usuario, carrito.producto.id_producto);

            if(cart != null)
            {
                ActualizarCarrito(carrito);
            }
            else
            {
                RegistrarCarrito(carrito);
            }
            dv.RecalcularDigitosCarrito("Carrito", sdv);
        }
    }
}
