using BE.AFIP;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class ProductoBE
    {
        public int id_producto { get; set; }
        public string Imagen { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
        public CategoriaBE Categoria { get; set; }
        public MarcaBE Marca { get; set; }
        public int Cantidad { get; set; }

        public bool Catalogo { get; set; }

        public decimal Precio { get; set; }

        public CodigoIVA codigoIVA { get; set; }
    }
}
