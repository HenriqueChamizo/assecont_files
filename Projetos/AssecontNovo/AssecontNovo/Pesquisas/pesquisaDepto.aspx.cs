using System;
using Assecontweb.Classes;
using Assecontweb.Types;

namespace AssecontNovo.Pesquisas
{
    public partial class pesquisaDepto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //bool logado = false;
            //UserApp user = new UserApp();

            //if (UserApp.UserId == 0)
            //{
            //    //UserApp.UserId = 1325;
            //   logado = user.Login(Response, Types.UsuarioTipo.Cliente, "flavinharps@gmail.com", "1", null, UserApp.WRITECOOKIE_FALSE, 0, "http://localhost:5155/pesquisas/pesquisaDepto.aspx");
            //    UserApp.RedirectAfterQuestion = "Http://www.assecont.com.br";
            //}

            //UserApp.Cliente = 1002;
            //UserApp.UserIdSimulacao = 288;

            Wr.Classes.Crypto crypto = new Wr.Classes.Crypto();
            int id = Convert.ToInt32(crypto.Decrypt(Page.Request.QueryString["I"].Replace(' ', '+')));

            serverViews.QuestId = id;
            
        }
    }
}