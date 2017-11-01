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

    public abstract class ServerPesquisa : CompositeControl
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        protected int questId;
        public int QuestId
        {
            get { return questId; }
            set { questId = value; }
        }

        protected BDAppLocal.BDAppAssecont bd;
        protected DataTable tdTables;
        protected RequiredFieldValidator Validator;
        protected LinkButton btnEnviar;
        protected LinkButton btnIgnorar;
        protected Panel panel;
        protected int loginIterno = 0;
        protected bool isCliente = false;

        protected abstract bool getBotaoIgnorar();
        protected abstract bool getBotaoEnviar();
        protected abstract bool getExibirQuestaoResposta();

        private static readonly object EventSubmitKey = new object();

        #region Evento
        [Category("Action"), Description("Raised when the user clicks the button.")]
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

        protected virtual void _buttonIgnorar_Click(object source, EventArgs e) { }

        #region Botão Enviar Resposta
        protected void _button_Click(object source, EventArgs e)
        {
            OnSubmit(EventArgs.Empty);
            if (Page.IsValid)
            {
                int idDados = setRespostasDados();
                foreach (Control cl in this.Controls)
                {
                    foreach (Control a in cl.Controls)
                    {
                        if (a is RadioButtonList)
                        {
                            string[] title = a.ClientID.Split('-');
                            int quest = Convert.ToInt32(title[1]);

                            int value = Convert.ToInt32(((RadioButtonList)a).SelectedValue);
                            setRespostas(string.Empty, value, quest, idDados);
                        }

                        if (a is TextBox)
                        {
                            string[] title = a.ClientID.Split('-');
                            int quest = Convert.ToInt32(title[1]);

                            string text = ((TextBox)a).Text;
                            setRespostas(text, -1, quest, idDados);
                        }
                    }
                }

                btnEnviarClick();
                pageRedirect(string.Empty);
            }
        }
        #endregion

        protected virtual void btnEnviarClick()
        {
 
        }

        protected virtual void pageRedirect(string url)
        {
            Page.Response.Redirect(url);
        }

        void setRespostas(string Texto, int Value, int QuestaoId, int DadosId)
        {
            string queryText = "INSERT INTO QuestionariosRespostas (QUESRESP_PERGUNTA, QUESRESP_DISSERTATIVA, QUESRESP_RESPOSTA_DADOS) VALUES ({0}, '{1}', {2}) ";
            string queryAlternativa = "INSERT INTO QuestionariosRespostas (QUESRESP_PERGUNTA, QUESRESP_ALTERNATIVA, QUESRESP_RESPOSTA_DADOS) VALUES ({0}, {1}, {2}) ";

            if (Value >= 0)
                bd.executeCommand(string.Format(queryAlternativa, QuestaoId, Value, DadosId));
            else
                bd.executeCommand(string.Format(queryText, QuestaoId, Texto, DadosId));
        }

        protected virtual int setRespostasDados()
        {
            return 0;
        }

        protected override void CreateChildControls()
        {
            bd = new BDAppLocal.BDAppAssecont();
            panel = new Panel();
            panel.ID = "panel";
            onLoad();
        }

        protected virtual void onLoad() { }

        #region Gerar Resposta
        protected virtual void GerarRespostas(Type.PesquisaTipo pesquisa)
        {
            Literal literal = new Literal();

            int i = 0;
            string name = string.Empty;
            string sql = "EXEC rs_questionario_detalhado @P_PESQUISA_TIPO = {0}, @P_INDICE = {1} ";

            tdTables = bd.getDataTable(string.Format(sql, (int)pesquisa, QuestId));
            string html = css.style() + css.styleNumber();

            html += getCabecalho(tdTables.Rows[0]);

            html += "<table style='font-size: 11pt;'>";

            foreach (DataRow dr in tdTables.Rows)
            {
                if (getExibirQuestaoResposta())
                {
                    bool subOrdem = dr["SUBORDEM"] is DBNull ? false : true;
                    bool infraOrdem = dr["INFRAORDEM"] is DBNull ? false : true;

                    literal = new Literal();
                    if (subOrdem && !infraOrdem)
                        html += "<tr><td style='padding-left: 15px; font-weight: 600;'>" + dr["SUBORDEM"] + ") ";

                    if (!infraOrdem && !subOrdem)
                        html += "<tr><td colspan='2' style='padding-top: 25px; padding-bottom: 15px;'>";

                    if (infraOrdem)
                        html += "<tr><td style='padding-left: 30px; font-weight: 600;'>";

                    html += dr["DESCRICAO"];

                    html += "</td></tr>";
                }

                if ((Type.Alternativas)Convert.ToInt32(dr["TIPO"]) != Type.Alternativas.Nenhum)
                {
                    html += "<tr><td style='padding-left: 30px; padding-bottom: 10px;'>";

                    literal.Text = html;
                    panel.Controls.Add(literal);

                    switch ((Type.Alternativas)Convert.ToInt32(dr["TIPO"]))
                    {
                        case Type.Alternativas.Bit:
                            {
                                RadioButtonList rb = Global.Bit(Convert.ToInt32(dr["QUESTAO"]));
                                name = rb.ID += i;
                                rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"]);
                                rb.Enabled = false;
                                panel.Controls.Add(rb);
                                break;
                            }


                        case Type.Alternativas.Numeracao:
                            {
                                RadioButtonList rb = Global.Numeracao(Convert.ToInt32(dr["QUESTAO"]), true);
                                name = rb.ID += i;
                                rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"]);
                                rb.Enabled = false;
                                panel.Controls.Add(rb);
                                break;
                            }


                        case Type.Alternativas.Dissertativa:
                            {
                                Label lbText = new Label();
                                lbText.ID = "flv" + i;
                                lbText.Text = dr["RESPOSTA"].ToString().Trim();
                                panel.Controls.Add(lbText);
                                break;
                            }

                        case Type.Alternativas.Frequencia:
                            {
                                RadioButtonList rb = Global.Frequencia(Convert.ToInt32(dr["QUESTAO"]));
                                name = rb.ID += i;
                                rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"]);
                                rb.Enabled = false;
                                panel.Controls.Add(rb);
                                break;
                            }

                        case Type.Alternativas.Qualificacao:
                            {
                                RadioButtonList rb = Global.Qualificacao(Convert.ToInt32(dr["QUESTAO"]));
                                name = rb.ID += i;
                                rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"]);
                                rb.Enabled = false;
                                panel.Controls.Add(rb);
                                break;
                            }
                    }

                    literal = new Literal();
                    html = "</td></tr>";
                }
                literal.Text = html;
                panel.Controls.Add(literal);
                html = string.Empty;

                i++;
            }

            literal = new Literal();
            literal.Text = html + "</td></tr></table>";
            panel.Controls.Add(literal);
            this.Controls.Add(panel);
        }
        #endregion

        #region Gerar Perguntas
        protected virtual void GerarPesquisa(Type.PesquisaTipo pesquisa)
        {
            Literal literal = new Literal();
            int i = 0;

            string sql = "SELECT QUESPG_IND, QUESPG_SUBORDEM, QUESPG_INFRAORDEM, QUESPG_DESCRICAO, QUESPG_QUEST_TIPO, " +
                         "(SELECT (CASE WHEN QUESPG_ADD_DPTO_RESPONSAVEL IS NOT NULL THEN LOGI_NOME ELSE NULL END)  " +
                         "FROM LoginsInternos " +
                         "WHERE LOGI_IND = dbo.fn_cliente_login_interno_home_office({0}, QUESPG_ADD_DPTO_RESPONSAVEL)) AS INTERNO  " +
                         "FROM QuestionariosPerguntas   " +
                         "WHERE QUESPG_QUESTIONARIO = {0}  " +
                         "ORDER BY QUESPG_ORDEM, QUESPG_SUBORDEM, QUESPG_INFRAORDEM";

            tdTables = bd.getDataTable(string.Format(sql, (int)pesquisa));

            string html = css.style() + css.styleNumber();

            html += getCabecalho(tdTables.Rows[0]);

            html += " <table style='font-size: 11pt;'>";

            string name = string.Empty;
            foreach (DataRow dr in tdTables.Rows)
            {
                bool subOrdem = dr["QUESPG_SUBORDEM"] is DBNull ? false : true;
                bool infraOrdem = dr["QUESPG_INFRAORDEM"] is DBNull ? false : true;

                literal = new Literal();
                if (subOrdem && !infraOrdem)
                    html += "<tr><td style='padding-left: 15px; font-weight: 600;'>" + dr["QUESPG_SUBORDEM"] + ") ";

                if (!infraOrdem && !subOrdem)
                    html += "<tr><td colspan='2' style='padding-top: 25px; padding-bottom: 8px;'>";

                if (infraOrdem)
                    html += "<tr><td style='padding-left: 30px; font-weight: 600;'>";

                html += dr["QUESPG_DESCRICAO"];

                if (!(dr["INTERNO"] is DBNull) && !dr["INTERNO"].ToString().Equals("Indefinido"))
                    html += "<br/>&nbsp; &nbsp; &nbsp;Responsável <span style='color: #428BCA; '>" + dr["INTERNO"] + "</span>";

                html += "</td></tr>";

                if ((Type.Alternativas)dr["QUESPG_QUEST_TIPO"] != Type.Alternativas.Nenhum)
                {
                    html += "<tr><td style='padding-left: 30px; padding-bottom: 8px;'>";

                    literal.Text = html;
                    panel.Controls.Add(literal);

                    if ((Type.Alternativas)dr["QUESPG_QUEST_TIPO"] == Type.Alternativas.Bit)
                    {
                        RadioButtonList rb = Global.Bit(Convert.ToInt32(dr["QUESPG_IND"]));
                        name = rb.ID;
                        panel.Controls.Add(rb);
                    }

                    if ((Type.Alternativas)dr["QUESPG_QUEST_TIPO"] == Type.Alternativas.Numeracao)
                    {
                        literal = new Literal();
                        literal.Text = "<table><tr><td> Péssimo </td><td>";
                        panel.Controls.Add(literal);
                        RadioButtonList rb = Global.Numeracao(Convert.ToInt32(dr["QUESPG_IND"]));
                        name = rb.ID;
                        panel.Controls.Add(rb);
                        literal = new Literal();
                        literal.Text = " </td><td>Ótimo </td></tr></table>";
                        panel.Controls.Add(literal);
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

                    literal = new Literal();
                    html = "</td></tr>";
                }

                literal.Text = html;
                panel.Controls.Add(literal);
                html = string.Empty;

                i++;
            }

            literal = new Literal();
            literal.Text = html + "</td></tr></table><div>";
            panel.Controls.Add(literal);

            btnEnviar = new LinkButton();
            btnEnviar.ID = "btEnviar";
            btnEnviar.Text = "Enviar respostas";
            btnEnviar.CssClass = "linkbutton";
            btnEnviar.Click += new EventHandler(_button_Click);

            literal = new Literal();
            literal.Text = html + "</div>";
            panel.Controls.Add(literal);

            btnIgnorar = new LinkButton();
            btnIgnorar.ID = "btnIgnorar";
            btnIgnorar.Text = "Responder depois...";
            btnIgnorar.CssClass = "linkbuttonred";
            btnIgnorar.Click += new EventHandler(_buttonIgnorar_Click);
            btnIgnorar.CausesValidation = false;

            btnEnviar.Visible = getBotaoEnviar();
            btnIgnorar.Visible = getBotaoIgnorar();

            this.Controls.Add(panel);
            this.Controls.Add(btnEnviar);
            this.Controls.Add(btnIgnorar);
        }
        #endregion

        public virtual string getCabecalho(DataRow dr)
        {
            return string.Empty;
        }

        protected override void RecreateChildControls()
        {
            EnsureChildControls();
        }

        protected override void Render(HtmlTextWriter writer)
        {
            panel.RenderControl(writer);
            if (questId == 0)
            {
                btnEnviar.RenderControl(writer);
                btnIgnorar.RenderControl(writer);
            }
        }
    }
}
