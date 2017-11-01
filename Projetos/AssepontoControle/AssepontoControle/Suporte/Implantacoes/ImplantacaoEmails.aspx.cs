using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Implantacoes
{
    public partial class ImplantacaoEmails : System.Web.UI.Page
    {
        BDApp bd;
        UserApp user;
        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();
            user = new UserApp();

            int andam = Convert.ToInt32(Request.QueryString["andam"]);

            if (!IsPostBack)
            {
                lbImplatacao.Text = bd.getFieldValueString(string.Format("SELECT STAT_NOME FROM AssepontoImplantacoesStatus WHERE STAT_IND = {0}", andam));
                int aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(*) FROM AssepontoImplantacoes WHERE IM_STATUS <> 2 AND IM_ASSEPONTO4 = 1 AND IM_ANDAMENTO = {0} AND IM_INICIO_IMPLANTACAO IS NOT NULL AND ((SELECT COUNT(*) FROM AssepontoPendencias WHERE PEN_IMPLANTACAO = IM_IND AND PEN_ANDAM = {0} AND PEN_EMAIL_FINALIZAR <> 1) >= 10)", andam));
                if (aux > 0)
                {
                    RadMenu1.FindItemByValue("Empresas").ImageUrl = "http://www.asseponto.com.br/assepontocontrole/Images/16x16/TickVerde.png";
                    RadMenu1.FindItemByValue("Empresas").Text += "(" + aux + ")";
                }
            }
        }

        protected void RadMenu1_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
        {
            int andam = Convert.ToInt32(Request.QueryString["andam"]);

            switch (e.Item.Value)
            {
                case "Email":
                    EnviarCobrancaSelecionados();
                    break;

                case "Empresas":
                    Response.Redirect(string.Format("~/suporte/implantacoes/ImplantacaoEmails.aspx?status=1&andam={0}&iniciadas=1&env=0", andam));
                    break;
            }
        }

        private void EnviarCobrancaSelecionados()
        {
            int andam = Convert.ToInt32(Request.QueryString["andam"]);
            int Contador = 0;

            bd.openConnection();
            for (int i = 0; i < RadListView1.Items.Count; i++)
            {
                CheckBox chk = RadListView1.Items[i].FindControl("CheckBox1") as CheckBox;

                if (chk.Checked == true)
                {
                    int Implantacao = Convert.ToInt32(chk.Text);
                    int ind = Convert.ToInt32(bd.getClienteIndiceFromImplantacao(Implantacao));

                    switch (andam)
                    {
                        case 1:
                            EnviarEmailPlanilha(Implantacao);
                            break;

                       case 2:
                            EnviarEmailTreinamento(Implantacao);
                            break;

                       case 5:
                            EnviarEmailRetorno(Implantacao);
                            break;
                    }

                    Contador++;

                    if (Contador == 10)
                    {
                        RadListView1.Rebind();
                        Contador = 0;
                    }

                }
            }
            bd.closeConnection();

            RadListView1.Rebind();
        }

        public void CheckBoxHeader_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkHeader = sender as CheckBox;
            for (int i = 0; i < RadListView1.Items.Count; i++)
            {
                CheckBox chk = RadListView1.Items[i].FindControl("CheckBox1") as CheckBox;
                chk.Checked = chkHeader.Checked;
            }
        }

        private void EnviarEmailTreinamento(int Implantacao)
        {
            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);
            string EmailTo = bd.getClienteEmailFromImplantacao(Implantacao);
            string EmailCC = bd.getClienteEmailFromImplantacao2(Implantacao);
            int ind = Convert.ToInt32(bd.getClienteIndiceFromImplantacao(Implantacao));

            EmailInstalacao email = new EmailInstalacao(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailCobrancaTreinamento.htm");
            email.Send(EmailTo, EmailCC);

            bd.executeCommand(string.Format("EXEC asseponto_pendecias_email {0}, {1}, {2}, 0, 2, '{3}', 'Cliente não entrou em contato.'", UserApp.UserId, ind, Implantacao,
                                                        "Encaminhamos E-mail solicitando o retorno para  agendamento do treinamento operacional."));
        }

        private void EnviarEmailPlanilha(int Implantacao)
        {
            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);
            string EmailTo = bd.getClienteEmailFromImplantacao(Implantacao);
            string EmailCC = bd.getClienteEmailFromImplantacao2(Implantacao);
            int ind = Convert.ToInt32(bd.getClienteIndiceFromImplantacao(Implantacao));

            EmailInstalacao email = new EmailInstalacao(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailCobrancaPlanilha.htm");
            email.Send(EmailTo, EmailCC);

            bd.executeCommand(string.Format("EXEC asseponto_pendecias_email {0}, {1}, {2}, 0, 1, '{3}', 'Cliente não entrou em contato.'", UserApp.UserId, ind, Implantacao,
                                                        "Encaminhamos E-mail solicitando o retorno com a planilha de funcionários devidamente preenchida."));
        }

        private void EnviarEmailRetorno(int Implantacao)
        {
            string EmailFrom = bd.getEmailFromSuporte(UserApp.UserId);
            string EmailTo = bd.getClienteEmailFromImplantacao(Implantacao);
            string EmailCC = bd.getClienteEmailFromImplantacao2(Implantacao);
            int ind = Convert.ToInt32(bd.getClienteIndiceFromImplantacao(Implantacao));

            EmailInstalacao email = new EmailInstalacao(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailCobrancaInstalacao.htm");
            email.Send(EmailTo, EmailCC);

            bd.executeCommand(string.Format("EXEC asseponto_pendecias_email {0}, {1}, {2}, 0, 5, '{3}', 'Cliente não entrou em contato.'", UserApp.UserId, ind, Implantacao,
                         "Encaminhamos E-mail solicitando o retorno do cliente para finalizar a instalação do software Asseponto4."));
        }
    }
}