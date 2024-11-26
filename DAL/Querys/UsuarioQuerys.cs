using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Querys
{
    public class UsuarioQuerys
    {
        public const string GetUser = "SELECT TOP 1 * FROM Usuario WHERE email = @user";
        public const string GetUsers = "SELECT * FROM Usuario";
        public const string BlockUser = "UPDATE Usuario SET Contador = 3 WHERE id_usuario = @user ";
        public const string RegisterUser = "INSERT INTO USUARIO(Email, Password, RazonSocial, Identificacion, Contador, Estado, Nombre, Apellido, TipoDocumento, TipoCliente) " +
        "OUTPUT inserted.id_usuario VALUES (@email, @Password, @RazonSocial, @Identificacion,0,'Activo', @Nombre, @Apellido, @TipoDoc, @TipoCliente)";
        public const string UnlockUser = "UPDATE Usuario SET Contador = 0 WHERE id_usuario = @user ";
        public const string addBlock = "UPDATE Usuario SET Contador = Contador + 1 WHERE id_usuario = @user ";
        public const string GetUser_id = "SELECT TOP 1 * FROM Usuario WHERE id_usuario = @user";
    }
}
