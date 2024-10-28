using BE.AFIP;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class Detalle_VentaBE
    {
        public int Id { get; set; }
        public ProductoBE Producto { get; set; }
        public string Descripcion { get; set; }
        public string Codigo { get; set; }
        public int Cantidad { get; set; }
        public float PrecioUnitario { get; set; }
        public float Total { get; set; }
        public float IVA { get; set; }
        public VentaBE venta { get; set; }
        public CodigoIVA codigoIVA { get; set; }


    }
}
