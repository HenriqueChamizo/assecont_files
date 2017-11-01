using System;
using System.Web.UI;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Pesquisa
{
    public partial class pesquisaAssepontoDetalhado : System.Web.UI.Page
    {
        //BDApp bd;
        private DateTime dataInicial;
        private DateTime dataFinal;
        private int Responderam;
        private int Status;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                (new Permissoes(new BDApp())).getAcessoResponse("Questionarios/RelatorioSoftware.aspx", Response);
                initParametrosQueryString();
            }
            initParametros();
        }

        void initParametrosQueryString()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["S"])) ComboboxStatus.SelectedValue = Request.QueryString["S"];
            if(!string.IsNullOrEmpty(Request.QueryString["DI"])) RadDatePicker1.SelectedDate = Convert.ToDateTime(Request.QueryString["DI"]);
            if (!string.IsNullOrEmpty(Request.QueryString["DF"])) RadDatePicker2.SelectedDate = Convert.ToDateTime(Request.QueryString["DF"]);          
        }

        void initParametros()
        {
            if (comboboxResponderam.SelectedValue == string.Empty) { comboboxResponderam.SelectedValue = "0"; Responderam = 0; }
            else Responderam = Convert.ToInt32(comboboxResponderam.SelectedValue);

            if (ComboboxStatus.SelectedValue == string.Empty) { ComboboxStatus.SelectedValue = "0"; Status = 0; }
            else Status = Convert.ToInt32(ComboboxStatus.SelectedValue);

            RadDatePicker1.SelectedDate = dataInicial = RadDatePicker1.SelectedDate == null ? Convert.ToDateTime(DateTime.Now.ToString("01/MM/yyyy")) : RadDatePicker1.SelectedDate.Value;
            RadDatePicker2.SelectedDate = dataFinal = RadDatePicker2.SelectedDate == null ? DateTime.Now : RadDatePicker2.SelectedDate.Value;
        }

        protected void comboboxResponderam_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Responderam = Convert.ToInt32(e.Value);
            RadGrid1.DataBind();
        }

        protected void ComboboxStatus_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Status = Convert.ToInt32(e.Value);
            RadGrid1.DataBind();
        }

        protected void SqlDataQuestAtendimento_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@DATAINICIAL"].Value = dataInicial;
            e.Command.Parameters["@DATAFINAL"].Value = dataFinal;
            e.Command.Parameters["@STATUS"].Value = Status;
            e.Command.Parameters["@RESPONDERAM"].Value = Responderam;
        }

        protected void RadDatePicker1_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            dataInicial = RadDatePicker1.SelectedDate.Value;
            dataFinal = RadDatePicker2.SelectedDate.Value;
            RadGrid1.DataBind();
        }
    }
}