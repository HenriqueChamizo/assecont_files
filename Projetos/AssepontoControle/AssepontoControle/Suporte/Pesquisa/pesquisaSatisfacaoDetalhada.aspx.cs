using System;
using Asseponto.Classes;

namespace Asseponto.Suporte.Pesquisa
{
    public partial class pesquisaSatisfacaoDetalhada : System.Web.UI.Page
    {
        private DateTime dataInicial;
        private DateTime dataFinal;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                new Permissoes((new BDApp())).getAcessoResponse("pesquisa", Response);

            RadDatePicker1.SelectedDate = dataInicial = RadDatePicker1.SelectedDate == null ? Convert.ToDateTime(DateTime.Now.ToString("01/MM/yyyy")) : RadDatePicker1.SelectedDate.Value;
            RadDatePicker2.SelectedDate = dataFinal = RadDatePicker2.SelectedDate == null ? DateTime.Now : RadDatePicker2.SelectedDate.Value;
        }

        //protected void SqlData_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        //{
        //    e.Command.Parameters["@RESPONDERAM"].Value = comboboxResponderam.SelectedItem.Value;
        //    e.Command.Parameters["@SETOR"].Value = comboboxSetor.SelectedItem.Value;
        //}

        protected void RadDatePicker1_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            dataInicial = RadDatePicker1.SelectedDate.Value;
            dataFinal = RadDatePicker2.SelectedDate.Value;
            RadGrid1.DataBind();
        }
        //protected void SqlData_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        //{
        //    e.Command.Parameters["@DATAINICIAL"].Value = dataInicial;
        //    e.Command.Parameters["@DATAFINAL"].Value = dataFinal;
        //}
    }
}