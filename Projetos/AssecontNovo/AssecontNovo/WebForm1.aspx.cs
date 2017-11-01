using System;

namespace AssecontNovo
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            serverViews.DataInicial = Convert.ToDateTime("01/01/2015");
            serverViews.DataFinal = Convert.ToDateTime("01/11/2015");
           serverViews.Setor = Assecontweb.Types.Types.AssecontSetor.Fiscal;

            //serverViews.RelatorioSpedFiscal = Assecontweb.Classes.Views.Type.RelatorioSpedFiscal.Cliente;
        }
    }
}