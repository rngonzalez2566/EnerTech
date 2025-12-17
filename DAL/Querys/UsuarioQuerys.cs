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
        public const string RegisterUser = "INSERT INTO USUARIO(Email, Password, RazonSocial, Identificacion, Contador, Estado, Nombre, Apellido, TipoDocumento, TipoCliente,DVH) " +
        "OUTPUT inserted.id_usuario VALUES (@email, @Password, @RazonSocial, @Identificacion,0,'Activo', @Nombre, @Apellido, @TipoDoc, @TipoCliente,@dvh)";
        public const string UnlockUser = "UPDATE Usuario SET Contador = 0, DVH = @dv WHERE id_usuario = @user ";
        public const string addBlock = "UPDATE Usuario SET Contador = Contador + 1, DVH = @dv WHERE id_usuario = @user ";
        public const string GetUser_id = "SELECT TOP 1 * FROM Usuario WHERE id_usuario = @user";
        public const string UpdatePasswordReset = @"
                                                    UPDATE Usuario
                                                    SET Password = @pass,
                                                        Contador = 0,
                                                        DVH = @dvh
                                                    WHERE id_usuario = @id
                                                    ";

        public static string UpdateUser = @"
                                            UPDATE Usuario
                                            SET
                                                Email = @Email,
                                                RazonSocial = @RazonSocial,
                                                Identificacion = @Identificacion,
                                                Nombre = @Nombre,
                                                Apellido = @Apellido,
                                                TipoDocumento = @TipoDoc,
                                                TipoCliente = @TipoCliente,
                                                Estado = @Estado,
                                                DVH = @dvh
                                            WHERE id_usuario = @id;
";
    }
}
