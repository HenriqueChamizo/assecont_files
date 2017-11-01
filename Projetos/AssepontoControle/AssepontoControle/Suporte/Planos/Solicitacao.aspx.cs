using Asseponto.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace Asseponto.Suporte.Planos
{
    public partial class Solicitacao : System.Web.UI.Page
    {
        private BDApp bd;
        private UserApp user;
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            bd = new BDApp();
            user = new UserApp();
            Modelo.Asseponto.ClienteDetail cliente = new Modelo.Asseponto.ClienteDetail();
            Modelo.Asseponto.RevendaDetail revenda = new Modelo.Asseponto.RevendaDetail();
            cliente.CAD_IND = Convert.ToInt32(Request.QueryString["ind"]);

            if (!IsPostBack)
                ManutencaoStatus1.Cliente = cliente.CAD_IND;

            //BLL.ClienteBLL bLL = new BLL.ClienteBLL(BLL.TypesConnections.Asseponto);
            //bLL.GetClienteWithRevenda(ref cliente, ref revenda);
            //MontaCliente(ref cliente, ref revenda);
        }

        //private void MontaCliente(ref Modelo.Asseponto.ClienteDetail cliente, ref Modelo.Asseponto.RevendaDetail revenda)
        //{
        //    lbCliRazao.Text = cliente.CAD_RAZAOSOCIAL;
        //    lbCliCnpj.Text = cliente.CAD_CNPJ;
        //    lbContato.Text = cliente.CAD_CONTATO;
        //    lbTelefone1.Text = cliente.CAD_TELEFONE1;
        //    lbTelefone2.Text = cliente.CAD_TELEFONE2;
        //    lbEmail1.Text = cliente.CAD_EMAIL;
        //    lbEmail2.Text = cliente.CAD_EMAIL2;
            
        //    lbContatoFin.Text = cliente.CAD_FINANCEIRO_CONTATO;
        //    lbTelefone1Fin.Text = cliente.CAD_FINANCEIRO_TELEFONE1;
        //    lbTelefone2Fin.Text = cliente.CAD_FINANCEIRO_TELEFONE2;
        //    lbEmail1Fin.Text = cliente.CAD_FINANCEIRO_EMAIL;
        //    lbEmail2Fin.Text = cliente.CAD_FINANCEIRO_EMAIL2;

        //    lbRevRazao.Text = revenda.REV_RAZAOSOCIAL;
        //    lbRevCnpj.Text = revenda.REV_CNPJ;
        //}
    }
}