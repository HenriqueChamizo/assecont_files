using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace Asseponto.Suporte.Clientes
{
    public partial class Pendencia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FormUtils utils = new FormUtils();
            utils.InitializePageControls();
        }
    }
}