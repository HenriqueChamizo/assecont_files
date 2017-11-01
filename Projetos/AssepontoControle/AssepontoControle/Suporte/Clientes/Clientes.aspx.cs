using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Asseponto.Suporte.Clientes
{
    public partial class Clientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["banco"] == "fin")
            {
                TextSearch1.Visible = RadListView1.Visible = false;
                TextSearch2.Visible = RadListView2.Visible = true;
            }
            else
            {
                TextSearch1.Visible = RadListView1.Visible = true;
                TextSearch2.Visible = RadListView2.Visible = false;
            }

        }
    }
}