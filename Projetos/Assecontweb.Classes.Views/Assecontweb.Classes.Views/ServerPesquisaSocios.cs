using System;
using System.ComponentModel;
using System.Data;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace Assecontweb.Classes.Views
{
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal),
    AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal),
    DefaultEvent("Submit"), DefaultProperty("ButtonText"),]
    [ToolboxData("<{0}:ServerPesquisaSocios runat=server></{0}:ServerPesquisaSocios>")]

    public class ServerPesquisaSocios : CompositeControl, INamingContainer
    {
        #region Getters & Setters
        private int _Cliente;
        public int Cliente
        {
            get { return _Cliente; }
            set { _Cliente = value; }
        }

        private string _pageRedirect;
        public string pageRedirect
        {
            get { return _pageRedirect; }
            set { _pageRedirect = value; }
        }

        private Type.PesquisaTipo pesquisa = Type.PesquisaTipo.Socio;

        private bool _visualizar;
        public bool visualizar
        {
            get { return _visualizar; }
            set { _visualizar = value; }
        }

        private DateTime _dataResposta;
        public DateTime dataResposta
        {
            get { return _dataResposta; }
            set { _dataResposta = value; }
        }
        #endregion

        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        BDAppAssecont bd;
        DataTable tdTables;
        private RequiredFieldValidator Validator;
        private LinkButton btnEnviar;
        private Panel panel;
        private string NomeCliente = string.Empty;
        private string Empresa = string.Empty;

        private static readonly object EventSubmitKey = new object();

        #region Evento
        [Category("Action"),
        Description("Raised when the user clicks the button.")]
        public event EventHandler Submit
        {
            add
            {
                Events.AddHandler(EventSubmitKey, value);
            }
            remove
            {
                Events.RemoveHandler(EventSubmitKey, value);
            }
        }

        protected virtual void OnSubmit(EventArgs e)
        {
            EventHandler SubmitHandler = (EventHandler)Events[EventSubmitKey];

            if (SubmitHandler != null)
            {
                SubmitHandler(this, e);
            }
        }

        #endregion

        private void _button_Click(object source, EventArgs e)
        {
            OnSubmit(EventArgs.Empty);
            if (Page.IsValid)
            {
                try
                {
                    int idDados = SaveBancoDados();
                    foreach (Control cl in this.Controls)
                    {
                        foreach (Control a in cl.Controls)
                        {
                            if (a is RadioButtonList)
                            {
                                int quest = Convert.ToInt32(a.ClientID.Split('-')[1]);
                                int value = Convert.ToInt32(((RadioButtonList)a).SelectedValue);
                                SaveBanco(string.Empty, value, quest, idDados);
                            }

                            if (a is TextBox)
                            {
                                int quest = Convert.ToInt32(a.ClientID.Split('-')[1]);
                                string text = ((TextBox)a).Text;
                                SaveBanco(text, -1, quest, idDados);
                            }
                        }
                    }
                    sendEmail();
                }
                catch (Exception ex)
                {
                    Page.Response.RedirectPermanent("http://assecont.com.br/assecont/Avisos/ErroTela.aspx");
                }

                if (string.IsNullOrEmpty(pageRedirect))
                    Page.DataBind();
                else
                    Page.Response.RedirectPermanent(pageRedirect);
            }
        }

        private void sendEmail()
        {
            try
            {
                bd.executeCommand("UPDATE ClientesSocios SET CLISOC_QUESTIONARIO_RESPONDIDOEM = GETDATE() WHERE CLISOC_IND = " + Cliente);

                EmailPesquisaFromAtendimento email = new EmailPesquisaFromAtendimento("informativo@assecontmail.com.br", null, Properties.Resources.EmailPesquisaFromAtendimento);
                email.send(NomeCliente, Empresa, "http://assecont.com.br/assecont/pesquisas/pesquisaSatisfacao.aspx", Cliente, "debora@assecont.com.br");
            }
            catch (Exception ex)
            {
                throw new Exception("Erro no envio do E-mail " + ex.Message);
            }
        }

        private void SaveBanco(string text, int value, int quest, int idDados)
        {
            string queryText = "INSERT INTO QuestionariosRespostas (QUESRESP_PERGUNTA, QUESRESP_DISSERTATIVA, QUESRESP_RESPOSTA_DADOS) " +
                                                                            "VALUES ({0}, '{1}', {2})";

            string queryAlternativa = "INSERT INTO QuestionariosRespostas (QUESRESP_PERGUNTA, QUESRESP_ALTERNATIVA, QUESRESP_RESPOSTA_DADOS) " +
                                                                           "VALUES ({0}, {1}, {2})";
            if (value >= 0)
                bd.executeCommand(string.Format(queryAlternativa, quest, value, idDados));
            else
                bd.executeCommand(string.Format(queryText, quest, text, idDados));
        }

        private int SaveBancoDados()
        {
            string query = "INSERT INTO QuestionariosRespostasDados (QUERESDADOS_SOCIO) VALUES ({0}) SELECT @@IDENTITY ";

            return bd.getFieldValueInteger(string.Format(query, Cliente));
        }

        private bool verificarPrazoQuestionario()
        {
            if (DateTime.Now.Month >= 1 && DateTime.Now.Month <= 6)
                return true;
            return false;
        }

        protected override void CreateChildControls()
        {
            panel = new Panel();
            bd = new BDAppAssecont();
            Literal lit = new Literal();

            panel.ID = "panel";

            Cliente = Cliente > 0 ? Cliente : Convert.ToInt32((new Wr.Classes.Crypto()).Decrypt(Page.Request.QueryString["i"].Replace(' ', '+')));
            visualizar = string.IsNullOrEmpty(Page.Request.QueryString["V"]) ? false : Convert.ToBoolean((new Wr.Classes.Crypto()).Decrypt(Page.Request.QueryString["v"].Replace(' ', '+')));
            dataResposta = Page.Request.QueryString["D"] == "" ? (new DateTime()) : Convert.ToDateTime(Page.Request.QueryString["D"]);

            if (Cliente == 0)
                throw new Exception("Cliente não informado");

            string query = "SELECT a.CLISOC_NOME AS NOME, CLI_RAZAOSOCIAL FROM ClientesSocios a " +
                "INNER JOIN Clientes ON CLI_IND = CLISOC_CLIENTE WHERE a.CLISOC_IND = {0} " +
                //"WHERE CLISOC_DESLIGAMENTO IS NULL AND CLI_DATA_ENCERRAMENTO IS NULL AND CLISOC_EMAIL IS NOT NULL AND " +
                //"EXISTS(SELECT * FROM ClientesSocios b WHERE b.CLISOC_EMAIL = a.CLISOC_EMAIL AND b.CLISOC_IND = {0}) " +
                "ORDER BY CLI_RAZAOSOCIAL ASC";

            DataTable tdDados = bd.getDataTable(string.Format(query, Cliente));

            foreach (DataRow dr in tdDados.Rows)
            {
                if (NomeCliente.ToLower() != dr["NOME"].ToString().ToLower())
                {
                    NomeCliente = Wr.Classes.Strings.capitalizeWords(dr["NOME"].ToString());
                    lit.Text += "<br /><b style='color: #0083E0;'>" + NomeCliente + "</b><br/>" + dr["CLI_RAZAOSOCIAL"].ToString();
                }
                //else
                //{
                //    lit.Text += ", " + dr["CLI_RAZAOSOCIAL"].ToString();
                //}

                Empresa = dr["CLI_RAZAOSOCIAL"].ToString();
            }

            panel.Controls.Add(lit);
            lit = new Literal();

            if (visualizar)
            {
                //panel.Controls.Add(lit);
                GerarRespostas(lit);
            }
            else
                GerarPesquisa(lit);
        }

        #region Gerar Resposta
        void GerarRespostas(Literal lit)
        {
            int i = 0;

            string sql = dataResposta == new DateTime() ? "EXEC rs_questionario_detalhado @P_INDICE = {0}, @P_PESQUISA_TIPO =  {1}" : "EXEC rs_questionario_detalhado @P_INDICE = {0}, @P_PESQUISA_TIPO = {1}, @P_DATARESPOSTA = '{2}'";

            tdTables = bd.getDataTable(string.Format(sql, Cliente, (int)pesquisa, dataResposta));

            string html = css.style() + css.styleNumber() + "<table style='font-size: 11pt;'>";
            string name = string.Empty;

            foreach (DataRow dr in tdTables.Rows)
            {
                bool subOrdem = dr["SUBORDEM"] is DBNull ? false : true;
                bool infraOrdem = dr["INFRAORDEM"] is DBNull ? false : true;

                lit = new Literal();
                if (subOrdem && !infraOrdem)
                    html += "<tr><td style='padding-left: 15px; font-weight: 600;'>" + dr["SUBORDEM"] + ") ";

                if (!infraOrdem && !subOrdem)
                    html += "<tr><td colspan='2' style='padding-top: 25px; padding-bottom: 15px;'>";

                if (infraOrdem)
                    html += "<tr><td style='padding-left: 30px; font-weight: 600;'>";

                html += dr["DESCRICAO"];

                if (!(dr["RESPONSAVEL_DEPTO"] is DBNull) && !dr["RESPONSAVEL_DEPTO"].ToString().Equals("Indefinido"))
                    html += "<br/>&nbsp; &nbsp; &nbsp;Responsável <span style='color: #428BCA; '>" + dr["RESPONSAVEL_DEPTO"] + "</span>";

                html += "</td></tr>";

                if ((Type.Alternativas)Convert.ToInt32(dr["TIPO"]) != Type.Alternativas.Nenhum)
                {
                    html += "<tr><td style='padding-left: 30px; padding-bottom: 10px;'>";

                    lit.Text = html;
                    panel.Controls.Add(lit);

                    if ((Type.Alternativas)Convert.ToInt32(dr["TIPO"]) == Type.Alternativas.Bit)
                    {
                        RadioButtonList rb = Global.Bit(Convert.ToInt32(dr["QUESTAO"]));
                        name = rb.ID += i;
                        rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"] is DBNull ? 0 : dr["RESPOSTA"]);
                        panel.Controls.Add(rb);
                    }

                    if ((Type.Alternativas)Convert.ToInt32(dr["TIPO"]) == Type.Alternativas.Numeracao)
                    {
                        RadioButtonList rb = Global.Numeracao(Convert.ToInt32(dr["QUESTAO"]));
                        name = rb.ID += i;
                        rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"] is DBNull ? 0 : dr["RESPOSTA"]);
                        panel.Controls.Add(rb);
                    }


                    if ((Type.Alternativas)Convert.ToInt32(dr["TIPO"]) == Type.Alternativas.Dissertativa)
                    {
                        TextBox txt = Global.Dissertativa(Convert.ToInt32(dr["QUESTAO"]));
                        txt.ID += i;
                        txt.Text = (dr["RESPOSTA"] is DBNull ? "" : dr["RESPOSTA"]).ToString().Trim();
                        panel.Controls.Add(txt);
                    }

                    if ((Type.Alternativas)Convert.ToInt32(dr["TIPO"]) == Type.Alternativas.Frequencia)
                    {
                        RadioButtonList rb = Global.Frequencia(Convert.ToInt32(dr["QUESTAO"]));
                        name = rb.ID += i;
                        rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"] is DBNull ? 0 : dr["RESPOSTA"]);
                        panel.Controls.Add(rb);
                    }

                    if ((Type.Alternativas)Convert.ToInt32(dr["TIPO"]) == Type.Alternativas.Qualificacao)
                    {
                        RadioButtonList rb = Global.Qualificacao(Convert.ToInt32(dr["QUESTAO"]));
                        name = rb.ID += i;
                        rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"] is DBNull ? 0 : dr["RESPOSTA"]);
                        panel.Controls.Add(rb);
                    }

                    lit = new Literal();
                    html = "</td></tr>";
                }

                lit.Text = html;
                panel.Controls.Add(lit);
                html = string.Empty;

                i++;
            }

            lit = new Literal();
            lit.Text = html + "</td></tr></table>";
            panel.Controls.Add(lit);

            btnEnviar = new LinkButton();
            btnEnviar.ID = "btEnviar";
            btnEnviar.Text = "Enviar Respostas";
            btnEnviar.CssClass = "linkButton";
            btnEnviar.Visible = false;

            this.Controls.Add(panel);
            this.Controls.Add(btnEnviar);
        }
        #endregion

        #region Gerar Perguntas
        void GerarPesquisa(Literal lit)
        {
            int i = 0;

            string sql = "SELECT QUESPG_IND, QUESPG_SUBORDEM, QUESPG_INFRAORDEM, QUESPG_DESCRICAO, QUESPG_QUEST_TIPO,  " +

                    "(SELECT (CASE WHEN QUESPG_ADD_DPTO_RESPONSAVEL IS NOT NULL THEN LOGI_NOME ELSE NULL END)  " +
                    "FROM LoginsInternos " +
                    "WHERE LOGI_IND = dbo.fn_cliente_login_interno_home_office({0}, QUESPG_ADD_DPTO_RESPONSAVEL)) AS INTERNO  " +
                    "FROM QuestionariosPerguntas " +
                    "WHERE QUESPG_QUESTIONARIO = 1 AND  " +

                    "NOT EXISTS (SELECT * FROM QuestionariosRespostasDados  " +
                    "INNER JOIN ClientesSocios ON QUERESDADOS_SOCIO = CLISOC_IND WHERE QUERESDADOS_SOCIO = {0} " +
                    "AND QUERESDADOS_DATA >= '%DATAINICIAL%' AND QUERESDADOS_DATA <= '%DATAFINAL%') " +

                    "ORDER BY QUESPG_ORDEM, QUESPG_SUBORDEM, QUESPG_INFRAORDEM ";

            if (verificarPrazoQuestionario())
            {
                sql = sql.Replace("%DATAINICIAL%", DateTime.Now.ToString("01/01/yyyy"));
                sql = sql.Replace("%DATAFINAL%", DateTime.Now.ToString("30/06/yyyy"));
            }
            else
            {
                sql = sql.Replace("%DATAINICIAL%", DateTime.Now.ToString("01/07/yyyy"));
                sql = sql.Replace("%DATAFINAL%", DateTime.Now.ToString("31/12/yyyy"));
            }

            tdTables = bd.getDataTable(string.Format(sql, Cliente));

            string html = css.style() + css.styleNumber() +
                    "  <div style='font-size: 11pt; padding-top: 10px;'> " +
                    "As respostas abaixo não serão reveladas aos colaboradores, somente a diretoria e a  " +
                    "área da qualidade, para que sejam estudadas as melhorias. Sua contribuição é muito importante. " +
                    "</div> <table style='font-size: 11pt;'>";

            string name = string.Empty;

            foreach (DataRow dr in tdTables.Rows)
            {
                bool subOrdem = dr["QUESPG_SUBORDEM"] is DBNull ? false : true;
                bool infraOrdem = dr["QUESPG_INFRAORDEM"] is DBNull ? false : true;

                lit = new Literal();
                if (subOrdem && !infraOrdem)
                    html += "<tr><td style='padding-left: 15px; font-weight: 600;'>" + dr["QUESPG_SUBORDEM"] + ") ";

                if (!infraOrdem && !subOrdem)
                    html += "<tr><td colspan='2' style='padding-top: 25px; padding-bottom: 15px;'>";

                if (infraOrdem)
                    html += "<tr><td style='padding-left: 30px; font-weight: 600;'>";

                html += dr["QUESPG_DESCRICAO"];

                if (!(dr["INTERNO"] is DBNull) && !dr["INTERNO"].ToString().Equals("Indefinido"))
                    html += "<br/>&nbsp; &nbsp; &nbsp;Responsável <span style='color: #428BCA; '>" + dr["INTERNO"] + "</span>";

                html += "</td></tr>";

                if ((Type.Alternativas)dr["QUESPG_QUEST_TIPO"] != Type.Alternativas.Nenhum)
                {
                    html += "<tr><td style='padding-left: 30px; padding-bottom: 10px;'>";

                    lit.Text = html;
                    panel.Controls.Add(lit);

                    if ((Type.Alternativas)dr["QUESPG_QUEST_TIPO"] == Type.Alternativas.Bit)
                    {
                        RadioButtonList rb = Global.Bit(Convert.ToInt32(dr["QUESPG_IND"]));
                        name = rb.ID;
                        panel.Controls.Add(rb);
                    }

                    if ((Type.Alternativas)dr["QUESPG_QUEST_TIPO"] == Type.Alternativas.Numeracao)
                    {
                        RadioButtonList rb = Global.Numeracao(Convert.ToInt32(dr["QUESPG_IND"]));
                        name = rb.ID;
                        panel.Controls.Add(rb);
                    }

                    if ((Type.Alternativas)dr["QUESPG_QUEST_TIPO"] == Type.Alternativas.Dissertativa)
                    {
                        TextBox txt = Global.Dissertativa(Convert.ToInt32(dr["QUESPG_IND"]));
                        panel.Controls.Add(txt);
                    }

                    if ((Type.Alternativas)dr["QUESPG_QUEST_TIPO"] == Type.Alternativas.Frequencia)
                    {
                        RadioButtonList rb = Global.Frequencia(Convert.ToInt32(dr["QUESPG_IND"]));
                        name = rb.ID;
                        panel.Controls.Add(rb);
                    }

                    if ((Type.Alternativas)dr["QUESPG_QUEST_TIPO"] == Type.Alternativas.Qualificacao)
                    {
                        RadioButtonList rb = Global.Qualificacao(Convert.ToInt32(dr["QUESPG_IND"]));
                        name = rb.ID;
                        panel.Controls.Add(rb);
                    }

                    if (name != "")
                    {
                        Validator = new RequiredFieldValidator();
                        Validator.ID = "validator" + i;
                        Validator.ControlToValidate = name;
                        Validator.Text = "Obrigatório";
                        Validator.CssClass = "ViewsValidator";
                        Validator.SetFocusOnError = true;
                        panel.Controls.Add(Validator);
                        name = string.Empty;
                    }

                    lit = new Literal();
                    html = "</td></tr>";
                }

                lit.Text = html;
                panel.Controls.Add(lit);
                html = string.Empty;

                i++;
            }

            lit = new Literal();
            lit.Text = html + "</td></tr></table><div>";
            panel.Controls.Add(lit);

            btnEnviar = new LinkButton();
            btnEnviar.ID = "btEnviar";
            btnEnviar.Text = "Enviar Respostas";
            btnEnviar.CssClass = "linkButtonEnviar";
            btnEnviar.Click += new EventHandler(_button_Click);

            lit = new Literal();
            lit.Text = html + "</div>";
            panel.Controls.Add(lit);

            this.Controls.Add(panel);
            this.Controls.Add(btnEnviar);
        }
        #endregion

        protected override void RecreateChildControls()
        {
            EnsureChildControls();
        }

        protected override void Render(HtmlTextWriter writer)
        {
            panel.RenderControl(writer);
            btnEnviar.RenderControl(writer);
        }

        private class BDAppAssecont : Wr.Classes.BD
        {
            public BDAppAssecont()
            {
                Conectar(new BDConnection("200.170.88.138", "assecont2", "assecont5272", "*h6prMvr"));
            }
        }
    }
}
