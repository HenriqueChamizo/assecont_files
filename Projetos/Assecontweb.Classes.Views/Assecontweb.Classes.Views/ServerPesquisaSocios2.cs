using System;
using System.ComponentModel;
using System.Data;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assecontweb.Classes.Views
{
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal),
    AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal),
    DefaultEvent("Submit"), DefaultProperty("ButtonText"),]
    [ToolboxData("<{0}:ServerPesquisaSocios runat=server></{0}:ServerPesquisaSocios>")]

    public class ServerPesquisaSocios2 : ServerPesquisa
    {
        #region Getters & Setters
        private int _Socio;
        public int SocioId
        {
            get { return _Socio; }
            set { _Socio = value; }
        }

        private string _pageUrl;
        public string PageUrl
        {
            get { return _pageUrl; }
            set { _pageUrl = value; }
        }
        #endregion

        private string NomeCliente = string.Empty;
        private string Empresa = string.Empty;

        protected override bool getBotaoIgnorar() { return false; }
        protected override bool getBotaoEnviar() { return true; }
        protected override bool getExibirQuestaoResposta() { return true; }

        protected override void pageRedirect(string url)
        {
            base.pageRedirect(PageUrl);
        }

        protected override void btnEnviarClick()
        {
            sendEmail();
        }

        private void sendEmail()
        {
            try
            {
                bd.executeCommand("UPDATE ClientesSocios SET CLISOC_QUESTIONARIO_RESPONDIDOEM = GETDATE() WHERE CLISOC_IND = " + SocioId);

                EmailPesquisaFromAtendimento email = new EmailPesquisaFromAtendimento("informativo@assecontmail.com.br", null, Properties.Resources.EmailPesquisaFromAtendimento);
                email.send(NomeCliente, Empresa, "http://assecont.com.br/assecont/pesquisas/pesquisaSatisfacao.aspx", SocioId, "debora@assecont.com.br");
            }
            catch (Exception ex)
            {
                throw new Exception("Erro no envio do E-mail " + ex.Message);
            }
        }

        protected override int setRespostasDados()
        {
            string query = "INSERT INTO QuestionariosRespostasDados (QUERESDADOS_SOCIO) VALUES ({0}) SELECT @@IDENTITY ";
            return bd.getFieldValueInteger(string.Format(query, SocioId));
        }

        private bool verificarPrazoQuestionario()
        {
            if (DateTime.Now.Month >= 1 && DateTime.Now.Month <= 6)
                return true;
            return false;
        }

        protected override void onLoad()
        {
            if (SocioId == 0)
                throw new Exception("Cliente não informado");

            if (questId > 0)
                GerarRespostas(Type.PesquisaTipo.Socio);
            else
                GerarPesquisa(Type.PesquisaTipo.Socio);
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
            string html = "  <div style='font-size: 11pt; padding-top: 10px;'> " +
                    "As respostas abaixo não serão reveladas aos colaboradores, somente a diretoria e a  " +
                    "área da qualidade, para que sejam estudadas as melhorias. Sua contribuição é muito importante. " +
                    "</div><table><tr><td style='font-size: 11pt;'>";

            string query = "SELECT a.CLISOC_NOME AS NOME, CLI_RAZAOSOCIAL FROM ClientesSocios a " +
                "INNER JOIN Clientes ON CLI_IND = CLISOC_CLIENTE WHERE a.CLISOC_IND = {0} " +
                "ORDER BY CLI_RAZAOSOCIAL ASC";

            DataTable tableDados = bd.getDataTable(string.Format(query, SocioId));

            foreach (DataRow drDados in tableDados.Rows)
            {
                if (NomeCliente.ToLower() != dr["NOME"].ToString().ToLower())
                {
                    NomeCliente = Wr.Classes.Strings.capitalizeWords(dr["NOME"].ToString());
                    html += "<br /><b style='color: #0083E0;'>" + NomeCliente + "</b><br/>" + dr["CLI_RAZAOSOCIAL"].ToString();
                }
                //Empresa = dr["CLI_RAZAOSOCIAL"].ToString();
            }

            return html;
        }

        //#region Gerar Perguntas
        //void GerarPesquisa(Literal lit)
        //{
        //    int i = 0;

        //    string sql = "SELECT QUESPG_IND, QUESPG_SUBORDEM, QUESPG_INFRAORDEM, QUESPG_DESCRICAO, QUESPG_QUEST_TIPO,  " +

        //            "(SELECT (CASE WHEN QUESPG_ADD_DPTO_RESPONSAVEL IS NOT NULL THEN LOGI_NOME ELSE NULL END)  " +
        //            "FROM LoginsInternos " +
        //            "WHERE LOGI_IND = dbo.fn_cliente_login_interno_home_office({0}, QUESPG_ADD_DPTO_RESPONSAVEL)) AS INTERNO  " +
        //            "FROM QuestionariosPerguntas " +
        //            "WHERE QUESPG_QUESTIONARIO = 1 AND  " +

        //            "NOT EXISTS (SELECT * FROM QuestionariosRespostasDados  " +
        //            "INNER JOIN ClientesSocios ON QUERESDADOS_SOCIO = CLISOC_IND WHERE QUERESDADOS_SOCIO = {0} " +
        //            "AND QUERESDADOS_DATA >= '%DATAINICIAL%' AND QUERESDADOS_DATA <= '%DATAFINAL%') " +

        //            "ORDER BY QUESPG_ORDEM, QUESPG_SUBORDEM, QUESPG_INFRAORDEM ";

        //    if (verificarPrazoQuestionario())
        //    {
        //        sql = sql.Replace("%DATAINICIAL%", DateTime.Now.ToString("01/01/yyyy"));
        //        sql = sql.Replace("%DATAFINAL%", DateTime.Now.ToString("30/06/yyyy"));
        //    }
        //    else
        //    {
        //        sql = sql.Replace("%DATAINICIAL%", DateTime.Now.ToString("01/07/yyyy"));
        //        sql = sql.Replace("%DATAFINAL%", DateTime.Now.ToString("31/12/yyyy"));
        //    }

        //    tdTables = bd.getDataTable(string.Format(sql, SocioId));
        //}
    }
}
