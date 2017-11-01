using System;
using AssecontNovo.Classes;

namespace AssecontNovo.MasterPages
{
    public partial class Legalizacao : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string parameter = Request.QueryString["i"];            

            //if(!string.IsNullOrEmpty(parameter))
            //{
            //    UserAssecontweb user = new UserAssecontweb();
            //    user.setId(parameter);

            //    if (user.Id > 0)
            //    {
            //        if(!user.checarPermisao(Assecontweb.AccessApp.PermissoesList.FerramentasQuestionariosObrigacoes))
            //        {
            //            Response.Redirect("http://www.assecont.com.br/Assecontwebnovo/login.aspx");
            //        }
            //    }            
            //}
        }
    }
}