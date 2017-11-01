using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Clientes
{
    public partial class ManutencoesCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                (new Permissoes(new BDApp())).getAcessoResponse("Manutencao", Response);

            ManutencaoLancamento1.Cliente = Convert.ToInt32(Request.QueryString["cliente"]);
            ManutencaoCancelamento1.Cliente = Convert.ToInt32(Request.QueryString["cliente"]);          
        }

        protected void RadMenu2_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
        {
            switch (e.Item.Text)
            {
                case "Lançar Manutenção": 
                    expandirLancarManutencao();
                    break;
                case "Cancelamento": 
                    expandirCancelamento();
                    break;
            }
        }

        private void expandirLancarManutencao()
        {
            ManutencaoLancamento1.Visible = true;

            if (ManutencaoCancelamento1.Visible)
            {
                ManutencaoCancelamento1.Visible = false;
            }
        }

        private void expandirCancelamento()
        {
            ManutencaoCancelamento1.Visible = true;

            if (ManutencaoLancamento1.Visible)
            {
                ManutencaoLancamento1.Visible = false;
            }
        }
    }
}