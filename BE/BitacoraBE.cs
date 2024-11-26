using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class BitacoraBE
    {
        public int id_bitacora { get; set; }
        public UsuarioBE usuario { get; set; }
        public string Criticidad { get; set; }
        public string Detalle { get; set; }
        public DateTime Fecha { get; set; }
    }
}
