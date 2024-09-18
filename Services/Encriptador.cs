using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public static class Encriptador
    {

        public static string Encriptar(string Valor)
        {
  
            byte[] textAsBytes = System.Text.Encoding.UTF8.GetBytes(Valor);
                
            return System.Convert.ToBase64String(textAsBytes);
            

        }

        public static string Descencriptar(string Valor)
        {

            byte[] textAsBytes = Convert.FromBase64String(Valor);
            
            return System.Text.Encoding.UTF8.GetString(textAsBytes);


        }

        public static string Hash(string Valor)
        {

            UnicodeEncoding codificar = new UnicodeEncoding();
            byte[] textobyte = codificar.GetBytes(Valor);
            SHA256 sha256 = new SHA256CryptoServiceProvider();
            byte[] tablaBytes = sha256.ComputeHash(textobyte);
            string passwordcifrada = Convert.ToBase64String(tablaBytes).ToString();
           
            return passwordcifrada;


        }

    }
}
