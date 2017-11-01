using System;
using System.Web;
using Wr.Classes;
using Asseponto.Classes;

namespace Asseponto.MasterPages
{
    public partial class Revenda : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.RawUrl.ToLower().Contains("login.aspx"))
            {
                nav.Style.Add("height", "0px");
                nav.Style.Add("background-color", "white");
                //Menu.Visible = false;
                sitemappathwrapper1.Visible = false;
            }

            if (UserApp.UserId == 0)
            {
                if (!HttpContext.Current.Request.Url.ToString().ToLower().Contains("login.aspx"))
                {
                    if (Session[Types.PageBeforeLogin] == null)
                    {
                        Session[Types.PageBeforeLogin] = HttpContext.Current.Request.Url;
                    }

                    Response.Redirect("~/revenda/login.aspx");
                }
            }
        }

        protected void HyperCadastro_Click(object sender, EventArgs e)
        {

            UserApp user = new UserApp();
            int ind = user.Revenda;


            Response.Redirect(string.Format("~/revenda/Cadastro/CadastroDados.aspx?ind={0}", ind));
        }
    }
}