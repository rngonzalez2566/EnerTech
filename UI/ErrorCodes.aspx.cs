using Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class ErrorCodes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Cargar códigos de error
                List<string> errorMessages = GetErrorMessages();
                rptErrorCodes.DataSource = errorMessages;
                rptErrorCodes.DataBind();
            }
        }

        private List<string> GetErrorMessages()
        {
            // Devuelve todos los mensajes de error definidos en la clase ErrorMessages
            return new List<string>
            {
                ErrorMessages.ERR001,
                ErrorMessages.ERR002,
                ErrorMessages.ERR003,
                ErrorMessages.ERR004,
                ErrorMessages.ERR005,
                ErrorMessages.ERR006,
                ErrorMessages.ERR007,
                ErrorMessages.ERR008,
                ErrorMessages.ERR009,
                ErrorMessages.ERR010,
                ErrorMessages.ERR011,
                ErrorMessages.ERR012,
                ErrorMessages.ERR013,
                ErrorMessages.ERR014,
                ErrorMessages.ERR015,
                ErrorMessages.ERR016,
                ErrorMessages.ERR017,
                ErrorMessages.ERR018,
                ErrorMessages.ERR019,
                ErrorMessages.ERR020,
                ErrorMessages.ERR021,
                ErrorMessages.ERR022,
                ErrorMessages.ERR023,
                ErrorMessages.ERR024,
                ErrorMessages.ERR025,
                ErrorMessages.ERR026,
                ErrorMessages.ERR027
            };
        }
    }
}