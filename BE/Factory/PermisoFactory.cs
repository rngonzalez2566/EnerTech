using BE.Composite;
using BE.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE.Factory
{
    public static class PermisoFactory
    {
        public static Componente CrearPermiso(Permiso tipoPermiso, int? id = null)
        {
            if (tipoPermiso == Permiso.EsFamilia)
            {
                return new Familia { Nombre = tipoPermiso.ToString(), Id = id ?? 0 };
            }
            else
            {
                return new Patente { Nombre = tipoPermiso.ToString(), Permiso = tipoPermiso, Id = id ?? 0 };
            }
        }
    }
}
