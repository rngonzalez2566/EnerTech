using BE.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE.Permisos
{
    public class PermisoBE : DVH
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public Permiso Permiso { get; set; }
    }
}
