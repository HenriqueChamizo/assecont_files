using System;
using System.Data;
using System.Web.UI;

namespace Assecontweb.Classes.Views
{
    [ToolboxData("<{0}:ServerPesquisaFuncionario runat=server></{0}:ServerPesquisaFuncionario>")]

    public class ServerPesquisaFuncionario : ServerPesquisa
    {
        #region Getters & Setters
        private int _funcionario;
        public int funcionario
        {
            get { return _funcionario; }
            set { _funcionario = value; }
        }
        #endregion

        protected override bool getBotaoIgnorar() { return false; }
        protected override bool getBotaoEnviar() { return true; }
        protected override bool getExibirQuestaoResposta() { return true; }

        protected override void pageRedirect(string url)
        {
            string pageRedirect = UserApp.RedirectAfterQuestion;
            UserApp.RedirectAfterQuestion = string.Empty;
            base.pageRedirect(pageRedirect);
        }

        protected override int setRespostasDados()
        {
            string query = "INSERT INTO QuestionariosRespostasDados (QUERESDADOS_AVALIADOR_INTERNO, QUERESDADOS_LOGIN_INTERNO, QUERESDADOS_SETOR) VALUES ({0}, {1}, {2}) SELECT @@IDENTITY ";
            return bd.getFieldValueInteger(string.Format(query, UserApp.UserId, funcionario, (int)UserApp.Setor));
        }

        protected override void onLoad()
        {
            if (questId > 0)
                GerarRespostas(Type.PesquisaTipo.Funcionario);
            else
                GerarPesquisa(Type.PesquisaTipo.Funcionario);
        }

        protected override void GerarRespostas(Type.PesquisaTipo pesquisa)
        {
            base.GerarRespostas(pesquisa);
        }

        protected override void GerarPesquisa(Type.PesquisaTipo pesquisa)
        {
            base.GerarPesquisa(pesquisa);
        }

        public override string getCabecalho(DataRow dr)
        {
            if (questId > 0)
            {
                base.getCabecalho(dr);
                return "<div style='font-size: 11pt; padding-top: 10px;'>Funcionário(a): " +
                    "<span style='color: #0086E7; padding-right: 40px; '>" + dr["RESPONSAVEL_DEPTO"].ToString() + "</span> " +
                    "Avaliador(a): <span style='color: #0086E7;'>" + dr["AVALIADOR"].ToString() + "</span></div>";
            }
            else
            {
                string func_nome = bd.getLoginInternoNome(funcionario);
                return "<div style='font-size: 11pt; padding-top: 10px;'>Funcionário(a): " +
                    "<span style='color: #0086E7; padding-right: 40px; '>" + func_nome + "</span> " +
                    "Avaliador(a): <span style='color: #0086E7;'>" + UserApp.UserId_Nome + "</span></div>";
            }
        }

        //protected virtual void _buttonIgnorar_Click(object source, EventArgs e)
        //{
        //    try
        //    {
        //        bd.executeCommand("UPDATE LoginsExternos SET LOGE_IGNORAR_QUESTIONARIO = GETDATE() WHERE LOGE_IND = " + UserApp.UserId);
        //    }
        //    catch (Exception ex)
        //    { }

        //    UserApp.IgnoreQuestion = true;
        //    pageRedirect(string.Empty);
        //}
    }
}