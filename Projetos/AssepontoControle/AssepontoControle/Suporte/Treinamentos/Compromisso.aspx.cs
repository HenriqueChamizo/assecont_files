using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Treinamentos
{
    public partial class Compromisso : System.Web.UI.Page
    {
        private int ind;
        private DateTime data;
        private BDApp bd;
        private UserApp user;
        private bool finalizado;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                ind = Convert.ToInt32(Request.QueryString["ind"]);
                data = Convert.ToDateTime(Request.QueryString["data"]);
                lbDIA.Text = "DIA: " + data.ToString("dd/MM/yyyy");
            }
            catch
            {
                Response.Redirect("~/suporte/treinamentos/default.aspx");
            }

            if (ind <= 0)
            {

                PanelClientes.Visible = false;
                PanelBotoes.Visible = false;
                PanelCodigo.Visible = false;
            }
            else
            {
                bd = new BDApp();
                finalizado = bd.getFieldValueBool("SELECT (CASE WHEN AGE_FINALIZADO_POR IS NULL THEN 0 ELSE 1 END) FROM AssepontoAgendaTreinamentos LEFT JOIN AssepontoSuporte ON AGE_FINALIZADO_POR = SUP_IND WHERE AGE_IND = " + ind);
                if (finalizado)
                {
                    PanelBotoes.Visible = false;
                    PanelCodigo.Visible = false;
                    RadGrid1.MasterTableView.GetColumn("EditCommandColumn").Visible = false;
                    lbErro.Text = "TREINAMENTO FINALIZADO";
                }
            }

        }

        protected void comboboxRevenda_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Response.Redirect(string.Format("~/Suporte/Treinamentos/Compromisso.aspx?ind={0}&data={1}", e.Value, data));
        }

        protected void SqlAgendaCliente_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@IND"].Value = ind;
        }

        #region CheckBox's
        public void CheckBoxHeader_CheckedChanged(object sender, EventArgs e)
        {
            bd = new BDApp();
            for (int i = 0; i < RadGrid1.Items.Count; i++)
            {
                HiddenField idCliente = RadGrid1.Items[i].FindControl("HiddenIdAgendaCliente") as HiddenField;
                GravarStatus(Convert.ToInt32(idCliente.Value), CheckBoxHeader.Checked);
            }
            RadGrid1.DataBind();
        }

        protected void CheckRealizado_CheckedChanged(object sender, EventArgs e)
        {
            bd = new BDApp();
            CheckBox chk = sender as CheckBox;
            GridDataItem item = (GridDataItem)chk.NamingContainer;
            string id = item.GetDataKeyValue("AGECLI_IND").ToString();
            GravarStatus(Convert.ToInt32(id), chk.Checked);
        }

        void GravarStatus(int idAgendaCliente, bool Status)
        {
            string query = "UPDATE AssepontoAgendaClientes SET AGECLI_COMPARECEU = {0} WHERE AGECLI_IND = {1}";
            bd.executeCommand(string.Format(query, Status ? 1 : 0, idAgendaCliente));
        }
        #endregion

        protected void lkFinalizar_Click(object sender, EventArgs e)
        {
            try
            {
                bd = new BDApp();
                user = new UserApp();
                EnviarEmailTreinamento();
                FinalizarTreinamento();

                Response.Redirect("~/suporte/treinamentos/default.aspx");
            }
            catch (Exception ex)
            {
                lbErro.Text = "Erro: " + ex.Message;
            }
        }

        protected void lkCancelar_Click(object sender, EventArgs e)
        {
            try
            {
                bd = new BDApp();
                user = new UserApp();
                string query = "UPDATE AssepontoAgendaTreinamentos SET AGE_CANCELADO = 1, AGE_FINALIZADO_POR = {0} WHERE AGE_IND = {1}";
                bd.executeCommand(string.Format(query, UserApp.UserId, ind));

                Response.Redirect("~/suporte/treinamentos/default.aspx");
            }
            catch (Exception ex)
            {
                lbErro.Text = "Erro: " + ex.Message;
            }
        }

        #region Codigo TEAM VIEWER
        protected void lkCodigo_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string codigo = txtCodigo.Text;

                    bd = new BDApp();
                    user = new UserApp();
                    GravarCodigo(codigo);
                    EnviarEmailCodigo(codigo);
                }
                catch (Exception ex)
                {
                    lbErro.Text = "Erro: " + ex.Message;
                }
            }
        }

        void GravarCodigo(string Codigo)
        {
            string query = "UPDATE AssepontoAgendaTreinamentos SET AGE_LINK = '{0}', AGE_EMAIL_CODIGO_EM = GETDATE() WHERE AGE_IND = {1}";

            bd.executeCommand(string.Format(query, Codigo, ind));

            RadGrid1.DataBind();
        }

        void EnviarEmailCodigo(string codigo)
        {
            combobox.SelectedValue = ind.ToString();
            string dataHora = combobox.SelectedItem.Text;
            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];

            EmailTreinamento emailTreinamento = new EmailTreinamento(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailTreinamentoEnvioCodigo.htm");
            emailTreinamento.templateEnviarCodigo(dataHora, codigo);

            for (int i = 0; i < RadGrid1.Items.Count; i++)
            {
                Label EmailTo = RadGrid1.Items[i].FindControl("lbEmail") as Label;
                Label lbPresencial = RadGrid1.Items[i].FindControl("lbPresencial") as Label;

                if (lbPresencial.Text != "Presencial")
                {
                    emailTreinamento.Send(EmailTo.Text);
                    if (i == 0)
                    {
                        List<string> listEmails = bd.getFieldValueListString("SELECT ISNULL(SUP_EMAIL, '') FROM AssepontoSuporte WHERE SUP_ATIVO = 1 AND (SUP_SETOR = 4 OR SUP_SETOR = 3 OR SUP_SETOR = 1)");
                        listEmails.Add("suporte@assecont.com.br");
                        listEmails.Add("implantacao@assecont.com.br");
                        //listEmails.Add("henrique@assecont.com.br"); 
                        //listEmails.Add("pedro@assecont.com.br");
                        emailTreinamento.Send(listEmails);
                    }
                }
            }
        }
        #endregion

        #region FinalizarTreinamento
        void FinalizarTreinamento()
        {
            string query = "UPDATE AssepontoAgendaTreinamentos SET AGE_REALIZADO = 1, AGE_FINALIZADO_POR = {0} WHERE AGE_IND = {1}";
            bd.executeCommand(string.Format(query, UserApp.UserId, ind));
        }

        void EnviarEmailTreinamento()
        {
            combobox.SelectedValue = ind.ToString();
            string dataHora = combobox.SelectedItem.Text;
            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"]; //bd.getEmailFromSuporte(UserApp.UserId);

            EmailQuestionarios emailQuest = new EmailQuestionarios(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailQuestTreinamento.html");
            EmailInstalacao emailCobranca = new EmailInstalacao(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailCobrancaTreinamento.htm");

            string query = "SELECT IM_IND FROM AssepontoImplantacoes WHERE IM_CLIENTE = {0}";
            string queryQuest = "INSERT INTO AssepontoQuestTreinamento (QUEST_TREI_CLIENTE, QUEST_TREI_DATA, QUEST_TREI_TECNICO) VALUES ({0}, GETDATE(), {1}) SELECT @@IDENTITY";

            for (int i = 0; i < RadGrid1.Items.Count; i++)
            {
                Label EmailTo = RadGrid1.Items[i].FindControl("lbEmail") as Label;
                HiddenField Cliente = RadGrid1.Items[i].FindControl("HiddenCliente") as HiddenField;
                CheckBox ckCompareceu = RadGrid1.Items[i].FindControl("CheckRealizado") as CheckBox;

                int idImplantacao = bd.getFieldValueInteger(string.Format(query, Cliente.Value));

                if (ckCompareceu.Checked)
                {
                    int idQuest = bd.getFieldValueInteger(string.Format(queryQuest, Cliente.Value, UserApp.UserId));
                    try
                    {
                        emailQuest.Send(EmailTo.Text, idQuest, user.UserName(), "", "Treinamento Assecont Tecnologia");
                    }
                    catch { }
                    PendeciaRealizado(idImplantacao, Convert.ToInt32(Cliente.Value));
                }
                else
                {
                    try
                    {
                        emailCobranca.Send(EmailTo.Text, "suporte@assecont.com.br");
                    }
                    catch { }
                    PendeciaCobranca(idImplantacao, Convert.ToInt32(Cliente.Value));
                }
            }
        }

        void PendeciaCobranca(int Implantacao, int Cliente)
        {
            bd.executeCommand(string.Format("EXEC asseponto_pendecias_email {0}, {1}, {2}, 0, 2, '{3}', 'Cliente não entrou em contato.'", UserApp.UserId, Cliente, (Implantacao > 0 ? Implantacao.ToString() : "NULL"),
                                                        "Encaminhamos E-mail solicitando o retorno para reagendar o treinamento operacional do software Asseponto4."));
        }

        void PendeciaRealizado(int Implantacao, int Cliente)
        {
            bd.executeCommand(string.Format("EXEC asseponto_pendecias_email {0}, {1}, {2}, 0, 2, '', 'Treinamento realizado com sucesso. Usuário apto a administrar o sistema. Suporte a disposição.', 1",
                                                                    UserApp.UserId, Cliente, (Implantacao > 0 ? Implantacao.ToString() : "NULL")));
        }
        #endregion

        protected void lkExcluir_Click(object sender, EventArgs e)
        {
            if (RadGrid1.Items.Count < 1)
            {
                string query = "DELETE FROM AssepontoAgendaTreinamentos WHERE AGE_IND = {0}";

                bd.executeCommand(string.Format(query, ind));

                Response.Redirect("~/suporte/treinamentos/default.aspx");
            }
        }
    }
}