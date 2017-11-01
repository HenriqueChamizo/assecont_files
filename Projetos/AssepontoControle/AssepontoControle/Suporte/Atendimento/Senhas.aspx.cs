using System;
using Asseponto.Classes;
using Wr.Classes;

namespace Asseponto.Suporte.Atendimento
{
    public partial class Senhas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SenhaControl1.Cliente = Convert.ToInt32(Request.QueryString["cliente"]);
            SenhaControl1.Suporte = UserApp.UserId;
        }
    }
}