<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PedidosResumo.ascx.cs"
    Inherits="Asseponto.WebControls.PedidosResumo" %>
<div id="PedidosResumosWrapper" runat="server">
    <table>
        <tr>
            <td valign="top">
                <img alt="Pedidos" src="http://www.assecont.com.br/assepontocontrole/Images/48x48/Basket.png" />
            </td>
            <td valign="top">
                <strong  class="siteTituloDestaque"><asp:Label ID="Label1" runat="server" CssClass="sitepadraoazuldestaque">Pedidos</asp:Label></strong>
                <asp:HyperLink ID="linkNPedidos" runat="server" CssClass="sitelinkpadraoazul"></asp:HyperLink><br />
                <asp:Label ID="labelRevendaTit" runat="server">Último Pedido:</asp:Label><br />
                <asp:HyperLink ID="linkUltimoPedido" runat="server" CssClass="sitelinkpadraoazul"></asp:HyperLink><br />
                <asp:Label ID="labelRevenda" runat="server"></asp:Label>
                <asp:Label ID="labelDataHora" runat="server" ForeColor="#999999"></asp:Label>
            </td>
        </tr>
    </table>
</div>
