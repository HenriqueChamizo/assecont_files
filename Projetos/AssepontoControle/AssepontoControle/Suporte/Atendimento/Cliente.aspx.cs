using System;
using Asseponto.Classes;
using Telerik.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Wr.Classes;
using System.Collections.Generic;

namespace Asseponto.Suporte.Atendimento
{
    public partial class Cliente : System.Web.UI.Page
    {
        private int indImplantacao = 0;
        private int andamento = 0;
        private int status = 0;
        private int cliente;

        private BDApp bd;
        private UserApp user;
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            bd = new BDApp();
            user = new UserApp();
            cliente = Convert.ToInt32(Request.QueryString["ind"]);

            if (!IsPostBack)
            {
                if (!String.IsNullOrEmpty(Request.QueryString["situacao"]))
                {
                    pendenciasEmAberto1.Situacao = Convert.ToByte(Request.QueryString["situacao"]);
                    pendenciasEmAberto1.Title = "Pendências " + Asseponto.Classes.Utils.GetDescription((Types.PendenciaSituacao)pendenciasEmAberto1.Situacao);
                }

                if (UserApp.UserId > 0)
                    (new BDRegistryApp()).setUltimoCliente(cliente);

                ManutencaoStatus1.Cliente = cliente;
                pendenciasEmAberto1.Cliente = cliente;

                setMenu();
                CadastroAssefin.ClienteId = cliente;
            }
        }

        void setMenu()
        {
            string query = "SELECT IM_IND, IM_ANDAMENTO, IM_STATUS FROM AssepontoImplantacoes WHERE IM_CLIENTE = {0}";

            DataTable tdCLiente = bd.getDataTable(string.Format(query, cliente));

            foreach (DataRow dr in tdCLiente.Rows)
            {
                indImplantacao = dr["IM_IND"] is DBNull ? 0 : Convert.ToInt32(dr["IM_IND"].ToString());
                andamento = dr["IM_ANDAMENTO"] is DBNull ? 0 : Convert.ToInt32(dr["IM_ANDAMENTO"].ToString());
                status = dr["IM_STATUS"] is DBNull ? 0 : Convert.ToInt32(dr["IM_STATUS"].ToString());
            }

            RadMenu2.Items.FindItemByText("Pendências em Aberto").NavigateUrl = "~/Suporte/Atendimento/Cliente.aspx?ind=" + cliente + "&situacao=" + Convert.ToInt32(Types.PendenciaSituacao.EmAberto);
            RadMenu2.Items.FindItemByText("Pendências Solucionadas").NavigateUrl = "~/Suporte/Atendimento/Cliente.aspx?ind=" + cliente + "&situacao=" + Convert.ToInt32(Types.PendenciaSituacao.Fechado);
            RadMenu2.Items.FindItemByText("Senhas").NavigateUrl = "~/Suporte/Atendimento/Senhas.aspx?cliente=" + cliente;
            RadMenu2.Items.FindItemByText("Cadastro").NavigateUrl = "~/Suporte/Clientes/Cliente.aspx?ind=" + cliente;
            RadMenu2.Items.FindItemByText("Agendar Treinamento").NavigateUrl = "~/Suporte/Treinamentos/addAgendaCliente.aspx?ind=" + cliente;
            RadMenu2.Items.FindItemByText("Ir para implantação").NavigateUrl = "~/suporte/Implantacoes/implantacao.aspx?ind=" + indImplantacao;
            RadMenu2.Items.FindItemByText("Nova Pendência").NavigateUrl = "~/Suporte/Atendimento/Pendencia.aspx?cliente=" + cliente;

            implantacao.Visible = false;
            RadMenu2.Items.FindItemByText("Marcar como finalizado").Visible = false;
            RadMenu2.Items.FindItemByText("Ir para implantação").Visible = false;

            if (indImplantacao > 0 && andamento != 7 && status != 1) //Implantacao Incompleta
            {
                implantacao.Visible = true;
                lbImplatacao.Text = bd.getAndamentoImplantacao(cliente);
                RadMenu2.Items.FindItemByText("Ir para implantação").Visible = false;
                RadMenu2.Items.FindItemByText("Marcar como finalizado").Visible = true;
            }

            if (indImplantacao > 0 && andamento != 7 && status == 1) //Implantacao
            {
                implantacao.Visible = true;
                RadMenu2.Items.FindItemByText("Ir para implantação").Visible = true;
                RadMenu2.Items.FindItemByText("Marcar como finalizado").Visible = false;
                RadMenu2.Items.FindItemByText("Nova Pendência").Visible = false;
            }
        }

        protected void RadMenu2_ItemClick(object sender, RadMenuEventArgs e)
        {
            if (e.Item.Text == "Marcar como finalizado")
            {
                bd.executeCommand(string.Format("UPDATE AssepontoImplantacoes SET IM_ANDAMENTO = 7 WHERE IM_CLIENTE = {0}", cliente));
                Response.Redirect(string.Format("~/Suporte/Atendimento/Cliente.aspx?ind={0}", cliente));
            }

            if (e.Item.Text == "Questionario Treinamento")
            {
                EnviarQuestionarioTreinamento();
                Response.Redirect(string.Format("~/Suporte/Atendimento/Cliente.aspx?ind={0}", cliente));
            }
        }

        void EnviarQuestionarioTreinamento()
        {
            string Tecnico = user.UserName();
            int usuario = UserApp.UserId;

            int ind = bd.getFieldValueInteger(string.Format("INSERT INTO AssepontoQuestTreinamento (QUEST_TREI_CLIENTE, QUEST_TREI_DATA, QUEST_TREI_TECNICO) VALUES ({0}, GETDATE(), {1}) SELECT @@IDENTITY", cliente, usuario));

            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);
            string EmailTo = bd.getEmailFromCliente(cliente);
            string Titulo = "Treinamento Assecont";

            EmailQuestionarios email = new EmailQuestionarios(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailQuestTreinamento.html");
            email.Send(EmailTo, ind, Tecnico, "", Titulo);

            string EmailCC = bd.getEmailFromCliente2(cliente);

            if (EmailCC != "")
            {
                ind = bd.getFieldValueInteger(string.Format("INSERT INTO AssepontoQuestTreinamento (QUEST_TREI_CLIENTE, QUEST_TREI_DATA, QUEST_TREI_TECNICO) VALUES ({0}, GETDATE(), {1}) SELECT @@IDENTITY", cliente, UserApp.UserId));
                email.Send(EmailCC, ind, Tecnico, "", Titulo);
            }
        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            if (((FormView)sender).CurrentMode != FormViewMode.ReadOnly)
            {
                Validadores validadores = new Validadores((FormView)sender);
            }
        }

        protected void btnEnviaComercial_Click(object sender, EventArgs e)
        {
            string query = @"IF NOT EXISTS(SELECT * FROM AssepontoClientesComercial WHERE COM_FECHADOEM IS NULL AND COM_CLIENTE = {0})
                             BEGIN
                                 INSERT INTO AssepontoClientesComercial (COM_CLIENTE, COM_ENVIADOPOR, COM_ENVIADOEM)
                                 VALUES({0}, {1}, '{2}')
                             END";
            DateTime enviadoem = DateTime.Now;
            query = string.Format(query, cliente.ToString(), UserApp.UserId.ToString(), enviadoem.ToString("dd/MM/yyyy hh:mm:ss"));
            bd.executeCommand(query);
            EmailComercial(cliente, enviadoem);
            Response.Redirect("~/Suporte/Atendimento/Cliente.aspx?ind=" + cliente);
        }

        protected void EmailComercial(int cli, DateTime enviadoem)
        {
            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);

            List<string> EmailTo = new List<string>();
            //EmailTo.Add("henrique@assecont.com.br");
            //EmailTo.Add("valmirreis@assecont.com.br");
            EmailTo.Add("comercial@assecont.com.br");
            string Titulo = "Envio para Comercial - AssepontoControle";


            EmailComercial email = new EmailComercial(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailClienteComercial.htm");
            //EmailComercial email = new EmailComercial(EmailFrom, null, "~\\Arquivos\\EmailClienteComercial.html");
            email.Send(EmailTo, bd.getClienteRazaoSocial(cliente), UserApp.UserId, Titulo);
        }
    }
}