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
        public int RegistrarUsuario(UsuarioBE usuario)
        {
            ValidarUsuario(usuario);
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    usuario.Email = Encriptador.Encriptar(usuario.Email);
                    usuario.Nombre = Encriptador.Encriptar(usuario.Nombre);
                    usuario.Apellido = Encriptador.Encriptar(usuario.Apellido);
                    usuario.Password = Encriptador.Hash(usuario.Password);

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

        private void ValidarUsuario(UsuarioBE usuario)
        {
            if (string.IsNullOrWhiteSpace(usuario.Password) || string.IsNullOrWhiteSpace(usuario.Email))
                throw new Exception(ErrorMessages.ERR002);

            if (string.IsNullOrWhiteSpace(usuario.Nombre) || string.IsNullOrWhiteSpace(usuario.Apellido))
                throw new Exception(ErrorMessages.ERR002);

            if (!ValidarFormatoPassword(usuario.Password))
                throw new Exception(ErrorMessages.ERR017);

        }

        private bool ValidarFormatoPassword(string password)
        {
            string regex = @"^(?=.*[A-Z])(?=.*[\W_]).{8,}$";
            return Regex.IsMatch(password, regex);
        }
    }
}
