using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;

namespace AssecontNovo.HoleriteFunc
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnInformeRendimento_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/InformesRendimentoFuncionario.aspx");
        }

        protected void btnHolerite_Click(object sender, EventArgs e)
        {

        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        }

        protected void SqlDataCadastro_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@CADASTRO"].Value = (new UserApp()).UserId;
        }
    }
}