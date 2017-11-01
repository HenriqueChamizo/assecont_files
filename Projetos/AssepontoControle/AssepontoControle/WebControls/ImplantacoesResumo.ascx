<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ImplantacoesResumo.ascx.cs"
    Inherits="Asseponto.WebControls.ImplantacoesResumo" %>
<div id="ImplantacoesResumosWrapper" runat="server">
    <table>
        <tr>
            <td valign="top">
                <img alt="Implantações" src="../Images/48x48/FlagBlue.png" />
            </td>
            <td valign="top">
                <strong class="siteTituloDestaque"><asp:Label ID="labelTitulo" runat="server" CssClass="sitepadraoazuldestaque">Implantações</asp:Label></strong>
                <div runat="server" id="divIniciadas"  ><asp:HyperLink ID="linkNImplantacoesIniciadas" runat="server" style="font-weight: normal;" CssClass="sitelinkpadraoazul"></asp:HyperLink><br /></div>
                <div runat="server" id="divNaoIniciadas"  ><asp:HyperLink ID="linkNImplantacoesNaoIniciadas" runat="server" style="font-weight: normal;" CssClass="sitelinkpadraoazul"></asp:HyperLink><br /></div>
            </td>
        </tr>
    </table>
</div>
