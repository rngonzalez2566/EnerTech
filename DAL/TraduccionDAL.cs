using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using Newtonsoft.Json;

namespace DAL
{
    public class TraduccionDAL
    {
        private readonly string _filePath;

        public TraduccionDAL()
        {
            _filePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Traducciones", "Traducciones.json");
        }

        public Dictionary<string, Dictionary<string, string>> CargarTraducciones()
        {
            if (!File.Exists(_filePath))
            {
                throw new FileNotFoundException("Archivo de traducciones no encontrado.");
            }

            string json = File.ReadAllText(_filePath);
            return JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(json);
        }
    }
}
