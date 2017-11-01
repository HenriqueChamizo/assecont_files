using System;
using System.Web.UI.WebControls;
using Wr.Classes;
using Asseponto.Classes;

namespace Asseponto.Revenda
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Cookies cookies = new Cookies(Request);

                TextBox UserName = (TextBox)LoginRevenda.FindControl("UserName");
                UserName.Text = cookies.Read("LoginUser");
            }

            if (Request.Form["u"] != "" && Request.Form["p"] != "" && Request.Form["u"] != null && Request.Form["p"] != null)
                if (logar(Request.Form["u"], Request.Form["p"]))
                    ((Literal)LoginRevenda.Controls[0].FindControl("FailureText")).Text = "Login ou senha invalidos...";
        }

        protected void Login1_LoggingIn(object sender, LoginCancelEventArgs e)
        {
            e.Cancel = !logar(LoginRevenda.UserName, LoginRevenda.Password);
        }

        bool logar(string Username, string Senha)
        {
            UserApp user = new UserApp();
            return user.Login(Response, Types.UsuarioTipo.Revenda, Username, Senha, (Literal)LoginRevenda.Controls[0].FindControl("FailureText"), UserApp.WRITECOOKIE_TRUE);
        }

        protected void linkbCadastro_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/RevendaCadastro/CadastroRevendas.aspx?ind=0");
        }

        #region Imagem
        protected void ImageButton1_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect("http://www.assecont.com.br/tecnologia/assefin/");
        }

        protected void ImageButton2_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect("http://www.assecont.com.br/tecnologia/asseponto/");
        }
        #endregion

        protected void UserName_TextChanged(object sender, EventArgs e)
        {
             
        }

        protected void ImageButtonVideo_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect("http://www.assecont.com.br/tecnologia/asseponto/asseponto.htm");
        }
    }
}