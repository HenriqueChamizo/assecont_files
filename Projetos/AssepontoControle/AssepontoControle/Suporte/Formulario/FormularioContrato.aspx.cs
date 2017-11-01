using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Wr.Classes;
using System.Configuration;

namespace Asseponto.Suporte.Formulario
{
    public partial class FormularioContrato : System.Web.UI.Page
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

            EmailFormulario email = new EmailFormulario(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailFormularioTreinamento.htm");
            email.Send(EmailTo, txtRazaoSocial.Text, txtCNPJ.Text, txtNome.Text, txtEmail.Text, txtFuncionario.Text, txtOBS.Text);
        }
    }
}