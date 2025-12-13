using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using BE;
using AfipWsfeClient;
using DAL;
using Newtonsoft.Json;

namespace BLL.AFIP
{
    public class FacturacionAFIP
    {
        VentaBLL _ventaService = new VentaBLL();
        tokenAFIP _tokenService = new tokenAFIP();
        VentaDAL _serviceVenta = new VentaDAL();
        DigitoVerificadorDAL dv = new DigitoVerificadorDAL();
        Services.DigitoVerificador sdv = new Services.DigitoVerificador();

        public async Task<VentaBE> GenerarFacturaAFIP(int idVenta)
        {
            VentaBE venta = null;

            try
            {
                venta = _ventaService.GetVenta(idVenta);

                Task<BE.AFIP.tokenAFIP> tokenTask = _tokenService.ObtenerOActualizarTokenAsync();
                BE.AFIP.tokenAFIP token = await tokenTask;

                var wsfeClient = new WsfeClient
                {
                    IsProdEnvironment = false,
                    Cuit = 20358545492,
                    Sign = token.sign,
                    Token = token.token
                };

                // Get next WSFE Comp. Number
                var response = await wsfeClient.FECompUltimoAutorizadoAsync(1, 6);
                var compNumber = response.Body.FECompUltimoAutorizadoResult.CbteNro + 1;

                // Build WSFE FECAERequest
                var ivaList = new List<AfipServiceReference.AlicIva>();
                foreach (RelatedTaxesBE taxes in venta.RelatedTaxes)
                {
                    ivaList.Add(new AfipServiceReference.AlicIva
                    {
                        BaseImp = (double)taxes.BaseImponible,
                        Id = taxes.codigoIVA,
                        Importe = (double)taxes.TotalIVA
                    });
                }

                var feCaeReq = new AfipServiceReference.FECAERequest
                {
                    FeCabReq = new AfipServiceReference.FECAECabRequest
                    {
                        CantReg = 1,
                        CbteTipo = 6,
                        PtoVta = 1
                    },
                    FeDetReq = new List<AfipServiceReference.FECAEDetRequest>
                    {
                        new AfipServiceReference.FECAEDetRequest
                        {
                            CbteDesde = compNumber,
                            CbteHasta = compNumber,
                            CbteFch = DateTime.Now.ToString("yyyyMMdd"),
                            Concepto = 1,
                            DocNro = 35854549,
                            DocTipo = 96,
                            ImpNeto = (double)venta.TotalGravado,
                            ImpTotal = (double)venta.Total,
                            MonCotiz = 1,
                            MonId = "PES",
                            CondicionIVAReceptorId = 5,
                            ImpIVA = (double)venta.IVA,
                            Iva = ivaList
                        }
                    }
                };

                // Call WSFE FECAESolicitar
                var compResult = await wsfeClient.FECAESolicitarAsync(feCaeReq);

                if (compResult?.Body?.FECAESolicitarResult?.FeDetResp != null &&
                    compResult.Body.FECAESolicitarResult.FeDetResp.Count > 0)
                {
                    var detalle = compResult.Body.FECAESolicitarResult.FeDetResp[0];

                    // Verificar si la factura fue aprobada
                    if (detalle.Resultado == "A")
                    {
                        venta.Estado = "A";
                        venta.Observaciones = "Autorizada";
                        venta.TipoAutorizacion = "CAE";
                        venta.FechaVtoCae = DateTime.ParseExact(
                            detalle.CAEFchVto,
                            "yyyyMMdd",
                            System.Globalization.CultureInfo.InvariantCulture
                        );
                        venta.PuntoDeVenta = 1;
                        venta.NumeroVenta = int.Parse(detalle.CbteDesde.ToString());
                        venta.CodigoAutorizacion = long.Parse(detalle.CAE);
                        venta.Facturado = true;
                        venta.TipoComprobante = "6";
                        venta.QRData = GenerarStringQR(venta);

                        _serviceVenta.ActualizarVenta(venta);
                        dv.RecalcularDigitosVenta("Venta", sdv);
                    }
                    else if (detalle.Resultado == "R")
                    {
                        venta.Estado = "R";

                        if (detalle.Observaciones != null && detalle.Observaciones.Count > 0)
                        {
                            foreach (var obs in detalle.Observaciones)
                            {
                                venta.Observaciones = obs.Code + " - " + obs.Msg;
                                break;
                            }
                        }

                        _serviceVenta.ActualizarVentaRechazada(venta);
                    }
                }
                else
                {
                    // Respuesta inválida / vacía pero sin excepción: marcamos rechazada
                    venta.Estado = "R";
                    venta.Observaciones = "Sin respuesta de AFIP";
                    _serviceVenta.ActualizarVentaRechazada(venta);
                }

                return venta;
            }
            catch (Exception ex)
            {
                // ✅ MODO PRUEBAS: si AFIP no responde (sin internet/puerto/caído), autorizo por CAEA mock
                // Importante: esto es SOLO para DEV/QA (como vos dijiste)
                if (venta == null)
                    venta = _ventaService.GetVenta(idVenta);

                venta.Estado = "A";
                venta.Observaciones = "Autorizada por contingencia CAEA" + ex.Message;
                venta.TipoAutorizacion = "CAEA";

                // Fecha del momento
                venta.FechaVtoCae = DateTime.Now;

                // Datos fijos mock
                venta.PuntoDeVenta = 2;
                venta.NumeroVenta = 10;                 // nro dummy
                venta.CodigoAutorizacion = 1256771254799125123; // CAEA dummy

                venta.Facturado = true;
                venta.TipoComprobante = "6";
                venta.QRData = GenerarStringQR(venta);

                _serviceVenta.ActualizarVenta(venta);
                dv.RecalcularDigitosVenta("Venta", sdv);

                return venta;
            }
        }

        public static string GenerarStringQR(VentaBE venta)
        {
            var qrData = new
            {
                ver = 1,
                fecha = venta.Fecha.ToString("yyyy-MM-dd"),
                cuit = 20358545492,
                ptoVta = venta.PuntoDeVenta,
                tipoCmp = venta.TipoComprobante,
                nroCmp = venta.NumeroVenta,
                importe = venta.Total,
                moneda = "PES",
                ctz = 1.00,
                tipoDocRec = 96,
                nroDocRec = venta.usuario.Identificacion,
                tipoCodAut = "E",
                codAut = venta.CodigoAutorizacion
            };

            string jsonString = JsonConvert.SerializeObject(qrData);
            string qrString = Convert.ToBase64String(Encoding.UTF8.GetBytes(jsonString));
            return $"https://www.afip.gob.ar/fe/qr/?p={qrString}";
        }
    }
}
