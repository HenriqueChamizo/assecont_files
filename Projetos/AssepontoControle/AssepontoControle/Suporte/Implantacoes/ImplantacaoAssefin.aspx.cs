using System;
using System.Configuration;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Implantacoes
{
    public partial class ImplantacaoAssefin : System.Web.UI.Page
    {
        private BDApp bd;
        private UserApp user;
        private int indImplantacao;
        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();
            user = new UserApp();

            indImplantacao = Convert.ToInt32(Request.QueryString["ind"]);
            string cliente = bd.getClienteIndiceFromImplantacao(indImplantacao);

            RadMenu2.Items.FindItemByText("Pendências").NavigateUrl = "~/suporte/Implantacoes/Pendencias.aspx?implantacao=" + indImplantacao;
            RadMenu2.Items.FindItemByText("Nova Pendência").NavigateUrl = "~/suporte/Implantacoes/Pendencia.aspx?implantacao=" + indImplantacao;
            RadMenu2.Items.FindItemByText("Cadastro").NavigateUrl = "~/suporte/Clientes/Cliente.aspx?ind=" + cliente;

            if (bd.getImplantacaoStatusFinalizado(indImplantacao) == (int)Types.ImplantacaoStatus.Finalizado)
                btSalvar.Visible = btFinalizar.Visible = false;

            if (bd.getAndamentoFromImplantacao(indImplantacao) == (int)Types.ImplantacaoAndamento.PrimeiroContato
             && (new Permissoes(bd)).getAcesso("excluirimplantacao"))
                btExcluir.Visible = true;
        }

        protected void btExcluir_Click(object sender, EventArgs e)
        {
            bd.executeCommand(string.Format("DELETE FROM AssepontoImplantacoes WHERE IM_IND = {0}", indImplantacao));
            Response.Redirect("~/suporte/Implantacoes/default.aspx?status=1");
        }

        protected void lkAgendamento_Click(object sender, EventArgs e)
        {
            bd.executeCommand(string.Format("UPDATE AssepontoImplantacoes SET IM_AGENDA_CONCLUIDO_POR = {0} WHERE IM_IND = {1}", UserApp.UserId, indImplantacao));
            Response.Redirect(string.Format("~/suporte/Implantacoes/Implantacao.aspx?ind={0}", indImplantacao));
        }

        protected void lkVoltarAgenda_Click(object sender, EventArgs e)
        {
            bd.executeCommand(string.Format("UPDATE AssepontoImplantacoes SET IM_AGENDA_CONCLUIDO_POR = NULL WHERE IM_IND = {0}", indImplantacao));
            Response.Redirect(string.Format("~/suporte/Implantacoes/Implantacao.aspx?ind={0}", indImplantacao));
        }

        protected void btFinalizar_Click(object sender, EventArgs e)
        {
            UserApp user = new UserApp();

            (new BDApp()).setImplantacaoStatusFinalizado(UserApp.UserId, Convert.ToInt32(Request.QueryString["ind"]));

            Response.RedirectPermanent("~/suporte/Implantacoes");
        }

        protected void sqlImplantacoes_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                BDApp bd = new BDApp();
                int ind = Convert.ToInt32(Request.QueryString["ind"]);
                Response.Redirect(string.Format("~/suporte/Implantacoes/ImplantacaoAssefin.aspx?ind={0}", ind));
            }
        }

        protected void RadMenu2_ItemClick(object sender, RadMenuEventArgs e)
        {
            switch (e.Item.Text)
            {
                case "E-mail Cobrança Instalação":
                    EnviarEmailInstalacao();
                    break;
            }
        }


        void EnviarEmailInstalacao()
        {
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1") return;

            int Implantacao = Convert.ToInt32(Request.QueryString["ind"]);

            BDApp bd = new BDApp();
            UserApp user = new UserApp();

            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);
            string EmailTo = bd.getClienteEmailFromImplantacao(Implantacao);
            string EmailCC = bd.getClienteEmailFromImplantacao2(Implantacao);
            //string EmailCC2 = bd.getClienteRevendaEmail(Convert.ToInt32(bd.getClienteIndiceFromImplantacao(Implantacao)));

            EmailInstalacao email = new EmailInstalacao(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailInstalacao.htm");
            email.Send(EmailTo, EmailCC);
        }
    }
}