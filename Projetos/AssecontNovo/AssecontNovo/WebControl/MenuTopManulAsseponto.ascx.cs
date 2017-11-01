using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssecontNovo.WebControl
{
    public partial class MenuTopManulAsseponto : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //HyperLink HyperLink = new HyperLink();

            if (Request.RawUrl.ToLower().Contains("/rotinastratamento.aspx"))
            {
                HyperTrantamento = alterar(HyperTrantamento);
            }

            if (Request.RawUrl.ToLower().Contains("/cadastro.aspx"))
            {
                HyperCadastro = alterar(HyperCadastro);
            }

            if (Request.RawUrl.ToLower().Contains("/bancohoras.aspx"))
            {
                HyperBancoHoras = alterar(HyperBancoHoras);
            }

            if (Request.RawUrl.ToLower().Contains("/relatorios.aspx"))
            {
                HyperRelatorios = alterar(HyperRelatorios);
            }

            if (Request.RawUrl.ToLower().Contains("/ocorrenciatratamentos.aspx"))
            {
                HyperOcorrenciaTratamento = alterar(HyperOcorrenciaTratamento);
            }

            if (Request.RawUrl.ToLower().Contains("/backup.aspx"))
            {
                HyperOcorrenciaTratamento = alterar(HyperBackup);
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