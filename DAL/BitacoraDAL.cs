using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using Services;
using System.Data;

namespace DAL
{
    public class BitacoraDAL : Acceso
    {
        public int RegistrarBitacora(BitacoraBE Bitacora)
        {
            try
            {
                xCommandText = Querys.BitacoraQuerys.RegisterBitacora;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", Bitacora.usuario.id_usuario);
                xParameters.Parameters.AddWithValue("@crit", Bitacora.Criticidad);
                xParameters.Parameters.AddWithValue("@Det", Bitacora.Detalle);
                xParameters.Parameters.AddWithValue("@Fecha", Bitacora.Fecha);
       

                return ExecuteNonEscalar();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public List<BitacoraBE> GetBitacora()
        {

            try
            {
                xCommandText = Querys.BitacoraQuerys.GetBitacora;
                DataSet ds = ExecuteReader();

                List<BitacoraBE> Bitacora = new List<BitacoraBE>();
                if (ds.Tables[0].Rows.Count > 0)
                    Bitacora = Tools.BitacoraTools.FillListBitacora(ds);

                return Bitacora;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }
    }
}
