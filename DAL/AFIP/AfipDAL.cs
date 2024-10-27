using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE.AFIP;
using Services;

namespace DAL.AFIP
{
    public class AfipDAL:Acceso
    {

        public tokenAFIP getLoginTicket()
        {
            return null;
        }

        public tokenAFIP obtenerTicketDB ()
        {
            try
            {
                xCommandText = AFIP.Querys.AfipQuerys.getToken;
                DataSet ds = ExecuteReader();

                tokenAFIP token = ds.Tables[0].Rows.Count <= 0 ? null : Tools.tokenAfipTools.FillObjectToken(ds.Tables[0].Rows[0]);

                return token;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
            
        }
    }
}
