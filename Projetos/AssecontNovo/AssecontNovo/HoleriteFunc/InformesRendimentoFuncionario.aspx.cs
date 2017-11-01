using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;

namespace AssecontNovo.HoleriteFunc
{
    public partial class InformesRendimentoFuncionario : System.Web.UI.Page
    {
        private BDAppAssecont bd;
        private UserApp user;
        private int ind = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDAppAssecont();
            user = new UserApp();
            ind = user.UserId;

            serverViews.Funcionario = (new UserApp()).UserId;
            setNome();
        }

        private void setNome()
        {
            if (ind == 0)
                Response.Redirect("http://www.assecont.com.br/holeriteFunc/Login.aspx");

            MasterPage MasterP = (MasterPage)Master;
            LinkButton LbNome = (LinkButton)MasterP.FindControl("lbNomeLogin");
            LbNome.Text = user.UserName;
        }
    }
}