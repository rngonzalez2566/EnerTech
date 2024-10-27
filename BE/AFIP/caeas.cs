using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE.AFIP
{
    public class caeas
    {
        public int caea { get; set; }

        public int Periodo { get; set; }
        public int Orden { get; set; }

        public DateTime ValidoDesde { get; set; }
        public DateTime ValidoHasta { get; set; }
    }
}
