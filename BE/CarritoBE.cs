using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class CarritoBE
    {
        public int id_carrito { get; set; }
        public UsuarioBE usuario { get; set; }

        public ProductoBE producto { get; set; }

        public int Cantidad { get; set; }

    }
}
