using BE.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE.Composite
{
    public abstract class Componente
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public abstract IList<Componente> Hijos { get; }
        public abstract void AgregarHijo(Componente componente);
        public abstract void VaciarHijos();
        public abstract void BorrarHijo(Componente componente);
        public Permiso Permiso { get; set; }
    }
}
