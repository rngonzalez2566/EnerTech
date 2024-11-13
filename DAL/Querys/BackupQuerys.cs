using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Querys
{
    public class BackupQuerys
    {

        public const string Realizar_Backup = @"DECLARE @rutaCompleta NVARCHAR(255) = @RutaBackupParam;
                                                DECLARE @nombreBase NVARCHAR(255) = @NombreBaseParam;
                                                DECLARE @backupQuery NVARCHAR(MAX) = 'BACKUP DATABASE [' + @nombreBase + '] TO DISK = ''' + @rutaCompleta + ''' WITH FORMAT, MEDIANAME = ''SQLServerBackups'', NAME = ''Full Backup of ' + @nombreBase + '''';
                                                EXEC(@backupQuery);";
      
    }
}
