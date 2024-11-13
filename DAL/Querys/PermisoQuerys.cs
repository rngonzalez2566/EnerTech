using BE.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Querys
{
    public class PermisoQuerys
    {
        public const string Guardar_Componente = "INSERT INTO Permiso (Nombre, Permiso) OUTPUT inserted.Id_Permiso VALUES (@Nombre, @Permiso)";
        public const string Borrar_Familia = "DELETE FROM FamiliaPatente WHERE Id_Padre = @PadreId";
        public const string Guardar_FamiliaPatente = "INSERT INTO FamiliaPatente (Id_Padre, Id_Hijo) VALUES (@PadreId, @HijoId)";
        public const string Guardar_Familia = "UPDATE Permiso SET Nombre = @NombreFamilia WHERE Id_Permiso = @FamiliaId";
        public const string Get_Familias = "SELECT Id_Permiso, Nombre, Permiso FROM Permiso WHERE Permiso IS NULL";
        public const string Get_Patentes = "SELECT Id_Permiso, Nombre, Permiso FROM Permiso WHERE Permiso IS NOT NULL";
        public const string Get_Familia_Patente = @"WITH RECURSIVO AS (
    SELECT fp.Id_Padre, fp.Id_Hijo 
    FROM FamiliaPatente fp 
    WHERE fp.Id_Padre = @familia   
    UNION ALL
    SELECT fp2.Id_Padre, fp2.Id_Hijo 
    FROM FamiliaPatente fp2 
    INNER JOIN RECURSIVO r ON r.Id_Hijo = fp2.Id_Padre
)
SELECT r.Id_Padre, r.Id_Hijo, p.Id_Permiso, p.Nombre, p.Permiso 
FROM RECURSIVO r 
INNER JOIN Permiso p ON r.Id_Hijo = p.Id_Permiso
GROUP BY r.Id_Padre, r.Id_Hijo, p.Id_Permiso, p.Nombre, p.Permiso;";

        public const string Get_Usuario_Permiso = "SELECT p.* FROM UsuarioPermiso up INNER JOIN Permiso p on p.Id_Permiso = up.Id_Patente WHERE Id_usuario = @user";
        public const string Borrar_Permiso_Usuario = "DELETE FROM UsuarioPermiso WHERE id_usuario = @user";
        public const string Guardar_Permiso_Usuario = "INSERT INTO UsuarioPermiso (id_usuario, Id_Patente, DVH) VALUES (@user, @PatenteId, @DVH)";

        public const string Get_validacion_familia = @"SELECT p.Id_Permiso, p.Nombre 
FROM FamiliaPatente fm 
INNER JOIN Permiso p ON p.Id_Permiso = fm.Id_Padre
INNER JOIN Permiso p2 ON p2.Id_Permiso = fm.Id_Hijo 
WHERE fm.Id_Hijo = @hijo";

        public const string Get_Patentes_Familia = "SELECT Id_Permiso, Nombre, Permiso, Id_Padre, Id_Hijo FROM Permiso p INNER JOIN FamiliaPatente fm on fm.Id_Hijo = p.Id_Permiso WHERE Id_Padre = @idPadre ORDER BY Permiso DESC";
        public const string Get_Usuarios_Permisos = "SELECT Id_Usuario_Permiso, id_usuario, Id_Patente, DVH FROM UsuarioPermiso";
        public const string Get_Permisos_Usuarios = "SELECT Id_Permiso, Nombre, Permiso FROM Permiso p INNER JOIN UsuarioPermiso up on up.Id_Patente = p.Id_Permiso WHERE up.id_usuario = @user ORDER BY Permiso DESC";
        public const string Get_All_Permiso = "SELECT Id_Permiso, Nombre, Permiso, DVH FROM Permiso";
        public const string Get_All_Familia = "SELECT Id_Padre, Id_Hijo, DVHFROM FamiliaPatente";

    }
}
