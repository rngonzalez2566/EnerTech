using System.Collections.Generic;

namespace BE.AFIP
{
    public class CodigoIVA
    {
        public int Codigo { get; set; }
        public decimal Porcentaje { get; set; }

        // Constructor privado para limitar la creación de instancias
        private CodigoIVA(int codigo, decimal porcentaje)
        {
            Codigo = codigo;
            Porcentaje = porcentaje;
        }

        // Lista estática de tipos de IVA predefinidos
        public static readonly List<CodigoIVA> TiposIVA = new List<CodigoIVA>
        {
            new CodigoIVA(3, 0.0m),      // Código 1: 0%
            new CodigoIVA(4, 10.5m),     // Código 2: 21%
            new CodigoIVA(5, 21.0m),     // Código 3: 10.5%
            new CodigoIVA(6, 27.0m),
            new CodigoIVA(8, 5.0m),
            new CodigoIVA(9, 2.5m),
           
        };

        // Método para obtener un TipoIVA por su código
        public static CodigoIVA ObtenerTipoIVA(int codigo)
        {
            return TiposIVA.Find(tipo => tipo.Codigo == codigo);
        }

        public static List<CodigoIVA> ObtenerListaIVA()
        {
            return TiposIVA;
        }
    }
}