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
    [ToolboxData("<{0}:ServerPesquisaTecnologia runat=server></{0}:ServerPesquisaTecnologia>")]

    public class ServerPesquisaTecnologia : CompositeControl, INamingContainer
    {
        private Type.PesquisaTipo pesquisa = Type.PesquisaTipo.Tecnologia;

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

        private BDAppLocal bd;
        private BDAppLocal.BDAppTecnologia bdTecnologia;
        private RequiredFieldValidator Validator;
        private DataTable tdTables;
        private LinkButton btnEnviar;
        private Panel panel;
        private string NomeCliente = string.Empty;
        private string Empresa = string.Empty;

        #region Evento
        private static readonly object EventSubmitKey = new object();

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
            try
            {
                OnSubmit(EventArgs.Empty);
                foreach (Control cl in this.Controls)
                {
                    foreach (Control a in cl.Controls)
                    {
                        if (a is RadioButtonList)
                        {
                            int quest = Convert.ToInt32(a.ClientID.Split('-')[1]);
                            int value = Convert.ToInt32(((RadioButtonList)a).SelectedValue);
                            SaveBanco("", value, quest);
                        }

                        if (a is TextBox)
                        {
                            int quest = Convert.ToInt32(a.ClientID.Split('-')[1]);
                            string text = ((TextBox)a).Text;
                            SaveBanco(text, -1, quest);
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

        private void sendEmail()
        {
            try
            {
                EmailPesquisaFromAtendimento email = new EmailPesquisaFromAtendimento("informativo@assecontmail.com.br", null, Properties.Resources.EmailPesquisaFromAtendimento);
                email.send(string.Empty, Empresa, "http://assecont.com.br/assecont/Questionarios/pesquisaSatisfacaoTecnologia.aspx", Cliente, "mariac@assecont.com.br");
            }
            catch (Exception ex)
            {
                throw new Exception("Erro no envio do E-mail " + ex.Message);
            }
        }

        private void SaveBanco(string text, int value, int quest)
        {
            string queryText = "INSERT INTO QuestionariosRespostas (QUESRESP_PERGUNTA, QUESRESP_DISSERTATIVA, QUESRESP_CLIENTE_TECNOLOGIA) " +
                                                                            "VALUES ({0}, '{1}', {2})";

            string queryAlternativa = "INSERT INTO QuestionariosRespostas (QUESRESP_PERGUNTA, QUESRESP_ALTERNATIVA, QUESRESP_CLIENTE_TECNOLOGIA) " +
                                                                           "VALUES ({0}, {1}, {2})";
            if (value >= 0)
                bd.executeCommand(string.Format(queryAlternativa, quest, value, Cliente));
            else
                bd.executeCommand(string.Format(queryText, quest, text, Cliente));
        }

        protected override void CreateChildControls()
        {
            panel = new Panel();
            bdTecnologia = new BDAppLocal.BDAppTecnologia();
            bd = new BDAppLocal();
            Literal lit = new Literal();

            panel.ID = "panel";

            Cliente = Cliente > 0 ? Cliente : Convert.ToInt32((new Wr.Classes.Crypto()).Decrypt(Page.Request.QueryString["i"].Replace(' ', '+')));
            visualizar = string.IsNullOrEmpty(Page.Request.QueryString["V"]) ? false : Convert.ToBoolean((new Wr.Classes.Crypto()).Decrypt(Page.Request.QueryString["v"].Replace(' ', '+')));

            if (Cliente == 0)
                throw new Exception("Cliente não informado");

            string query = "SELECT CAD_RAZAOSOCIAL FROM AssepontoClientes WHERE CAD_IND = {0}";

            DataTable tdDados = bdTecnologia.getDataTable(string.Format(query, Cliente));

            foreach (DataRow dr in tdDados.Rows)
            {
                //NomeCliente = Wr.Classes.Strings.capitalizeWords(dr["NOME"].ToString());
                //lit.Text +=  + NomeCliente + "</b><br/>" + dr["CLI_RAZAOSOCIAL"].ToString();
                Empresa = dr["CAD_RAZAOSOCIAL"].ToString();
                lit.Text += "<br /><b style='font-size: 14pt; color: #0083E0;'>" + Empresa + "</b>";
            }

            panel.Controls.Add(lit);

            if (visualizar)
            {
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

                html += dr["DESCRICAO"] + "</td></tr>";

                if ((Type.alternativas)Convert.ToInt32(dr["TIPO"]) != Type.alternativas.Nenhum)
                {
                    html += "<tr><td style='padding-left: 30px; padding-bottom: 10px;'>";

                    lit.Text = html;
                    panel.Controls.Add(lit);

                    if ((Type.alternativas)Convert.ToInt32(dr["TIPO"]) == Type.alternativas.Bit)
                    {
                        RadioButtonList rb = Global.Bit(Convert.ToInt32(dr["QUESTAO"]));
                        name = rb.ID += i;
                        rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"]);
                        panel.Controls.Add(rb);
                    }

                    if ((Type.alternativas)Convert.ToInt32(dr["TIPO"]) == Type.alternativas.Numeracao)
                    {
                        RadioButtonList rb = Global.Numeracao(Convert.ToInt32(dr["QUESTAO"]));
                        name = rb.ID += i;
                        rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"]);
                        panel.Controls.Add(rb);
                    }


                    if ((Type.alternativas)Convert.ToInt32(dr["TIPO"]) == Type.alternativas.Dissertativa)
                    {
                        TextBox txt = Global.Dissertativa(Convert.ToInt32(dr["QUESTAO"]));
                        txt.ID += i;
                        txt.Text = dr["RESPOSTA"].ToString().Trim();
                        panel.Controls.Add(txt);
                    }

                    if ((Type.alternativas)Convert.ToInt32(dr["TIPO"]) == Type.alternativas.Frequencia)
                    {
                        RadioButtonList rb = Global.Frequencia(Convert.ToInt32(dr["QUESTAO"]));
                        name = rb.ID += i;
                        rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"]);
                        panel.Controls.Add(rb);
                    }

                    if ((Type.alternativas)Convert.ToInt32(dr["TIPO"]) == Type.alternativas.Qualificacao)
                    {
                        RadioButtonList rb = Global.Qualificacao(Convert.ToInt32(dr["QUESTAO"]));
                        name = rb.ID += i;
                        rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"]);
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
            btnEnviar.CssClass = "linkButtonEnviar";
            btnEnviar.Visible = false;

            this.Controls.Add(panel);
            this.Controls.Add(btnEnviar);
        }
        #endregion

        #region Gerar Perguntas
        void GerarPesquisa(Literal lit)
        {
            int i = 0;

            string sql = "SELECT QUESPG_IND, QUESPG_SUBORDEM, QUESPG_INFRAORDEM, QUESPG_DESCRICAO, QUESPG_QUEST_TIPO " +
                            "FROM QuestionariosPerguntas  " +
                            "WHERE NOT EXISTS(SELECT QUESRESP_CLIENTE_TECNOLOGIA  " +
                            "FROM QuestionariosRespostas WHERE QUESRESP_CLIENTE_TECNOLOGIA = {0} AND " +
                            "DATEADD (MONTH, 2 ,QUESRESP_DATA) > GETDATE()) AND " +
                            "QUESPG_QUESTIONARIO = {1} ORDER BY QUESPG_ORDEM, QUESPG_SUBORDEM, QUESPG_INFRAORDEM ";

            tdTables = bd.getDataTable(string.Format(sql, Cliente, (int)pesquisa));

            if (tdTables.Rows.Count > 0)
            {
                string html = css.style() + css.styleNumber() + "   <div style='font-size: 11pt;'> " +
                        "As respostas abaixo não serão reveladas aos colaboradores, somente a diretoria e a  " +
                        "área da qualidade, para que sejam estudadas as melhorias. Sua contribuição é muito importante. " +
                        "</div><table style='font-size: 11pt;'>";
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

                    html += dr["QUESPG_DESCRICAO"] + "</td></tr>";

                    if ((Type.alternativas)dr["QUESPG_QUEST_TIPO"] != Type.alternativas.Nenhum)
                    {
                        html += "<tr><td style='padding-left: 30px; padding-bottom: 10px;'>";

                        lit.Text = html;
                        panel.Controls.Add(lit);

                        if ((Type.alternativas)dr["QUESPG_QUEST_TIPO"] == Type.alternativas.Bit)
                        {
                            RadioButtonList rb = Global.Bit(Convert.ToInt32(dr["QUESPG_IND"]));
                            name = rb.ID;
                            panel.Controls.Add(rb);
                        }

                        if ((Type.alternativas)dr["QUESPG_QUEST_TIPO"] == Type.alternativas.Numeracao)
                        {
                            RadioButtonList rb = Global.Numeracao(Convert.ToInt32(dr["QUESPG_IND"]));
                            name = rb.ID;
                            panel.Controls.Add(rb);
                        }

                        if ((Type.alternativas)dr["QUESPG_QUEST_TIPO"] == Type.alternativas.Dissertativa)
                        {
                            TextBox txt = Global.Dissertativa(Convert.ToInt32(dr["QUESPG_IND"]));
                            panel.Controls.Add(txt);
                        }

                        if ((Type.alternativas)dr["QUESPG_QUEST_TIPO"] == Type.alternativas.Frequencia)
                        {
                            RadioButtonList rb = Global.Frequencia(Convert.ToInt32(dr["QUESPG_IND"]));
                            name = rb.ID;
                            panel.Controls.Add(rb);
                        }

                        if ((Type.alternativas)dr["QUESPG_QUEST_TIPO"] == Type.alternativas.Qualificacao)
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
                btnEnviar.CssClass = "linkButton";
                btnEnviar.Click += new EventHandler(_button_Click);

                lit = new Literal();
                lit.Text = html + "</div>";
                panel.Controls.Add(lit);

                this.Controls.Add(panel);
                this.Controls.Add(btnEnviar);
            }
            else
            {
                Page.Response.RedirectPermanent("http://www.assecont.com.br/assecont/avisos/ErrorQuestionarioJaRealizado.aspx");
            }
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
    }
}