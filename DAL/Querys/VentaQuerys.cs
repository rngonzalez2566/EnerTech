using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Querys
{
    public class VentaQuerys
    {
        public const string addVenta = "INSERT INTO VENTA(Fecha,Detalle,id_usuario,Total,IVA,TotalGravado) "+
                                        "OUTPUT inserted.Id VALUES(@fecha, @detalle, @user, @total, @iva, @gravado)";
        public const string addDetalle_Venta = "INSERT INTO Detalle_Venta(id_venta,id_producto,Codigo,Descripcion,Cantidad,PrecioUnitario,Total,IVA,CodigoIVA) "+
                                                "OUTPUT inserted.Id VALUES(@venta, @prod, @cod, @descripcion, @cant, @PU, @tot, @iva, @codIVA)";

        public const string addRelated_Taxes = "INSERT INTO RelatedTaxes(codigoIVA,TasaIVA,BaseImponible,TotalIVA,id_venta)" +
                                                "OUTPUT inserted.Id VALUES(@cod,@tasa,@base,@iva,@venta)";
        public const string Get_Venta_User = "Select * From venta where id_usuario = @user order by fecha desc";
        public const string Get_Detalle_Venta = "Select * From Detalle_Venta where id_venta = @venta";
    }
}
