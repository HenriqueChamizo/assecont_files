using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;

namespace AssecontNovo.Grupo.ImpostoIbit
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void lkBuscar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Grupo/ImpostoIbit/default.aspx?NCM=" + txtNCM.Text.Trim());
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;   
        }
    }
}