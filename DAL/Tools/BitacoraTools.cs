﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using System.Data;
using System.IO;

namespace DAL.Tools
{
    public class BitacoraTools
    {

        public static BitacoraBE FillObjectBitacora(DataRow dr)
        {
            BitacoraBE Bitacora = new BitacoraBE();
            UsuarioDAL user = new UsuarioDAL();
            Bitacora.usuario = new UsuarioBE();


            if (dr.Table.Columns.Contains("Id") && !Convert.IsDBNull(dr["Id"]))
                Bitacora.Id = Convert.ToInt32(dr["Id"]);

            if (dr.Table.Columns.Contains("Criticidad") && !Convert.IsDBNull(dr["Criticidad"]))
                Bitacora.Criticidad = Convert.ToString(dr["Criticidad"]);

            if (dr.Table.Columns.Contains("Detalle") && !Convert.IsDBNull(dr["Detalle"]))
                Bitacora.Detalle = Convert.ToString(dr["Detalle"]);

            if (dr.Table.Columns.Contains("Fecha") && !Convert.IsDBNull(dr["Fecha"]))
                Bitacora.Fecha = Convert.ToDateTime(dr["Fecha"]);

            if (dr.Table.Columns.Contains("id_usuario") && !Convert.IsDBNull(dr["id_usuario"]))
                Bitacora.usuario.Id = Convert.ToInt32(dr["id_usuario"]);

            if (Bitacora.usuario.Id == 0)
            {
                Bitacora.usuario.Nombre = "Sistema";
            }
            else
            {
                Bitacora.usuario = user.GetUsuarioID(Bitacora.usuario.Id);
                Bitacora.usuario.Nombre = Services.Encriptador.Descencriptar(Bitacora.usuario.Nombre);
            }
           

            return Bitacora;
        }

        public static List<BitacoraBE> FillListBitacora(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectBitacora(dr)).ToList();
        }
    }
}
