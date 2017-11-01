using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;

namespace AssecontNovo.Teste
{
    public partial class depoimentos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SqlDataTecnologia_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new BDAppTecnologia()).Conn.ConnectionString;
        }
    }
}