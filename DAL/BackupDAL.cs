using BE;
using BE.Composite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class BackupDAL : Acceso
    {
        public bool RealizarBackup(BackupBE backup)
        {
            bool backupRealizado = false;

            xCommandText = Querys.BackupQuerys.Realizar_Backup;
            xParameters.Parameters.Clear();
            xParameters.Parameters.AddWithValue("@RutaBackupParam", backup.RutaBackup);
            xParameters.Parameters.AddWithValue("@NombreBaseParam", backup.NombreBase);

            ExecuteNonQueryNonTransaction();
       

            backupRealizado = true;

            return backupRealizado;
        }

        public bool RealizarRestore(string nombreBase, string rutaBackup)
        {
            bool restoreRealizado = false;

            xCommandText = $"USE [master] " +
                                    $"ALTER DATABASE [{nombreBase}] SET OFFLINE WITH ROLLBACK IMMEDIATE  " +
                                    $"RESTORE DATABASE [{nombreBase}] FROM DISK = '{rutaBackup}' WITH REPLACE  " +
                                    $"ALTER DATABASE [{nombreBase}] SET ONLINE";

            ExecuteNonQueryNonTransaction();

            restoreRealizado = true;
            return restoreRealizado;
        }
    }
}
