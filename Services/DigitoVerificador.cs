using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public class DigitoVerificador
    {
        public int CalcularDV(object xObjeto)
        {
            int DVH = 0;
            //int xID = 0;
            //string xNombreID = "";
            Type t = xObjeto.GetType();
            PropertyInfo[] props = t.GetProperties();
            foreach (var prop in props)
            {

                if (prop.Name.Substring(0, 3).ToUpper() != "ID_")
                {
                    if (prop.Name.ToUpper() != "DVH")
                    {
                        if (prop.GetMethod.ReturnType.IsGenericType == false)
                        {
                            if (prop.SetMethod.IsVirtual == false)
                            {
                                if (prop.GetValue(xObjeto) != null)
                                {
                                    string xAtributo = prop.GetValue(xObjeto).ToString();
                                    for (int i = 0; i < xAtributo.Length; i++)
                                    {
                                        byte[] bytes = Encoding.ASCII.GetBytes(xAtributo.Substring(i, 1));
                                        int result = bytes[0];
                                        DVH = DVH + (result * (i + 1));

                                    }
                                }


                            }
                        }
                    }
                }
                else
                {
                    //xNombreID = prop.Name.ToUpper();
                    //xID = int.Parse(prop.GetValue(xObjeto).ToString());
                }
            }

            //string xConsulta = "SELECT ISNULL(SUM(DVH),0) DVH FROM " + xTabla + " WHERE " + xNombreID + " <> " + xID + " ";
            //DAL.Acceso acceso = new DAL.Acceso();
            //DataTable dt = acceso.ExecuteReader(xConsulta);
            //int dv = int.Parse(dt.Rows[0]["DVH"].ToString()) + DVH;
            //string xDVV = "UPDATE DigitoVerificador set valorDVV = " + dv + " where nombre_tabla = '" + xTabla + "' ";
            //string msg = acceso.ExecutenonQuery(xDVV);
            return DVH;
        }
    }
}
