using BE.Composite;
using BE.Enums;
using BE.Factory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class UsuarioBE
    {

        public int Id { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string RazonSocial { get; set; }
        public int Identificacion { get; set; }
        public int Contador { get; set; }
        public string Estado { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string TipoDocumento { get; set; }
        public string TipoCliente { get; set; }

        List<Componente> _permisos = new List<Componente>();
        public List<Componente> Permisos
        {
            get
            {
                return _permisos;
            }
        }
        public void EliminarPermisosPorId(List<int> ids)
        {
            _permisos.RemoveAll(p => ids.Contains(p.Id));
        }

        public void AsignarPermiso(Permiso tipoPermiso)
        {
            Componente permiso = PermisoFactory.CrearPermiso(tipoPermiso);
            _permisos.Add(permiso);
        }

        public void EliminarPermiso(Componente permiso)
        {
            _permisos.Remove(permiso);
        }



    }
}
