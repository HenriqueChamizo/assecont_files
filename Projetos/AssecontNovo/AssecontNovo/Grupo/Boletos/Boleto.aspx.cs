using AssecontNovo.Classes;
using System;

namespace AssecontNovo.Grupo.Boletos
{
    public partial class Boleto : System.Web.UI.Page
    {
        private string cnpjCpf;
        private int boletoId;
        private BDAppAssefin bd;
        private DateTime data;

        const string query = "SELECT {0} FROM Boletos INNER JOIN ContasParticulares ON BOL_CONTAP = CTAP_IND " +
                                "INNER JOIN Bancos ON BCO_IND = CTAP_BANCO WHERE BOL_IND = {1} ";

        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDAppAssefin();
            PanelAvisoItau.Visible = false;

            boletoId = Convert.ToInt32(Request.QueryString["id"]);
            cnpjCpf = Request.QueryString["cnpj"];
            cnpjCpf = cnpjCpf.Trim().Replace("-", "").Replace("/", "").Replace(".", "");

            DateTime Vencimento = bd.getFieldValueDateTime(string.Format(query, "BOL_VENCIMENTO", boletoId));

            if (!string.IsNullOrEmpty(Request.QueryString["data"])) 
            {
                data = Convert.ToDateTime(Request.QueryString["data"]);

                if (data.Date < Vencimento.Date)
                    data = Vencimento;
            }
            else 
            {
                data = Vencimento;
            }

            //if (!string.IsNullOrEmpty(Request.QueryString["data"])) data = Convert.ToDateTime(Request.QueryString["data"]);
            //else data = bd.getFieldValueDateTime(string.Format(query, "BOL_VENCIMENTO", boletoId));

            if (bd.getFieldValueString(string.Format(query, "BCO_NUMERO", boletoId)) == "33")
                GerarSantader();
            else
                GerarItau();

            setDateView(Request.QueryString["process"]);
        }

        private void setDateView(string processo)
        {
            if (processo == "546")
                bd.executeCommand(string.Format("UPDATE Boletos SET BOL_VISUALIZADOEM = '{0}' WHERE BOL_IND = {1} AND BOL_VISUALIZADOEM IS NULL", DateTime.Now, boletoId));
            else
                bd.executeCommand(String.Format("UPDATE Boletos SET BOL_VISUALIZADO_WEBEM = '{0}' WHERE BOL_IND = {1} AND BOL_VISUALIZADO_WEBEM IS NULL", DateTime.Now, boletoId));
        }

        private void GerarSantader()
        {
            GerarBoleto gerar = new GerarBoleto(cnpjCpf, data, boletoId, bd);
            //CreateHtmlToPDFDocument(gerar.BoletoSantader().MontaHtmlEmbedded());
            PlaceHolder1.Controls.Add(gerar.BoletoSantader());
        }

        private void GerarItau()
        {
            GerarBoletoItau gerar = new GerarBoletoItau(cnpjCpf, data, boletoId, bd);
            BoletoNet.BoletoBancario banco = gerar.BoletoItau();

            if (banco.Boleto.DataVencimento.CompareTo(DateTime.Now) < 0)
                PanelAvisoItau.Visible = true;
            PlaceHolder1.Controls.Add(banco);
        }


        void CreatePDFDocument(string htmlText)
        {
            //byte[] pdfBuffer = null;
            //string htmlCode = htmlText;//bb.MontaHtml();
            //string baseUrl = string.Empty;
            //pdfBuffer = htmlToPdfConverter.ConvertHtmlToMemory(htmlCode, baseUrl);

            //string strFileName = Server.MapPath("test.pdf");

            //Response.ClearContent();
            //Response.ContentType = "application/pdf";
            // Response.AddHeader("Content-Disposition", String.Format("filename={0}", strFileName));
            //HttpContext.Current.Response.AddHeader("Content-Length", pdfBuffer.Length.ToString());
            //Response.BinaryWrite(pdfBuffer);

            //web.RenderControl(output);

            //HttpContext.Current.Response.End();
            //HttpContext.Current.Response.Flush();

            //Document document = new Document();

            //string strFileName = HttpContext.Current.Server.MapPath("test.pdf");
            //PdfWriter.GetInstance(document, new FileStream(strFileName, FileMode.Create));
            //document.Open();
            //System.Net.WebClient wc = new System.Net.WebClient();
            //string htmlText = wc.DownloadString("http://localhost:59500/my.html");
            //Response.Write(htmlText);
            //List<IElement> htmlarraylist = HTMLWorker.ParseToList(new StringReader(htmlText), null);
            //for (int k = 0; k < htmlarraylist.Count; k++)
            //{
            //    document.Add((IElement)htmlarraylist[k]);
            //}


            //document.Close();
            //ShowPdf(strFileName);
        }

        //Este código, necessita do iTextSharp

        //private void CreateHtmlToPDFDocument(string boletoHTML)
        //{
        //    //var boletoHTML = boletoBancario.MontaHtmlEmbedded();

        //    //string strFileName = HttpContext.Current.Server.MapPath("test.pdf");

        //    // Grava Boleto em Arquivo HTML .::

        //    var id = Guid.NewGuid();
        //    var boletoPathHTML = HttpContext.Current.Server.MapPath("Boleto_" + id + ".html");
        //    var f = new FileStream(boletoPathHTML, FileMode.Create);
        //    var w = new StreamWriter(f, Encoding.Default);
        //    w.Write(boletoHTML);
        //    w.Close();
        //    f.Close();

        //    // Transforma o html do boleto em imagem, e adiciona ele ao PDF .::

        //    var boletoPathPDF = HttpContext.Current.Server.MapPath("Boleto_" + id + ".pdf");

        //    var imagePath = GerarImagem(boletoPathHTML);
        //    var doc = new Document(PageSize.A4, 46, 0, 40, 0);
        //    var filePDF = new FileStream(boletoPathPDF, FileMode.Create);

        //    PdfWriter.GetInstance(doc, filePDF);
        //    doc.Open();

        //    var gif = Image.GetInstance(imagePath);
        //    gif.ScaleAbsolute(494.0F, 785.0F);
        //    doc.Add(gif);
        //    doc.CloseDocument();
        //    doc.Close();
        //    doc.Dispose();
        //    filePDF.Close();
        //    filePDF.Dispose();

        //    ShowPdf(boletoPathPDF);

        //    System.IO.File.Delete(boletoPathHTML);
        //    System.IO.File.Delete(boletoPathPDF);
        //    System.IO.File.Delete(imagePath);
        //}

        //private string GerarImagem(string _boletoPathHTML)
        //{
        //    var width = 680;
        //    var height = 1096;
        //    var webBrowserWidth = 680;
        //    var webBrowserHeight = 1096;
        //    var bmp = WebsiteThumbnailImageGenerator.GetWebSiteThumbnail(_boletoPathHTML, webBrowserWidth, webBrowserHeight, width, height);
        //    var boletoPathBMP = Path.Combine(Path.GetTempPath(), "Boleto_" + Guid.NewGuid().ToString() + ".bmp");

        //    var myEncoder = System.Drawing.Imaging.Encoder.Quality;
        //    var myEncoderParameters = new System.Drawing.Imaging.EncoderParameters(1);
        //    var myEncoderParameter = new System.Drawing.Imaging.EncoderParameter(myEncoder, 100L);

        //    myEncoderParameters.Param[0] = myEncoderParameter;
        //    bmp.Save(boletoPathBMP, GetEncoder(System.Drawing.Imaging.ImageFormat.Png), myEncoderParameters);

        //    return boletoPathBMP;
        //}

        //private static System.Drawing.Imaging.ImageCodecInfo GetEncoder(System.Drawing.Imaging.ImageFormat format)
        //{
        //    var codecs = System.Drawing.Imaging.ImageCodecInfo.GetImageDecoders();
        //    foreach (var codec in codecs)
        //    {
        //        if (codec.FormatID == format.Guid)
        //        {
        //            return codec;
        //        }
        //    }
        //    return null;
        //}

        //public class WebsiteThumbnailImageGenerator
        //{
        //    public static System.Drawing.Bitmap GetWebSiteThumbnail(string Url, int BrowserWidth, int BrowserHeight, int ThumbnailWidth, int ThumbnailHeight)
        //    {
        //        var thumbnailGenerator = new WebsiteThumbnailImage(Url, BrowserWidth, BrowserHeight, ThumbnailWidth, ThumbnailHeight);
        //        return thumbnailGenerator.GenerateWebSiteThumbnailImage();
        //    }

        //    private class WebsiteThumbnailImage
        //    {
        //        public WebsiteThumbnailImage(string Url, int BrowserWidth, int BrowserHeight, int ThumbnailWidth, int ThumbnailHeight)
        //        {
        //            m_Url = Url;
        //            m_BrowserWidth = BrowserWidth;
        //            m_BrowserHeight = BrowserHeight;
        //            m_ThumbnailHeight = ThumbnailHeight;
        //            m_ThumbnailWidth = ThumbnailWidth;
        //        }

        //        private readonly string m_Url;

        //        private System.Drawing.Bitmap m_Bitmap;

        //        private readonly int m_ThumbnailWidth;

        //        private readonly int m_ThumbnailHeight;

        //        private readonly int m_BrowserWidth;

        //        private readonly int m_BrowserHeight;

        //        public System.Drawing.Bitmap GenerateWebSiteThumbnailImage()
        //        {
        //            var m_thread = new System.Threading.Thread(_GenerateWebSiteThumbnailImage);
        //            m_thread.SetApartmentState(System.Threading.ApartmentState.STA);
        //            m_thread.Start();
        //            m_thread.Join();
        //            return m_Bitmap;
        //        }

        //        private void _GenerateWebSiteThumbnailImage()
        //        {
        //            var m_WebBrowser = new System.Windows.Forms.WebBrowser();
        //            m_WebBrowser.ScrollBarsEnabled = false;
        //            m_WebBrowser.Navigate(m_Url);
        //            m_WebBrowser.DocumentCompleted += WebBrowser_DocumentCompleted;
        //            while (m_WebBrowser.ReadyState != System.Windows.Forms.WebBrowserReadyState.Complete)
        //                System.Windows.Forms.Application.DoEvents();
        //            m_WebBrowser.Dispose();
        //        }

        //        private void WebBrowser_DocumentCompleted(object sender, System.Windows.Forms.WebBrowserDocumentCompletedEventArgs e)
        //        {
        //            var m_WebBrowser = (System.Windows.Forms.WebBrowser)sender;
        //            m_WebBrowser.ClientSize = new System.Drawing.Size(m_BrowserWidth, m_BrowserHeight);
        //            m_WebBrowser.ScrollBarsEnabled = false;
        //            m_Bitmap = new System.Drawing.Bitmap(m_WebBrowser.Bounds.Width, m_WebBrowser.Bounds.Height);
        //            m_WebBrowser.BringToFront();
        //            m_WebBrowser.DrawToBitmap(m_Bitmap, m_WebBrowser.Bounds);
        //        }
        //    }
        //}

        //public void ShowPdf(string strFileName)
        //{
        //    Response.ClearContent();
        //    Response.ClearHeaders();
        //    Response.AddHeader("Content-Disposition", "inline;filename=boleto.pdf");
        //    Response.ContentType = "application/pdf";
        //    Response.WriteFile(strFileName);
        //    Response.Flush();
        //    Response.Clear();
        //}

        #region BoletoHTML
        //    html = html.Replace(".cut{width:665px;height:1px;border-top:dashed 1px #000}", ".cut{width:665px;height:1px;border-top:dashed 1px #000; heigt: 50px; padding: 5px;}");/*Barra corte */
        //    html = html.Replace("*{margin:0px;padding:0px}", "");
        //    html = html.Replace(".Al{text-align:left}", "");
        //    html = html.Replace(".pL6{padding-left:6px}", ".pL6{padding-left:6px; min-height: 80px;}");
        //    html = html.Replace(".At{vertical-align:top}", ".At{padding-left: 6px; padding-bottom: 2px; padding-top: 2px; border-left: 1px solid black;}");
        //    html = html.Replace(".w659{width:659px}", ".w659{width:659px; padding-left: 6px; padding-bottom: 2px; padding-top: 2px; border-left: 1px solid black;}");

        //    html = html.Replace(".h13 td{vertical-align:top}", ".h13 td{height: 13px !important; padding-top: 2px;}");
        //    html = html.Replace(".h12 td{vertical-align:top}", ".h12 td{height: 15px !important}");
        //    html = html.Replace(".rBb td{border-bottom:solid 1px #000}", ".rBb td{border-bottom: 1px solid #000}");

        //    html = html.Replace(".cpN{font:bold 10px arial;color:black}", ".cpN{padding-right: 20px;}");

        //    //html = html.Replace(".ct td, .cp td{padding-left:6px;border-left:solid 1px #000}", "");

        //    html = html.Replace("font: bold 10px arial; ", "font: bold 9pt arial; padding: 2px;");
        //    html = html.Replace("9px", "8pt arial; padding: 2px;");
        //    html = html.Replace("\"arial narrow\"", "arial");

        //    html = html.Replace("class=\"w666\"", "style=\"max-width: 666px; border-collapse: collapse; width: 100%; !important;\"");


        //    html = html.Replace(".EcdBar{height:50px;vertical-align:bottom}", ".EcdBar{height:70px;vertical-align:bottom;padding-top: 10px;}");
        //    html = html.Replace("class=\"w123\"", "style=\"width: 45px !important; border=1px solid black; \"");
        //    html = html.Replace("class=\"w180\"", "style=\"width: 180px !important; padding-left: 6px; height: 13px; border-left: solid 1px #000; \"");
        //    html = html.Replace("class=\"w34\"", "style=\"width: 34px; padding-left: 4px; padding-right: 4px; height: 13px; border-left: 1px solid black;\"");

        //    html = html.Replace(".w472{width:472px}", ".w472{width: 472px !important; padding-left: 4px; padding-right: 4px; border-left: solid 1px #000; }");
        //    html = html.Replace(".w126{width:126px}", ".w126{width: 126px !important; padding-left: 3px; padding-right: 3px; border-left: solid 1px #000; }");
        //    html = html.Replace(".w128{width:128px}", ".w128{width: 128px !important; padding-left: 3px; padding-right: 3px; border-left: solid 1px #000; }");

        //    html = html.Replace(".w298{width:298px}", ".w298{width: 298px !important; padding-left: 6px; padding-right: 3px; border-left: solid 1px #000; }");
        //    html = html.Replace(".w45{width:45px}", ".w45{width: 45px !important; padding-left: 3px; padding-right: 3px; border-left: solid 1px #000; }");

        //    //html = html.Replace("cp h12 ", "style=\"padding-left: 6px; height: 13px; border-bottom: 1px solid black;\"");
        #endregion
    }


}