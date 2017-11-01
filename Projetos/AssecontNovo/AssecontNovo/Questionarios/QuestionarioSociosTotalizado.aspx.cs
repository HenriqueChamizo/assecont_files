using System;
using AssecontNovo.Classes;
using System.Web.UI.WebControls;

namespace AssecontNovo.Questionarios
{
    public partial class QuestionarioSociosTotalizado : System.Web.UI.Page
    {
        private static DateTime DATA_INICIAL = Convert.ToDateTime("01/01/2015");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DateTime dtaQuestionario = (new BDAppAssecont()).getUltimoQuestionarioRespondidoSocio();
                preencherComboBox(dtaQuestionario, DATA_INICIAL);
                combobox.Items.Add(new Telerik.Web.UI.RadComboBoxItem("01/01/2015 - 31/12/2015", "01/01/2015 - 31/12/2015"));
                combobox.SelectedIndex = combobox.Items.Count - 1;
            }
        }

        private void preencherComboBox(DateTime Fim, DateTime Inicio)
        {
            if (Fim.CompareTo(Inicio) > 0)
            {
                //combobox.Items.Add(new Telerik.Web.UI.RadComboBoxItem(Inicio.ToString("dd/MM/yyyy") + " - " + (Inicio.AddMonths(6).AddDays(-1)).ToString("dd/MM/yyyy"), Inicio.ToString("dd/MM/yyyy")));
                combobox.Items.Add(new Telerik.Web.UI.RadComboBoxItem(Inicio.ToString("dd/MM/yyyy") + " - " + (Inicio.AddMonths(6).AddDays(-1)).ToString("dd/MM/yyyy"), Inicio.ToString("dd/MM/yyyy") + " - " + (Inicio.AddMonths(6).AddDays(-1)).ToString("dd/MM/yyyy")));
                Inicio = Inicio.AddMonths(6);
                preencherComboBox(Fim, Inicio);
            }
        }

        protected void combobox_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            DataListQuestSocio.DataBind();
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            //SqlData.ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
            ((SqlDataSource)sender).ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        }

        protected void SqlData_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            //e.Command.Parameters["@DATAINICIAL"].Value = Convert.ToDateTime(combobox.SelectedValue);
            //e.Command.Parameters["@DATAFINAL"].Value = Convert.ToDateTime(combobox.SelectedValue).AddMonths(6);

            string[] datas = combobox.SelectedValue.Split('-');

            e.Command.Parameters["@DATAINICIAL"].Value = Convert.ToDateTime(datas[0].Trim());
            e.Command.Parameters["@DATAFINAL"].Value = Convert.ToDateTime(datas[1].Trim());
        }
    }
}