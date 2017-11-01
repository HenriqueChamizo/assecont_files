//(CASE WHEN dbo.fn_data_eh_feriado(dbo.fn_dia_util(BOL_VENCIMENTO)) = 1 THEN DATEADD(DAY, 1, dbo.fn_dia_util(BOL_VENCIMENTO)) ELSE dbo.fn_dia_util(BOL_VENCIMENTO) END) &lt; CONVERT(DATE, GETDATE())

//(CASE WHEN dbo.fn_data_eh_feriado(dbo.fn_dia_util(BOL_VENCIMENTO)) = 1 THEN DATEADD(DAY, 1, dbo.fn_dia_util(BOL_VENCIMENTO)) ELSE dbo.fn_dia_util(BOL_VENCIMENTO) END) AS BOL_VENCIMENTO

using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using Telerik.Web.UI;

namespace AssecontNovo.Grupo.Boletos
{
    public partial class BoletoTodos : System.Web.UI.Page
    {
        private string cnpjCpf;
        //private int ind;
        private string vencimento;
        private string numero;
        protected void Page_Load(object sender, EventArgs e)
        {
            cnpjCpf = Request.QueryString["cnpj"];
        }

        protected void RadGridBoletos_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;

                Panel PanelVencimento = (Panel)item["PAGO"].FindControl("PanelVencimento");
                LinkButton btnEmAberto = (LinkButton)item["PAGO"].FindControl("btnEmAberto");
                btnEmAberto.Attributes.Add("onClick", "javascript:controlshow(" + PanelVencimento.ClientID + "); controlhidden(" + btnEmAberto.ClientID + "); return false;");
                RadComboBox RadComboBoxVencimentos = (RadComboBox)item["PAGO"].FindControl("RadComboBoxVencimentos");

                for (int i = 0; i < 15; i++)
                {
                    RadComboBoxVencimentos.Items.Add(new RadComboBoxItem(DateTime.Now.AddDays(i).ToString("dd/MM/yyyy"), DateTime.Now.AddDays(i).ToString("dd/MM/yyyy")));
                }
            }
        }

        /// Gerar Boleto Em Aberto
        protected void btnGerarBoletoEmAberto_Click(object sender, EventArgs e)
        {
            vencimento = string.Empty;
            numero = string.Empty;

            LinkButton btn = sender as LinkButton;
            GridDataItem item = (GridDataItem)btn.NamingContainer;

            RadComboBox RadComboBoxVencimentos = item.FindControl("RadComboBoxVencimentos") as RadComboBox;
            vencimento = RadComboBoxVencimentos.SelectedValue;

            HiddenField lbBoleInd = item.FindControl("hidden_ind") as HiddenField;
            numero = lbBoleInd.Value;

            if (vencimento != "" && numero != "")
                Response.Redirect(string.Format("~/grupo/Boletos/Boleto.aspx?cnpj={0}&data={1}&id={2}", cnpjCpf, vencimento, numero));
        }


        /// Gerar Boleto
        protected void btnGerarBoleto_Click(object sender, EventArgs e)
        {
            numero = string.Empty;
            vencimento = string.Empty;

            LinkButton btn = sender as LinkButton;
            GridDataItem item = (GridDataItem)btn.NamingContainer;

            HiddenField lbBoleInd = item.FindControl("hidden_ind") as HiddenField;
            numero = lbBoleInd.Value;

            Label lbVencimento = item.FindControl("lbVencimento") as Label;
            vencimento = lbVencimento.Text;

            if (lbVencimento.Text == "")
                vencimento = DateTime.Now.AddDays(15).ToString("dd/MM/yyyy");

            Response.Redirect(string.Format("~/grupo/Boletos/Boleto.aspx?cnpj={0}&data={1}&id={2}", cnpjCpf, vencimento, numero));
        }

        protected void lkVoltar_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.Format("~/grupo/Boletos/default.aspx?cnpj={0}", cnpjCpf));
        }

        protected void SqlDataAssefin_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new BDAppAssefin()).Conn.ConnectionString;
        }

        //public void GeraPDFbyURL(string url)
        //{
        //    if (string.IsNullOrEmpty(url)) return;

        //    string conteudoHTML = new System.Net.WebClient().DownloadString(url);
        //    HtmlToPdfBuilder pdf = new HtmlToPdfBuilder(iTextSharp.text.PageSize.A4);
        //    HtmlPdfPage pagina = pdf.AddPage();
        //    pagina.AppendHtml(conteudoHTML);

        //    byte[] file = pdf.RenderPdf();

        //    if (file != null)
        //    {
        //        Response.ContentType = "application/pdf";
        //        Response.AddHeader("content-length", file.Length.ToString());
        //        Response.BinaryWrite(file);
        //    }
        //}
    }
}