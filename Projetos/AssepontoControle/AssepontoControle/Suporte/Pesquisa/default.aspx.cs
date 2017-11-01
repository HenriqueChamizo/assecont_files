using System;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Asseponto.Classes;

namespace Asseponto.Suporte.Pesquisa
{
    public partial class _default : System.Web.UI.Page
    {
        private DateTime dataInicial;
        private DateTime dataFinal;
        private int setor = 0;
        //int contQtdItems = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                new Permissoes((new BDApp())).getAcessoResponse("pesquisa", Response);
                comboboxSetor.SelectedIndex = 0;
            }

            setor = Convert.ToInt32(comboboxSetor.SelectedValue);
            RadDatePicker1.SelectedDate = dataInicial = RadDatePicker1.SelectedDate == null ? Convert.ToDateTime(DateTime.Now.ToString("01/MM/yyyy")) : RadDatePicker1.SelectedDate.Value;
            RadDatePicker2.SelectedDate = dataFinal = RadDatePicker2.SelectedDate == null ? DateTime.Now : RadDatePicker2.SelectedDate.Value;
        }

        protected void RadDatePicker1_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            dataInicial = RadDatePicker1.SelectedDate.Value;
            dataFinal = RadDatePicker2.SelectedDate.Value;
            DataList1.DataBind();
        }

        protected void SqlData_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@IMPLANTACAO"].Value = comboboxSetor.SelectedValue;
            e.Command.Parameters["@DATAINICIAL"].Value = dataInicial;
            e.Command.Parameters["@DATAFINAL"].Value = dataFinal;
        }

        protected void comboboxSetor_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            DataList1.DataBind();
        }
    }
}