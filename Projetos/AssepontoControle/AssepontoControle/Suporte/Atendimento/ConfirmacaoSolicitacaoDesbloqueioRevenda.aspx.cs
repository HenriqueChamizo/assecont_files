using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Asseponto.Suporte.Atendimento
{
    public partial class ConfirmacaoSolicitacaoDesbloqueioRevenda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            int Cliente = Convert.ToInt32(Request.QueryString["ind"]);
            Response.Redirect(String.Format("~/Suporte/Revendas/Revenda.aspx?ind={0}", Cliente));
        }
    }
}