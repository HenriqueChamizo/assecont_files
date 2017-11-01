using System;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Relatorios
{
    public partial class RelatorioPedidosPeriodo : System.Web.UI.Page
    {
        private int rep;
        private DateTime dataInicial;
        private DateTime dataFinal;

        protected void Page_Load(object sender, EventArgs e)
        {
            BDApp bd = new BDApp();

            new Permissoes(bd).getAcessoResponse("relatorio_implantacao", Response);

            dataInicial = Convert.ToDateTime((String.IsNullOrEmpty(Request.QueryString["datainicial"])) ? "01/01/2000" : Request.QueryString["datainicial"]);
            dataFinal = Convert.ToDateTime((String.IsNullOrEmpty(Request.QueryString["datafinal"])) ? "01/01/2050" : Request.QueryString["datafinal"]);
            rep = Convert.ToInt32(Request.QueryString["rep"]);

            if (String.IsNullOrEmpty(comboboxRep.SelectedValue))
                comboboxRep.SelectedIndex = rep = 0;
            else
                rep = Convert.ToInt32(comboboxRep.SelectedValue);
        }


        protected void comboboxRep_DataBound(object sender, EventArgs e)
        {
            comboboxRep.Items.Insert(0, new RadComboBoxItem("Todos os Relógios", "0"));

            if (!IsPostBack)
                comboboxRep.SelectedIndex = 0;
        }

        protected void comboboxRep_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            rep = Convert.ToInt32(e.Value);
            DataListPedidos.DataBind();
            DetailsView1.DataBind();
        }

        protected void SqlDataImplantacaoes_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@datainicial"].Value = dataInicial.ToString("dd/MM/yyyy");
            e.Command.Parameters["@datafinal"].Value = dataFinal.ToString("dd/MM/yyyy");
            e.Command.Parameters["@rep"].Value = rep;
        }
    }
}