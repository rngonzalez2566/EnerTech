using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE.Composite
{
    public class Familia : Componente
    {
        private IList<Componente> _hijos;
        public Familia()
        {
            _hijos = new List<Componente>();
        }


        public override IList<Componente> Hijos
        {
            get
            {
                return _hijos.ToArray();
            }
        }

        public override void VaciarHijos()
        {
            _hijos = new List<Componente>();
        }

        public override void AgregarHijo(Componente componente)
        {
            _hijos.Add(componente);
        }

        public override void BorrarHijo(Componente componente)
        {
            _hijos.Remove(componente);
        }

        public object ToList()
        {
            throw new NotImplementedException();
        }
    }
}

