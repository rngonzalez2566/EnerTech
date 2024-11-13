using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE.Permisos
{
    public class FamiliaPatenteBE :DVH
    {
        public int Id_Padre { get; set; }
        public int Id_Hijo { get; set; }
    }
}
