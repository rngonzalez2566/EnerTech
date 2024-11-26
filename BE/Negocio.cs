using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class Negocio
    {
        public int id_negocio { get; set; }
        public string Nombre { get; set; }
        public string RazonSocial { get; set; }
        public int Identificacion { get; set; }
        public string Direccion { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public DateTime InicioActividades { get; set; }
        public string privateKey { get; set; }
        public string certificate { get; set; }
    }
}
