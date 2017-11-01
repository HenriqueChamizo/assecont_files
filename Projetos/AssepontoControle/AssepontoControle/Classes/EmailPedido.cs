using System;
using System.Web.UI.WebControls;
using Wr.Classes;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Asseponto.Classes
{
    public class EmailPedido : EmailApp
    {
        public EmailPedido(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string EmailTo, string EmailCC, string EmailCC2, string EmailCC3, string EmailCC4, string EmailCC5, int PedidoInd)
        {
            BDApp bd = new BDApp();

            string revenda = string.Empty;

            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            DataTable tbPedidos = bd.getDataTable(String.Format("SELECT REV_RAZAOSOCIAL, PED_CLI_RAZAO, dbo.fn_asseponto_datetostr(PED_DATA) AS DATA, " +
                                    "(RTRIM(FABR_NOME) + ':' + PED_MODELOREP) AS REP, PED_REVENDA, PED_REV_CONTATO, PED_REV_TEL, PED_REV_EMAIL, " +
                                    "(SELECT VERS4_DESCRICAO FROM Asseponto4Versoes WHERE VERS4_COD = PED_VERSAO_AQUISICAO) AS VERSAO " +
                                    "FROM AssepontoPedidosRevendas LEFT JOIN AssepontoRevendas ON PED_REV_IND = REV_IND " +
                                    "LEFT JOIN AssepontoRepFabricantes ON FABR_COD = PED_REP_FABRICANTE WHERE PED_IND = {0}", PedidoInd));

            foreach (DataRow reader in tbPedidos.Rows)
            {
                revenda = reader["REV_RAZAOSOCIAL"].ToString().Trim();

                CorpoEmail = CorpoEmail.Replace("%REVENDA%", revenda);
                CorpoEmail = CorpoEmail.Replace("%CLIENTE%", reader["PED_CLI_RAZAO"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%DATA%", reader["DATA"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%REP%", reader["REP"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%VERSAO%", reader["VERSAO"].ToString().Trim());

                CorpoEmail = CorpoEmail.Replace("%NOMEREVENDA%", reader["PED_REVENDA"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%TELREVENDA%", reader["PED_REV_TEL"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%CONTREVENDA%", reader["PED_REV_CONTATO"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%EMAILREVENDA%", reader["PED_REV_EMAIL"].ToString().Trim());

                //CorpoEmail = CorpoEmail.Replace("%REVENDA%", bd.getRevendaRazaoSocialFromPedido(PedidoInd));
                //CorpoEmail = CorpoEmail.Replace("%CLIENTE%", bd.getClienteRazaoSocialFromPedido(PedidoInd));
                //CorpoEmail = CorpoEmail.Replace("%DATA%", bd.getDataFromPedido(PedidoInd));
                //CorpoEmail = CorpoEmail.Replace("%REP%", bd.getRepFromPedido(PedidoInd));
                //CorpoEmail = CorpoEmail.Replace("%VERSAO%", bd.getVersaoFromPedido(PedidoInd));
            }

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = String.Format("Pedido Revenda:: {0}", revenda);
            emaildados.Body = CorpoEmail;

            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);
            emaildados.Emails.Add(EmailCC);
            emaildados.Emails.Add(EmailCC2);
            emaildados.Emails.Add(EmailCC3);
            emaildados.Emails.Add(EmailCC4);
            emaildados.Emails.Add(EmailCC5);
            emaildados.Emails.Add("mariana@assecont.com.br");
            emaildados.Emails.Add("sandracruz@assecont.com.br");

            emaildados.ReplyTo = new System.Collections.Generic.List<string>();
            emaildados.ReplyTo.Add("implantacao@assecont.com.br");

            base.Send(emaildados);
        }

        public void Send(string EmailTo, int PedidoInd)
        {
            BDApp bd = new BDApp();

            string revenda = string.Empty;

            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            DataTable tbPedidos = bd.getDataTable(String.Format("SELECT REV_RAZAOSOCIAL, PED_CLI_RAZAO, dbo.fn_asseponto_datetostr(PED_DATA) AS DATA, " +
                                    "(RTRIM(FABR_NOME) + ':' + PED_MODELOREP) AS REP, PED_REVENDA, PED_REV_CONTATO, PED_REV_TEL, PED_REV_EMAIL, " +
                                    "(SELECT VERS4_DESCRICAO FROM Asseponto4Versoes WHERE VERS4_COD = PED_VERSAO_AQUISICAO) AS VERSAO " +
                                    "FROM AssepontoPedidosRevendas LEFT JOIN AssepontoRevendas ON PED_REV_IND = REV_IND " +
                                    "LEFT JOIN AssepontoRepFabricantes ON FABR_COD = PED_REP_FABRICANTE WHERE PED_IND = {0}", PedidoInd));

            foreach (DataRow reader in tbPedidos.Rows)
            {
                revenda = reader["REV_RAZAOSOCIAL"].ToString().Trim();

                CorpoEmail = CorpoEmail.Replace("%REVENDA%", revenda);
                CorpoEmail = CorpoEmail.Replace("%CLIENTE%", reader["PED_CLI_RAZAO"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%DATA%", reader["DATA"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%REP%", reader["REP"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%VERSAO%", reader["VERSAO"].ToString().Trim());

                CorpoEmail = CorpoEmail.Replace("%NOMEREVENDA%", reader["PED_REVENDA"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%TELREVENDA%", reader["PED_REV_TEL"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%CONTREVENDA%", reader["PED_REV_CONTATO"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%EMAILREVENDA%", reader["PED_REV_EMAIL"].ToString().Trim());

                //CorpoEmail = CorpoEmail.Replace("%REVENDA%", bd.getRevendaRazaoSocialFromPedido(PedidoInd));
                //CorpoEmail = CorpoEmail.Replace("%CLIENTE%", bd.getClienteRazaoSocialFromPedido(PedidoInd));
                //CorpoEmail = CorpoEmail.Replace("%DATA%", bd.getDataFromPedido(PedidoInd));
                //CorpoEmail = CorpoEmail.Replace("%REP%", bd.getRepFromPedido(PedidoInd));
                //CorpoEmail = CorpoEmail.Replace("%VERSAO%", bd.getVersaoFromPedido(PedidoInd));
            }

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = String.Format("Pedido Revenda:: {0}", revenda);
            emaildados.Body = CorpoEmail;

            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);

            emaildados.ReplyTo = new System.Collections.Generic.List<string>();
            emaildados.ReplyTo.Add("implantacao@assecont.com.br");
            emaildados.ReplyTo.Add("comercial@assecont.com.br");

            base.Send(emaildados);
        }
    }
}