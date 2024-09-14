using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class Usuario : Acceso
    {
        public BE.Usuario GetUsuario(int idUsuario)
        {
           
            try
			{
                xCommandText = Querys.UsuarioQuerys.GetUser;
                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@user", idUsuario);
                DataSet ds = ExecuteReader();


                BE.Usuario Usuario = ds.Tables[0].Rows.Count <= 0 ? null : Tools.UsuarioTools.FillObjectUsuario(ds.Tables[0].Rows[0]);

                return Usuario;
            }
			catch
			{

                throw new Exception("Se produjo un error con la base de datos");
            }
        }
        public List<BE.Usuario> GetUsuarios()
        {

            try
            {
                xCommandText = Querys.UsuarioQuerys.GetUsers;
                DataSet ds = ExecuteReader();

                List<BE.Usuario> Usuarios = new List<BE.Usuario>();
                if (ds.Tables[0].Rows.Count > 0)
                    Usuarios = Tools.UsuarioTools.FillListUsuario(ds);

                return Usuarios;
            }
            catch
            {

                throw new Exception("Se produjo un error con la base de datos");
            }
        }

        public void BloquearUsuario(int idUsuario)
        {
            try
            {
                xCommandText = Querys.UsuarioQuerys.BlockUser;
                executeNonQuery();
            }
            catch
            {

                throw new Exception("Se produjo un error con la base de datos");
            }
        }

        public int RegistrarUsuario(BE.Usuario usuario)
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

                return ExecuteNonEscalar();
            }
            catch
            {

                throw new Exception("Se produjo un error con la base de datos");
            }
        }
    }
}
