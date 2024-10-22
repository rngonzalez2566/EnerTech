using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE.AFIP
{
    public class PuntoDeVenta
    {
        public int Id { get; set; }

        public string Codigo { get; set; }
        public string Nombre { get; set; }

        public bool Activo { get; set; }

        public TipoPV TipoPV { get; set; }

        public int ultimoNumero { get; set; }
    }
}
