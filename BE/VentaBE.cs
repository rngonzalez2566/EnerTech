using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class VentaBE
    {
        public int Id { get; set; }
        public DateTime Fecha { get; set; }
        public string Detalle { get; set; }

        public int CodigoAutorizacion { get; set; }

        public DateTime FechaVtoCae { get; set; }
        public int PuntoDeVenta { get; set; }
        public int NumeroVenta { get; set; }

        public UsuarioBE usuario { get; set; }
        public string TipoComprobante {  get; set; }

        public float Total {  get; set; }
        public float IVA { get; set; }

    }
}
