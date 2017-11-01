using System;
using System.Web.UI.WebControls;

namespace AssecontNovo.WebControl
{
    public partial class MenuTopCotacao : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.RawUrl.ToLower().Contains("/default.aspx"))
            {
                HyperMudar = alterar(HyperMudar);
            }

            if (Request.RawUrl.ToLower().Contains("/beneficio.aspx"))
            {
                HyperBeneficio = alterar(HyperBeneficio);
            }

            if (Request.RawUrl.ToLower().Contains("/form.aspx"))
            {
                HyperCotacao = alterar(HyperCotacao);
            }
        }

        HyperLink alterar(HyperLink HyperLink)
        {
            System.Drawing.Color color = System.Drawing.ColorTranslator.FromHtml("#0086E7");

            HyperLink.BackColor = color;
            HyperLink.ForeColor = System.Drawing.Color.White;
            HyperLink.NavigateUrl = "";

            return HyperLink;
        }
    }
}