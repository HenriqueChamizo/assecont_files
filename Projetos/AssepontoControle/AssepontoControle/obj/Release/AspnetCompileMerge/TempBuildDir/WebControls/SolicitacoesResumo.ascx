<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SolicitacoesResumo.ascx.cs"
    Inherits="Asseponto.WebControls.SolicitacoesResumo" %>
<div id="SolicitacoesResumoWrapper" runat="server">
    <table>
        <tr>
            <td valign="top">
                <img alt="Implantações" src="http://www.assecont.com.br/assepontocontrole/Images/48x48/Key.png" />
            </td>
            <td valign="top">
                <strong class="siteTituloDestaque"><asp:Label ID="labelTitulo" runat="server" CssClass="sitepadraoazuldestaque">Solicitações de Desbloqueio</asp:Label></strong>
                <div runat="server" id="divSolicitacoes"><asp:HyperLink ID="linkNSolicitacoes" runat="server" CssClass="sitelinkpadraoazul"></asp:HyperLink><br /></div>
            </td>
        </tr>
    </table>
</div>
