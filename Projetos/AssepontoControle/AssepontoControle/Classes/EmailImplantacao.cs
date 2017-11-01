using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using Wr.Classes;
using System.Configuration;

namespace Asseponto.Classes
{
    public class EmailImplantacao : EmailApp
    {
        public EmailImplantacao(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string EmailTo, int PedidoInd)
        {
            BDApp bd = new BDApp();

            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%CLIENTE%", bd.getClienteRazaoSocialFromPedido(PedidoInd));
            CorpoEmail = CorpoEmail.Replace("%DATAFECHAMENTO%", bd.getDataFechamentoFromPedido(PedidoInd));
            CorpoEmail = CorpoEmail.Replace("%REVENDA%", bd.getRevendaRazaoSocialFromPedido(PedidoInd));
            CorpoEmail = CorpoEmail.Replace("%REP%", bd.getRepFromPedido(PedidoInd));
            CorpoEmail = CorpoEmail.Replace("%VERSAO%", bd.getVersaoFromPedido(PedidoInd));

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = String.Format("Pedido Para Implantação: {0}", bd.getClienteRazaoSocialFromPedido(PedidoInd));
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);

            emaildados.ReplyTo = new List<string>();
            emaildados.ReplyTo.Add("implantacao@assecont.com.br");
            base.Send(emaildados);
        }
    }
}