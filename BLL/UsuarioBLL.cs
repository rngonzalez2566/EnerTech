using BE;
using Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;
using System.Transactions;
using DAL;



namespace BLL
{
    public class UsuarioBLL
    {
        UsuarioDAL usuarioDAL = new UsuarioDAL();   
        BitacoraBLL bitacora = new BitacoraBLL();
        PermisoBLL _permisoService = new PermisoBLL();
        DigitoVerificador dv = new DigitoVerificador();
        DigitoVerificadorDAL dvDAL = new DigitoVerificadorDAL();
        public int RegistrarUsuario(UsuarioBE usuario, string password)
        {
            ValidarUsuario(usuario, password);
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    usuario.Email = Encriptador.Encriptar(usuario.Email);
                    usuario.Nombre = Encriptador.Encriptar(usuario.Nombre);
                    usuario.Apellido = Encriptador.Encriptar(usuario.Apellido);
                    usuario.Password = Encriptador.Hash(usuario.Password);
                    usuario.Contador = 0;
                    usuario.DVH = dv.CalcularDV(usuario);

                    int _id = usuarioDAL.RegistrarUsuario(usuario);
                    bitacora.RegistrarBitacora($"{usuario.Identificacion} - Se registro un nuevo usuario correctamente","Media",usuario);
                    dvDAL.AltaDVV("Usuario");
                    scope.Complete();

                    return _id;
                }

            }
            catch 
            {
                throw new Exception(ErrorMessages.ERR001);
            }
        }

        public UsuarioBE Login(string user, string password)
        {
            try
            {
                if (string.IsNullOrEmpty(user)) throw new Exception(ErrorMessages.ERR002);
                if (string.IsNullOrEmpty(password)) throw new Exception(ErrorMessages.ERR002);

                UsuarioBE usuario = usuarioDAL.Login(Encriptador.Encriptar(user));

                if (usuario != null)
                    ValidarUsuarioLogin(usuario, password);


                if (usuario != null)
                {
                    if(usuario.Password == Encriptador.Hash(password))
                    {

                        _permisoService.GetComponenteUsuario(usuario);
                        usuario.Contador = 0;
                        usuario.DVH = dv.CalcularDV(usuario);                       
                        usuarioDAL.DesbloquearUsuario(usuario.id_usuario, usuario.DVH);
                        bitacora.RegistrarBitacora($"{user} - Inicio sesion correctamente", "Baja", usuario);
                        dvDAL.AltaDVV("Usuario");
                        return usuario;
                    }
                    else
                    {               
                        usuario.Contador += 1;
                        usuario.DVH = dv.CalcularDV(usuario);
                        usuarioDAL.SumarContadorbloqueo(usuario);
                        bitacora.RegistrarBitacora($"{user} - Inicio de sesion incorrecto", "Medio", usuario);
                        dvDAL.AltaDVV("Usuario");
                        throw new Exception(ErrorMessages.ERR012);
                    }
                    
                }
                else
                {
                    return null;
                }

                
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }
            

        }

        public List<UsuarioBE> GetUsuarios()
        {
            try
            {
               
               List<UsuarioBE>  usuarios = usuarioDAL.GetUsuarios();
                foreach (UsuarioBE usuario in usuarios)
                {
                    _permisoService.GetComponenteUsuario(usuario);
                }
                    
                return usuarios;

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }
        }

        public UsuarioBE GetUsuarioID(int user)
        {
            try
            {

               UsuarioBE usuario = usuarioDAL.GetUsuarioID(user);
                _permisoService.GetComponenteUsuario(usuario);
                return usuario;

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }
        }

        private void ValidarUsuario(UsuarioBE usuario, string password)
        {
            if (string.IsNullOrWhiteSpace(usuario.Password) || string.IsNullOrWhiteSpace(usuario.Email))
                throw new Exception(ErrorMessages.ERR002);

            if (string.IsNullOrWhiteSpace(usuario.Nombre) || string.IsNullOrWhiteSpace(usuario.Apellido))
                throw new Exception(ErrorMessages.ERR002);

            if (!ValidarFormatoPassword(password))
                throw new Exception(ErrorMessages.ERR017);
            
            if (usuario.Contador >= 3)
            {
                bitacora.RegistrarBitacora($"{Encriptador.Descencriptar(usuario.Email)} - Usuario Bloqueado", "Medio", usuario);
                throw new Exception(ErrorMessages.ERR013);
            }
                
        }

        private void ValidarUsuarioLogin(UsuarioBE usuario, string password)
        {

            if (usuario.Contador >= 3)
            {
                bitacora.RegistrarBitacora($"{Encriptador.Descencriptar(usuario.Email)} - Usuario Bloqueado", "Medio", usuario);
                throw new Exception(ErrorMessages.ERR013);
            }

        }

        private bool ValidarFormatoPassword(string password)
        {
            string regex = @"^(?=.*[A-Z])(?=.*[\W_]).{8,}$";
            return Regex.IsMatch(password, regex);
        }
    }
}
