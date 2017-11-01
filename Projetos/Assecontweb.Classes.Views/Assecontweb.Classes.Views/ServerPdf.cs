using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Web;
using System.IO;

namespace Assecontweb.Classes.Views
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:ServerPdf runat=server></{0}:ServerPdf>")]
    public class ServerPdf : WebControl
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        #region Getters & Setters
        private int _Indice;
        public int Indice
        {
            get { return _Indice; }
            set { _Indice = value; }
        }

        private int _Cliente;
        public int Cliente
        {
            get { return _Cliente; }
            set { _Cliente = value; }
        }

        private Types.Types.ViewerArquivoTipo _ArquivoTipo;
        public Types.Types.ViewerArquivoTipo ArquivoTipo
        {
            get { return _ArquivoTipo; }
            set { _ArquivoTipo = value; }
        }
        #endregion

        protected override void RenderContents(HtmlTextWriter output)
        {
            Control web = new Control();

            ServerViewerClass viewerclass = new ServerViewerClass(Indice, Cliente, ArquivoTipo);
            ServerViewerClass.FileViewer file = viewerclass.ReadFile();

            HttpContext.Current.Response.ClearContent();
            HttpContext.Current.Response.AddHeader("Content-Disposition", (file.Extensao == "txt" ? "attachment;" : "") + String.Format("filename={0}", (Path.GetExtension(file.Nome) == String.Empty ? file.Nome + "." + file.Extensao : file.Nome) ));
           
            switch (file.Extensao)
            {
                case "txt": HttpContext.Current.Response.ContentType = "text/plain"; break;
                case "pdf": HttpContext.Current.Response.ContentType = "application/pdf"; break;
                case "zip": HttpContext.Current.Response.ContentType = "application/zip"; break;
                case "rar": HttpContext.Current.Response.ContentType = "application/x-rar-compressed"; break;
                case "docx": HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"; break;
                case "doc": HttpContext.Current.Response.ContentType = "application/msword"; break;
                case "xls": HttpContext.Current.Response.ContentType = "application/vnd.ms-excel"; break;
                case "xlsx": HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"; break;
                default: HttpContext.Current.Response.ContentType = "application/octet-stream"; break;
            }

            try
            {
                HttpContext.Current.Response.BinaryWrite(file.Conteudo);
            }
            catch (NullReferenceException ex)
            {
                throw new Exception("#Arquivo não encontrado. \n \nO Arquivo pode ter sido excluido pelo responsavel. \n \nEntre em contato com o setor responsavel. #");
            }

            StringWriter stw = new StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);

            output = htextw;

            HttpContext.Current.Response.Write(stw.ToString());
            HttpContext.Current.Response.End();

            web.RenderControl(output);

            this.Render(output);
        }
    }
}
