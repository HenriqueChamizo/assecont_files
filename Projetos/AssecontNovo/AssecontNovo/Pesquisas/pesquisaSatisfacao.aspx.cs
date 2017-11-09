using System;

namespace AssecontNovo.Pesquisas
{
    public partial class pesquisaSatisfacao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["v"]))
            {
                serverViews.Cliente = Convert.ToInt32((new Wr.Classes.Crypto()).Decrypt(Request.QueryString["i"].Replace(' ', '+')));
            }

            //if (!string.IsNullOrEmpty(Request.QueryString["q"]))
            //{
            //    serverViews.QuestId = Convert.ToInt32((new Wr.Classes.Crypto()).Decrypt(Request.QueryString["q"].Replace(' ', '+')));
            //}
            //serverViews.Cliente = Convert.ToInt32(Request.QueryString["I"]);
            //serverViews.Config = Convert.ToInt32(Request.QueryString["C"]);
        }
    }
}