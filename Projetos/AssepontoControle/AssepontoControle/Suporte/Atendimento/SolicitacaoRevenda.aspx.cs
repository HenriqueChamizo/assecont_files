using System;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace Asseponto.Suporte.Atendimento
{
    public partial class SolicitacaoRevenda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            BDApp bd = new BDApp();

            if (!string.IsNullOrEmpty(bd.getFieldValueString(string.Format("SELECT CADP_REV_LIBERADO_EM FROM AssepontoRevendasProvisorios WHERE CADP_REV_IND = '{0}'", ind))))
            {
                RadMenu2.Visible = false;
                btDesbloquearAcesso.Visible = false;
            }
        }
        protected void RadMenu2_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
        {
            switch (e.Item.Text)
            {
                case "Excluir Solicitação":
                    ExcluirSolicitacao();
                    break;
            }
        }

        private void EnviarEmailCliente(int ind)
        {
            BDApp bd = new BDApp();

            string Contato = bd.getFieldValueString(string.Format("SELECT REV_CONTATO FROM AssepontoRevendas WHERE REV_IND = '{0}'", ind));

            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1") return;

            string EmailFrom = ConfigurationManager.AppSettings["EMAILRECIPIENT"];
            string EmailTo = ConfigurationManager.AppSettings["EMAILRECIPIENT"];
            string EmailCC = bd.getFieldValueString(string.Format("SELECT REV_EMAIL FROM AssepontoRevendas WHERE REV_IND = '{0}'", ind));
            string EmailCC2 = bd.getFieldValueString(string.Format("SELECT REV_EMAIL2 FROM AssepontoRevendas WHERE REV_IND = '{0}'", ind));

            EmailCredenciarRevenda email = new EmailCredenciarRevenda(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailRevendaGold.htm");
            email.Send(EmailTo, EmailCC, EmailCC2, ind, Contato);

           // email.sendRevendaGold(EmailTo, EmailCC, EmailCC2, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailRevendaGold.htm");

            Response.Redirect(String.Format("~/Suporte/Atendimento/ConfirmacaoSolicitacaoDesbloqueioRevenda.aspx?ind={0}", ind));
        }

        private void desbloquearacesso(int solicitacao)
        {
            BDApp bd = new BDApp();

            bd.openConnection();

            SqlCommand cmd = new SqlCommand("asseponto_transferir_revenda_provisorio", bd.Conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@P_IND", solicitacao);

            SqlParameter parameter_cliente = cmd.Parameters.Add("@R_REVENDA", SqlDbType.Int);
            parameter_cliente.Direction = ParameterDirection.Output;

            cmd.ExecuteNonQuery();

            int ind = Convert.ToInt32(parameter_cliente.Value);

            bd.closeConnection();

            EnviarEmailCliente(ind);
        }

        private void ExcluirSolicitacao()
        {
            BDApp bd = new BDApp();
            UserApp user = new UserApp();

            int ind = Convert.ToInt32(Request.QueryString["ind"]);

            bd.executeCommand(String.Format("DELETE FROM AssepontoRevendasProvisorios WHERE CADP_REV_IND = {0}", ind));
            Response.Redirect("~/Suporte/Atendimento/SolicitacoesDesbloqueioRevenda.aspx");
        }

        protected void btDesbloquearAcesso_Click(object sender, EventArgs e)
        {
            int solicitacao = Convert.ToInt32(Request.QueryString["ind"]);
            int suporte = UserApp.UserId;

            BDApp bd = new BDApp();

            Label lbCnpj = (Label)FormView1.FindControl("CADP_REV_CNPJ");
            string cnpj = lbCnpj.Text.Trim();

            Label lbCpf = (Label)FormView1.FindControl("Lbcpf");
            string cpf = lbCpf.Text.Trim();

            int cadastrado = bd.getFieldValueInteger(string.Format("SELECT REV_IND FROM AssepontoRevendas WHERE (assecont1.dbo.fn_asseponto_trim_cnpj(REV_CNPJ) = assecont1. dbo.fn_asseponto_trim_cnpj('{0}')) OR (assecont1.dbo.fn_asseponto_trim_cnpj(REV_CPF) = assecont1. dbo.fn_asseponto_trim_cnpj('{1}'))", cnpj, cpf));

            if (cadastrado == 0)
            {
                bd.getFieldValueString(string.Format("UPDATE AssepontoRevendasProvisorios SET CADP_REV_TECNICO = '{0}' WHERE CADP_REV_IND = {1}", suporte, solicitacao));
                desbloquearacesso(solicitacao);
            }
            else
                Response.Redirect("~/Suporte/Atendimento/SolicitacoesDesbloqueioRevenda.aspx?liberado=1");
        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            FormView frm = (FormView)sender;

            DataRowView row = (DataRowView)frm.DataItem;
            //divVersao.Visible = (String.IsNullOrEmpty(row["CADP_REV_TECNICO"].ToString()));
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string lbCNPJ = ((Label)FormView1.FindControl("CADP_REV_CNPJ")).Text;
            string lbCPF = ((Label)FormView1.FindControl("Lbcpf")).Text;

            args.IsValid = string.IsNullOrEmpty((new BDApp()).getFieldValueString(string.Format(
                "SELECT REV_IND FROM AssepontoRevendas WHERE (assecont1.dbo.fn_asseponto_trim_cnpj(REV_CNPJ) = assecont1. dbo.fn_asseponto_trim_cnpj('{0}')) OR (assecont1.dbo.fn_asseponto_trim_cnpj(REV_CPF) = assecont1. dbo.fn_asseponto_trim_cnpj('{1}'))", lbCNPJ, lbCPF)));
        }
    }
}