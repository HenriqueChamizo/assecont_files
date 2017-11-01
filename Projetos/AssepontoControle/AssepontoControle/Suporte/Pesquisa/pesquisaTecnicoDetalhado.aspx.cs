using System;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Pesquisa
{
    public partial class pesquisaTecnicoDetalhado : System.Web.UI.Page
    {
        private int tecnico = 0;
        private int rapido = 2;
        private int prestativo = 2;
        private int gentil = 2;
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

        #region parametros
        void initParametros()
        {
            if (comboboxResponderam.SelectedValue == string.Empty) { comboboxResponderam.SelectedValue = "2"; Responderam = 2; }
            else Responderam = Convert.ToInt32(comboboxResponderam.SelectedValue);

            if (ComboboxStatus.SelectedValue == string.Empty) { ComboboxStatus.SelectedValue = "0"; Status = 0; }
            else Status = Convert.ToInt32(ComboboxStatus.SelectedValue);

            if (comboboxTecnico.SelectedValue == string.Empty) { comboboxTecnico.SelectedIndex = tecnico = 0; }
            else tecnico = Convert.ToInt32(comboboxTecnico.SelectedValue);

            if (comboboxGentil.SelectedValue == string.Empty) { comboboxGentil.SelectedValue = "2"; gentil = 2; }
            else gentil = Convert.ToInt32(comboboxGentil.SelectedValue);

            if (comboboxPrestativo.SelectedValue == string.Empty) { comboboxPrestativo.SelectedValue = "2"; prestativo = 2; }
            else prestativo = Convert.ToInt32(comboboxPrestativo.SelectedValue);

            if (comboboxRapido.SelectedValue == string.Empty) { comboboxRapido.SelectedValue = "2"; rapido = 2; }
            else rapido = Convert.ToInt32(comboboxRapido.SelectedValue);

            RadDatePicker1.SelectedDate = dataInicial = RadDatePicker1.SelectedDate == null ? Convert.ToDateTime(DateTime.Now.ToString("01/MM/yyyy")) : RadDatePicker1.SelectedDate.Value;
            RadDatePicker2.SelectedDate = dataFinal = RadDatePicker2.SelectedDate == null ? DateTime.Now : RadDatePicker2.SelectedDate.Value;
        }

        void initParametrosQueryString()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["T"]) && !Request.QueryString["T"].Equals("-1")) comboboxTecnico.SelectedValue = Request.QueryString["T"];
            if (!string.IsNullOrEmpty(Request.QueryString["S"])) ComboboxStatus.SelectedValue = Request.QueryString["S"];
            if (!string.IsNullOrEmpty(Request.QueryString["DI"])) RadDatePicker1.SelectedDate = Convert.ToDateTime(Request.QueryString["DI"]);
            if (!string.IsNullOrEmpty(Request.QueryString["DF"])) RadDatePicker2.SelectedDate = Convert.ToDateTime(Request.QueryString["DF"]);
        }
        #endregion

        protected void Combobox_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadGrid1.DataBind();
        }

        protected void SqlDataQuestAtendimento_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@DATAINICIAL"].Value = dataInicial;
            e.Command.Parameters["@DATAFINAL"].Value = dataFinal;
            e.Command.Parameters["@STATUS"].Value = Status;
            e.Command.Parameters["@RESPONDERAM"].Value = Responderam;

            e.Command.Parameters["@TECNICO"].Value = tecnico;
            e.Command.Parameters["@RAPIDO"].Value = rapido;
            e.Command.Parameters["@PRESTATIVO"].Value = prestativo;
            e.Command.Parameters["@GENTIL"].Value = gentil;
        }

        protected void RadDatePicker1_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            dataInicial = RadDatePicker1.SelectedDate.Value;
            dataFinal = RadDatePicker2.SelectedDate.Value;
            RadGrid1.DataBind();
        }

        protected void comboboxTecnico_DataBound(object sender, EventArgs e)
        {
            comboboxTecnico.Items.Insert(0, new RadComboBoxItem("Todos os técnicos", "0"));

            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["T"]) && !Request.QueryString["T"].Equals("-1"))
                    comboboxTecnico.SelectedValue = Request.QueryString["T"];
                else
                    comboboxTecnico.SelectedIndex = 0;
            }
        }
    }
}