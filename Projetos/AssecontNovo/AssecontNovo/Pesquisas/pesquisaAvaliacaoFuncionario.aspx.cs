using System;
using Assecontweb.Classes;

namespace AssecontNovo.Pesquisas
{
    public partial class pesquisaAvaliacaoFuncionario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            UserApp user = new UserApp();
            UserApp.UserId = 180;
            //serverViews.funcionario = 188;
            UserApp.RedirectAfterQuestion = "Http://www.assecont.com.br";
        }
    }
}