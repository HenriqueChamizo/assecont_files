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
    [ToolboxData("<{0}:ServerPesquisaDepartamento runat=server></{0}:ServerPesquisaDepartamento>")]


    public class ServerPesquisaDepartamento : CompositeControl, INamingContainer
    {
        #region Getters & Setters
        private Type.AssecontSetor _Setor;
        public Type.AssecontSetor Setor
        {
            get { return _Setor; }
            set { _Setor = value; }
        }

        private int questId;
        public int QuestId
        {
            get { return questId; }
            set { questId = value; }
        }
        #endregion

        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        BDAppLocal.BDAppAssecont bd;
        DataTable tdTables;
        private RequiredFieldValidator Validator;
        private LinkButton btnEnviar;
        private LinkButton btnIgnorar;
        private Panel panel;
        private int loginIterno = 0;
        private bool isCliente = false;

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

        #region Botão Enviar
        private void _button_Click(object source, EventArgs e)
        {
            OnSubmit(EventArgs.Empty);
            if (Page.IsValid)
            {
                int idDados = SaveBancoDados();
                foreach (Control cl in this.Controls)
                {
                    foreach (Control a in cl.Controls)
                    {
                        if (a is RadioButtonList)
                        {
                            string[] title = a.ClientID.Split('-');
                            int quest = Convert.ToInt32(title[1]);

                            int value = Convert.ToInt32(((RadioButtonList)a).SelectedValue);
                            SaveBanco("", value, quest, idDados);
                        }

                        if (a is TextBox)
                        {
                            string[] title = a.ClientID.Split('-');
                            int quest = Convert.ToInt32(title[1]);

                            string text = ((TextBox)a).Text;
                            SaveBanco(text, -1, quest, idDados);
                        }
                    }
                }
                string pageRedirect = UserApp.RedirectAfterQuestion;
                UserApp.RedirectAfterQuestion = string.Empty;
                Page.Response.Redirect(pageRedirect);
            }
        }
        #endregion

        #region Botão Responder Depois...
        private void _buttonIgnorar_Click(object source, EventArgs e)
        {
            try
            { bd.executeCommand("UPDATE LoginsExternos SET LOGE_IGNORAR_QUESTIONARIO = GETDATE() WHERE LOGE_IND = " + UserApp.UserId); }
            catch (Exception ex)
            { }

            UserApp.IgnoreQuestion = true;
            string pageRedirect = UserApp.RedirectAfterQuestion;
            UserApp.RedirectAfterQuestion = string.Empty;
            Page.Response.Redirect(pageRedirect);
        }
        #endregion

        #region setBanco
        void SaveBanco(string text, int value, int quest, int idDados)
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
            string query = "INSERT INTO QuestionariosRespostasDados (QUERESDADOS_LOGIN_EXTERNO, QUERESDADOS_SETOR, QUERESDADOS_EMPRESA, QUERESDADOS_LOGIN_INTERNO) VALUES ({0}, {1}, {2}, {3}) SELECT @@IDENTITY ";

            return bd.getFieldValueInteger(string.Format(query, UserApp.UserId, (int)Setor, UserApp.Cliente, loginIterno));
        }
        #endregion

        protected override void CreateChildControls()
        {
            bd = new BDAppLocal.BDAppAssecont();
            Literal lit = new Literal();
            panel = new Panel();
            panel.ID = "panel";
            panel.Controls.Add(lit);
            lit = new Literal();

            if (questId > 0)
            {
                GerarRespostas(lit);
            }
            else
            {
                isCliente = UserApp.Cliente != 0 && UserApp.UserIdSimulacao == 0;
                GerarPesquisa(lit);
            }
        }

        #region Gerar Resposta
        void GerarRespostas(Literal lit)
        {
            int i = 0;
            string name = string.Empty;
            string sql = "EXEC rs_questionario_detalhado @P_PESQUISA_TIPO =  2, @P_INDICE = {0} ";

            tdTables = bd.getDataTable(string.Format(sql, QuestId));

            string html = css.style() + css.styleNumber();
            html += getCabecalho(tdTables.Rows[0]["RESPONSAVEL_DEPTO"].ToString(), ((Type.AssecontSetor)Convert.ToInt32(tdTables.Rows[0]["RESPONSAVEL_SETOR"])).ToString());

            foreach (DataRow dr in tdTables.Rows)
            {
                if ((Type.Alternativas)Convert.ToInt32(dr["TIPO"]) != Type.Alternativas.Nenhum)
                {
                    html += "<tr><td style='padding-left: 30px; padding-top: 25px; padding-bottom: 10px;'><br />";

                    html += getPergunta(dr["DESCRICAO"].ToString());

                    lit.Text = html;
                    panel.Controls.Add(lit);

                    switch ((Type.Alternativas)Convert.ToInt32(dr["TIPO"]))
                    {
                        case Type.Alternativas.Bit:
                            {
                                RadioButtonList rb = Global.Bit(Convert.ToInt32(dr["QUESTAO"]));
                                name = rb.ID += i;
                                rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"]);
                                panel.Controls.Add(rb);
                                break;
                            }


                        case Type.Alternativas.Numeracao:
                            {
                                RadioButtonList rb = Global.Numeracao(Convert.ToInt32(dr["QUESTAO"]), true);
                                name = rb.ID += i;
                                rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"]);
                                panel.Controls.Add(rb);
                                break;
                            }


                        case Type.Alternativas.Dissertativa:
                            {
                                Label lbText = new Label();
                                lbText.ID = "flv" + i;
                                lbText.Text = "<br>" + (dr["RESPOSTA"] != DBNull.Value && dr["RESPOSTA"].ToString() != ""  ? dr["RESPOSTA"].ToString().Trim() : "Não respondeu") + "<br>";
                                panel.Controls.Add(lbText);
                                break;
                            }

                        case Type.Alternativas.Frequencia:
                            {
                                RadioButtonList rb = Global.Frequencia(Convert.ToInt32(dr["QUESTAO"]));
                                name = rb.ID += i;
                                rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"]);
                                panel.Controls.Add(rb);
                                break;
                            }

                        case Type.Alternativas.Qualificacao:
                            {
                                RadioButtonList rb = Global.Qualificacao(Convert.ToInt32(dr["QUESTAO"]));
                                name = rb.ID += i;
                                rb.SelectedIndex = Convert.ToInt32(dr["RESPOSTA"]);
                                panel.Controls.Add(rb);
                                break;
                            }
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
            lit.Text = html + "</td></tr></table><br><br>";
            panel.Controls.Add(lit);

            this.Controls.Add(panel);
        }
        #endregion

        #region Gerar Perguntas
        void GerarPesquisa(Literal lit)
        {
            int i = 0;

            string sql = "SELECT QUESPG_IND, QUESPG_SUBORDEM, QUESPG_INFRAORDEM, QUESPG_DESCRICAO, QUESPG_QUEST_TIPO " +
                            "FROM QuestionariosPerguntas   " +
                            "WHERE QUESPG_QUESTIONARIO = 2  " +
                            "ORDER BY QUESPG_ORDEM, QUESPG_SUBORDEM, QUESPG_INFRAORDEM";

            string sqlInterno = "SELECT LOGI_IND, LOGI_NOME    " +
                    "FROM LoginsInternos   " +
                    "WHERE LOGI_IND = dbo.fn_cliente_login_interno_home_office({0}, {1})";

            tdTables = bd.getDataTable(string.Format(sqlInterno, UserApp.Cliente, (int)Setor));

            string html = css.style() + css.styleNumber() + getDescricao();

            html += getCabecalho(tdTables.Rows[0]["LOGI_NOME"].ToString(), Setor.ToString());

            if (!(tdTables.Rows[0]["LOGI_IND"] is DBNull))
                loginIterno = Convert.ToInt32(tdTables.Rows[0]["LOGI_IND"]);

            html += " <table style='font-size: 11pt;'>";

            tdTables = bd.getDataTable(sql);

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
                        lit = new Literal();
                        lit.Text = "<table><tr><td> Péssimo </td><td>";
                        panel.Controls.Add(lit);
                        RadioButtonList rb = Global.Numeracao(Convert.ToInt32(dr["QUESPG_IND"]));
                        name = rb.ID;
                        panel.Controls.Add(rb);
                        lit = new Literal();
                        lit.Text = " </td><td>Ótimo </td></tr></table>";
                        panel.Controls.Add(lit);
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
            btnEnviar.Text = "Enviar respostas";
            btnEnviar.CssClass = "linkbutton";
            btnEnviar.Click += new EventHandler(_button_Click);

            lit = new Literal();
            lit.Text = html + "</div>";
            panel.Controls.Add(lit);

            btnIgnorar = new LinkButton();
            btnIgnorar.ID = "btnIgnorar";
            btnIgnorar.Text = "Responder depois...";
            btnIgnorar.CssClass = "linkbuttonred";
            btnIgnorar.Click += new EventHandler(_buttonIgnorar_Click);
            btnIgnorar.CausesValidation = false;

            if (!isCliente)
                btnEnviar.Visible = false;

            this.Controls.Add(panel);
            this.Controls.Add(btnEnviar);
            this.Controls.Add(btnIgnorar);
        }
        #endregion

        private string getDescricao()
        {
            return "<div style='font-size: 11pt; padding-top: 10px;'> " +
             "Com o objetivo de oferecer o melhor atendimento a você, gostaríamos de saber sua opinião sobre a ultima vez que utilizou nosso serviço. " +
             "Esta avaliação é confidencial e reflete ativamente na premiação que oferecemos aos nossos colaboradores. " +
             "<br /><br />Vamos começar? <br /><br />";
        }

        private string getCabecalho(string Responsavel, string Setor)
        {
           string txt = "Departamento: <span style='color: #0086E7;'>" + Setor;

            txt += "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>";

            if (!string.IsNullOrEmpty(Responsavel))
                txt += "Responsavel: <span style='color: #0086E7;'>" + Responsavel + "<span></div>";

            return txt;
        }

        private string getPergunta(string Descricao)
        {
            return "<span style='color: #444444;'>" + Descricao + "</span>";
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
