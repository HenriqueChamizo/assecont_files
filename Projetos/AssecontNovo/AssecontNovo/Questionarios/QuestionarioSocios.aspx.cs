using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using Assecontweb;
using Telerik.Web.UI;

namespace AssecontNovo.Questionarios
{
    public partial class QuestionarioSocios : System.Web.UI.Page
    {
        private int responderam;
        public int Responderam
        {
            get { return responderam; }
            set { responderam = value; }
        }

        private static readonly DateTime DATA_INICIAL = Convert.ToDateTime("01/01/2015");
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                verificarAcesso();
            }
            catch
            {
                Response.Redirect("http://www.assecont.com.br/Assecontwebnovo/inicio.aspx");
            }

            if (!IsPostBack)
            {
                DateTime dtaQuestionario = (new BDAppAssecont()).getUltimoQuestionarioRespondidoSocio();
                preencherComboBox(dtaQuestionario, DATA_INICIAL);

                comboboxDatas.SelectedIndex = comboboxDatas.Items.Count - 1;
                lbUltimoEnvio.Text = "Ultimo envio em " + (new BDAppAssecont()).getFieldValueDateTime("SELECT TOP 1 CLISOC_QUESTIONARIO_ENVIADOEM FROM ClientesSocios ORDER BY CLISOC_QUESTIONARIO_ENVIADOEM DESC").ToString("dd/MM/yyyy");
            }
        }

        void verificarAcesso()
        {
            //return;
            int UserId = Convert.ToInt32((new Wr.Classes.Crypto()).Decrypt(Request.QueryString["u"].Replace(' ', '+')));
            Assecontweb.Classes.AccessApp access = new Assecontweb.Classes.AccessApp(UserId);

            if (UserId > 0 || access.CheckPermission(Assecontweb.Classes.AccessApp.PermissoesList.FerramentasQuestionariosSocios))
            {
                //if (!access.CheckPermission(Assecontweb.Classes.AccessApp.PermissoesList.FerramentasQuestionariosVisualizacaoQuestionario))
                //{
                //RadGridQuestionarioSocios.Visible = lbDataCombo.Visible = comboboxDatas.Visible = comboboxRespondidos.Visible = lbResponderam.Visible = btTotalizado.Visible = false;
                //Responderam = comboboxRespondidos.SelectedIndex = 0;
                //}
                //else if (!IsPostBack)
                //{
                    RadGridNaoResponderam.Visible = false;
                    Responderam = comboboxRespondidos.SelectedIndex = 1;
                //}
                //else
                //{
                //    lbDataCombo.Visible = comboboxDatas.Visible = Responderam == 0 ? false : true;
                //}
            }
            else
                Response.Redirect("http://www.assecont.com.br/Assecontwebnovo/inicio.aspx");
        }

        //void viewRadGridResponderam(bool visible)
        //{
        //    RadGridQuestionarioSocios.Visible = visible;
        //    lbDataCombo.Visible = comboboxDatas.Visible = visible;
        //    Responderam = comboboxRespondidos.SelectedIndex = 1;
        //}

        //void viewButtons(bool visible)
        //{
        //    comboboxRespondidos.Visible = lbResponderam.Visible = btTotalizado.Visible = visible;
        //}

        private void preencherComboBox(DateTime Fim, DateTime Inicio)
        {
            if (Fim.CompareTo(Inicio) > 0)
            {
                comboboxDatas.Items.Add(new Telerik.Web.UI.RadComboBoxItem(Inicio.ToString("dd/MM/yyyy") + " - " + (Inicio.AddMonths(6).AddDays(-1)).ToString("dd/MM/yyyy"), Inicio.ToString("dd/MM/yyyy")));
                Inicio = Inicio.AddMonths(6);
                preencherComboBox(Fim, Inicio);
            }
        }

        protected void comboboxDatas_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadGridQuestionarioSocios.DataBind();
        }

        protected void comboboxRespondidos_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //Responderam = Convert.ToInt32(e.Value);
            comboboxRespondidos.SelectedIndex = Convert.ToInt32(e.Value);
            RadGridQuestionarioSocios.Visible = e.Value.Equals("1") ? true : false;
            RadGridNaoResponderam.Visible = e.Value.Equals("0") ? true : false;
            lbDataCombo.Visible = comboboxDatas.Visible = e.Value.Equals("1") ? true : false;
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            SqlData.ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        }

        protected void SqlData_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@RESPONDERAM"].Value = string.IsNullOrEmpty(comboboxRespondidos.SelectedValue) ? 0 : Convert.ToInt32(comboboxRespondidos.SelectedValue);
            e.Command.Parameters["@DATAINICIAL"].Value = comboboxDatas.SelectedValue;
            e.Command.Parameters["@DATAFINAL"].Value = Convert.ToDateTime(comboboxDatas.SelectedValue).AddMonths(6).ToString();
        }

        protected void btnEnviarPesquisa_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = sender as LinkButton;
                GridDataItem item = (GridDataItem)btn.NamingContainer;

                HiddenField hdnSocioId = item.FindControl("hdnSocioId") as HiddenField;
                int indice = Convert.ToInt32(hdnSocioId.Value);

                

                if (indice > 0)
                {
                    EmailQuestSocio emailQuest = new EmailQuestSocio("notificacao@assecont.com.br", null, Server.MapPath("") + "\\..\\Classes\\Emails\\QuestionarioSocio\\EmailQuestSocio.htm");
                    emailQuest.send(indice, Wr.Classes.Utils.GetDescription(Assecontweb.Types.Types.Periodicidade.Semestral), "http://www.assecont.com.br/pesquisas/pesquisaSatisfacao.aspx");

                    atualizarPesquisa(indice);
                }
                else
                    throw new Exception("Erro ao gerar o e-mail");
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }

        void atualizarPesquisa(int idSocio)
        {
            (new BDAppAssecont()).executeCommand("UPDATE ClientesSocios SET CLISOC_EMAIL_QUESTIONARIO_ENVIADOEM = GETDATE() WHERE CLISOC_IND = " + idSocio);
            RadGridNaoResponderam.DataBind();
        }

    }
}