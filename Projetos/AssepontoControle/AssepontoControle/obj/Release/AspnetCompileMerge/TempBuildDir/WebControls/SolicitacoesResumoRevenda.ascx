<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SolicitacoesResumoRevenda.ascx.cs" Inherits="Asseponto.WebControls.SolicitacoesResumoRevenda" %>
<div id="SolicitacoesResumoWrapper" runat="server">
    <table>
        <tr>
            <td valign="top">
                <img alt="Implantações" src="../Images/48x48/Key.png" />
            </td>
            <td valign="top">
                <strong class="siteTituloDestaque"><asp:Label ID="labelTitulo" runat="server" CssClass="sitepadraoazuldestaque">Solicitações Revendas</asp:Label></strong>
                <div runat="server" id="divSolicitacoes"><asp:HyperLink ID="linkNSolicitacoes" runat="server" CssClass="sitelinkpadraoazul"></asp:HyperLink><br /></div>
            </td>
        </tr>
    </table>
</div>
