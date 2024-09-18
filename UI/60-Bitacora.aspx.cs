using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BE;
using BLL;

namespace UI
{
    public partial class _60_Bitacora : System.Web.UI.Page
    {
        BitacoraBLL _bitacoraService = new BitacoraBLL();
        public List<BitacoraBE> Registros { get; set; } = new List<BitacoraBE>();
        protected void Page_Load(object sender, EventArgs e)
        {
           var Movimientos = _bitacoraService.GetBitacora();
            Registros = Movimientos.ToList();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            List<BitacoraBE> registros = _bitacoraService.GetBitacora();
          
        }
    }
}