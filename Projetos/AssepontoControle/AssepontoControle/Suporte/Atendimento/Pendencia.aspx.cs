using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Wr.Classes;
using System.Data.SqlClient;
using System.Configuration;

namespace Asseponto.Suporte.Atendimento
{
    public partial class Pendencia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(Request.QueryString["ind"]))
                FormView1.DefaultMode = FormViewMode.Insert;
            else
                FormView1.DefaultMode = FormViewMode.Edit;
        }

        protected void sqlPendencias_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                BDApp bd = new BDApp();
                UserApp user = new UserApp();

                int Ind = Convert.ToInt32(Request.QueryString["ind"]);
                int Cliente = bd.getClienteFromPendencia(Ind);

                EnviarEmailPendencia(bd, Ind);

                switch (Convert.ToInt32(e.Command.Parameters["@PEN_SITUACAO"].Value))
                {
                    case (int)Types.PendenciaSituacao.EmAberto:
                        EnviarQuestionarioAtendimento(bd, Cliente, 0);
                        Response.Redirect(String.Format("~/Suporte/Atendimento/Cliente.aspx?ind={0}&situacao=" + Convert.ToInt32(Types.PendenciaSituacao.EmAberto), Cliente));
                        break;
                    case (int)Types.PendenciaSituacao.Fechado:
                        {
                            bd.executeCommand(string.Format("EXEC asseponto_pendecia_responsavel2 '{0}', '{1}'", Ind, UserApp.UserId.ToString()));
                            EnviarQuestionarioAtendimento(bd, Cliente, 1);
                            Response.Redirect(String.Format("~/Suporte/Atendimento/Cliente.aspx?ind={0}&situacao=" + Convert.ToInt32(Types.PendenciaSituacao.Fechado), Cliente));
                            break;
                        }
                }
            }
        }

        protected void sqlPendencias_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@PEN_RESPONSAVEL1"].Value = UserApp.UserId.ToString();

            if (e.Command.Parameters["@PEN_SOLUCAO"].Value != null)
            {
                e.Command.Parameters["@PEN_DATAHORASOLUCAO"].Value = DateTime.Now;
                e.Command.Parameters["@PEN_SITUACAO"].Value = Types.PendenciaSituacao.Fechado;
            }
            else
            {
                e.Command.Parameters["@PEN_DATAHORA"].Value = DateTime.Now;
                e.Command.Parameters["@PEN_SITUACAO"].Value = Types.PendenciaSituacao.EmAberto;
            }
        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            if (((FormView)sender).CurrentMode != FormViewMode.ReadOnly)
            {
                Validadores validadores = new Validadores((FormView)sender);
            }

            if (FormView1.CurrentMode == FormViewMode.Insert)
            {
                ((Label)Wr.Classes.PageUtils.FindControl(FormView1, "labelResponsavel")).Text = (new UserApp()).UserName();
                ((Label)Wr.Classes.PageUtils.FindControl(FormView1, "PEN_DATAHORA")).Text = String.Format("{0:dd/MM/yyyy}", DateTime.Now);
            }
        }

        protected void sqlPendencias_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@PEN_RESPONSAVEL1"].Value = UserApp.UserId.ToString();
            e.Command.Parameters["@PEN_TIPO"].Value = Types.PendenciaTipo.Suporte;

            if (e.Command.Parameters["@PEN_SOLUCAO"].Value != null)
            {
                e.Command.Parameters["@PEN_RESPONSAVEL2"].Value = UserApp.UserId.ToString();
                e.Command.Parameters["@PEN_DATAHORASOLUCAO"].Value = DateTime.Now;
                e.Command.Parameters["@PEN_SITUACAO"].Value = Types.PendenciaSituacao.Fechado;
            }
            else
            {
                e.Command.Parameters["@PEN_DATAHORA"].Value = DateTime.Now;
                e.Command.Parameters["@PEN_SITUACAO"].Value = Types.PendenciaSituacao.EmAberto;
            }
        }

        protected void sqlPendencias_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                BDApp bd = new BDApp();

                int Ind = bd.getIdentity(e.Command);
                int Cliente = bd.getClienteFromPendencia(Ind);

                bd.executeCommand(string.Format("EXEC asseponto_pendencia_salvar '{0}'", Ind));

                EnviarEmailPendencia(bd, Ind);

                switch (Convert.ToInt32(e.Command.Parameters["@PEN_SITUACAO"].Value))
                {
                    case (int)Types.PendenciaSituacao.EmAberto:
                        EnviarQuestionarioAtendimento(bd, Cliente, 0);
                        break;
                    case (int)Types.PendenciaSituacao.Fechado:
                        EnviarQuestionarioAtendimento(bd, Cliente, 1);
                        break;

                }

                Response.Redirect(String.Format("~/Suporte/Atendimento/Cliente.aspx?ind={0}", Request.QueryString["cliente"]));
            }
        }

        protected void Salvar_Click(object sender, EventArgs e)
        {
            if (FormView1.CurrentMode == FormViewMode.Insert)
                FormView1.InsertItem(((LinkButton)sender).CausesValidation);
            else
                if (FormView1.CurrentMode == FormViewMode.Edit)
                    FormView1.UpdateItem(((LinkButton)sender).CausesValidation);
        }

        private void EnviarEmailPendencia(BDApp bd, int Pendencia)
        {
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1" || (!((CheckBox)Wr.Classes.PageUtils.FindControl(FormView1, "checkboxEnviarEmail")).Checked)) return;

            UserApp user = new UserApp();
            string EmailTo = "";
            string EmailCC = "";
            string EmailCC2 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC"];
            string EmailCC3 = "";
            string EmailCC4 = "";

            EmailTo = bd.getEmailClienteFromPendencia(Pendencia);
            EmailCC = bd.getEmailRevendaFromPendencia(Pendencia);
            EmailCC3 = bd.getEmailRevendaFromPendencia2(Pendencia);
            EmailCC4 = bd.getEmailClienteFromPendencia2(Pendencia);

            EmailPendencia email = new EmailPendencia(ConfigurationManager.AppSettings["EMAILSENDER"], null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailPendencia.htm");
            email.Send(EmailTo, EmailCC, EmailCC2, EmailCC3, EmailCC4, Pendencia);
        }

        private void EnviarQuestionarioAtendimento(BDApp bd, int Cliente, int Situacao)
        {
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1" || (!((CheckBox)Wr.Classes.PageUtils.FindControl(FormView1, "checkboxEnviarEmail")).Checked)) return;

            UserApp user = new UserApp();

            int ind = bd.getFieldValueInteger(string.Format("INSERT INTO AssepontoQuestAtendimento (QUEST_CLIENTE, QUEST_DATA, QUEST_TECNICO, QUEST_PEN_FECHADO) VALUES ({0}, GETDATE(), {1}, {2}) SELECT @@IDENTITY", Cliente, UserApp.UserId, Situacao));
            string tecnico = user.UserName();

            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);
            string EmailTo = bd.getEmailFromCliente(Cliente);
            string Titulo = "Atendimento Assecont";

            EmailQuestionarios email = new EmailQuestionarios(ConfigurationManager.AppSettings["EMAILSENDER"], null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailQuestAtendimento.html");
            email.Send(EmailTo, ind, tecnico, "", Titulo);

            string EmailCC = bd.getEmailFromCliente2(Cliente);

            if (EmailCC != "")
            {
                ind = bd.getFieldValueInteger(string.Format("INSERT INTO AssepontoQuestAtendimento (QUEST_CLIENTE, QUEST_DATA, QUEST_TECNICO, QUEST_PEN_FECHADO) VALUES ({0}, GETDATE(), {1}, {2}) SELECT @@IDENTITY", Cliente, UserApp.UserId, Situacao));
                email.Send(EmailCC, ind, tecnico, "", Titulo);
            }
        }
    }
}