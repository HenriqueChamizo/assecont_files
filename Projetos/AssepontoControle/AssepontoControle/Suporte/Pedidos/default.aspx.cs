using System;
using Asseponto.Classes;

namespace Asseponto.Suporte.Pedidos
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RadMenu2.FindItemByText("Em Aberto Asseponto4").NavigateUrl = String.Format("~/suporte/pedidos/default.aspx?status={0}", Convert.ToInt32(Types.PedidoStatus.EmAberto));
            RadMenu2.FindItemByText("Em Aberto AssepontoWeb").NavigateUrl = String.Format("~/suporte/pedidos/default.aspx?status={0}&web=8", Convert.ToInt32(Types.PedidoStatus.EmAberto));
            RadMenu2.FindItemByText("Em Aberto Assefin").NavigateUrl = String.Format("~/suporte/pedidos/default.aspx?status={0}&assef=1", Convert.ToInt32(Types.PedidoStatus.EmAberto));
            RadMenu2.FindItemByText("Fechados Asseponto4").NavigateUrl = String.Format("~/suporte/pedidos/default.aspx?status={0}&assef=0", Convert.ToInt32(Types.PedidoStatus.Fechado));
            RadMenu2.FindItemByText("Fechados AssepontoWeb").NavigateUrl = String.Format("~/suporte/pedidos/default.aspx?status={0}&web=8", Convert.ToInt32(Types.PedidoStatus.Fechado));
            RadMenu2.FindItemByText("Fechados Assefin").NavigateUrl = String.Format("~/suporte/pedidos/default.aspx?status={0}&assef=1", Convert.ToInt32(Types.PedidoStatus.Fechado));
        }
    }
}