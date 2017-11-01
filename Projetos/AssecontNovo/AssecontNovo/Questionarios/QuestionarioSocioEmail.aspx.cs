using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using Assecontweb;
using Telerik.Web.UI;

namespace AssecontNovo.Questionarios
{
    public partial class QuestionarioSocioEmail : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                lbUltimoEnvio.Text = "Ultimo envio em " + (new BDAppAssecont()).getFieldValueDateTime("SELECT TOP 1 CLISOC_QUESTIONARIO_ENVIADOEM FROM ClientesSocios ORDER BY CLISOC_QUESTIONARIO_ENVIADOEM DESC").ToString("dd/MM/yyyy");
            }

            //int UserId = Convert.ToInt32((new Wr.Classes.Crypto()).Decrypt(Request.QueryString["u"]));
            //AccessApp access = new AccessApp(UserId);

            //if (!access.CheckPermission(AccessApp.PermissoesList.FerramentasQuestionariosVisualizacaoQuestionario))
            //    Response.Redirect("http://www.assecont.com.br/Assecontwebnovo/inicio.aspx");
        }

        private void preencherComboBox(DateTime Fim, DateTime Inicio)
        {
            if (Fim.CompareTo(Inicio) > 0)
            {
                //comboboxDatas.Items.Add(new Telerik.Web.UI.RadComboBoxItem(Inicio.ToString("dd/MM/yyyy") + " - " + (Inicio.AddMonths(6).AddDays(-1)).ToString("dd/MM/yyyy"), Inicio.ToString("dd/MM/yyyy")));
                Inicio = Inicio.AddMonths(6);
                preencherComboBox(Fim, Inicio);
            }
        }

        protected void comboboxDatas_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadGridQuestionarioSocios.DataBind();
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            SqlData.ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        }

        protected void SqlData_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            //e.Command.Parameters["@RESPONDERAM"].Value = 0;
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
                    EmailQuestSocio emailQuest = new EmailQuestSocio("informativo@assecontmail.com.br", null, Server.MapPath("") + "\\..\\Classes\\Emails\\QuestionarioSocio\\EmailQuestSocio.htm", "http://www.assecont.com.br/assecont/Questionarios/pesquisaSatisfacaoCliente.aspx?C=1&I=");
                    emailQuest.send(indice);

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
            (new BDAppAssecont()).executeCommand("UPDATE ClientesSocios SET CLISOC_2VIA_QUESTIONARIO_ENVIADOEM = GETDATE() WHERE CLISOC_IND = " + idSocio);
        }
    }
}