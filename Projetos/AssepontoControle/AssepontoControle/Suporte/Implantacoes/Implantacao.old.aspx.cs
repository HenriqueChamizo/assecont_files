using Asseponto.Classes;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net.Mail;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Wr.Classes;

namespace Asseponto.Suporte.Implantacoes
{
    public partial class Implantacao : System.Web.UI.Page
    {
        private BDApp bd;
        private UserApp user;
        private int indImplantacao;
        private string cliente;
        public bool andamentoBool = false;
        public bool erroMail = false;
        public bool agendaIsExists;
        public string erroMessage = "";
        public string inicioImplantacao;
        //RadioButtonList rblAgendamento;
        //RadioButtonList rblRetorno;
        RadioButtonList rblStatusAndamento;
        RadioButtonList rblStatusAndamentoTipo;

        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();
            user = new UserApp();

            indImplantacao = Convert.ToInt32(Request.QueryString["ind"]);
            cliente = bd.getClienteIndiceFromImplantacao(indImplantacao);
            int andamento = bd.getAndamentoFromImplantacao(indImplantacao);

            RadMenu2.Items.FindItemByText("Pendências").NavigateUrl = "~/suporte/Implantacoes/Pendencias.aspx?implantacao=" + indImplantacao;
            RadMenu2.Items.FindItemByText("Nova Pendência").NavigateUrl = "~/suporte/Implantacoes/Pendencia.aspx?implantacao=" + indImplantacao;
            RadMenu2.Items.FindItemByText("Agendar Treinamento").NavigateUrl = "~/Suporte/Treinamentos/addAgendaCliente.aspx?ind=" + cliente;
            RadMenu2.Items.FindItemByText("Cadastro").NavigateUrl = "~/suporte/Clientes/Cliente.aspx?ind=" + cliente;
            RadMenu2.Items.FindItemByText("Agenda").NavigateUrl = "~/suporte/Implantacoes/Agenda.aspx?ind=" + indImplantacao;

            if (bd.getImplantacaoStatusFinalizado(indImplantacao) == (int)Types.ImplantacaoStatus.Finalizado)
            {
                btSalvar.Visible = btFinalizar.Visible = btFinalizar1.Visible = false;
                btEnviaEmail.Visible = true;
            }
            else if (andamento == (int)Types.ImplantacaoAndamento.RepassadoRevendaFinalizado ||
                     andamento == (int)Types.ImplantacaoAndamento.Finalizada)
                btEnviaEmail.Visible = true;

            if (andamento == (int)Types.ImplantacaoAndamento.PrimeiroContato
                && (new Permissoes(bd)).getAcesso("excluirimplantacao"))
                btExcluir.Visible = btExcluir1.Visible = true;

            andamentoBool = bd.getEmailFinalizaImplantacaoEnviado(indImplantacao);

            lbErroMail.Visible = erroMail;
            lbErroMail.Text = erroMessage;


            FormUtils formutils = new FormUtils();
            formutils.InitializePageControls();

            List<String> listaItens = new List<String>();
            //rblAgendamento = (RadioButtonList)FormView1.FindControl("RadioButtonStatusAgendamento");
            //rblRetorno = (RadioButtonList)FormView1.FindControl("RadioButtonStatusRetorno");
            rblStatusAndamento = (RadioButtonList)FormView1.FindControl("RdbStatusAndamento");
            rblStatusAndamentoTipo = (RadioButtonList)FormView1.FindControl("RadioButtonStatusTipo");

            if (Convert.ToInt32(rblStatusAndamento.SelectedValue) == 9)
                listaItens = bd.getImplantacoesStatusTipo(Convert.ToInt32(cliente), Types.ImplantacaoAndamento.Agendamento);
            else if (Convert.ToInt32(rblStatusAndamento.SelectedValue) == 5)
                listaItens = bd.getImplantacoesStatusTipo(Convert.ToInt32(cliente), Types.ImplantacaoAndamento.Retorno);
            else
                listaItens.Add(";0;1");

            foreach (String l in listaItens)
            {
                String[] split = l.Split(new String[] { ";" }, StringSplitOptions.None);
                string value = split[1];
                string texto = split[0];
                bool selecionado = split[2] == "1" ? true : false;
                ListItem li = new ListItem();
                li.Value = value;
                li.Text = texto;
                li.Selected = selecionado;
                if (rblStatusAndamentoTipo != null)
                    rblStatusAndamentoTipo.Items.Add(li);
            }

            agendaIsExists = bd.getFieldValueBool(String.Format("SELECT CASE WHEN EXISTS(SELECT AGE_IND FROM AssepontoImplantacoesAgenda WHERE AGE_IMPLANTACAO = IM_IND AND " +
                                                "AGE_FINALIZADO_POR IS NULL) THEN 1	ELSE 0 END " +
                                                "FROM AssepontoImplantacoes WHERE IM_IND = {0}", indImplantacao));

            inicioImplantacao = bd.getFieldValueString(String.Format("SELECT (case when IM_INICIO_IMPLANTACAO is null then 'NULL' else CONVERT(varchar(20), IM_INICIO_IMPLANTACAO) end) FROM AssepontoImplantacoes where IM_IND = {0}", indImplantacao));
        }

        #region botão finalizar
        protected void btFinalizar_Click(object sender, EventArgs e)
        {
            int Cliente = Convert.ToInt32(bd.getClienteIndiceFromImplantacao(indImplantacao));
            if (agendaIsExists)
            {
                int agenda = bd.getFieldValueInteger(String.Format("SELECT TOP 1 * FROM AssepontoImplantacoesAgenda WHERE AGE_IMPLANTACAO = {0} AND AGE_FINALIZADO_POR IS NULL ORDER BY AGE_AGENDADO_EM DESC", indImplantacao));
                if (agenda > 0)
                    bd.setImplantacaoAgendaFinalizada(UserApp.UserId, agenda);
            }

            bd.setImplantacaoStatusFinalizado(UserApp.UserId, Convert.ToInt32(Request.QueryString["ind"]));

            RadioButtonList RdbStatusAndamento = (RadioButtonList)FormView1.FindControl("RdbStatusAndamento");
            int andam = Convert.ToInt32(RdbStatusAndamento.SelectedValue);

            //if (andam != 7)
            //{
            //    EnviarEmailFinalizarIncompleto(Cliente, andam);
            //}
            Response.RedirectPermanent("~/suporte/Implantacoes/default.aspx?status=1");
        }
        #endregion

        protected void sqlImplantacoes_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
                Response.Redirect(string.Format("~/suporte/Implantacoes/Implantacao.aspx?ind={0}", indImplantacao));
        }

        protected void RadMenu2_ItemClick(object sender, RadMenuEventArgs e)
        {
            switch (e.Item.Text)
            {
                //case "E-mail 40 Dias":
                //    EnviarEmail40Dias();
                //    break;

                case "E-mail 60 Dias":
                    EnviarEmail60Dias();
                    break;

                //case "E-mail Cobrança Instalação":
                //    EnviarEmailInstalacao();
                //    break;

                case "E-mail Primeiro Contato":
                    EnviarEmail1Contato();
                    break;

            }
        }

        #region Email Finalizar Incompleto
        void EnviarEmailFinalizarIncompleto(int Cliente, int andam)
        {

            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1") return;
            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);
            string EmailTo = bd.getClienteEmailFromImplantacao(indImplantacao);
            string EmailCC = bd.getClienteEmailFromImplantacao2(indImplantacao);
            //string EmailCC2 = bd.getClienteRevendaEmail(Convert.ToInt32(bd.getClienteIndiceFromImplantacao(Implantacao)));

            EmailInstalacao email = new EmailInstalacao(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailCobrancaFinalizarSemSucesso.htm");
            email.Send(EmailTo, EmailCC);

            bd.executeCommand(string.Format("EXEC asseponto_pendecias_email {0}, {1}, {2}, 1, {3}, '{4}'", UserApp.UserId, Cliente, indImplantacao, andam,
                                        "Encaminhamos email informado que consta em aberto o processo de instalação e implantação do software AssePonto 4.   " +
                                        "Após diversas tentativas de contatos por e-mail e telefone, não obtivemos retorno para realização e conclusão dos serviços.    " +
                                        "IMPLANTAÇÃO FINALIZADA, SUPORTE A DISPOSIÇÃO DO CLIENTE PARA INSTALAÇÃO.<br />" +
                                        "Contatos Suporte:  " +
                                        "Telefones: 11 2173-8851 - 2173-8853 - 2173-8854 - 2173-8856 - 2173-8857 - 2173-8858 - " +
                                        "2173-8867 - 2173-8868  " +
                                        "E-mail: suporte@assecont.com.br    " +
                                        "MSN/SKYPE: suporteasseponto; suporteasseponto2; suporteasseponto3;" +
                                        "suporteasseponto4; suporteasseponto5; suporteasseponto6;" +
                                        "suporteasseponto7; suporteasseponto9; suporteasseponto10. "));
        }
        #endregion

        #region Email Contato
        void EnviarEmail1Contato()
        {
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1") return;
            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);
            string EmailTo = bd.getClienteEmailFromImplantacao(indImplantacao);
            string EmailCC = bd.getClienteEmailFromImplantacao2(indImplantacao);
            //string EmailCC2 = bd.getClienteRevendaEmail(Convert.ToInt32(bd.getClienteIndiceFromImplantacao(Implantacao)));

            EmailInstalacao email = new EmailInstalacao(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailInstalacaoContato.htm");
            email.Send(EmailTo, EmailCC);

            //bd.executeCommand(string.Format("EXEC asseponto_pendecias_email {0}, {1}, {2}, 0, 6, '{4}'", UserApp.UserId, ind, Implantacao,
            //                 "Encaminhamos link de acesso remoto para implantação do sistema."));
        }
        #endregion

        #region Email 60 dias
        void EnviarEmail60Dias()
        {
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1") return;
            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);
            string EmailTo = bd.getClienteEmailFromImplantacao(indImplantacao);
            string EmailCC = bd.getClienteEmailFromImplantacao2(indImplantacao);

            EmailImplantacao60Dias email = new EmailImplantacao60Dias(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailImplantacao60Dias.htm");
            email.Send(EmailTo, EmailCC);
        }
        #endregion

        #region Email Instalação
        void EnviarEmailInstalacao()
        {
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1") return;
            int ind = Convert.ToInt32(bd.getClienteIndiceFromImplantacao(indImplantacao));

            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);
            string EmailTo = bd.getClienteEmailFromImplantacao(indImplantacao);
            string EmailCC = bd.getClienteEmailFromImplantacao2(indImplantacao);
            //string EmailCC2 = bd.getClienteRevendaEmail(Convert.ToInt32(bd.getClienteIndiceFromImplantacao(Implantacao)));

            EmailInstalacao email = new EmailInstalacao(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailCobrancaInstalacao.htm");
            email.Send(EmailTo, EmailCC);

            bd.executeCommand(string.Format("EXEC asseponto_pendecias_email {0}, {1}, {2}, 0, 5, '{3}'", UserApp.UserId, ind, indImplantacao,
                         "Encaminhamos E-mail solicitando o retorno do cliente para finalizar a instalação do software Asseponto4."));
        }
        #endregion

        #region Email Finaliza Implantação
        SmtpStatusCode EnviarEmailImplantacaoFinalizada()
        {
            SmtpStatusCode retorno;
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1") return SmtpStatusCode.CommandNotImplemented;
            int ind = Convert.ToInt32(bd.getClienteIndiceFromImplantacao(indImplantacao));

            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);
            string EmailTo = bd.getClienteEmailFromImplantacao(indImplantacao);
            string EmailCC = bd.getClienteEmailFromImplantacao2(indImplantacao);

            EmailFinalizaImplantacao email = new EmailFinalizaImplantacao(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailFinalizaImplantacao.htm");
            email.GetClieFuncNomes(indImplantacao);

            retorno = email.Send(EmailTo, EmailCC);
            return retorno;
        }
        #endregion

        protected void btExcluir_Click(object sender, EventArgs e)
        {
            if (agendaIsExists)
            {
                int agenda = bd.getFieldValueInteger(String.Format("SELECT TOP 1 * FROM AssepontoImplantacoesAgenda WHERE AGE_IMPLANTACAO = {0} AND AGE_FINALIZADO_POR IS NULL ORDER BY AGE_AGENDADO_EM DESC", indImplantacao));
                if (agenda > 0)
                    bd.setImplantacaoAgendaFinalizada(UserApp.UserId, agenda);
            }

            bd.executeCommand(string.Format("DELETE FROM AssepontoImplantacoes WHERE IM_IND = {0}", indImplantacao));
            Response.Redirect("~/suporte/Implantacoes/default.aspx?status=1");
        }

        protected void lkPlanilha_Click(object sender, EventArgs e)
        {
            int PedidoIndice = bd.getFieldValueInteger("SELECT IM_PEDIDO FROM AssepontoImplantacoes WHERE IM_IND = " + indImplantacao);
            Response.Redirect("~/ViewFile.aspx?ind=" + PedidoIndice);
        }

        protected void btnFinalizarAgenda_Click(object sender, EventArgs e)
        {
            bd.executeCommand(string.Format("UPDATE AssepontoImplantacoes SET IM_DTAGENDA = NULL WHERE IM_IND = {0}", indImplantacao));
            bd.executeCommand(string.Format("UPDATE AssepontoImplantacoesAgenda SET AGE_FINALIZADO_POR = {0}, AGE_FINALIZADO_EM = GETDATE() WHERE AGE_FINALIZADO_POR IS NULL AND AGE_IMPLANTACAO = {1}", UserApp.UserId, indImplantacao));
            FormView1.DataBind();
        }

        protected void btSalvar_Click(object sender, EventArgs e)
        {
            if (inicioImplantacao == "NULL")
                bd.executeCommand(String.Format("UPDATE AssepontoImplantacoes " +
                                                "SET IM_ANDAMENTO_TIPO = {0}, " +
                                                "IM_ANDAMENTO = {1}, " +
                                                "IM_INICIO_IMPLANTACAO = GETDATE() " +
                                                "WHERE IM_IND = {2}", rblStatusAndamentoTipo.SelectedValue, rblStatusAndamento.SelectedValue, indImplantacao));
            else
                bd.executeCommand(String.Format("UPDATE AssepontoImplantacoes " +
                                                "SET IM_ANDAMENTO_TIPO = {0}, " +
                                                "IM_ANDAMENTO = {1} " +
                                                "WHERE IM_IND = {2}", rblStatusAndamentoTipo.SelectedValue, rblStatusAndamento.SelectedValue, indImplantacao));

            //if (Convert.ToInt32(rblStatusAndamento.SelectedValue) == (int)Types.ImplantacaoAndamento.Agendamento)
            //    bd.executeCommand(String.Format("UPDATE AssepontoImplantacoes " + 
            //                                    "SET IM_ANDAMENTO_TIPO = {0}, " +
            //                                    "IM_ANDAMENTO = {1} " + 
            //                                    "WHERE IM_IND = {2}", rblAgendamento.SelectedValue, rblStatusAndamento.SelectedValue, indImplantacao));
            //else if (Convert.ToInt32(rblStatusAndamento.SelectedValue) == (int)Types.ImplantacaoAndamento.Retorno)
            //    bd.executeCommand(String.Format("UPDATE AssepontoImplantacoes " +
            //                                    "SET IM_ANDAMENTO_TIPO = {0}, " +
            //                                    "IM_ANDAMENTO = {1} " +
            //                                    "WHERE IM_IND = {2}", rblRetorno.SelectedValue, rblStatusAndamento.SelectedValue, indImplantacao));

            FormView1.UpdateItem(((LinkButton)sender).CausesValidation);
        }

        protected void btEnviaEmail_Click(object sender, EventArgs e)
        {
            SmtpStatusCode statusMail = EnviarEmailImplantacaoFinalizada();
            if (statusMail != SmtpStatusCode.Ok)
            {
                erroMail = true;
                erroMessage = statusMail.ToString();
                lbErroMail.Visible = erroMail;
                lbErroMail.Text = erroMessage;
            }
            else
            {
                bd.executeCommand(string.Format("UPDATE AssepontoImplantacoes SET IM_ENVIA_EMAIL_POR = {0}, IM_EMAIL_ENVIADO_EM = GETDATE() where IM_IND = {1}", UserApp.UserId, indImplantacao));
                erroMail = true;
                erroMessage = "Email Enviado";
                lbErroMail.Visible = erroMail;
                lbErroMail.Text = erroMessage;
                lbErroMail.Attributes.CssStyle.Add("color", "GreenYellow");
                //Response.Redirect("~/suporte/Implantacoes/implantacao.aspx?ind=" + indImplantacao);
            }
        }

        protected void btnHistoricoAgenda_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Suporte/Implantacoes/Agenda.aspx?ind=" + indImplantacao);
        }

        //protected void RadioButtonStatusAgendamento_Load(object sender, EventArgs e)
        //{
            
        //}
    }
}