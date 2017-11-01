using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Asseponto.Classes;

namespace Asseponto.Suporte.Treinamentos
{
    public partial class addAgendaCliente : System.Web.UI.Page
    {
        private int agenda;
        private string agendaDescricao;
        private string nome;
        private string email;
        private string telefone;
        private int ind;
        private bool presencial;
        private UserApp user;
        private BDApp bd;

        protected void Page_Load(object sender, EventArgs e)
        {
            ind = Convert.ToInt32(Request.QueryString["ind"]);
            bd = new BDApp();
            user = new UserApp();

            RadMenu2.Items.FindItemByText("Nova Pendência").NavigateUrl = "~/Suporte/Atendimento/Pendencia.aspx?cliente=" + ind;
            RadMenu2.Items.FindItemByText("Pendências em Aberto").NavigateUrl = "~/Suporte/Atendimento/Cliente.aspx?ind=" + ind + "&situacao=" + Convert.ToInt32(Types.PendenciaSituacao.EmAberto);
            RadMenu2.Items.FindItemByText("Pendências Solucionadas").NavigateUrl = "~/Suporte/Atendimento/Cliente.aspx?ind=" + ind + "&situacao=" + Convert.ToInt32(Types.PendenciaSituacao.Fechado);
            RadMenu2.Items.FindItemByText("Senhas").NavigateUrl = "~/Suporte/Atendimento/Senhas.aspx?cliente=" + ind;
            RadMenu2.Items.FindItemByText("Cadastro").NavigateUrl = "~/Suporte/Clientes/Cliente.aspx?ind=" + ind;

            int indImplantacao = metodIndImplantion();
            if (indImplantacao > 0)
                RadMenu2.Items.FindItemByText("Ir para implantação").NavigateUrl = "~/suporte/Implantacoes/implantacao.aspx?ind=" + indImplantacao;
            else
                RadMenu2.Items.FindItemByText("Ir para implantação").Visible = false;

            //if (rblProdutos.SelectedIndex != 0)
            //{

            //}

            if (!IsPostBack)
            {
                if ((new Permissoes(new BDApp())).getAcesso("agendaCliente") || UserApp.UserId == 17)
                    comboboxRevenda.DataSourceID = "SqlAgendaAdmin";
                else
                    comboboxRevenda.DataSourceID = "sqlAgenda";
            }
        }

        int metodIndImplantion()
        {
            return bd.getFieldValueInteger(string.Format("SELECT IM_IND FROM AssepontoImplantacoes WHERE IM_CLIENTE = {0} AND IM_STATUS = 1", ind));
        }

        protected void lkSalvar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    agenda = comboboxRevenda.SelectedValue == string.Empty ? Convert.ToInt32(comboboxRevenda.Items[0].Value) : Convert.ToInt32(comboboxRevenda.SelectedValue);
                    agendaDescricao = comboboxRevenda.FindItemByValue(agenda.ToString()).Text;
                    nome = txtNome.Text;
                    email = txtEmail.Text;
                    telefone = txtTelefone.Text;
                    presencial = checkPresencial.Checked;

                    bd.openConnection();

                    int result = 0;

                    try
                    {
                        result = Salvar();
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("Não foi possivel adicionar o participante, verifique os dados. Erro: " + ex.Message);
                    }

                    if (result > 0)
                        EnviarEmailConfirmacao();
                }
                catch (Exception ex)
                {
                    lbErro.Text = "ERRO: " + ex.Message;
                }
                finally
                {
                    bd.closeConnection();
                    RadGrid1.DataBind();
                }
            }
        }

        private int Salvar()
        {
            string query = "INSERT INTO AssepontoAgendaClientes (AGECLI_AGENDA, AGECLI_CLIENTE, AGECLI_AGENDADO_EM, AGECLI_AGENDADO_POR, AGECLI_CONTATO, " +
                        "AGECLI_CONTATO_EMAIL, AGECLI_CONTATO_TELEFONE, AGECLI_EMAIL_ENVIADO, AGECLI_PRESENCIAL) VALUES " +
                        "({0}, {1}, GETDATE(), {2}, '{3}', '{4}', '{5}', 0, '{6}') SELECT @@IDENTITY";

            return bd.getFieldValueInteger(string.Format(query, agenda, ind, UserApp.UserId, nome, email, telefone, presencial));
        }

        private void EnviarEmailConfirmacao()
        {
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1") return;

            Int32 idImplantacao = bd.getFieldValueInteger("SELECT IM_IND FROM AssepontoImplantacoes WHERE IM_CLIENTE = " + ind);
            string RazaoSocial = bd.getClienteRazaoSocial(ind);
            string CNPJ = bd.getClienteCnpjCpf(ind);

            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = email;

            if (!presencial)
            {
                EmailTreinamento emailTreinamento = new EmailTreinamento(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailTreinamentoConfirmacao.htm");
                emailTreinamento.templateConfirmarTreinamento(RazaoSocial, agendaDescricao, CNPJ, nome, email, telefone);
                emailTreinamento.Send(EmailTo);

                bd.executeCommand(string.Format("EXEC asseponto_pendecias_email {0}, {1}, {2}, 0, 5, '{3}', 'Cliente entrou em contato.'", UserApp.UserId, ind, (idImplantacao > 0 ? idImplantacao.ToString() : "NULL"),
                             "Treinamento agendado para " + agendaDescricao + " (horário de Brasília). Necessário o uso de fone de ouvido ou caixas de som. " +
                             "Um e-mail será enviado alguns minutos antes com o link do acesso ao treinamento, caso não receba entrar em contato conosco."));
            }
            else
            {
                EmailTreinamento emailTreinamento = new EmailTreinamento(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailTreinamentoPresencialConfirmacao.htm");
                emailTreinamento.templateConfirmarTreinamento(RazaoSocial, agendaDescricao, CNPJ, nome, email, telefone);
                emailTreinamento.Send(EmailTo);

                bd.executeCommand(string.Format("EXEC asseponto_pendecias_email {0}, {1}, {2}, 0, 5, '{3}', 'Cliente entrou em contato.'", UserApp.UserId, ind, (idImplantacao > 0 ? idImplantacao.ToString() : "NULL"),
                             "Treinamento Presencial agendado para " + agendaDescricao + " (horário de Brasília). "));
            }
        }
    }
}