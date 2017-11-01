using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;
using Wr.Classes;

namespace Asseponto.Clientes.Treinamento
{
    public partial class _default : System.Web.UI.Page
    {
        private int cliente;
        private BDApp bd;

        private int agenda;
        private string agendaDescricao;
        private string nome;
        private string email;
        private string telefone;

        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();
            if (string.IsNullOrEmpty(Request.QueryString["cli"])) 
                verificarCadastro(Request.QueryString["ind"]);
            else 
                cliente = Convert.ToInt32(Request.QueryString["cli"]);
            validacao();

            MasterPage MasterP = (MasterPage)Master;
            ((HtmlGenericControl)MasterP.FindControl("sitemappathwrapper1")).Visible = false;
        }

        void verificarCadastro(string cnpj_cpf)
        {
            cliente = bd.getFieldValueInteger(string.Format("SELECT CAD_IND FROM AssepontoClientes WHERE dbo.fn_trim_cnpj(dbo.fn_cliente_cnpj_cpf(CAD_IND)) = dbo.fn_trim_cnpj('{0}') ", cnpj_cpf));
        }

        void validacao()
        {
            string mensagem = string.Empty;
            bool exibir = false;
            int bloqueado = 0;

            DataTable prazoManutencao = bd.getDataTable(string.Format("SELECT CAD_IND, CAD_RAZAOSOCIAL, dbo.fn_cliente_cnpj_cpf(CAD_IND) AS CNPJ_CPF, " +
                    "(CASE WHEN  dbo.fn_asseponto_cliente_tem_manutencao_ativa(CAD_IND) = 1 THEN NULL ELSE AssepSolicitacao.DIAS END) AS DIASCORRRIDOS, " +
                    "(CASE WHEN AssepManutencao.MNT_REVENDA IS NULL THEN NULL ELSE REV_CNPJ END) AS REV_CNPJ, " +
                    "(CASE WHEN AssepManutencao.MNT_CANCELADO = 1 THEN NULL ELSE 'Manutenção desde ' + dbo.fn_asseponto_datetostr(AssepManutencao.MNT_DATA) END) AS MANUNTECAO  " +          
                    "FROM AssepontoClientes  " +
                    "LEFT JOIN AssepontoRevendas ON CAD_REVENDA = REV_IND " +
                    "CROSS APPLY (SELECT TOP 1 (DATEDIFF(DAY, NSE_DATA, GETDATE())) AS DIAS FROM AssepontoNSeries WHERE CAD_IND = NSE_CLIENTE  ORDER BY NSE_DATA ASC) AssepSolicitacao " +
                    "OUTER APPLY (SELECT TOP 1 MNT_REVENDA, MNT_CANCELADO, MNT_DATA FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND ORDER BY MNT_DATA DESC, MNT_IND DESC) AssepManutencao " +
                    "WHERE CAD_IND = '{0}'  " +
                    "ORDER BY CAD_IND DESC", cliente));

            if (prazoManutencao.Rows.Count > 0)
            {
                if (prazoManutencao.Rows[0]["REV_CNPJ"] is DBNull)
                    bloqueado = (new BDAppAssefin()).ChecarPendencias(prazoManutencao.Rows[0]["CNPJ_CPF"].ToString());
                else
                    bloqueado = (new BDAppAssefin()).ChecarPendencias(prazoManutencao.Rows[0]["REV_CNPJ"].ToString());

                if (!(prazoManutencao.Rows[0]["DIASCORRRIDOS"] is DBNull) && Convert.ToInt32(prazoManutencao.Rows[0]["DIASCORRRIDOS"]) < 0)
                {
                    mensagem = prazoManutencao.Rows[0]["DIASCORRRIDOS"] + " dias decorridos. <br /> Prazo de Suporte expirado, ";
                    exibir = true;
                }
                else
                {
                    if (bloqueado > 0)
                    {
                        mensagem = "Consta pendencias financeiras no sistema, ";
                        exibir = true;
                    }
                    else
                        AvisoTd.Visible = exibir;
                }

                if (exibir)
                {
                    AgendarTd.Visible = AgendadoTd.Visible = false;
                    lbAviso.Text = mensagem += "por favor entre em contato com o comercial. <br /><br /> E-mail: comercial@assecont.com.br";
                }
            }
            else
            {
                AgendarTd.Visible = AgendadoTd.Visible = false;
                AvisoTd.Visible = true;
                lbAviso.Text = "CNPJ/CPF não consta no nosso sistema.";
            }
        }

        public void EnviarEmailConfirmacao()
        {
            int idImplantacao = bd.getFieldValueInteger("SELECT IM_IND FROM AssepontoImplantacoes WHERE IM_CLIENTE = " + cliente);
            string RazaoSocial = bd.getClienteRazaoSocial(cliente);
            string CNPJ = bd.getClienteCnpjCpf(cliente);

            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = email;

            EmailTreinamento emailTreinamento = new EmailTreinamento(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailTreinamentoConfirmacao.htm");
            emailTreinamento.templateConfirmarTreinamento(RazaoSocial, agendaDescricao, CNPJ, nome, email, telefone);
            emailTreinamento.Send(EmailTo);

            bd.executeCommand(string.Format("EXEC asseponto_pendecias_email 29, {0}, {1}, 0, 5, '{2}', 'Cliente agendou o treinamento via site.'", cliente, idImplantacao,
                         "Treinamento agendado via site pelo cliente dia " + agendaDescricao + " (horário de Brasília). Necessário o uso de fone de ouvido ou caixas de som. " +
                         "Participante " + nome + " e-mail " + email));
        }

        private int Salvar()
        {
            string query = "INSERT INTO AssepontoAgendaClientes (AGECLI_AGENDA, AGECLI_CLIENTE, AGECLI_AGENDADO_EM, AGECLI_AGENDADO_POR, AGECLI_CONTATO, " +
                        "AGECLI_CONTATO_EMAIL, AGECLI_CONTATO_TELEFONE, AGECLI_EMAIL_ENVIADO, AGECLI_PRESENCIAL) VALUES " +
                        "({0}, {1}, GETDATE(), 29, '{2}', '{3}', '{4}', 0, 0) SELECT @@IDENTITY";

            return bd.getFieldValueInteger(string.Format(query, agenda, cliente, nome, email, telefone));
        }

        protected void lkConfirmar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    agenda = Convert.ToInt32(((RadComboBox)FormView2.FindControl("comboboxTreinamento")).SelectedValue);
                    agendaDescricao = ((RadComboBox)FormView2.FindControl("comboboxTreinamento")).SelectedItem.Text.Trim();
                    nome = ((TextBox)FormView2.FindControl("txtNome")).Text;
                    email = ((TextBox)FormView2.FindControl("txtEmail")).Text;
                    telefone = ((TextBox)FormView2.FindControl("txtTelefone")).Text;

                    if (Salvar() > 0)
                        EnviarEmailConfirmacao();

                    Response.Redirect("~/clientes/treinamento/default.aspx?cli=" + cliente);

                }
                catch (Exception ex)
                {
                    ((Label)FormView2.FindControl("lbErro")).Text = "ERRO: " + ex.Message;
                }
                finally
                {
                    bd.closeConnection();
                }
            }
        }

        protected void FormView2_DataBound(object sender, EventArgs e)
        {
            FormUtils formutils = new FormUtils();
            formutils.InitializePageControls();
        }

        protected void SqlDataAgendada_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@cliente"].Value = cliente;
        }
    }
}