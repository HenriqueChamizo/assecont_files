<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MenuTopCotacao.ascx.cs" Inherits="Assecont2.WebControl.MenuTopCotacao" %>

<style type="text/css">
    .menuManual
    {
        width: 110px;
        height: 40px;
        padding: 2px 14px 3px 10px;
        display: inline-block;
        line-height: 19px;
        color: #141414;
        border: 1px solid #CCC;
        cursor: pointer;
        text-align: center;
        display: table-cell;
        vertical-align: middle;
    }
</style>

<div>
    <table style="margin-top: 20px; margin-bottom: 20px;">
        <tr>
            <td>
                <asp:HyperLink ID="HyperMudar" runat="server" CssClass="menuManual" NavigateUrl="../contabilidade/Cotacao/default.aspx">Por que Mudar?</asp:HyperLink>
            </td>
            <td>
                <asp:HyperLink ID="HyperBeneficio" runat="server" CssClass="menuManual" NavigateUrl="../contabilidade/Cotacao/beneficio.aspx">Benefícios</asp:HyperLink>
            </td>
            <td>
                <asp:HyperLink ID="HyperCotacao" runat="server" CssClass="menuManual" NavigateUrl="../contabilidade/Cotacao/form.aspx">Cotação</asp:HyperLink>
            </td>
        </tr>
    </table>
</div>
