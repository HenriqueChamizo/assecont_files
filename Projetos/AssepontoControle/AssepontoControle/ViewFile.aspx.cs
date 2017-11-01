using System;
using System.Data;
using System.Web;
using Asseponto.Classes;

namespace Asseponto
{
    public partial class ViewFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(string.IsNullOrEmpty(Request.QueryString["ind"]))
                openContrato(Convert.ToInt32(Request.QueryString["contrato"]));
            else
                openPlanilha(Convert.ToInt32(Request.QueryString["ind"]));
        }

        private void openArquivo(string extensao, byte[] arquivo)
        {
            HttpContext.Current.Response.ClearContent();
            HttpContext.Current.Response.AddHeader("Content-Disposition", String.Format("filename=arquivo." + extensao));

            switch (extensao)
            {
                case "pdf": HttpContext.Current.Response.ContentType = "application/pdf"; break;
                case "xls": HttpContext.Current.Response.ContentType = "application/vnd.ms-excel"; break;
                case "xlsx": HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"; break;
                default: HttpContext.Current.Response.ContentType = "application/octet-stream"; break;
            }

            HttpContext.Current.Response.BinaryWrite(arquivo);
            HttpContext.Current.Response.End();
        }

        private void openPlanilha(int indice)
        {
            Model.Pedido ped = new Model.Pedido(indice);
            ped.selectPlanilha();
            openArquivo(ped.Extensao, ped.Arquivo);
        }

        private byte[] arquivoByte;
        public byte[] ArquivoByte
        {
            get { return arquivoByte; }
            set { arquivoByte = value; }
        }

        private void openContrato(int indice)
        {
            DataTable dados = (new BDAppAssefin()).getContratoArquivo(indice);

            foreach (DataRow reader in dados.Rows)
            {
                if (reader["FATUCONARQ_ARQUIVO"] != DBNull.Value)
                {
                    ArquivoByte = (byte[])reader["FATUCONARQ_ARQUIVO"];
                    //string s = (string)reader["FATUCONARQ_ARQUIVO"];
                    //ArquivoByte = System.Text.Encoding.Unicode.GetBytes(s);
                }

                openArquivo("pdf", ArquivoByte);
            }
        }
    }
}