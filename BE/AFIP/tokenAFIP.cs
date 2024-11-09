using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE.AFIP
{
    public class tokenAFIP
    {
        public uint codigo { get; set; }
        public string token { get; set; }
        public string sign { get; set; }
        public DateTime FechaGeneracion { get; set; }
        public DateTime FechaExpiracion { get; set; }
    }
}
