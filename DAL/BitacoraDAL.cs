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
                xParameters.Parameters.AddWithValue("@dv", Bitacora.DVH);


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


        public BitacoraBE GetBitacoraID(int id)
        {

            try
            {
                xCommandText = Querys.BitacoraQuerys.GetBitacora_id;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@bit", id);
                DataSet ds = ExecuteReader();


                BE.BitacoraBE bit = ds.Tables[0].Rows.Count <= 0 ? null : Tools.BitacoraTools.FillObjectBitacora(ds.Tables[0].Rows[0]);

                return bit;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public void DepurarBitacora(DateTime? desde, DateTime? hastaExclusivo)
        {
            try
            {
                // Si no mandan fechas, NO BORRAMOS NADA (seguridad)
                if (!desde.HasValue && !hastaExclusivo.HasValue)
                    throw new Exception("Debe indicar al menos una fecha para depurar.");

                xCommandText = @"
                                DELETE FROM Bitacora
                                WHERE (@desde IS NULL OR Fecha >= @desde)
                                  AND (@hasta IS NULL OR Fecha < @hasta);";

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@desde", (object)desde ?? DBNull.Value);
                xParameters.Parameters.AddWithValue("@hasta", (object)hastaExclusivo ?? DBNull.Value);

                executeNonQuery();
            }
            catch
            {
                throw new Exception(ErrorMessages.ERR001);
            }
        }

    }
}
