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

                    int _id = usuarioDAL.RegistrarUsuario(usuario);

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
                UsuarioBE usuario = usuarioDAL.Login(Encriptador.Encriptar(user));
                ValidarUsuario(usuario, password);

                if (usuario != null)
                {
                    if(usuario.Password == Encriptador.Hash(password))
                    {

                        usuarioDAL.DesbloquearUsuario(usuario.Id);
                        return usuario;
                    }
                    else
                    {
                        usuarioDAL.SumarContadorbloqueo(usuario);
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

        private void ValidarUsuario(UsuarioBE usuario, string password)
        {
            if (string.IsNullOrWhiteSpace(usuario.Password) || string.IsNullOrWhiteSpace(usuario.Email))
                throw new Exception(ErrorMessages.ERR002);

            if (string.IsNullOrWhiteSpace(usuario.Nombre) || string.IsNullOrWhiteSpace(usuario.Apellido))
                throw new Exception(ErrorMessages.ERR002);

            if (!ValidarFormatoPassword(password))
                throw new Exception(ErrorMessages.ERR017);
            
            if (usuario.Contador >= 3)
                throw new Exception(ErrorMessages.ERR013);
        }

        private bool ValidarFormatoPassword(string password)
        {
            string regex = @"^(?=.*[A-Z])(?=.*[\W_]).{8,}$";
            return Regex.IsMatch(password, regex);
        }
    }
}
