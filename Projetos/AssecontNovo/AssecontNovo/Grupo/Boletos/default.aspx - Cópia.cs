
using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using Telerik.Web.UI;

namespace AssecontNovo.Grupo.Boletos
{
    public partial class _default : System.Web.UI.Page
    {
        private string cnpjCpf;
        private int ind;
        private BDAppAssefin bd;
        private string vencimento;
        private string numero;
        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDAppAssefin();
            cnpjCpf = Request.QueryString["cnpj"];
            RadWindowAtualizaCelular.VisibleOnPageLoad = true;

            if (!IsPostBack)
            {
                openAtualizacao();
                PanelEmAbertos.Visible = false;
               // RadWindowAtualizaCelular.NavigateUrl = "AtualizaCelular.aspx?ind=" + Eval("CAD_IND").ToString();
            }
        }

        void openAtualizacao()
        {
            string query = "SELECT (CASE WHEN CAD_CADASTRO_ATUALIZADO_EM IS NULL THEN 1 ELSE 0 END) FROM Cadastros WHERE dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj('{0}') OR dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj('{0}')";

            RadWindowAtulizaEmail.VisibleOnPageLoad = bd.getFieldValueBool(string.Format(query, cnpjCpf));
        }

        protected void RadGridBoletos_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;

                Panel PanelVencimento = (Panel)item["PAGO"].FindControl("PanelVencimento");
                LinkButton lkGerarBoleto2 = (LinkButton)item["PAGO"].FindControl("lkGerarBoleto2");
                lkGerarBoleto2.Attributes.Add("onClick", "javascript:controlshow(" + PanelVencimento.ClientID + "); controlhidden(" + lkGerarBoleto2.ClientID + "); return false;");
                RadComboBox RadComboBoxVencimentos = (RadComboBox)item["PAGO"].FindControl("RadComboBoxVencimentos");

                for (int i = 0; i < 20; i++)
                {
                    RadComboBoxVencimentos.Items.Add(new RadComboBoxItem(DateTime.Now.AddDays(i).ToString("dd/MM/yyyy"), DateTime.Now.AddDays(i).ToString("dd/MM/yyyy")));
                }
            }
        }

        protected void lkBoletos_Click(object sender, EventArgs e)
        {
            vencimento = string.Empty;
            numero = string.Empty;

            LinkButton lkBoletos = sender as LinkButton;
            GridDataItem item = (GridDataItem)lkBoletos.NamingContainer;

            RadComboBox RadComboBoxVencimentos = item.FindControl("RadComboBoxVencimentos") as RadComboBox;
            vencimento = RadComboBoxVencimentos.SelectedValue;

            HiddenField lbBoleInd = item.FindControl("hidden_ind") as HiddenField;
            numero = lbBoleInd.Value;

            if (vencimento != "" && numero != "")
                Response.Redirect(string.Format("~/grupo/Boletos/Boleto.aspx?cnpj={0}&data={1}&id={2}", cnpjCpf, vencimento, numero));
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

        //protected void lbBoletoPago_Click(object sender, EventArgs e)
        //{
        //    numero = string.Empty;
        //    vencimento = string.Empty;

        //    LinkButton lkBoletos = sender as LinkButton;
        //    GridDataItem item = (GridDataItem)lkBoletos.NamingContainer;

        //    HiddenField lbBoleInd = item.FindControl("hidden_ind") as HiddenField;
        //    numero = lbBoleInd.Value;

        //    Label lbVencimento = item.FindControl("lbVencimento") as Label;
        //    vencimento = lbVencimento.Text;

        //    //if (vencimento.Contains("Conta"))
        //    //    vencimento = DateTime.Now.AddDays(15).ToString("dd/MM/yyyy");

        //    Response.Redirect(string.Format("~/grupo/Boletos/Boleto.aspx?cnpj={0}&data={1}&id={2}", cnpjCpf, vencimento, numero));
        //}

        protected void lkBoletoSms_Click(object sender, EventArgs e)
        {

        }

        protected void lkTodos_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.Format("~/grupo/Boletos/BoletoTodos.aspx?cnpj={0}", cnpjCpf));
        }

        protected void lBEmAberto_Click(object sender, EventArgs e)
        {
            PanelEmAbertos.Visible = true;
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = bd.Conn.ConnectionString;
        }

        protected void SqlDataBoletosAbertos_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {

        }
    }
}