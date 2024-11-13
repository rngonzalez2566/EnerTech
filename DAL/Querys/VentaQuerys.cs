using BE;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Querys
{
    public class VentaQuerys
    {
        public const string addVenta = "INSERT INTO VENTA(Fecha,Detalle,id_usuario,Total,IVA,TotalGravado,Facturado) "+
                                        "OUTPUT inserted.Id VALUES(@fecha, @detalle, @user, @total, @iva, @gravado,@fac)";
        public const string addDetalle_Venta = "INSERT INTO Detalle_Venta(id_venta,id_producto,Codigo,Descripcion,Cantidad,PrecioUnitario,Total,IVA,CodigoIVA) "+
                                                "OUTPUT inserted.Id VALUES(@venta, @prod, @cod, @descripcion, @cant, @PU, @tot, @iva, @codIVA)";

        public const string addRelated_Taxes = "INSERT INTO RelatedTaxes(codigoIVA,TasaIVA,BaseImponible,TotalIVA,id_venta)" +
                                                "OUTPUT inserted.Id VALUES(@cod,@tasa,@base,@iva,@venta)";
        public const string Get_Venta_User = "Select id,Fecha, Detalle,id_usuario,Total,IVA,TotalGravado, case when Estado = 'A' then 'Facturado' else 'Pendiente' end estado From venta where id_usuario = 4 order by fecha desc";
        public const string Get_Venta = "Select * From venta where id = @venta";
        public const string Get_Ventas = "Select * From venta order by fecha desc";
        public const string Get_Detalle_Venta = "Select * From Detalle_Venta where id_venta = @venta";
        public const string Get_Taxes_Venta = "Select * From RelatedTaxes where id_venta = @venta";
        public const string update_Venta = "update Venta set PuntoDeVenta = @pv, NumeroVenta = @nro, Estado = @estado, Observaciones = @obs, CodigoAutorizacion = @cod, FechaVtoCae = @fc, TipoAutorizacion = @ta, Facturado = @fac, TipoComprobante = @tc, QRData=@qr where Id = @venta";
        public const string update_Venta_rechazada = "update Venta set  Estado = @estado, Observaciones = @obs where Id = @venta";
        public const string update_reprocesar = "update Venta set  Estado = '', observaciones = '' where Id = @venta";

        public const string filtro_fechas = "SELECT * FROM venta WHERE(@fd IS NULL OR fecha >= @fd) AND(@fh IS NULL OR fecha <= @fh) " +
                                            "AND (@fac IS NULL OR facturado = @fac) ORDER BY fecha DESC";
    }
}
