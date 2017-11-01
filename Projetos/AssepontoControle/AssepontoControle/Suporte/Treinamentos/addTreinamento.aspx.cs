using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;

namespace Asseponto.Suporte.Treinamentos
{
    public partial class addTreinamento : System.Web.UI.Page
    {
        private BDApp bd;
        private UserApp user;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                DivDescricao.Visible = false;
        }

        protected void RbSalvar_Click(object sender, EventArgs e)
        {
            bd = new BDApp();
            user = new UserApp();

            DateTime data = Convert.ToDateTime(RDTP_Horario.SelectedDate.Value);
            string semana = Wr.Classes.Strings.capitalizeWords((new System.Globalization.CultureInfo("pt-BR").DateTimeFormat.GetDayName(data.DayOfWeek)));

            string descricao = txtDescricao.Text;
            bool feriado = rbtnFeriado.Checked;
            bool treinamento = rbtnTreinamento.Checked;
            bool treinamentoIndividual = rbtnTreinamentoIndividual.Checked;

            string query = string.Empty;

            if (treinamento)
                descricao = "Treinamento";

            if (treinamentoIndividual)
            {
                treinamento = true;
                descricao = "Treinamento Individual";
            }

            query = "INSERT INTO AssepontoAgendaTreinamentos " +
                    "(AGE_DATA_HORA, AGE_DESCRICAO, AGE_CRIADO_POR, AGE_CRIADO_DATA, AGE_ASSEPONTO4, AGE_SEMANA, AGE_FERIADO, AGE_REALIZADO, AGE_TREINAMENTO_INDIVIDUAL) " +
                    "VALUES ('{0}', '{1}', {2}, GETDATE(), {3}, '{4}', {5}, {5}, {6})";

            bd.executeCommand(string.Format(query, data, descricao, UserApp.UserId, Utils.ConvertBooleanToString(treinamento), semana, 
               Utils.ConvertBooleanToString(feriado), Utils.ConvertBooleanToString(treinamentoIndividual)));

            Page.ClientScript.RegisterStartupScript(this.GetType(), "openProcess", "openProcess()", true);       
        }

        protected void CheckTreinamento_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton chk = (RadioButton)sender;
            if (chk.Enabled)
            {
                DivDescricao.Visible = false;
            }
        }

        protected void CheckFeriado_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton chk = (RadioButton)sender;
            if (chk.Enabled)
            {
                DivDescricao.Visible = true;

            }            
        }

        protected void CheckTreinamentoIndividual_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton chk = (RadioButton)sender;
            if (chk.Enabled)
            {
                DivDescricao.Visible = false;
            }
        }
    }
}