using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using Wr.Classes;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Asseponto.Classes
{
    public class EmailPendencia : EmailApp
    {
        public EmailPendencia(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string EmailTo, string EmailCC, string EmailCC2, string EmailCC3, string EmailCC4, int Pendencia)
        {
            BDApp bd = new BDApp();

            //SqlCommand comm = bd.Conn.CreateCommand();

            //comm.CommandText = String.Format("SELECT CAD_CONTATO, PEN_PROTOCOLO, dbo.fn_texttohtmltext(PEN_PROBLEMA) AS PEN_PROBLEMA, PEN_DATAHORA, CAD_RAZAOSOCIAL, " +
            //    "dbo.fn_texttohtmltext(PEN_SOLUCAO) AS PEN_SOLUCAO, SUP_NOME " +
            //    "FROM AssepontoPendencias " +
            //    "INNER JOIN AssepontoClientes ON PEN_INDCADASTRO = CAD_IND " +
            //    "INNER JOIN AssepontoSuporte ON SUP_IND = PEN_RESPONSAVEL1 WHERE PEN_IND = {0}", Pendencia);

            //SqlDataReader reader = comm.ExecuteReader();

            string CorpoEmailTemplate = "";
            string CorpoEmail = "";

            DataTable tbCliPendecias = bd.getDataTable(String.Format("SELECT CAD_CONTATO, PEN_PROTOCOLO, dbo.fn_texttohtmltext(PEN_PROBLEMA) AS PEN_PROBLEMA, PEN_DATAHORA, CAD_RAZAOSOCIAL, " +
                "dbo.fn_texttohtmltext(PEN_SOLUCAO) AS PEN_SOLUCAO, SUP_NOME " +
                "FROM AssepontoPendencias " +
                "INNER JOIN AssepontoClientes ON PEN_INDCADASTRO = CAD_IND " +
                "INNER JOIN AssepontoSuporte ON SUP_IND = PEN_RESPONSAVEL1 WHERE PEN_IND = {0}", Pendencia));
            //reader.Read();

            foreach (DataRow reader in tbCliPendecias.Rows)
            {
                CorpoEmailTemplate = getBody();
                CorpoEmail = CorpoEmailTemplate;

                CorpoEmail = CorpoEmail.Replace("%DATA%", String.Format("{0:dd/MM/yyyy}", Convert.ToDateTime(reader["PEN_DATAHORA"].ToString())));
                CorpoEmail = CorpoEmail.Replace("%CLIENTE%", reader["CAD_RAZAOSOCIAL"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%CONTATO%", reader["CAD_CONTATO"].ToString().Trim());
                CorpoEmail = CorpoEmail.Replace("%PROTOCOLO%", reader["PEN_PROTOCOLO"].ToString());
                CorpoEmail = CorpoEmail.Replace("%PROBLEMA%", reader["PEN_PROBLEMA"].ToString().Trim());

                if (reader["PEN_SOLUCAO"].ToString() != "")
                {
                    CorpoEmail = CorpoEmail.Replace("%SOLUCAO%", "<span class='Caption'>Solução</span><br />" + reader["PEN_SOLUCAO"].ToString().Trim() + "<br /><br />");
                }
                else
                {
                    CorpoEmail = CorpoEmail.Replace("%SOLUCAO%", "");
                }

                CorpoEmail = CorpoEmail.Replace("%SUPORTE%", reader["SUP_NOME"].ToString().Trim());
            }

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = String.Format("Aviso de Atendimento - Suporte");
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);
            emaildados.Emails.Add(EmailCC);
            emaildados.Emails.Add(EmailCC2);
            emaildados.Emails.Add(EmailCC3);
            emaildados.Emails.Add(EmailCC4);

            emaildados.ReplyTo = new List<string>();
            emaildados.ReplyTo.Add("suporte@assecont.com.br");
            base.Send(emaildados);
        }
    }
}