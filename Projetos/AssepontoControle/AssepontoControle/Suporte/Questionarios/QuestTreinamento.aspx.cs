using System;
using Asseponto.Classes;

namespace Asseponto.Suporte.Questionarios
{
    public partial class QuestTreinamento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int ind = Convert.ToInt32(Request.QueryString["ind"]);

            BDApp bd = new BDApp();
            if (bd.getFieldValueString(string.Format("SELECT QUEST_TREI_ATUALIZACAO FROM AssepontoQuestTreinamento WHERE QUEST_TREI_IND = {0}", ind)) != "")
                Response.RedirectPermanent("~/suporte/Questionarios/DuplicacaoQuestionario.aspx");
        }

        protected void lkEnviar_Click(object sender, EventArgs e)
        {
            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            InserirQuestionario(ind);
        }

        protected void InserirQuestionario(int ind)
        {
            BDApp bd = new BDApp();

            if (ind != 0)
            {
                bd.executeCommand(string.Format("UPDATE AssepontoQuestTreinamento SET QUEST_TREI_1 = '{0}', QUEST_TREI_2 = '{1}', QUEST_TREI_OBS = '{2}', QUEST_TREI_ATUALIZACAO = GETDATE() WHERE QUEST_TREI_IND = {3}", dbDificuldatdes.SelectedValue, dbExperiencia.SelectedValue, txtSugestao.Text, ind));
            }
            else 
            {
                bd.executeCommand(string.Format("INSERT INTO AssepontoQuestTreinamento (QUEST_TREI_1, QUEST_TREI_2, QUEST_TREI_OBS, QUEST_TREI_ATUALIZACAO, QUEST_TREI_TECNICO) VALUES ('{0}', '{1}', '{2}', GETDATE(), 8)", dbDificuldatdes.SelectedValue, dbExperiencia.SelectedValue, txtSugestao.Text));
            }
            Response.Redirect("~/suporte/Questionarios/ConfirmacaoQuestionario.aspx");
        }
    }
}