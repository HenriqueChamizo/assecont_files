using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;

namespace AssecontNovo.Informativos
{
    public partial class ViewInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        }
    }
}