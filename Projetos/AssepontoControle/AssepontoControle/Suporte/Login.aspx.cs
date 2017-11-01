using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Wr.Classes;

namespace Asseponto.Suporte
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Cookies cookies = new Cookies(Request);
                TextBox UserName = (TextBox)Login1.FindControl("UserName");
                UserName.Text = cookies.Read("LoginUser");
            }
        }

        protected void Login1_LoggingIn(object sender, LoginCancelEventArgs e)
        {
            UserApp user = new UserApp();
            //if (user.Login(Response, Types.UsuarioTipo.Assecont, ((TextBox)Login1.FindControl("UserName")).Text, Login1.Password, (Literal)Login1.Controls[0].FindControl("FailureText"), UserApp.WRITECOOKIE_TRUE))
            //{
            //    Session["LoginOk"] = true;
            //    e.Cancel = false;
            //}
            //else
            //{
            //    Session["LoginOK"] = false;
            //    e.Cancel = true;
            //}

            e.Cancel = !user.Login(Response, Types.UsuarioTipo.Assecont, ((TextBox)Login1.FindControl("UserName")).Text, Login1.Password, (Literal)Login1.Controls[0].FindControl("FailureText"), UserApp.WRITECOOKIE_TRUE);
            bool t = e.Cancel;
        }
    }
}