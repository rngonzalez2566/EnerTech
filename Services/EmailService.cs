using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Net.Mail;


namespace Services
{
    public class EmailService
    {
        public void EnviarFacturaPdf(string toEmail, string subject, string bodyHtml, byte[] pdfBytes, string pdfFileName)
        {
            if (string.IsNullOrWhiteSpace(toEmail))
                throw new Exception("El destinatario (email) está vacío.");

            string host = ConfigurationManager.AppSettings["SmtpHost"];
            int port = int.Parse(ConfigurationManager.AppSettings["SmtpPort"]);
            string user = ConfigurationManager.AppSettings["SmtpUser"];
            string pass = ConfigurationManager.AppSettings["SmtpPass"];
            string from = ConfigurationManager.AppSettings["SmtpFrom"];

            using (var msg = new MailMessage())
            {
                msg.From = new MailAddress(from, "EnerTech");
                msg.To.Add(toEmail);
                msg.Subject = subject;
                msg.Body = bodyHtml;
                msg.IsBodyHtml = true;

                // Adjuntar PDF
                using (var ms = new MemoryStream(pdfBytes))
                {
                    var attachment = new Attachment(ms, pdfFileName, "application/pdf");
                    msg.Attachments.Add(attachment);

                    using (var smtp = new SmtpClient(host, port))
                    {
                        smtp.EnableSsl = true;
                        smtp.Credentials = new NetworkCredential(user, pass);
                        smtp.Send(msg);
                    }
                }
            }
        }

        public void EnviarEmail(string toEmail, string subject, string bodyHtml)
        {
            if (string.IsNullOrWhiteSpace(toEmail))
                throw new Exception("El destinatario (email) está vacío.");

            string host = ConfigurationManager.AppSettings["SmtpHost"];
            int port = int.Parse(ConfigurationManager.AppSettings["SmtpPort"]);
            string user = ConfigurationManager.AppSettings["SmtpUser"];
            string pass = ConfigurationManager.AppSettings["SmtpPass"];
            string from = ConfigurationManager.AppSettings["SmtpFrom"];

            using (var msg = new MailMessage())
            {
                msg.From = new MailAddress(from, "EnerTech");
                msg.To.Add(toEmail);
                msg.Subject = subject;
                msg.Body = bodyHtml;
                msg.IsBodyHtml = true;

                using (var smtp = new SmtpClient(host, port))
                {
                    smtp.EnableSsl = true;
                    smtp.Credentials = new NetworkCredential(user, pass);
                    smtp.Send(msg);
                }
            }
        }
        }
}
