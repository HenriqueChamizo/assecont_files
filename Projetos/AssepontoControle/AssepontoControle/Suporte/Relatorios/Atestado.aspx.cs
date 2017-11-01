using System;
using Asseponto.Classes;

namespace Asseponto.Suporte.Relatorios
{
    public partial class Atestado : System.Web.UI.Page
    {
        private int ind;
        private BDApp bd;
        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();

            ind = Convert.ToInt32(Request.QueryString["ind"]);
            lbRazaoSocial.Text = bd.getClienteRazaoSocial(ind);

            lbCNPJ.Text = bd.getFieldValueString(string.Format("SELECT CAD_CNPJ FROM AssepontoClientes WHERE CAD_IND = {0}", ind));
            if (lbCNPJ.Text.Trim() == "")
                lbCNPJ.Visible = false;
            else
                lbCNPJ.Text = Convert.ToUInt64(lbCNPJ.Text).ToString(@"00\.000\.000\/0000\-00");

            lbCPF.Text = bd.getFieldValueString(string.Format("SELECT CAD_CPF FROM AssepontoClientes WHERE CAD_IND = {0}", ind));
            if (lbCPF.Text.Trim() == "")
                lbCPF.Visible = false;
            else
                lbCPF.Text = Convert.ToUInt64(lbCPF.Text).ToString(@"000\.000\.000\-00");

            int versao = bd.getFieldValueInteger(string.Format(@"select a.PED_VERSAO_AQUISICAO 
                                                                 from AssepontoClientes 
                                                                 outer apply( 
	                                                                 select PED_VERSAO_AQUISICAO 
	                                                                 from AssepontoPedidosRevendas  
	                                                                 where (PED_CLI_CNPJ = CAD_CNPJ or 
		                                                                   PED_CLI_CPF = CAD_CPF) and PED_REV_IND = CAD_REVENDA 
                                                                 ) a 
                                                                 where CAD_IND = {0}", ind));
            if (versao == 8)
            {
                lbVersao.Text = "AssePontoWeb";
                imgAtestado.ImageUrl = "../../Images/Site/AtestadoTecnicoWeb.png";
            }
            else
            {
                lbVersao.Text = "AssePonto Versão 4";
                imgAtestado.ImageUrl = "../../Images/Site/AtestadoTecnico.png";
            }
        }

        protected void lkImpressao_Click(object sender, EventArgs e)
        {
            bd.executeCommand(string.Format("UPDATE AssepontoClientes SET CAD_IMPRESSAO_CERTIFICADO = 1, CAD_DTA_CERTIFICADO = GETDATE() WHERE CAD_IND = {0} AND CAD_DTA_CERTIFICADO IS NULL", ind));
        }
    }
}