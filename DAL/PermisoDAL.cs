using BE;
using BE.Composite;
using BE.Enums;
using BE.Permisos;
using DAL.Tools;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class PermisoDAL : Acceso
    {

        public int GuardarPatenteFamilia(Componente componente, bool familia)
        {
            xCommandText = Querys.PermisoQuerys.Guardar_Componente;
            xParameters.Parameters.Clear();
            xParameters.Parameters.AddWithValue("@Nombre", componente.Nombre);
            if (familia) xParameters.Parameters.AddWithValue("@Permiso", DBNull.Value);
            else xParameters.Parameters.AddWithValue("@Permiso", componente.Permiso.ToString());

            
            return ExecuteNonEscalar();
        }

        public void GuardarFamiliaCreada(Familia familia)
        {
            xCommandText = Querys.PermisoQuerys.Borrar_Familia;
            xParameters.Parameters.Clear();
            xParameters.Parameters.AddWithValue("@PadreId", familia.id_componente);

            executeNonQuery();

            foreach (Componente item in familia.Hijos)
            {
                xCommandText = Querys.PermisoQuerys.Guardar_FamiliaPatente;
                xParameters.Parameters.Clear();

                xParameters.Parameters.AddWithValue("@PadreId", familia.id_componente);
                xParameters.Parameters.AddWithValue("@HijoId", item.id_componente);
                executeNonQuery();

                xCommandText = Querys.PermisoQuerys.Guardar_Familia;
                xParameters.Parameters.Clear();

    
                xParameters.Parameters.AddWithValue("@NombreFamilia", familia.Nombre);
                xParameters.Parameters.AddWithValue("@FamiliaId", familia.id_componente);
                executeNonQuery();

            }
        }

        public List<Familia> GetFamilias()
        {
            xCommandText = Querys.PermisoQuerys.Get_Familias;
            xParameters.Parameters.Clear();
            DataSet ds = ExecuteReader();
            List<Familia> familias = new List<Familia>();

            if (ds.Tables[0].Rows.Count > 0)
                familias = PermisoTools.FillListFamilia(ds);

            return familias;
        }

        public List<Patente> GetPatentes()
        {
            xCommandText = Querys.PermisoQuerys.Get_Patentes;
            xParameters.Parameters.Clear();
            DataSet ds = ExecuteReader();

            List<Patente> patentes = new List<Patente>();

            if (ds.Tables[0].Rows.Count > 0)
                patentes = PermisoTools.FillListPatente(ds);

            return patentes;
        }

        public List<Componente> TraerFamiliaPatentes(int familiaId)
        {
            xCommandText = Querys.PermisoQuerys.Get_Familia_Patente;
            xParameters.Parameters.Clear();
            xParameters.Parameters.AddWithValue("@familia", familiaId);
            DataSet ds = ExecuteReader();
            DataTable dt = ds.Tables[0];


            List<Componente> componentes = new List<Componente>();
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow rows in dt.Rows)
                {
                    int padreId = 0;
                    if (rows["Id_Padre"] != DBNull.Value)
                    {
                        padreId = int.Parse(rows["Id_Padre"].ToString());
                    }

                    int Id = int.Parse(rows["Id_Permiso"].ToString());
                    string nombre = rows["Nombre"].ToString();
                    string permiso = string.Empty;
                    if (rows["Permiso"] != DBNull.Value) permiso = rows["Permiso"].ToString();

                    Componente componente;
                    if (string.IsNullOrEmpty(permiso)) componente = new Familia();
                    else componente = new Patente();

                    componente.id_componente = Id;
                    componente.Nombre = nombre;
                    if (!string.IsNullOrEmpty(permiso)) componente.Permiso = (Permiso)Enum.Parse(typeof(Permiso), permiso);

                    Componente padre = GetComponente(padreId, componentes);
                    if (padre == null) componentes.Add(componente);
                    else padre.AgregarHijo(componente);
                }
            }
            return componentes;
        }

        private Componente GetComponente(int id, IList<Componente> lista)
        {
            Componente componente = lista != null ? lista.Where(i => i.id_componente.Equals(id)).FirstOrDefault() : null;

            if (componente == null && lista != null)
            {
                foreach (var item in lista)
                {
                    var _lista = GetComponente(id, item.Hijos);
                    if (_lista != null && _lista.id_componente == id) return _lista;
                    else if (_lista != null) return GetComponente(id, _lista.Hijos);
                }
            }
            return componente;
        }

        public void GetComponenteUsuario(UsuarioBE usuario)
        {
            xCommandText = Querys.PermisoQuerys.Get_Usuario_Permiso;
            xParameters.Parameters.Clear();
            xParameters.Parameters.AddWithValue("@user", usuario.id_usuario);
            DataSet ds = ExecuteReader();
            DataTable dt = ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow rows in dt.Rows)
                {
                    int id = int.Parse(rows["Id_Permiso"].ToString());
                    string nombre = rows["Nombre"].ToString();
                    string permiso = String.Empty;
                    if (rows["Permiso"].ToString() != String.Empty) permiso = rows["Permiso"].ToString();

                    Componente componente;
                    if (!String.IsNullOrEmpty(permiso))
                    {
                        componente = new Patente();
                        componente.id_componente = id;
                        componente.Nombre = nombre;
                        componente.Permiso = (Permiso)Enum.Parse(typeof(Permiso), permiso);
                        usuario.Permisos.Add(componente);
                    }
                    else
                    {
                        componente = new Familia();
                        componente.id_componente = id;
                        componente.Nombre = nombre;

                        var familia = TraerFamiliaPatentes(id);
                        foreach (var f in familia)
                        {
                            componente.AgregarHijo(f);
                        }

                        usuario.Permisos.Add(componente);
                    }
                }
            }
        }

        public void BorrarPermisoUsuario(UsuarioBE usuario)
        {
            xCommandText = Querys.PermisoQuerys.Borrar_Permiso_Usuario;
            xParameters.Parameters.Clear();
            xParameters.Parameters.AddWithValue("@user", usuario.id_usuario);

            executeNonQuery();
      
        }

        public void GuardarPermiso(UsuarioBE usuario, Componente permiso, string DVH)
        {

            xCommandText = Querys.PermisoQuerys.Guardar_Permiso_Usuario;
            xParameters.Parameters.Clear();
            xParameters.Parameters.AddWithValue("@user", usuario.id_usuario);
            xParameters.Parameters.AddWithValue("@PatenteId", permiso.id_componente);
            xParameters.Parameters.AddWithValue("@DVH", DVH);
            executeNonQuery();

    
        }

        public List<Familia> GetFamiliasValidacion(int familiaId)
        {

            xCommandText = Querys.PermisoQuerys.Get_validacion_familia;
            xParameters.Parameters.Clear();
            xParameters.Parameters.AddWithValue("@hijo", familiaId);
            DataSet ds = ExecuteReader();
            List<Familia> familias = new List<Familia>();

         
            if (ds.Tables[0].Rows.Count > 0)
                familias = PermisoTools.FillListFamilia(ds);

            return familias;
        }

        public Componente GetFamiliaArbol(int familiaId, Componente componenteOriginal, Componente componenteAgregar)
        {

            xCommandText = Querys.PermisoQuerys.Get_Patentes_Familia;
            xParameters.Parameters.Clear();
            xParameters.Parameters.AddWithValue("@idPadre", familiaId);
            DataSet ds = ExecuteReader();
            DataTable dt = ds.Tables[0];

       

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow rows in dt.Rows)
                {
                    int Id = int.Parse(rows["Id_Permiso"].ToString());
                    string nombre = rows["Nombre"].ToString();
                    string permiso = string.Empty;
                    if (rows["Permiso"] != DBNull.Value) permiso = rows["Permiso"].ToString();

                    Componente componente;
                    if (string.IsNullOrEmpty(permiso)) componente = new Familia();
                    else componente = new Patente();

                    componente.id_componente = Id;
                    componente.Nombre = nombre;
                    if (!string.IsNullOrEmpty(permiso)) componente.Permiso = (Permiso)Enum.Parse(typeof(Permiso), permiso);

                    if (componenteAgregar != null)
                    {
                        if (componente.GetType() == typeof(Patente)) componenteAgregar.AgregarHijo(componente);
                        else if (componente.GetType() == typeof(Familia)) LlenarComponenteFamilia(componente, componenteOriginal, componenteAgregar);
                    }
                    else
                    {
                        if (componente.GetType() == typeof(Patente)) componenteOriginal.AgregarHijo(componente);
                        else if (componente.GetType() == typeof(Familia)) LlenarComponenteFamilia(componente, componenteOriginal, componenteOriginal);
                    }
                }
            }

            return componenteOriginal;
        }

        private void LlenarComponenteFamilia(Componente componente, Componente componenteOriginal, Componente componenteRaiz)
        {
            Componente familia = new Familia();
            familia = componente;

            componenteRaiz.AgregarHijo(familia);

            GetFamiliaArbol(componente.id_componente, componenteOriginal, familia);
        }

        public Componente GetUsuarioArbol(int usuarioId, Componente componenteOriginal, Componente componenteAgregar)
        {
            xCommandText = Querys.PermisoQuerys.Get_Permisos_Usuarios;
            xParameters.Parameters.Clear();
            xParameters.Parameters.AddWithValue("@user", usuarioId);
            DataSet ds = ExecuteReader();
            DataTable dt = ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow rows in dt.Rows)
                {
                    int Id = int.Parse(rows["Id_Permiso"].ToString());
                    string nombre = rows["Nombre"].ToString();
                    string permiso = string.Empty;
                    if (rows["Permiso"] != DBNull.Value) permiso = rows["Permiso"].ToString();

                    Componente componente;
                    if (string.IsNullOrEmpty(permiso)) componente = new Familia();
                    else componente = new Patente();

                    componente.id_componente = Id;
                    componente.Nombre = nombre;
                    if (!string.IsNullOrEmpty(permiso)) componente.Permiso = (Permiso)Enum.Parse(typeof(Permiso), permiso);

                    if (componenteAgregar != null)
                    {
                        if (componente.GetType() == typeof(Patente)) componenteAgregar.AgregarHijo(componente);
                        else if (componente.GetType() == typeof(Familia)) LlenarComponenteFamilia(componente, componenteOriginal, componenteAgregar);
                    }
                    else
                    {
                        if (componente.GetType() == typeof(Patente)) componenteOriginal.AgregarHijo(componente);
                        else if (componente.GetType() == typeof(Familia)) LlenarComponenteFamilia(componente, componenteOriginal, componenteOriginal);
                    }
                }
            }

            return componenteOriginal;
        }

        public List<UsuarioPermisoBE> GetUsuariosPermisos()
        {

            xCommandText = Querys.PermisoQuerys.Get_Usuarios_Permisos;
            xParameters.Parameters.Clear();
            DataSet ds = ExecuteReader();

           List<UsuarioPermisoBE> usuariosPermisos = new List<UsuarioPermisoBE>();

            if (ds.Tables[0].Rows.Count > 0)
                usuariosPermisos = PermisoTools.FillListUsuarioPermisoDTO(ds);

            return usuariosPermisos;
        }

        public List<PermisoBE> GetPermisosBE()
        {
            xCommandText = Querys.PermisoQuerys.Get_All_Permiso;
            xParameters.Parameters.Clear();
            DataSet ds = ExecuteReader();

            List<PermisoBE> patentes = new List<PermisoBE>();

            if (ds.Tables[0].Rows.Count > 0)
                patentes = PermisoTools.FillListPermisoDTO(ds);

            return patentes;
        }

        public List<FamiliaPatenteBE> GetFamiliaPatenteBE()
        {
            xCommandText = Querys.PermisoQuerys.Get_All_Familia;
            xParameters.Parameters.Clear();
            DataSet ds = ExecuteReader();
           

            List<FamiliaPatenteBE> familiaPatenteDTO = new List<FamiliaPatenteBE>();

            if (ds.Tables[0].Rows.Count > 0)
                familiaPatenteDTO = PermisoTools.FillListFamiliaPatenteDTO(ds);

            return familiaPatenteDTO;
        }

    }
}
