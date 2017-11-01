using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;

namespace AssecontNovo.Legalizacao
{
    public partial class Extranet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //lbProtocolo.Text = Request.QueryString["ind"];
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        }
    }
}