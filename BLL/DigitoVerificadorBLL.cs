using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using BE;

namespace BLL
{
    public class DigitoVerificadorBLL
    {
        DigitoVerificadorDAL dv = new DigitoVerificadorDAL();
        UsuarioBLL user = new UsuarioBLL();
        BitacoraBLL bit = new BitacoraBLL();
        public void RecalcularDigitos()
        {
       
            dv.RecalcularDigitos();
        }

        public bool VerificarDV()
        {
            try
            {
                UsuarioBE usuario = new UsuarioBE();
                usuario.id_usuario = 1;
                usuario.Nombre = "Sistema";
                bool xValido = true;


                var lista = new List<String>();
                lista = dv.VerificarDV();

                foreach (var registro in lista)
                {
                    bit.RegistrarBitacora(registro.ToString(), "ALTA", usuario);
                    xValido = false;
                }


                xValido = ValidarDVH("Usuario");
                return xValido;
            }
            catch 
            {
                return false;
            }
           
        }

        public bool ValidarDVH(string xTabla)
        {
            UsuarioBE us = new UsuarioBE();
            us.id_usuario = 1;
            us.Nombre = "Sistema";

            bool xValido = true;
            if (xTabla == "Usuario")
            {
                List<UsuarioBE> usuarios = new List<UsuarioBE>();
                usuarios = user.GetUsuarios();

                Services.DigitoVerificador dv = new Services.DigitoVerificador();

                foreach (var usuario in usuarios)
                {
                    int dvhCalculado = dv.CalcularDV(usuario);

                    if (usuario.DVH != dvhCalculado)
                    {
                        bit.RegistrarBitacora($"El registro con id = {usuario.id_usuario} de la tabla usuario no es válido su DVH", "ALTA", usuario);
                        xValido = false;
                    }
                }
            }

            return xValido;
        }


    }
}
