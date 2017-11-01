using System;
using System.Web.UI.WebControls;
using Wr.Classes;
using Asseponto.Classes;
using System.Configuration;

namespace Asseponto.Suporte.Implantacoes
{
    public partial class Pendencia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["ind"]))
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
                    case (int)Types.PendenciaSituacao.Fechado:
                        {
                            bd.executeCommand(string.Format("EXEC asseponto_pendecia_responsavel2 '{0}', '{1}'", Ind, UserApp.UserId.ToString()));
                            break;
                        }
                }

                int Implantacao = bd.getImplantacaoFromPendencia(Convert.ToInt32(Request.QueryString["ind"]));
                Response.Redirect(String.Format("~/suporte/Implantacoes/Pendencias.aspx?implantacao={0}", Implantacao));
            }
        }

        protected void sqlPendencias_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            FormUtils utils = new FormUtils();
            utils.InitializePageControls();

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
                FormUtils utils = new FormUtils();
                utils.InitializePageControls();
                UserApp user = new UserApp();

                if (String.IsNullOrEmpty(Request.QueryString["ind"]))
                {
                    ((Label)Wr.Classes.PageUtils.FindControl(FormView1, "labelResponsavel")).Text = user.UserName();
                    ((Label)Wr.Classes.PageUtils.FindControl(FormView1, "PEN_DATAHORA")).Text = String.Format("{0:dd/MM/yyyy}", DateTime.Now);
                }
            }
        }

        protected void sqlPendencias_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            FormUtils formutils = new FormUtils();
            formutils.InitializePageControls();
            UserApp user = new UserApp();

            int Implantacao = Convert.ToInt32(Request.QueryString["Implantacao"]);

            e.Command.Parameters["@PEN_RESPONSAVEL1"].Value = UserApp.UserId.ToString();
            e.Command.Parameters["@PEN_INDCADASTRO"].Value = (new BDApp()).getClienteIndiceFromImplantacao(Implantacao);
            e.Command.Parameters["@PEN_TIPO"].Value = Types.PendenciaTipo.Implantacao;

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

        protected void Salvar_Click(object sender, EventArgs e)
        {
            if (FormView1.CurrentMode == FormViewMode.Insert)
                FormView1.InsertItem(((LinkButton)sender).CausesValidation);
            else
                if (FormView1.CurrentMode == FormViewMode.Edit)
                    FormView1.UpdateItem(((LinkButton)sender).CausesValidation);
        }

        protected void sqlPendencias_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                BDApp bd = new BDApp();
                int Implantacao = Convert.ToInt32(Request.QueryString["Implantacao"]);

                int Ind = bd.getIdentity(e.Command);

                bd.executeCommand(string.Format("EXEC asseponto_pendencia_salvar '{0}'", Ind));

                try
                {
                    EnviarEmailPendencia(bd, Ind);
                }
                catch 
                { }

                if (bd.getImplantacaoNPendencias(Implantacao) == 1)
                {
                    bd.executeCommand(string.Format("UPDATE AssepontoImplantacoes SET IM_INICIO_IMPLANTACAO = GETDATE() WHERE IM_IND = {0}", Implantacao));
                }

                Response.Redirect(String.Format("~/suporte/Implantacoes/Pendencias.aspx?implantacao={0}", Implantacao));
            }
        }

        private void EnviarEmailPendencia(BDApp bd, int Pendencia)
        {
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1" || (!((CheckBox)Wr.Classes.PageUtils.FindControl(FormView1, "checkboxEnviarEmail")).Checked)) return;

            UserApp user = new UserApp();

            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);
            string EmailTo = "";
            string EmailCC = "";
            string EmailCC2 = "marcos@assecont.com.br";
            string EmailCC3 = ""; //"valmirreis@assecont.com.br";
            string EmailCC4 = "";

            EmailTo = bd.getEmailClienteFromPendencia(Pendencia);
            EmailCC = bd.getEmailRevendaFromPendencia(Pendencia);
            EmailCC3 = bd.getEmailRevendaFromPendencia2(Pendencia);
            EmailCC4 = bd.getClienteEmailFromImplantacao2(Pendencia);


            EmailPendencia email = new EmailPendencia(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailPendencia.htm");
            email.Send(EmailTo, EmailCC, EmailCC2, EmailCC3, EmailCC4, Pendencia);

        }
    }
}