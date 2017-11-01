using Asseponto.Classes;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace Asseponto.Suporte.Util
{
    public partial class Default1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            EmailApp email = new EmailApp("valmirreis@assecont.com.br", "Teste", Label1, "");
            Wr.Classes.Email.EmailDados dados = new Email.EmailDados();
            dados.Body = "Teste";
            dados.Emails = new System.Collections.Generic.List<string>();
            dados.Emails.Add(TextBox1.Text);
            email.SendPublic(dados);
        }
    }
}