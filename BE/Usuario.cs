using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class Usuario
    {

        public int Id { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string RazonSocial { get; set; }
        public int Identificacion { get; set; }
        public int Contador { get; set; }
        public string Estado { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string TipoDocumento { get; set; }
        public string TipoCliente { get; set; }


    }
}
