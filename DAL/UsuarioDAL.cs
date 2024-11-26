using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using Services;

namespace DAL
{
    public class UsuarioDAL : Acceso
    {
       
        public UsuarioBE GetUsuario(string idUsuario)
        {
           
            try
			{
                xCommandText = Querys.UsuarioQuerys.GetUser;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", idUsuario);
                DataSet ds = ExecuteReader();


                BE.UsuarioBE Usuario = ds.Tables[0].Rows.Count <= 0 ? null : Tools.UsuarioTools.FillObjectUsuario(ds.Tables[0].Rows[0]);

                return Usuario;
            }
			catch
			{

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public UsuarioBE GetUsuarioID(int idUsuario)
        {

            try
            {
                xCommandText = Querys.UsuarioQuerys.GetUser_id;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", idUsuario);
                DataSet ds = ExecuteReader();


                BE.UsuarioBE Usuario = ds.Tables[0].Rows.Count <= 0 ? null : Tools.UsuarioTools.FillObjectUsuario(ds.Tables[0].Rows[0]);

                return Usuario;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }
        public List<UsuarioBE> GetUsuarios()
        {

            try
            {
                xCommandText = Querys.UsuarioQuerys.GetUsers;
                DataSet ds = ExecuteReader();

                List<BE.UsuarioBE> Usuarios = new List<BE.UsuarioBE>();
                if (ds.Tables[0].Rows.Count > 0)
                    Usuarios = Tools.UsuarioTools.FillListUsuario(ds);

                return Usuarios;
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public void BloquearUsuario(int idUsuario)
        {
            try
            {
                xCommandText = Querys.UsuarioQuerys.BlockUser;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@id", idUsuario);
                executeNonQuery();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public void DesbloquearUsuario(int idUsuario)
        {
            try
            {
                xCommandText = Querys.UsuarioQuerys.UnlockUser;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", idUsuario);
                executeNonQuery();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public int RegistrarUsuario(UsuarioBE usuario)
        {
            try
            {
                xCommandText = Querys.UsuarioQuerys.RegisterUser;
                
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@Email", usuario.Email);
                xParameters.Parameters.AddWithValue("@Password", usuario.Password );
                xParameters.Parameters.AddWithValue("@RazonSocial", usuario.RazonSocial );
                xParameters.Parameters.AddWithValue("@Identificacion", usuario.Identificacion );
                xParameters.Parameters.AddWithValue("@Nombre", usuario.Nombre);
                xParameters.Parameters.AddWithValue("@Apellido", usuario.Apellido);
                xParameters.Parameters.AddWithValue("@TipoDoc", usuario.TipoDocumento);
                xParameters.Parameters.AddWithValue("@TipoCliente", usuario.TipoCliente);
                xParameters.Parameters.AddWithValue("@dvh", usuario.DVH);

                return ExecuteNonEscalar();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public void SumarContadorbloqueo(UsuarioBE usuario)
        {
            try
            {
                xCommandText = Querys.UsuarioQuerys.addBlock;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", usuario.id_usuario);

                executeNonQuery();
            }
            catch
            {

                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public UsuarioBE Login(string user)
        {
            UsuarioBE usuario = GetUsuario(user);

            return usuario;
        }
    }
}
