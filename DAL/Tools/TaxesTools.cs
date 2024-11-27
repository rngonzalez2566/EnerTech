using BE.AFIP;
using BE;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Tools
{
    public  class TaxesTools
    {
        public static RelatedTaxesBE FillObjectTaxes(DataRow dr)
        {
            RelatedTaxesBE taxes = new RelatedTaxesBE();


            if (dr.Table.Columns.Contains("id_relatedtaxes") && !Convert.IsDBNull(dr["id_relatedtaxes"]))
                taxes.id_relatedtaxes = Convert.ToInt32(dr["id_relatedtaxes"]);

            if (dr.Table.Columns.Contains("CodigoIVA") && !Convert.IsDBNull(dr["CodigoIVA"]))
                taxes.codigoIVA = Convert.ToInt32(dr["CodigoIVA"]);

            if (dr.Table.Columns.Contains("DVH") && !Convert.IsDBNull(dr["DVH"]))
                taxes.DVH = Convert.ToInt32(dr["DVH"]);


            if (dr.Table.Columns.Contains("TasaIVA") && !Convert.IsDBNull(dr["TasaIVA"]))
                taxes.TasaIVA = Convert.ToDecimal(dr["TasaIVA"]);

            if (dr.Table.Columns.Contains("BaseImponible") && !Convert.IsDBNull(dr["BaseImponible"]))
                taxes.BaseImponible = Convert.ToDecimal(dr["BaseImponible"]);

            if (dr.Table.Columns.Contains("TotalIVA") && !Convert.IsDBNull(dr["TotalIVA"]))
                taxes.TotalIVA = Convert.ToDecimal(dr["TotalIVA"]);

            

            return taxes;
        }

        public static List<RelatedTaxesBE> FillListTaxes(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectTaxes(dr)).ToList();
        }
    }
}
