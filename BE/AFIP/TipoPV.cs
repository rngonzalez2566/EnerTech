using System.Collections.Generic;
namespace BE.AFIP
{
  

    public class TipoPV
    {
        public string Codigo { get; set; }

        // Constructor privado para limitar la creación de instancias
        private TipoPV(string codigo)
        {
            Codigo = codigo;
        }

        // Lista estática de tipos de IVA predefinidos
        public static readonly List<TipoPV> TiposPV = new List<TipoPV>
        {
            new TipoPV("CAE"),      
            new TipoPV("CAEA"),     

        };

        // Método para obtener un TipoIVA por su código
        public static TipoPV ObtenerTipoPV(string codigo)
        {
            return TiposPV.Find(tipo => tipo.Codigo == codigo);
        }

        public static List<TipoPV> ObtenerListaPV()
        {
            return TiposPV;
        }
    }