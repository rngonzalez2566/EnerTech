﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class BackupBE
    {
        public int Id { get; set; }
        public string NombreBase { get; set; }
        public string RutaBackup { get; set; }
        public string Nombre { get; set; }
        public DateTime Fecha { get; set; }
        public UsuarioBE RealizadoPor { get; set; }
    }
}
