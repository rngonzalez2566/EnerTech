﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Services;
using iTextSharp.text;
using iTextSharp.text.pdf;
using BE;
using System.Data;
using System.Linq;
using QRCoder;

namespace UI.WebServices
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class GeneraPdfAfip : System.Web.Services.WebService
    {
       
        /// <summary>
        /// Información de la empresa
        /// </summary>
        public class BusinessInfo
        {
            /// <summary>
            /// razón social de la empresa
            /// </summary>
            public string BusinessName { get; set; }
            /// <summary>
            /// domicilio comercial de la empresa
            /// </summary>
            public string Address { get; set; }
            /// <summary>
            /// condicion iva de la empresa
            /// </summary>
            public string IVACondition { get; set; }
            /// <summary>
            /// cuit de la empresa
            /// </summary>
            public long CUIT { get; set; }
            /// <summary>
            /// ingresos brutos
            /// </summary>
            public string GrossIncome { get; set; }

            /// <summary>
            /// fecha de inicio de actividades
            /// </summary>
            public DateTime InitialActivities { get; set; }
            /// <summary>
            /// Imagen Logo de la empresa que emite la factura
            /// </summary>
            public string PathImage { get; set; }
        }
        /// <summary>
        /// Información del cliente
        /// </summary>
        public class ClientInfo
        {
            /// <summary>
            /// razón social de la empresa
            /// </summary>
            public string BusinessName { get; set; }
            /// <summary>
            /// Nombre del cliente, se usa en caso que no tenga razón social
            /// </summary>
            public string FirstName { get; set; }
            /// <summary>
            /// Apellido del cliente, se usa en caso que no tenga raazón social
            /// </summary>
            public string LastName { get; set; }
            /// <summary>
            /// domicilio comercial de la empresa
            /// </summary>
            public string Address { get; set; }
            /// <summary>
            /// condicion iva del cliente
            /// </summary>
            public string IVACondition { get; set; }
            /// <summary>
            /// cuit de la empresa
            /// </summary>
            public long CUIT { get; set; }
            /// <summary>
            /// Condición de venta
            /// </summary>
            public string SaleCondition { get; set; }
        }
        [WebMethod]
        public static byte[] ReceipToPdf(BusinessInfo busineesInfo, ClientInfo clientInfo, VentaBE venta)
        {
            var doc = new iTextSharp.text.Document(iTextSharp.text.PageSize.A4, 10, 10, 270, 140);
            //create PdfReader object to read from the existing document
            using (MemoryStream output = new MemoryStream())
            {
                Totals totals = new Totals();
                PdfWriter writer = PdfWriter.GetInstance(doc, output);
                //open the document for writing 
                iTextSharp.text.Image imageLogo = iTextSharp.text.Image.GetInstance(busineesInfo.PathImage);
                //System.Drawing.Image img = Afip.Barcode.GenerateITFImage("12345678945687", 800, 100, 2); //cod barra
                //iTextSharp.text.Image CodBarra;
                //using (MemoryStream memory = new MemoryStream())
                //{
                //    img.Save(memory, System.Drawing.Imaging.ImageFormat.Png);
                //    CodBarra = iTextSharp.text.Image.GetInstance(memory.ToArray());
                //}
                writer.PageEvent = new Headers()//se agrega el header del documento
                {
                    BusinessInfo = busineesInfo,
                    Image = imageLogo,
                    ClientInfo = clientInfo,
                    Venta = venta
                };
                writer.PageEvent = new Footer() //se agrega el footer del documento
                {
                    //CodBarra = CodBarra,
                    Venta = venta
                };
                doc.Open();
                DataTable dt = CreateDataTable(venta);

                PdfPTable table = new PdfPTable(dt.Columns.Count);
                table.TotalWidth = doc.PageSize.Width - doc.LeftMargin - doc.RightMargin;
                table.HeaderRows = 1; // muestra el header de la table en todas las paginas
                table.LockedWidth = true;

                float[] widths = { 6F, 30F, 7F, 8F, 8F, 6F, 9F, 7F, 10F };
                table.SetWidths(widths);
                PdfPCell cell;
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    string cellText = dt.Columns[i].ColumnName;
                    cell = new PdfPCell();
                    cell.Phrase = new Phrase(cellText, new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1));
                    cell.BackgroundColor = new BaseColor(System.Drawing.ColorTranslator.FromHtml("#C8C8C8"));
                    cell.HorizontalAlignment = Element.ALIGN_CENTER;
                    cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                    cell.Padding = 1;
                    table.AddCell(cell);
                }

                table.HeaderRows = 2;
                table.FooterRows = 1;

                //agrego una celda con el evento Subtotal
                PdfPCell cellE = new PdfPCell(new Phrase("Subtotal"));
                cellE.Colspan = 7;
                table.AddCell(cellE);
                cellE = new PdfPCell();
                cellE.Colspan = 2;
                cellE.CellEvent = new SubTotal(totals);
                table.AddCell(cellE);

                //contenido de la tabla
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        cell = new PdfPCell();
                        cell.Border = PdfPCell.NO_BORDER;
                        if (j == 2 || j == 4 || j == 5 || j == 6 || j == 8)
                            cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                        if (j == 3 || j == 7)
                            cell.HorizontalAlignment = Element.ALIGN_CENTER;
                        cell.Phrase = new Phrase(dt.Rows[i][j].ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F));
                        if (j == 8)
                            cell.CellEvent = new SubTotal(totals, decimal.Parse(dt.Rows[i][j].ToString()));
                        table.AddCell(cell);
                    }
                }
                doc.Add(table);

                #region CuadroFinal
                //cuadro de impuestos y totales
                PdfPTable tbCuadroFinal = new PdfPTable(new float[] { 60, 40 });
                tbCuadroFinal.TotalWidth = doc.PageSize.Width - doc.LeftMargin - doc.RightMargin;
                tbCuadroFinal.LockedWidth = true;

                //PdfPCell cell;

                //otros impuestos
                PdfPTable tbOtrosImpuestos = new PdfPTable(new float[] { 50, 20, 15, 15 });
                var dtOtrosImpuestos = OtrosImpuestos();
                for (int i = 0; i < dtOtrosImpuestos.Columns.Count; i++)
                {
                    string cellText = dtOtrosImpuestos.Columns[i].ColumnName;
                    cell = new PdfPCell();
                    cell.Phrase = new Phrase(cellText, new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1));
                    cell.BackgroundColor = new BaseColor(System.Drawing.ColorTranslator.FromHtml("#C8C8C8"));
                    cell.HorizontalAlignment = Element.ALIGN_LEFT;
                    cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                    cell.Padding = 1;
                    tbOtrosImpuestos.AddCell(cell);
                }
                for (int i = 0; i < dtOtrosImpuestos.Rows.Count; i++)
                {
                    for (int j = 0; j < dtOtrosImpuestos.Columns.Count; j++)
                    {
                        cell = new PdfPCell();
                        cell.Border = PdfPCell.NO_BORDER;
                        if (j == 0)
                            cell.HorizontalAlignment = Element.ALIGN_LEFT;
                        if (j == 3)
                            cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                        cell.Phrase = new Phrase(dtOtrosImpuestos.Rows[i][j].ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F));
                        tbOtrosImpuestos.AddCell(cell);
                    }
                }
                cell = new PdfPCell(new Phrase("Importe Otros Tributos", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.Border = PdfPCell.NO_BORDER;
                cell.Colspan = 3;
                tbOtrosImpuestos.AddCell(cell);
                cell = new PdfPCell(new Phrase("0.0", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.Border = PdfPCell.NO_BORDER;
                tbOtrosImpuestos.AddCell(cell);

                //detalle totales e IVA
                PdfPTable tbTotales = new PdfPTable(new float[] { 60, 40 });
                tbTotales.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell = new PdfPCell(new Phrase("Importe Neto Gravado:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);
                cell = new PdfPCell(new Phrase("$"+venta.TotalGravado.ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);

                cell = new PdfPCell(new Phrase("IVA 27%:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);
                cell = new PdfPCell(new Phrase(venta.RelatedTaxes.FirstOrDefault(t => t.codigoIVA == 6)?.TotalIVA.ToString("C") ?? "$0,00", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);

                cell = new PdfPCell(new Phrase("IVA 21%:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);
                cell = new PdfPCell(new Phrase( venta.RelatedTaxes.FirstOrDefault(t => t.codigoIVA == 5)?.TotalIVA.ToString("C") ?? "$0,00", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);

                cell = new PdfPCell(new Phrase("IVA 10.5%:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);
                cell = new PdfPCell(new Phrase(venta.RelatedTaxes.FirstOrDefault(t => t.codigoIVA == 4)?.TotalIVA.ToString("C") ?? "$0,00", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);

                cell = new PdfPCell(new Phrase("IVA 5%:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);
                cell = new PdfPCell(new Phrase(venta.RelatedTaxes.FirstOrDefault(t => t.codigoIVA == 8)?.TotalIVA.ToString("C") ?? "$0,00", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);

                cell = new PdfPCell(new Phrase("IVA 2.5%:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);
                cell = new PdfPCell(new Phrase(venta.RelatedTaxes.FirstOrDefault(t => t.codigoIVA == 9)?.TotalIVA.ToString("C") ?? "$0,00", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);

                cell = new PdfPCell(new Phrase("IVA 0%:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);
                cell = new PdfPCell(new Phrase(venta.RelatedTaxes.FirstOrDefault(t => t.codigoIVA == 3)?.TotalIVA.ToString("C") ?? "$0,00", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);

                cell = new PdfPCell(new Phrase("Importe Otros Tributos:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);
                cell = new PdfPCell(new Phrase("$0,00", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8.6F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);

                cell = new PdfPCell(new Phrase("Importe Total:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);
                cell = new PdfPCell(new Phrase("$"+venta.Total.ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10F, 1)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                cell.Border = PdfPCell.NO_BORDER;
                tbTotales.AddCell(cell);

                tbCuadroFinal.AddCell(tbOtrosImpuestos);
                tbCuadroFinal.AddCell(tbTotales);
                tbCuadroFinal.SpacingBefore = 50f;
                doc.Add(tbCuadroFinal);
                //tbCuadroFinal.WriteSelectedRows(0, -1, doc.LeftMargin, writer.PageSize.GetTop(doc.TopMargin) + 255, writer.DirectContent);
                //tbCuadroFinal.WriteSelectedRows(0, -1, doc.LeftMargin,table.CalculateHeights() - 255, writer.DirectContent);
                #endregion

                doc.Close();
                return output.ToArray();
                //Response.Clear();
                //Response.ContentType = "application/pdf";
                //Response.AppendHeader("Content-Disposition", "inline; filename=" + "Mi_pdf" + ".pdf"); //attachment
                //Response.ContentType = "application/pdf";
                //Response.BinaryWrite();
                //Response.End();
            }
        }

        /// <summary>
        /// Encabezado del pdf
        /// </summary>
        class Headers : PdfPageEventHelper
        {
            public BusinessInfo BusinessInfo { get; set; }
            public ClientInfo ClientInfo { get; set; }
            public iTextSharp.text.Image Image { get; set; }
            public VentaBE Venta { get; set; } // Agregar propiedad para venta

            public override void OnEndPage(PdfWriter writer, Document document)
            {
                PdfPTable tbHeader = new PdfPTable(1);
                tbHeader.TotalWidth = document.PageSize.Width - document.LeftMargin - document.RightMargin;
                tbHeader.LockedWidth = true;
                //tbHeader.DefaultCell.Border = 0;

                PdfPCell cell = new PdfPCell(new Paragraph("ORIGINAL", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 16F, Font.BOLD)));
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                cell.Padding = 5;
                //cell.Border = 0;
                tbHeader.AddCell(cell);
                PdfPTable tbEmpresa = new PdfPTable(2);
                tbEmpresa.DefaultCell.Border = 0;
                #region EmpresaIzq
                PdfPTable tbEmpresaIzq = new PdfPTable(1);
                tbEmpresaIzq.DefaultCell.Border = 0;
                //imagen
                Image.ScaleToFit(150, 75);
                cell = new PdfPCell(Image);
                cell.Border = PdfPCell.NO_BORDER;
                cell.HorizontalAlignment = Element.ALIGN_LEFT;
                cell.Padding = 5;
                tbEmpresaIzq.AddCell(cell);
                //fin imagen
                //primer renglon
                PdfPTable tbRazonSocial = new PdfPTable(new float[] { 25f, 75f });
                tbRazonSocial.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Razón Social:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbRazonSocial.AddCell(cell);
                cell = new PdfPCell(new Paragraph(BusinessInfo.BusinessName.ToUpper(), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbRazonSocial.AddCell(cell);
                tbEmpresaIzq.AddCell(tbRazonSocial);
                //fin primer renglon
                //segundo renglon
                PdfPTable tbDomicilioComer = new PdfPTable(new float[] { 35f, 65f });
                tbDomicilioComer.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Domicilio Comercial:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbDomicilioComer.AddCell(cell);
                cell = new PdfPCell(new Paragraph(BusinessInfo.Address, new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbDomicilioComer.AddCell(cell);
                tbEmpresaIzq.AddCell(tbDomicilioComer);
                //fin segundo renglon
                //tercer renglon
                PdfPTable tbCondiIva = new PdfPTable(new float[] { 40f, 60f });
                tbCondiIva.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Condicion frente al IVA:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbCondiIva.AddCell(cell);
                cell = new PdfPCell(new Paragraph(BusinessInfo.IVACondition, new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbCondiIva.AddCell(cell);
                tbEmpresaIzq.AddCell(tbCondiIva);
                //fin tercer renglon
                #endregion
                #region EmpresaDer
                float paddingLeftEmpDer = 40f;
                PdfPTable tbEmpresaDer = new PdfPTable(1);
                tbEmpresaDer.DefaultCell.Border = 0;

                //primer renglon
                PdfPTable tbComprobanteTipo = new PdfPTable(1);
                tbRazonSocial.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Factura B", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 18F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 15;
                cell.PaddingTop = 10;
                cell.PaddingLeft = paddingLeftEmpDer;
                tbComprobanteTipo.AddCell(cell);
                tbEmpresaDer.AddCell(tbComprobanteTipo);
                //fin primer renglon
                //segundo renglon
                PdfPTable tbPVentaCNum = new PdfPTable(new float[] { 45, 15, 25, 20 });
                tbPVentaCNum.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Punto de Venta:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                cell.PaddingLeft = paddingLeftEmpDer;
                tbPVentaCNum.AddCell(cell);
                cell = new PdfPCell(new Paragraph(string.Format("{0:00000}", 1), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbPVentaCNum.AddCell(cell);
                cell = new PdfPCell(new Paragraph("Comp. Nro:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbPVentaCNum.AddCell(cell);
                cell = new PdfPCell(new Paragraph(string.Format("{0:00000000}", Venta.NumeroVenta), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbPVentaCNum.AddCell(cell);
                tbEmpresaDer.AddCell(tbPVentaCNum);
                //fin segundo renglon
                //tercer renglon
                PdfPTable tbFechaEmision = new PdfPTable(new float[] { 50, 50 });
                tbFechaEmision.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Fecha de Emisión:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                cell.PaddingLeft = paddingLeftEmpDer;
                tbFechaEmision.AddCell(cell);
                cell = new PdfPCell(new Paragraph(Venta.Fecha.ToString("dd/MM/yyyy"), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbFechaEmision.AddCell(cell);
                tbEmpresaDer.AddCell(tbFechaEmision);
                //fin tercer renglon
                //cuarto renglon
                PdfPTable tbcCuit = new PdfPTable(new float[] { 30, 70 });
                tbcCuit.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("CUIT:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                cell.PaddingLeft = paddingLeftEmpDer;
                tbcCuit.AddCell(cell);
                cell = new PdfPCell(new Paragraph(BusinessInfo.CUIT.ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbcCuit.AddCell(cell);
                tbEmpresaDer.AddCell(tbcCuit);
                //fin cuarto renglon
                //quinto renglon
                PdfPTable tbcIngBrutos = new PdfPTable(new float[] { 45, 55 });
                tbcIngBrutos.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Ingresos Brutos:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                cell.PaddingLeft = paddingLeftEmpDer;
                tbcIngBrutos.AddCell(cell);
                cell = new PdfPCell(new Paragraph(BusinessInfo.GrossIncome, new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbcIngBrutos.AddCell(cell);
                tbEmpresaDer.AddCell(tbcIngBrutos);
                //fin quinto renglon
                //sexto renglon
                PdfPTable tbcIniActiv = new PdfPTable(new float[] { 70, 30 });
                tbcIniActiv.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Fecha de Inicio de Actividades:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                cell.PaddingLeft = paddingLeftEmpDer;
                tbcIniActiv.AddCell(cell);
                cell = new PdfPCell(new Paragraph(BusinessInfo.InitialActivities.ToString("dd/MM/yyyy"), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbcIniActiv.AddCell(cell);
                tbEmpresaDer.AddCell(tbcIniActiv);
                //fin sexto renglon
                #endregion
                tbEmpresa.AddCell(tbEmpresaIzq);
                tbEmpresa.AddCell(tbEmpresaDer);
                tbEmpresa.Rows[0].GetCells()[0].Border = Rectangle.RIGHT_BORDER;//borde vertical central

                #region tbFechas
                PdfPTable tbFechas = new PdfPTable(new float[] { 37, 26, 37 });
                tbFechas.DefaultCell.Border = 0; //PdfPCell.NO_BORDER;
                //renglon fechas
                PdfPTable tbPeriodoDesde = new PdfPTable(new float[] { 70, 30 });
                tbPeriodoDesde.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Período Facturado Desde:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbPeriodoDesde.AddCell(cell);
                cell = new PdfPCell(new Paragraph(DateTime.Now.ToString("dd/MM/yyyy"), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbPeriodoDesde.AddCell(cell);
                tbFechas.AddCell(tbPeriodoDesde);
                PdfPTable tbPeriodoHasta = new PdfPTable(new float[] { 30, 70 });
                tbPeriodoDesde.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Hasta:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbPeriodoHasta.AddCell(cell);
                cell = new PdfPCell(new Paragraph(DateTime.Now.ToString("dd/MM/yyyy"), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbPeriodoHasta.AddCell(cell);
                tbFechas.AddCell(tbPeriodoHasta);
                PdfPTable tbVencimientoPago = new PdfPTable(new float[] { 70, 30 });
                tbVencimientoPago.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Fecha de Vto. para el pago:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbVencimientoPago.AddCell(cell);
                cell = new PdfPCell(new Paragraph(Venta.FechaVtoCae.ToString("dd/MM/yyyy"), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbVencimientoPago.AddCell(cell);
                tbFechas.AddCell(tbVencimientoPago);
                //fin renglon fechas
                #endregion
                #region tbCliente
                PdfPTable tbCliente = new PdfPTable(1);
                tbCliente.DefaultCell.Border = 0; //PdfPCell.NO_BORDER;
                //primer renglon cliente
                PdfPTable tbClienteCuitRazon = new PdfPTable(new float[] { 5, 20, 28, 47 });
                tbClienteCuitRazon.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("CUIT:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbClienteCuitRazon.AddCell(cell);
                cell = new PdfPCell(new Paragraph(ClientInfo.CUIT.ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbClienteCuitRazon.AddCell(cell);
                cell = new PdfPCell(new Paragraph("Apellido y Nombre / Razón Social:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbClienteCuitRazon.AddCell(cell);
                cell = new PdfPCell(new Paragraph(!string.IsNullOrEmpty(ClientInfo.BusinessName) ? ClientInfo.BusinessName : ClientInfo.LastName + ", " + ClientInfo.FirstName, new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbClienteCuitRazon.AddCell(cell);
                tbCliente.AddCell(tbClienteCuitRazon);
                //fin primer renglon cliente
                //segundo renglon cliente
                PdfPTable tbClienteIvaDomi = new PdfPTable(new float[] { 20, 30, 18, 32 });
                tbClienteIvaDomi.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Condición frente al IVA:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbClienteIvaDomi.AddCell(cell);
                cell = new PdfPCell(new Paragraph(ClientInfo.IVACondition, new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbClienteIvaDomi.AddCell(cell);
                cell = new PdfPCell(new Paragraph("Domicilio Comercial:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbClienteIvaDomi.AddCell(cell);
                cell = new PdfPCell(new Paragraph(ClientInfo.Address, new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbClienteIvaDomi.AddCell(cell);
                tbCliente.AddCell(tbClienteIvaDomi);
                //fin segundo renglon cliente
                //segundo renglon cliente
                PdfPTable tbClienteCondiVenta = new PdfPTable(new float[] { 20, 80 });
                tbClienteCondiVenta.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("Condición de Venta:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.BOLD)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbClienteCondiVenta.AddCell(cell);
                cell = new PdfPCell(new Paragraph(ClientInfo.SaleCondition, new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9F, Font.NORMAL)));
                cell.Border = 0;
                cell.PaddingBottom = 2;
                cell.PaddingTop = 2;
                tbClienteCondiVenta.AddCell(cell);
                tbCliente.AddCell(tbClienteCondiVenta);
                //fin tercer renglon cliente
                #endregion
                tbHeader.AddCell(tbEmpresa);
                tbHeader.AddCell(tbFechas);
                tbHeader.AddCell(tbCliente);
                tbHeader.WriteSelectedRows(0, -1, document.LeftMargin, writer.PageSize.GetTop(document.TopMargin) + 255, writer.DirectContent);

                #region CodComprobante
                //cuadro codigo del comprobante
                PdfPTable tbCodComprobante = new PdfPTable(1);
                tbCodComprobante.TotalWidth = 50f;
                tbCodComprobante.LockedWidth = true;
                cell = new PdfPCell(new Paragraph("B", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 25F, Font.BOLD)));
                cell.BorderWidthBottom = 0;
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                cell.PaddingTop = 2;
                cell.BackgroundColor = BaseColor.WHITE;
                tbCodComprobante.AddCell(cell);
                cell = new PdfPCell(new Paragraph("COD-" + string.Format("{0:000}", 06), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 7F, Font.BOLD)));
                cell.BorderWidthTop = 0;
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                cell.PaddingBottom = 3;
                cell.PaddingTop = 2;
                cell.BackgroundColor = BaseColor.WHITE;
                tbCodComprobante.AddCell(cell);
                tbCodComprobante.WriteSelectedRows(0, -1, tbHeader.TotalWidth / 2 - 15F, 800, writer.DirectContent);
                #endregion
            }
        }
        /// <summary>
        /// Pie de página del pdf
        /// </summary>
        class Footer : PdfPageEventHelper
        {
            PdfContentByte cb;
            PdfTemplate template;
            public VentaBE Venta { get; set; } // Agregar propiedad para venta

            public iTextSharp.text.Image CodBarra { get; set; }

            public override void OnStartPage(PdfWriter writer, Document document)
            {
                PdfPTable tbFooter = new PdfPTable(1);
                tbFooter.TotalWidth = document.PageSize.Width - document.LeftMargin - document.RightMargin;
                tbFooter.DefaultCell.Border = 0;
                tbFooter.LockedWidth = true;

                PdfPTable tbInfoCAE = new PdfPTable(new float[] { 60, 40 });
                tbInfoCAE.DefaultCell.Border = 0;
                #region tbCodQR
                //codigo QR
                //PdfPTable tbCodBarra = new PdfPTable(1);
                //tbCodBarra.DefaultCell.Border = 0;
                //CodBarra.ScaleToFit(250, 150);
                //PdfPCell cell = new PdfPCell(CodBarra);
                //cell.HorizontalAlignment = Element.ALIGN_LEFT;
                //cell.Border = 0;
                //tbCodBarra.AddCell(cell);
                ////fin codigo de barras
                ////codigo
                //cell = new PdfPCell(new Paragraph("03123123133213", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8F, Font.NORMAL)));
                //cell.HorizontalAlignment = Element.ALIGN_LEFT;
                //cell.Border = 0;
                //cell.PaddingLeft = 35;
                //tbCodBarra.AddCell(cell);
                //fin codigo
                // Generar el QR en lugar del código de barras
                PdfPTable tbQRCode = new PdfPTable(1);
                tbQRCode.DefaultCell.Border = 0;
                var qrImage = GenerateQRCode(Venta.QRData);
                if(qrImage != null)
                {
                    qrImage.ScaleToFit(150, 150);
                }
                PdfPCell cell = new PdfPCell(qrImage)
                    {
                        HorizontalAlignment = Element.ALIGN_LEFT,
                        Border = 0,
                        PaddingBottom = 10 // Ajusta este valor si necesitas más espacio debajo del QR
                    };
                    tbQRCode.AddCell(cell);
                
      
                #endregion
                #region CAE
                //CAE
                PdfPTable tbCAE = new PdfPTable(2);
                tbCAE.DefaultCell.Border = 0;
                cell = new PdfPCell(new Paragraph("CAE N°:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10F, Font.BOLD)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.Border = 0;
                tbCAE.AddCell(cell);
                cell = new PdfPCell(new Paragraph(Venta.CodigoAutorizacion.ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10F, Font.NORMAL)));
                cell.HorizontalAlignment = Element.ALIGN_LEFT;
                cell.Border = 0;
                tbCAE.AddCell(cell);
                cell = new PdfPCell(new Paragraph("Fecha Vto. de CAE:", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10F, Font.BOLD)));
                cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                cell.Border = 0;
                tbCAE.AddCell(cell);
                cell = new PdfPCell(new Paragraph(Venta.FechaVtoCae.ToString("dd/MM/yyyy"), new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10F, Font.NORMAL)));
                cell.HorizontalAlignment = Element.ALIGN_LEFT;
                cell.Border = 0;
                tbCAE.AddCell(cell);
                //Fin vencimiento CAE
                #endregion

                tbInfoCAE.AddCell(tbQRCode);
                tbInfoCAE.AddCell(tbCAE);
                tbFooter.AddCell(tbInfoCAE);
                //tbFooter.WriteSelectedRows(0, -1, document.LeftMargin, writer.PageSize.GetBottom(document.BottomMargin) - 5, writer.DirectContent);
                float qrPositionY = document.PageSize.GetBottom(document.BottomMargin) + 100; // Ajusta este valor para subir el QR
                tbFooter.WriteSelectedRows(0, -1, document.LeftMargin, qrPositionY, writer.DirectContent);

            }
            public override void OnOpenDocument(PdfWriter writer, Document document)
            {
                cb = writer.DirectContent;
                template = cb.CreateTemplate(50, 50);
            }
            public override void OnEndPage(PdfWriter writer, Document document)
            {
                BaseFont bfTimes = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, false);
                iTextSharp.text.Font times = new iTextSharp.text.Font(bfTimes, 8f, iTextSharp.text.Font.NORMAL);

                base.OnEndPage(writer, document);
                Rectangle page = document.PageSize;
                int pageN = writer.PageNumber;
                String text = "Página " + pageN.ToString() + " de ";

                float len = bfTimes.GetWidthPoint(text, times.Size);
                iTextSharp.text.Rectangle pageSize = document.PageSize;
                cb.BeginText();
                cb.SetFontAndSize(bfTimes, times.Size);
                cb.SetTextMatrix(page.Width - document.RightMargin - (len + 10), pageSize.GetBottom(writer.PageSize.Bottom) + 10);
                cb.ShowText(text);
                cb.EndText();
                cb.AddTemplate(template, page.Width - document.RightMargin - 10, pageSize.GetBottom(writer.PageSize.Bottom) + 10);
            }
            public override void OnCloseDocument(PdfWriter writer, Document document)
            {
                base.OnCloseDocument(writer, document);
                #region NumeroPaginas
                BaseFont bfTimes = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, false);
                iTextSharp.text.Font times = new iTextSharp.text.Font(bfTimes, 8f, iTextSharp.text.Font.NORMAL);
                template.BeginText();
                template.SetFontAndSize(bfTimes, times.Size);
                template.SetTextMatrix(0, 0);
                template.ShowText("" + (writer.PageNumber));
                template.EndText();
                #endregion
            }
        }

        public class Totals
        {
            public VentaBE Venta { get; set; } // Agregar propiedad para venta
            public decimal subtotal = 0;
            public decimal total = 0;
        }
        class SubTotal : IPdfPCellEvent
        {
            public VentaBE Venta { get; set; } // Agregar propiedad para venta
            decimal? price;
            Totals totals;

            public SubTotal(Totals totals, decimal price)
            {
                this.totals = totals;
                this.price = price;
            }

            public SubTotal(Totals totals)
            {
                this.totals = totals;
                price = null;
            }

            public void CellLayout(PdfPCell cell, Rectangle position, PdfContentByte[] canvases)
            {
                if (!price.HasValue)
                {
                    PdfContentByte canvas = canvases[PdfPTable.TEXTCANVAS];
                    ColumnText.ShowTextAligned(canvas, Element.ALIGN_LEFT, new Phrase(totals.subtotal.ToString()), position.GetLeft(0) + 2, position.GetBottom(0) + 2, 0);
                    totals.subtotal = 0;
                    return;
                }
                totals.subtotal += price.Value;
                totals.total += price.Value;
            }

        }

        /// <summary>
        /// datos de prueba del pdf
        /// </summary>
        /// <returns></returns>
        internal static DataTable CreateDataTable(VentaBE venta)
        {
            //string detalle = @"bahsbdas hbhsd hsbdhs dshdb ss bdhasda sdab dhasbdasdajb jasjdbha bajsdh bashd bhasjd bhjasdbhj";
            using (DataTable dt = new DataTable())
            {
                dt.Columns.Add("Código");
                dt.Columns.Add("Producto / Servico");
                dt.Columns.Add("Cantidad");
                dt.Columns.Add("U. medida");
                dt.Columns.Add("Precio unit.");
                dt.Columns.Add("% Bonif");
                dt.Columns.Add("Subtotal");
                dt.Columns.Add("Alicuota IVA");
                dt.Columns.Add("Subtotal c/IVA");
                Random ran = new Random();
                foreach(Detalle_VentaBE item in venta.Items)
                    dt.Rows.Add(new object[] { item.Producto.Codigo, item.Descripcion, item.Cantidad, "unidades", item.PrecioUnitario, "0.00", item.Total, item.codigoIVA.Porcentaje, item.Total });
                //for (int i = 0; i < 5; i++)
                //    dt.Rows.Add(new object[] { "asd123", detalle, 120, "unidades", 35, "6.00", "24,59", "3,43", ran.Next() });

                return dt;
            }
        }
        /// <summary>
        /// datos de prueba del pdf
        /// </summary>
        /// <returns></returns>
        internal static DataTable OtrosImpuestos()
        {
            using (DataTable dt = new DataTable())
            {
                dt.Columns.Add("Descripción");
                dt.Columns.Add("Detalle");
                dt.Columns.Add("Alic. %");
                dt.Columns.Add("Importe");
                string[] strRows = { "Per./Ret. de Impuesto a las Ganancias",
                                    "Per./Ret. de IVA",
                                    "Per./Ret. Ingresos Brutos",
                                    "Impuestos Internos",
                                    "Impuestos Municipales"};
                for (int i = 0; i < 5; i++)
                    dt.Rows.Add(new object[] { strRows[i], "", "", "0.0" });

                return dt;
            }

        }

        public static iTextSharp.text.Image GenerateQRCode(string qrData)
        {
            if(qrData == null) return null;
            using (var qrGenerator = new QRCodeGenerator())
            {
                var qrCodeData = qrGenerator.CreateQrCode(qrData, QRCodeGenerator.ECCLevel.Q);
                using (var qrCode = new QRCode(qrCodeData))
                {
                    using (var qrBitmap = qrCode.GetGraphic(20))
                    {
                        using (MemoryStream memory = new MemoryStream())
                        {
                            qrBitmap.Save(memory, System.Drawing.Imaging.ImageFormat.Png);
                            return iTextSharp.text.Image.GetInstance(memory.ToArray());
                        }
                    }
                }
            }
        }
    }
}
