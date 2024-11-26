using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
namespace DAL.Tools
{
    public class UsuarioTools
    {

        public static UsuarioBE FillObjectUsuario(DataRow dr)
        {
            UsuarioBE usuario = new UsuarioBE();
         

            if (dr.Table.Columns.Contains("id_usuario") && !Convert.IsDBNull(dr["id_usuario"]))
                usuario.id_usuario = Convert.ToInt32(dr["id_usuario"]);

            if (dr.Table.Columns.Contains("Email") && !Convert.IsDBNull(dr["Email"]))
                usuario.Email = Convert.ToString(dr["Email"]);

            if (dr.Table.Columns.Contains("Password") && !Convert.IsDBNull(dr["Password"]))
                usuario.Password = Convert.ToString(dr["Password"]);

            if (dr.Table.Columns.Contains("Nombre") && !Convert.IsDBNull(dr["Nombre"]))
                usuario.Nombre = Convert.ToString(dr["Nombre"]);

            if (dr.Table.Columns.Contains("Apellido") && !Convert.IsDBNull(dr["Apellido"]))
                usuario.Apellido = Convert.ToString(dr["Apellido"]);

            if (dr.Table.Columns.Contains("RazonSocial") && !Convert.IsDBNull(dr["RazonSocial"]))
                usuario.RazonSocial = Convert.ToString(dr["RazonSocial"]);

            if (dr.Table.Columns.Contains("TipoDocumento") && !Convert.IsDBNull(dr["TipoDocumento"]))
                usuario.TipoDocumento = Convert.ToString(dr["TipoDocumento"]);

            if (dr.Table.Columns.Contains("TipoCliente") && !Convert.IsDBNull(dr["TipoCliente"]))
                usuario.TipoCliente = Convert.ToString(dr["TipoCliente"]);


            if (dr.Table.Columns.Contains("Estado") && !Convert.IsDBNull(dr["Estado"]))
                usuario.Estado = Convert.ToString(dr["Estado"]);

            if (dr.Table.Columns.Contains("Identificacion") && !Convert.IsDBNull(dr["Identificacion"]))
                usuario.Identificacion = Convert.ToInt32(dr["Identificacion"]);

            if (dr.Table.Columns.Contains("Contador") && !Convert.IsDBNull(dr["Contador"]))
                usuario.Contador = Convert.ToInt32(dr["Contador"]);

            if (dr.Table.Columns.Contains("DVH") && !Convert.IsDBNull(dr["DVH"]))
                usuario.DVH = Convert.ToInt32(dr["DVH"]);



            return usuario;
        }

        public static List<UsuarioBE> FillListUsuario(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectUsuario(dr)).ToList();
        }

    }
}
