using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE.AFIP;
namespace BE
{
    public class RelatedTaxesBE
    {
        public int id_relatedtaxes { get; set; }
        public int codigoIVA { get; set; } // Tasa de IVA (ej. 0% o 21%)
        public decimal TasaIVA { get; set; }
        public decimal BaseImponible { get; set; } // Suma de bases imponibles con esta tasa
        public decimal TotalIVA { get; set; } // IVA total para esta tasa
    }
}
