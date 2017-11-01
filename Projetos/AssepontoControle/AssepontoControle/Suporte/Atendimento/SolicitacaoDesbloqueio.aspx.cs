using System;
using System.Data.SqlClient;
using System.Data;
using Asseponto.Classes;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Asseponto.Suporte.Atendimento
{
    public partial class SolicitacaoDesbloqueio : System.Web.UI.Page
    {
        #region Consts
        private static string MENU_LIBERADO_MANUAL = "Liberado Manualmente";
        private static string MENU_EXCLUIR_SOLICITACAO = "Excluir Solicitação";
        private static string MENU_CADASTRO = "Ir para o Cadastro";

        private static string MENU_EMAIL_SEMCADASTRO = "E-mail sem cadastro";
        private static string MENU_EMAIL_DENTRO365 = "E-mail cliente dentro 365";
        private static string MENU_EMAIL_DIAS_EXPIRADO = "E-mail 365 expirado";
        private static string MENU_EMAIL_BLOQUEADO = "E-mail bloqueado";
        private static string MENU_EMAIL_IMPLANTACAO = "E-mail em implantação";
        private static string MENU_EMAIL_SEMCONTRATO = "E-mail sem contrato";

        private static string EMAIL_COMERCIAL = "comercial@assecont.com.br";
        private static string EMAIL_FINANCERIO = "lays@assecont.com.br";
        private static string EMAIL_IMPLANTACAO = "implantacao@assecont.com.br";

        public static string TEXTO_EMAIL_COMERCIAL_DENTRO365 = "Senha liberada para <b>{0}</b> dentro de 365 dias,  abordar contrato de manutenção ou contratação avulsa de serviços. <br /><br /> CNPJ/CPF: {1} ";
        public static string TEXTO_EMAIL_COMERCIAL_EXPIRADO365 = "Cliente <b>{0}</b> solicita senha fora do prazo  de 365 dias, abordar contrato de manutenção ou contratação avulsa de serviços.  <br /><br /> CNPJ/CPF: {1} ";
        public static string TEXTO_EMAIL_FINANCEIRO_BLOQUEADO = "Cliente <b>{0}</b> bloqueado, tentou solicitar senha de ativação do software Asseponto4. <br /><br /> CNPJ/CPF: {1} ";
        public static string TEXTO_EMAIL_COMERCIAL_SEMCADASTRO = "Cliente <b>{0}</b> sem cadastro. <br /> Verificar aquisição de sistema. ";
        public static string TEXTO_EMAIL_IMPLANTACAO = "Implantação entrar em contato com solicitação de <b>{0}</b> .  <br /><br /> CNPJ/CPF: {1} ";
        public static string TEXTO_EMAIL_COMERCIAL_SEMCONTRATO = "Cliente <b>{0}</b> sem manutenção solicita senha, abordar contrato de manutenção ou contratação avulsa de serviços.  <br /><br /> CNPJ/CPF: {1} ";
        #endregion

        #region Struct Cliente
        private struct Cliente
        {
            public int cad_ind;
            public int asol_ind;
            public string cnpjCpf;
            public string cnpjCpf_revenda;
            public string observacao;
            public int diasCorridos;
        }
        #endregion

        private BDApp bd;
        private UserApp user;
        private Cliente cliente;

        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();
            user = new UserApp();
            cliente = new Cliente();
            cliente.asol_ind = Convert.ToInt32(Request.QueryString["ind"]);

            if (liberadoSolicitacao())
                visibleFalse();

            if (checarClienteExistente())
            {
                inicializarWebControls();

                cliente.diasCorridos = ManutencaoStatus1.getDiasCorridos();

                if (cliente.diasCorridos > 365)
                    visibleFalseBotoesLiberacao();
            }
            else
                SemCadastro();
        }

        #region control's
        private void visibleFalseBotoesLiberacao()
        {
            comboboxAsseponto4Versoes.Visible = false;
            btDesbloquearAcesso.Visible = false;
            siteseparador.Visible = false;
        }

        private void SemCadastro()
        {
            ManutencaoStatus1.Visible = false;
            RadMenu1.Items.FindItemByText(MENU_CADASTRO).Visible = false;
            lbSemCadastro.Text = "Cadastro não encontrado.";
            btDesbloquearAcesso.Text = "Enviar para implantação.";
        }

        private Boolean liberadoSolicitacao()
        {
            string query = "SELECT (CASE WHEN ASOL_LIBERADO_SUPORTE_POR IS NOT NULL THEN 1 ELSE 0 END) FROM AssepontoSolicitacoes WHERE ASOL_IND = '{0}'";
            return bd.getFieldValueBool(string.Format(query, cliente.asol_ind));
        }

        private void visibleFalse()
        {
            sitemenuesquerdo.Visible = false;
            RadMenu1.Visible = false;
            RadMenu2.Visible = false;
            comboboxAsseponto4Versoes.Visible = false;
            visibleFalseBotoesLiberacao();
            btDesbloquearAcesso.Visible = false;
        }

        private void inicializarWebControls()
        {
            ManutencaoStatus1.Cliente = cliente.cad_ind;
            Alerta.revenda = cliente.cnpjCpf;
            Alerta.cnpj_cpf = cliente.cnpjCpf_revenda;
            lbObservacao.Text = string.IsNullOrEmpty(cliente.observacao) ? "" : "<b>Observações do Cadastro: </b> <br />" + cliente.observacao + "<br /><br />";
        }

        #endregion

        #region setCliente
        private bool checarClienteExistente()
        {
            string query = "DECLARE @ASOL_CLIENTE INT, @ASOL_CNPJ_CPF NCHAR(20) " +
                "SELECT @ASOL_CLIENTE = ASOL_CLIENTE, @ASOL_CNPJ_CPF = (CASE WHEN ASOL_CNPJ IS NULL THEN ASOL_CPF ELSE ASOL_CNPJ END)  " +
                "FROM AssepontoSolicitacoes WHERE ASOL_IND =  {0}  " +
                "SELECT TOP 1 CAD_IND, CAD_OBS, dbo.fn_cliente_cnpj_cpf(CAD_IND) AS CNPJ_CPF_CLIENTE,  " +
                "(CASE WHEN (SELECT TOP 1 (CASE WHEN MNT_CANCELADO = 1 THEN NULL ELSE MNT_REVENDA END)   " +
                "	FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND ORDER BY MNT_DATA DESC) IS NULL THEN '' ELSE REV_CNPJ END) AS REV_CNPJ  " +
                "FROM AssepontoClientes   " +
                "LEFT JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA  " +
                "WHERE CAD_IND = @ASOL_CLIENTE OR  " +
                "dbo.fn_trim_cnpj(@ASOL_CNPJ_CPF) = dbo.fn_trim_cnpj(dbo.fn_cliente_cnpj_cpf(CAD_IND)) ";

            DataTable tbDados = bd.getDataTable(string.Format(query, cliente.asol_ind));

            if (tbDados.Rows.Count == 0)
                return false;
            else
            {
                foreach (DataRow dr in tbDados.Rows)
                {
                    cliente.cad_ind = Convert.ToInt32(dr["CAD_IND"]);
                    cliente.cnpjCpf_revenda = dr["REV_CNPJ"].ToString();
                    cliente.cnpjCpf = dr["CNPJ_CPF_CLIENTE"].ToString();

                    if (!(dr["CAD_OBS"] is DBNull))
                        cliente.observacao = dr["CAD_OBS"].ToString();
                }

                return true;
            }
        }
        #endregion

        #region RadMenu - ItemClick
        protected void RadMenu2_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
        {
            if (e.Item.Text.Equals(MENU_EXCLUIR_SOLICITACAO))
            {
                ExcluirSolicitacao();
                return;
            }

            if (e.Item.Text.Equals(MENU_LIBERADO_MANUAL))
            {
                LiberadoManualmente();
                return;
            }

            if (e.Item.Text.Equals(MENU_CADASTRO))
            {
                Response.Redirect("~/suporte/atendimento/cliente.aspx?ind=" + cliente.cad_ind);
                return;
            }

            if (e.Item.Text.Equals(MENU_EMAIL_BLOQUEADO))
            {
                enviarEmail(EMAIL_FINANCERIO, TEXTO_EMAIL_FINANCEIRO_BLOQUEADO);
                ExcluirSolicitacao();
                return;
            }

            if (e.Item.Text.Equals(MENU_EMAIL_SEMCONTRATO))
            {
                enviarEmail(EMAIL_COMERCIAL, TEXTO_EMAIL_COMERCIAL_SEMCONTRATO);
                return;
            }

            if (e.Item.Text.Equals(MENU_EMAIL_DIAS_EXPIRADO))
            {
                enviarEmail(EMAIL_COMERCIAL, TEXTO_EMAIL_COMERCIAL_EXPIRADO365);
                return;
            }

            if (e.Item.Text.Equals(MENU_EMAIL_DENTRO365))
            {
                enviarEmail(EMAIL_COMERCIAL, TEXTO_EMAIL_COMERCIAL_DENTRO365);

                return;
            }

            if (e.Item.Text.Equals(MENU_EMAIL_IMPLANTACAO))
            {
                enviarEmail(EMAIL_IMPLANTACAO, TEXTO_EMAIL_IMPLANTACAO);
                ExcluirSolicitacao();
                return;
            }
            if (e.Item.Text.Equals(MENU_EMAIL_SEMCADASTRO))
            {
                enviarEmail(EMAIL_COMERCIAL, TEXTO_EMAIL_COMERCIAL_SEMCADASTRO);
                return;
            }
        }
        #endregion

        #region Metodos Email's
        private void enviarEmail(string email_departamento, string aviso)
        {
            aviso = string.Format(aviso, ((Label)FormView1.FindControl("TextBox1")).Text.Trim(), cliente.cnpjCpf);

            EmailMsgInterna email = new EmailMsgInterna(ConfigurationManager.AppSettings["EMAILRECIPIENTCC4"], null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailMsgInterna.htm");
            email.Send(email_departamento, aviso, "Solicitação Desbloqueio - Asseponto4");
        }

        //private void enviarEmailCliente(string emailCliente1, string emailCliente2)
        //{
        //    EmailInstalacao email = new EmailInstalacao(ConfigurationManager.AppSettings["EMAILRECIPIENTCC4"], null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailCobrancaFinalizarSemSucesso.htm");
        //    email.Send(emailCliente1, emailCliente2);
        //}
        #endregion

        #region DesbloquearAcesso()
        protected void btDesbloquearAcesso_Click(object sender, EventArgs e)
        {
            DesbloquearAcesso();
        }

        private void DesbloquearAcesso()
        {
            int Solicitacao = cliente.asol_ind;
            int Suporte = UserApp.UserId;

            bd.openConnection();
            SqlCommand cmd = new SqlCommand("asseponto_desbloquear_acesso", bd.Conn);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@P_SOLICITACAO", Solicitacao);
            cmd.Parameters.AddWithValue("@P_SUPORTE", Suporte);
            cmd.Parameters.AddWithValue("@P_VERSAO_ASSEPONTO4", comboboxAsseponto4Versoes.SelectedValue);

            SqlParameter parameter_cliente = cmd.Parameters.Add("@R_CLIENTE", SqlDbType.Int);
            parameter_cliente.Direction = ParameterDirection.Output;

            cmd.ExecuteNonQuery();

            int Cliente = Convert.ToInt32(parameter_cliente.Value);
            bd.closeConnection();

            Response.Redirect(String.Format("~/suporte/Atendimento/Cliente.aspx?ind={0}", Cliente));
        }
        #endregion

        private void ExcluirSolicitacao()
        {
            bd.executeCommand(String.Format("DELETE FROM AssepontoSolicitacoes WHERE ASOL_IND = {0}", cliente.asol_ind));
            Response.Redirect("~/suporte/atendimento/solicitacoesdesbloqueio.aspx");
        }

        private void LiberadoManualmente()
        {
            bd.executeCommand(String.Format("UPDATE AssepontoSolicitacoes SET ASOL_LIBERADO_MANUAL = 1, ASOL_LIBERADO_MANUAL_SUPORTE_POR = {0}, ASOL_LIBERADOEM = GETDATE() WHERE ASOL_IND = {1}", UserApp.UserId, cliente.asol_ind));
            Response.Redirect(Request.RawUrl, false);
        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            FormView frm = (FormView)sender;
            DataRowView row = (DataRowView)frm.DataItem;
            divVersao.Visible = (String.IsNullOrEmpty(row["ASOL_LIBERADO_MANUAL_SUPORTE_POR"].ToString()));
        }
    }
}