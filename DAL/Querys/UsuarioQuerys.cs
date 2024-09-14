using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Querys
{
    public class UsuarioQuerys
    {
        public const string GetUser = "SELECT TOP 1 * FROM Usuario WHERE usuario = @user";
        public const string GetUsers = "SELECT * FROM Usuario";
        public const string BlockUser = "UPDATE Usuario SET Contador = 3 WHERE Id =@user ";
        public const string RegisterUser = "INSERT INTO USUARIO(Email, Password, RazonSocial, Identificacion, Contador, Estado, Nombre, Apellido, TipoDocumento, TipoCliente) " +
        "OUTPUT inserted.Id VALUES (@email, @Password, @RazonSocial, @Identificacion,0,'Activo', @Nombre, @Apellido, @TipoDoc, @TipoCliente)";
    }
}
