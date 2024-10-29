using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE.AFIP;
namespace BE
{
    public class VentaBE
    {
        public int Id { get; set; }
        public DateTime Fecha { get; set; }
        public string Detalle { get; set; }

        public long CodigoAutorizacion { get; set; }

        public DateTime FechaVtoCae { get; set; }
        public int PuntoDeVenta { get; set; }
        public int NumeroVenta { get; set; }

        public UsuarioBE usuario { get; set; }
        public string TipoComprobante {  get; set; }

        public decimal Total {  get; set; }
        public decimal IVA { get; set; }

        public decimal TotalGravado { get; set; }

        public TipoPV  TipoAutorizacion { get; set; }

        public List<Detalle_VentaBE> Items { get; set; }

        public List<RelatedTaxesBE> RelatedTaxes { get; set; }

    }
}
