using System;
using System.Web;
using AssecontNovo.Classes;

namespace AssecontNovo.MasterPages
{
    public partial class Holerite : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UserApp user = new UserApp();

            if (user.UserId == 0)
            {
                if (!HttpContext.Current.Request.Url.ToString().ToLower().Contains("login.aspx"))
                {
                    if (Session[Types.PageBeforeLogin] == null)
                    {
                        Session[Types.PageBeforeLogin] = HttpContext.Current.Request.Url;
                        Response.RedirectPermanent("~/holeriteFunc/Login.aspx");
                        //Response.Redirect("http://www.assecont.com.br/holeriteFunc/Login.aspx");
                    }
                }
            }
        }

        protected void lbSair_Click(object sender, EventArgs e)
        {
            UserApp user = new UserApp();
            user.UserId = 0;
            Session[Types.PageBeforeLogin] = null;
            //Response.RedirectPermanent("~/holeriteFunc/Login.aspx");
            Response.RedirectPermanent("~/default.aspx");
        }
    }
}