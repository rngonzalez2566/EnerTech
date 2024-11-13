using System;
using System.IO;
using System.Net;
using System.Text;
using System.Xml;
using System.Collections.Generic;
using AfipWsfeClient;
using System.Threading.Tasks;
using System.Transactions;
using DAL.AFIP;
using AfipLoginCmsServiceReference;
using Newtonsoft.Json;
using System.Security.Cryptography.X509Certificates;
using System.Security;
using System.ServiceModel;


namespace BLL.AFIP
{
    public class tokenAFIP
    {
        public uint UniqueId;
        public DateTime GenerationTime;
        public DateTime ExpirationTime;
        public string Service;
        public string Sign;
        public string Token;
        public XmlDocument XmlLoginTicketRequest = null;
        public XmlDocument XmlLoginTicketResponse = null;
        public string CertificatePath;
        public string XmlStrLoginTicketRequestTemplate = "<loginTicketRequest><header><uniqueId></uniqueId><generationTime></generationTime><expirationTime></expirationTime></header><service></service></loginTicketRequest>";
        private bool VerboseMode = true;
        private static uint GlobalUniqueID = 0u;
        public bool IsProdEnvironment { get; set; } = false;
        public string WsaaUrlHomologation { get; set; } = "https://wsaahomo.afip.gov.ar/ws/services/LoginCms";


        public string WsaaUrlProd { get; set; } = "https://wsaa.afip.gov.ar/ws/services/LoginCms";


        public string TicketCacheFolderPath { get; set; } = "";
        private readonly string certPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Certificados", "afip.p12"); // Ruta completa del archivo .pfx de tu certificado
        private readonly string certPassword = "afip123"; // Contraseña del certificado
        private readonly string service = "wsfe"; // Nombre del servicio, por ejemplo, "wsfe" para facturación electrónica

       AfipDAL _tokenDAL = new AfipDAL();

        public async Task<BE.AFIP.tokenAFIP> ObtenerOActualizarTokenAsync()
        {
            try
            {
                // Obtener el token desde la base de datos
                BE.AFIP.tokenAFIP token = _tokenDAL.obtenerTicketDB();

                // Verificar si el token es nulo o si está próximo a expirar
                if (token == null || token.FechaExpiracion.AddMinutes(-10) < DateTime.Now)
                {
                    // Generar un nuevo token
                    BE.AFIP.tokenAFIP nuevoToken = await GetLoginTicketAsync();

                 

                    using (TransactionScope scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
                    {
                        // Guardar el nuevo token en la base de datos
                        _tokenDAL.addLoginTicketDB(nuevoToken);
                        scope.Complete();
                    }

                    return nuevoToken;
                }
                else
                {
                    // Retornar el token existente si aún es válido
                    return token;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener o actualizar el token: " + ex.Message);
            }
        }

      
        public async Task<BE.AFIP.tokenAFIP> GetLoginTicketAsync()
        {
            try
            {
                // Get Login Ticket
                var loginClient = new LoginCmsClient { IsProdEnvironment = false };
                BE.AFIP.tokenAFIP ticket = await LoginCmsAsyncA(service, certPath, certPassword, false);
                
             
                // Aquí puedes devolver el Token obtenido si es necesario
                return ticket;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el Ticket de AFIP: " + ex.Message);
            }
        }

        public async Task<BE.AFIP.tokenAFIP> LoginCmsAsyncA(string service, string x509CertificateFilePath, string password, bool verbose)
        {
            // Define una ruta segura para almacenar el archivo ticket.json en la carpeta AppData del usuario
            //string appDataPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "AFIP");
            //Directory.CreateDirectory(appDataPath); // Crea la carpeta si no existe
            //string ticketCacheFile = Path.Combine(appDataPath, $"{service}ticket.json");

            //string appDataPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "AFIP");
            //Directory.CreateDirectory(appDataPath); // Crea la carpeta si no existe
            //string ticketCacheFile = Path.Combine(appDataPath, $"{service}ticket.json");

            //// Comprobación si el archivo existe y si el ticket es válido
            //if (File.Exists(ticketCacheFile))
            //{
            //    string ticketJson = File.ReadAllText(ticketCacheFile);
            //    WsaaTicket ticket = JsonConvert.DeserializeObject<WsaaTicket>(ticketJson);
            //    if (DateTime.UtcNow <= ticket.ExpirationTime)
            //    {
            //        return ticket;
            //    }
            //}

            // Resto del código permanece igual...
            CertificatePath = x509CertificateFilePath;
            VerboseMode = verbose;
            X509CertificateManager.VerboseMode = verbose;

            try
            {
                GlobalUniqueID++;
                XmlLoginTicketRequest = new XmlDocument();
                XmlLoginTicketRequest.LoadXml(XmlStrLoginTicketRequestTemplate);
                XmlNode xmlNodoUniqueId = XmlLoginTicketRequest.SelectSingleNode("//uniqueId");
                XmlNode xmlNodoGenerationTime = XmlLoginTicketRequest.SelectSingleNode("//generationTime");
                XmlNode xmlNodoExpirationTime = XmlLoginTicketRequest.SelectSingleNode("//expirationTime");
                XmlNode xmlNodoService = XmlLoginTicketRequest.SelectSingleNode("//service");
                xmlNodoGenerationTime.InnerText = DateTime.Now.AddMinutes(-10.0).ToString("s");
                xmlNodoExpirationTime.InnerText = DateTime.Now.AddMinutes(10.0).ToString("s");
                xmlNodoUniqueId.InnerText = Convert.ToString(GlobalUniqueID);
                xmlNodoService.InnerText = service;
                Service = service;
            }
            catch (Exception ex3)
            {
                throw new Exception("[ObtenerLoginTicketResponse]***Error GENERANDO el LoginTicketRequest : " + ex3.Message + ex3.StackTrace);
            }

            string base64SignedCms;
            try
            {
                SecureString securePassword = new NetworkCredential("", password).SecurePassword;
                securePassword.MakeReadOnly();
                X509Certificate2 certFirmante = X509CertificateManager.GetCertificateFromFile(CertificatePath, securePassword);
                Encoding msgEncoding = Encoding.UTF8;
                byte[] msgBytes = msgEncoding.GetBytes(XmlLoginTicketRequest.OuterXml);
                byte[] encodedSignedCms = X509CertificateManager.SignMessageBytes(msgBytes, certFirmante);
                base64SignedCms = Convert.ToBase64String(encodedSignedCms);
            }
            catch (Exception ex4)
            {
                throw new Exception("[ObtenerLoginTicketResponse]***Error FIRMANDO el LoginTicketRequest : " + ex4.Message);
            }

            string loginTicketResponse;
            try
            {
                LoginCMSClient wsaaService = new LoginCMSClient();
                wsaaService.Endpoint.Address = new EndpointAddress(IsProdEnvironment ? WsaaUrlProd : WsaaUrlHomologation);
                loginTicketResponse = (await wsaaService.loginCmsAsync(base64SignedCms)).loginCmsReturn;
            }
            catch (Exception ex2)
            {
                throw new Exception("[ObtenerLoginTicketResponse]***Error INVOCANDO al servicio WSAA : " + ex2.Message);
            }

            try
            {
                XmlLoginTicketResponse = new XmlDocument();
                XmlLoginTicketResponse.LoadXml(loginTicketResponse);
                UniqueId = uint.Parse(XmlLoginTicketResponse.SelectSingleNode("//uniqueId").InnerText);
                GenerationTime = DateTime.Parse(XmlLoginTicketResponse.SelectSingleNode("//generationTime").InnerText);
                ExpirationTime = DateTime.Parse(XmlLoginTicketResponse.SelectSingleNode("//expirationTime").InnerText);
                Sign = XmlLoginTicketResponse.SelectSingleNode("//sign").InnerText;
                Token = XmlLoginTicketResponse.SelectSingleNode("//token").InnerText;
            }
            catch (Exception ex)
            {
                throw new Exception("[ObtenerLoginTicketResponse]***Error ANALIZANDO el LoginTicketResponse : " + ex.Message);
            }


            BE.AFIP.tokenAFIP ticketResponse = new BE.AFIP.tokenAFIP
            {
                sign = Sign,
                token = Token,
                FechaExpiracion = ExpirationTime,
                FechaGeneracion = GenerationTime,
                codigo = UniqueId

            };

            // Guarda el ticket en la nueva ubicación
            //File.WriteAllText(ticketCacheFile, JsonConvert.SerializeObject(ticketResponse));

            return ticketResponse;
        }
    }
}
