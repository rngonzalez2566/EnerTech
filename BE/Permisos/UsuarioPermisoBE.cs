using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE.Permisos
{
    public class UsuarioPermisoBE : DVH
    {
        public int Id { get; set; }
        public int UsuarioId { get; set; }
        public int PermisoId { get; set; }
    }
}
