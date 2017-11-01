<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PendenciasResumo.ascx.cs"
    Inherits="Asseponto.WebControls.PendenciasResumo" %>
<div id="PendenciasResumoWrapper" runat="server">
    <table>
        <tr>
            <td valign="top">
                <img alt="Pendências" src="../Images/48x48/Warning.png" />
            </td>
            <td valign="top">
                <strong class="siteTituloDestaque">
                    <asp:Label ID="labelNPedidos" runat="server" style="font-weight: normal;" CssClass="sitepadraoazuldestaque"></asp:Label></strong>
                <div id="divUltimasPendencias" runat="server" >
                </div>
                <br />
                <asp:HyperLink ID="linkTodas" runat="server" style="font-weight: normal;" CssClass="sitelinkpadraoazul" NavigateUrl="#"></asp:HyperLink>
            </td>
        </tr>
    </table>
</div>
