﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Querys
{
    public class CarritoQuerys
    {
        public const string GetCarrito_User = "SELECT  * FROM Carrito where id_usuario = @user";
        public const string GetCarrito_User_Product = "SELECT  * FROM Carrito where id_usuario = @user and id_producto = @prod";
        public const string add_Carrito = "INSERT INTO CARRITO(id_producto, id_usuario, cantidad) OUTPUT inserted.Id VALUES(@prod,@user,@cantidad)";
        public const string update_Carrito = "UPDATE CARRITO SET CANTIDAD = @cantidad where id_usuario = @user and id_producto = @prod";
        public const string delete_Carrito = "DELETE FROM CARRITO where id_usuario = @user";
        public const string delete_Product_Carrito = "DELETE FROM CARRITO where id_usuario = @user and id_producto = @prod";
    }
}