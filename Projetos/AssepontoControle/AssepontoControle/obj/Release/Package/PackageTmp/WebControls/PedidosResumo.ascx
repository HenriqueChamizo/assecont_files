<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PedidosResumo.ascx.cs"
    Inherits="Asseponto.WebControls.PedidosResumo" %>
<div id="PedidosResumosWrapper" runat="server">
    <table>
        <tr>
            <td valign="top">
                <img alt="Pedidos" src="http://www.asseponto.com.br/assepontocontrole/Images/48x48/Basket.png" />
            </td>
            <td valign="top">
                <strong  class="siteTituloDestaque"><asp:Label ID="Label1" runat="server" CssClass="sitepadraoazuldestaque">Pedidos</asp:Label></strong>
                <div id="ponto4" runat="server">
                    <asp:HyperLink ID="linkNPedidos4" runat="server" CssClass="sitelinkpadraoazul"></asp:HyperLink><br />
                    <asp:Label ID="labelRevendaTit4" runat="server">Último Pedido:</asp:Label><br />
                    <asp:HyperLink ID="linkUltimoPedido4" runat="server" CssClass="sitelinkpadraoazul"></asp:HyperLink><br />
                    <asp:Label ID="labelRevenda4" runat="server"></asp:Label>
                    <asp:Label ID="labelDataHora4" runat="server" ForeColor="#999999"></asp:Label>
                    <br />
                </div>
                <div id="pontoWeb" runat="server">
                    <br />
                    <asp:HyperLink ID="linkNPedidosWeb" runat="server" CssClass="sitelinkpadraoazul"></asp:HyperLink><br />
                    <asp:Label ID="labelRevendaTitWeb" runat="server">Último Pedido:</asp:Label><br />
                    <asp:HyperLink ID="linkUltimoPedidoWeb" runat="server" CssClass="sitelinkpadraoazul"></asp:HyperLink><br />
                    <asp:Label ID="labelRevendaWeb" runat="server"></asp:Label>
                    <asp:Label ID="labelDataHoraWeb" runat="server" ForeColor="#999999"></asp:Label>
                </div>
            </td>
        </tr>
    </table>
</div>
