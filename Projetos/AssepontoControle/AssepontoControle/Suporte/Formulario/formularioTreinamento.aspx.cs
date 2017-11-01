using System;
using System.Configuration;
using Asseponto.Classes;

namespace Asseponto.Suporte.Formulario
{
    public partial class formularioTreinamento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btEnviar_Click(object sender, EventArgs e)
        {
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1") return;
            BDApp bd = new BDApp();

            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = ConfigurationManager.AppSettings["EMAILRECIPIENT"];

            EmailFormularioTreinamento email = new EmailFormularioTreinamento(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailFormularioTreinamento.htm");
            email.Send(EmailTo, txtRazaoSocial.Text, txtCNPJ.Text, txtNome.Text, txtEmail.Text, txtOBS.Text);
        }
    }
}