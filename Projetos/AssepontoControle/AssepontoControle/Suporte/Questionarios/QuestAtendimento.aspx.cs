using System;
using Asseponto.Classes;

namespace Asseponto.Suporte.Questionarios
{
    public partial class QuestAtendimento : System.Web.UI.Page
    {
        private int ind;
        protected void Page_Load(object sender, EventArgs e)
        {
            ind = Convert.ToInt32(Request.QueryString["ind"]);

            if (!IsPostBack && ind <= 0)
                Response.Redirect("~/suporte/Questionarios/ConfirmacaoQuestionario.aspx");

            checarDuplicado();
        }

        private void checarDuplicado()
        {
            if (!string.IsNullOrEmpty((new BDApp()).getFieldValueString(string.Format("SELECT QUEST_DATA_ATUALIZACAO FROM AssepontoQuestAtendimento WHERE QUEST_IND = {0}", ind))))
                Response.RedirectPermanent("~/suporte/Questionarios/DuplicacaoQuestionario.aspx");
        }

        protected void lkEnviar_Click(object sender, EventArgs e)
        {
            ind = Convert.ToInt32(Request.QueryString["ind"]);
            if (ind > 0) InserirQuestionario(ind);
            Response.Redirect("~/suporte/Questionarios/ConfirmacaoQuestionario.aspx");
        }

        protected void InserirQuestionario(int ind)
        {
            BDApp bd = new BDApp();

            string sql = "UPDATE AssepontoQuestAtendimento SET QUEST_DATA_ATUALIZACAO = GETDATE() ";

            sql += string.Format(", QUEST_1 = '{0}'", RbSatisfazPonto4.SelectedValue);
            sql += string.Format(", QUEST_2 = '{0}'", RbAvaliePonto4.SelectedValue);
            sql += string.Format(", QUEST_3 = '{0}'", RbAvalieSuporte.SelectedValue);

            sql += string.Format(", QUEST_4 = '{0}'", RbAtendenteGentil.SelectedValue);
            sql += string.Format(", QUEST_5 = '{0}'", RbAtendentePrestativo.SelectedValue);
            sql += string.Format(", QUEST_6 = '{0}'", RbAtendenteRapido.SelectedValue);
            sql += string.Format(", QUEST_7 = '{0}'", RbIndicarPonto4.SelectedValue);
            
            //sql += ", QUEST_1 = " + RbSatisfazPonto4.SelectedValue;
            //sql += ", QUEST_2 =" + RbAvaliePonto4.SelectedValue;
            //sql += ", QUEST_3 = " + RbAvalieSuporte.SelectedValue;

            //sql += ", QUEST_4 = " + RbAtendenteGentil.SelectedValue;
            //sql += ", QUEST_5 = " + RbAtendentePrestativo.SelectedValue;
            //sql += ", QUEST_6 = " + RbAtendenteRapido.SelectedValue;
            //sql += ", QUEST_7 = " + RbIndicarPonto4.SelectedValue;

            if (!string.IsNullOrEmpty(txtPqPonto4.Text))
                sql += string.Format(", QUEST_1_PQ = '{0}'", txtPqPonto4.Text);

            if (!string.IsNullOrEmpty(txtSugestao.Text))
                sql += string.Format(", QUEST_OBS = '{0}'", txtSugestao.Text);

            sql += string.Format(" WHERE QUEST_IND = {0}", ind);

            bd.executeCommand(sql);

            //else
            //{
            //bd.executeCommand(string.Format("INSERT INTO AssepontoQuestAtendimento (QUEST_DATA_ATUALIZACAO, QUEST_1, QUEST_2, QUEST_3 , QUEST_4, QUEST_5, QUEST_6, QUEST_7, QUEST_1_PQ, QUEST_OBS, QUEST_TECNICO, QUEST_PEN_FECHADO) VALUES (GETDATE(),'{0}', '{1}', '{2}','{3}', '{4}', '{5}', '{6}', '{7}', '{8}', 0, 0)", RbSatisfazPonto4.SelectedValue, RbAvaliePonto4.SelectedValue, RbAvalieSuporte.SelectedValue, RbAtendenteGentil.SelectedValue, RbAtendentePrestativo.SelectedValue, RbAtendenteRapido.SelectedValue, RbIndicarPonto4.SelectedValue, txtPqPonto4.Text, txtSugestao.Text));
            //}            
        }
    }
}