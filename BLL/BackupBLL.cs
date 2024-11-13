using BE;
using DAL;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class BackupBLL
    {
        SessionManager _sessionManager = new SessionManager();
        BackupDAL _backupService = new BackupDAL();
        public void RealizarBackup(string rutaBackup)
        {
            string nombreBase = "EnerTech";
            DateTime fecha = DateTime.Now;
            string nombreBackup = $"{nombreBase}_{fecha.ToString("dd-MM-yyyy-HH-mm-ss")}";
            var clienteLogueado = _sessionManager.Get<UsuarioBE>("Usuario");

            if (!Directory.Exists(rutaBackup))
            {
                Directory.CreateDirectory(rutaBackup);
            }

            string rutaCompletaBackup = Path.Combine(rutaBackup, $"{nombreBackup}.bak");

            var backup = new BackupBE()
            {
                NombreBase = nombreBase,
                RutaBackup = rutaCompletaBackup,
                Nombre = nombreBackup,
                Fecha = fecha,
                RealizadoPor = clienteLogueado
            };

            bool backupRealizado = _backupService.RealizarBackup(backup);

            if (backupRealizado)
            {
                //_bitacoraService.AltaBitacora($"{clienteLogueado.RazonSocial} ({clienteLogueado.Id}) realizó backup de la base de datos", Criticidad.Media, clienteLogueado);
            }
            else
                throw new Exception("Hubo un error en generar el backup en la ruta.");
        }

        public void RealizarRestore(string rutaBackup)
        {
            string nombreBase = "EnerTech";
            var clienteLogueado = _sessionManager.Get<UsuarioBE>("Usuario");
            bool restoreRealizado = _backupService.RealizarRestore(nombreBase, rutaBackup);

            if (restoreRealizado)
            {
                //_bitacoraService.AltaBitacora($"{clienteLogueado.RazonSocial} ({clienteLogueado.Id}) realizó backup de la base de datos", Criticidad.Alta, clienteLogueado);
            }
            else
                throw new Exception("Hubo un error al generar el restore en la base de datos.");
        }
    }
}
