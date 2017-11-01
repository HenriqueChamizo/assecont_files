using System;
using Wr.Classes;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Collections.Generic;

namespace Asseponto.Classes
{
    public class EmailAtendimentoAvulso : EmailApp
    {
        private EmailDados emaildados;

        public EmailAtendimentoAvulso(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void SendInterno(string contato, string email, string cnpjCpf, string servico, Boolean cliente)
        {
            //BDApp bd = new BDApp();
            //List<string> emails = bd.getEmailsSuporte();

            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%CONTATO%", contato);
            CorpoEmail = CorpoEmail.Replace("%EMAIL%", email);
            CorpoEmail = CorpoEmail.Replace("%SERVICO%", servico);
            CorpoEmail = CorpoEmail.Replace("%CNPJ_CPF%", cnpjCpf);

            if (cliente)
                CorpoEmail = CorpoEmail.Replace("%OBS%", "Cliente realizou um pedido de atendimento avulso.");
            else
                CorpoEmail = CorpoEmail.Replace("%OBS%", "Cliente NÃO possui cadastro no assefin.");

            emaildados = new EmailDados();

            emaildados.Subject = String.Format("Pedido de Atendimento {0}", servico);
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add("comercial@assecont.com.br");
            //emaildados.Emails.AddRange(emails);

            base.Send(emaildados);
        }

        public void SendCliente(string contato, string email, string cnpjCpf, string servico)
        {
            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%CONTATO%", contato);
            CorpoEmail = CorpoEmail.Replace("%EMAIL%", email);
            CorpoEmail = CorpoEmail.Replace("%SERVICO%", servico);
            CorpoEmail = CorpoEmail.Replace("%CNPJ_CPF%", cnpjCpf);

            emaildados = new EmailDados();

            emaildados.Subject = String.Format("Pedido de Atendimento {0}", servico);
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(email);

            emaildados.ReplyTo = new System.Collections.Generic.List<string>();
            emaildados.ReplyTo.Add("comercial@assecont.com.br");

            base.Send(emaildados);
        }
    }
}