<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AssecontNews.ascx.cs"
    Inherits="Asseponto.WebControls.AssecontNews" %>
<div id="SolicitacoesResumoWrapper" runat="server">
    <table style="padding-top: 10px;">
        <tr>
            <td valign="top" style="padding-right: 8px;" >
                <img alt="Jornal" src="http://www.asseponto.com.br/assepontocontrole/Images/Site/AssecontNews.png" />
            </td>
            <td valign="top">
                <strong>
                    <asp:Label ID="labelTitulo" runat="server" CssClass="sitepadraoazuldestaque">Assecont Informando</asp:Label></strong><br />
                <div runat="server" id="divSolicitacoes">
                    <a target="_blank" class="sitelinkpadraoazul" href="../Jornal/Edicao1.pdf">1 Edição - Janeiro/2015</a>
                    <br />
                </div>
            </td>
        </tr>
    </table>
</div>
