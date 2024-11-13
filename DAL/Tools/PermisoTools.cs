using BE.Composite;
using BE.Enums;
using BE.Permisos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Tools
{
    public class PermisoTools
    {

        public static Familia FillObjectFamilia(DataRow dr)
        {
            Familia familia = new Familia();

            if (dr.Table.Columns.Contains("Id_Permiso") && !Convert.IsDBNull(dr["Id_Permiso"]))
                familia.Id = Convert.ToInt32(dr["Id_Permiso"]);


            if (dr.Table.Columns.Contains("Nombre") && !Convert.IsDBNull(dr["Nombre"]))
                familia.Nombre = Convert.ToString(dr["Nombre"]);
            return familia;
        }

        public static List<Familia> FillListFamilia(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectFamilia(dr)).ToList();
        }

        public static Patente FillObjectPatente(DataRow dr)
        {
            Patente patente = new Patente();

            if (dr.Table.Columns.Contains("Id_Permiso") && !Convert.IsDBNull(dr["Id_Permiso"]))
                patente.Id = Convert.ToInt32(dr["Id_Permiso"]);


            if (dr.Table.Columns.Contains("Nombre") && !Convert.IsDBNull(dr["Nombre"]))
                patente.Nombre = Convert.ToString(dr["Nombre"]);

            if (dr.Table.Columns.Contains("Permiso") && !Convert.IsDBNull(dr["Permiso"]))
                patente.Permiso = (Permiso)Enum.Parse(typeof(Permiso), dr["Permiso"].ToString());

            return patente;
        }

        public static List<Patente> FillListPatente(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectPatente(dr)).ToList();
        }

        public static UsuarioPermisoBE FillObjectUsuarioPermiso(DataRow dr)
        {
            var usuarioPermiso = new UsuarioPermisoBE();

            if (dr.Table.Columns.Contains("Id_Usuario_Permiso") && !Convert.IsDBNull(dr["Id_Usuario_Permiso"]))
                usuarioPermiso.Id = Convert.ToInt32(dr["Id_Usuario_Permiso"]);

            if (dr.Table.Columns.Contains("Id_Cliente") && !Convert.IsDBNull(dr["Id_Cliente"]))
                usuarioPermiso.UsuarioId = Convert.ToInt32(dr["Id_Cliente"]);

            if (dr.Table.Columns.Contains("Id_Patente") && !Convert.IsDBNull(dr["Id_Patente"]))
                usuarioPermiso.PermisoId = Convert.ToInt32(dr["Id_Patente"]);

            if (dr.Table.Columns.Contains("DVH") && !Convert.IsDBNull(dr["DVH"]))
                usuarioPermiso.dvh = Convert.ToString(dr["DVH"]);


            return usuarioPermiso;
        }

        public static List<UsuarioPermisoBE> FillListUsuarioPermisoDTO(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectUsuarioPermiso(dr)).ToList();
        }

        public static PermisoBE FillObjectPermisoDTO(DataRow dr)
        {
            PermisoBE permisoDTO = new PermisoBE();

            if (dr.Table.Columns.Contains("Id_Permiso") && !Convert.IsDBNull(dr["Id_Permiso"]))
                permisoDTO.Id = Convert.ToInt32(dr["Id_Permiso"]);

            if (dr.Table.Columns.Contains("Nombre") && !Convert.IsDBNull(dr["Nombre"]))
                permisoDTO.Nombre = Convert.ToString(dr["Nombre"]);

            if (dr.Table.Columns.Contains("Permiso") && !Convert.IsDBNull(dr["Permiso"]))
                permisoDTO.Permiso = (Permiso)Enum.Parse(typeof(Permiso), dr["Permiso"].ToString());

            return permisoDTO;
        }

        public static List<PermisoBE> FillListPermisoDTO(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectPermisoDTO(dr)).ToList();
        }

        public static FamiliaPatenteBE FillObjectFamiliaPatenteDTO(DataRow dr)
        {
            FamiliaPatenteBE familiaPatenteDTO = new FamiliaPatenteBE();

            if (dr.Table.Columns.Contains("Id_Padre") && !Convert.IsDBNull(dr["Id_Padre"]))
                familiaPatenteDTO.Id_Padre = Convert.ToInt32(dr["Id_Padre"]);

            if (dr.Table.Columns.Contains("Id_Hijo") && !Convert.IsDBNull(dr["Id_Hijo"]))
                familiaPatenteDTO.Id_Hijo = Convert.ToInt32(dr["Id_Hijo"]);

            return familiaPatenteDTO;
        }

        public static List<FamiliaPatenteBE> FillListFamiliaPatenteDTO(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectFamiliaPatenteDTO(dr)).ToList();
        }

    }
}
