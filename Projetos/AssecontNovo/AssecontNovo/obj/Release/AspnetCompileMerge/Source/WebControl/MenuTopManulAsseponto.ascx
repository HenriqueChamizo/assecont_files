<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MenuTopManulAsseponto.ascx.cs" Inherits="Assecont2.WebControl.MenuTopManulAsseponto" %>

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
                <asp:HyperLink ID="HyperTrantamento" runat="server" CssClass="menuManual" NavigateUrl="~/Tecnologia/Asseponto/Manual/rotinasTratamento.aspx">Rotinas de Tratamento</asp:HyperLink>
            </td>
            <td>
                <asp:HyperLink ID="HyperCadastro" runat="server" CssClass="menuManual" NavigateUrl="~/Tecnologia/Asseponto/Manual/cadastro.aspx">Cadastro</asp:HyperLink>
            </td>
            <td>
                <asp:HyperLink ID="HyperBancoHoras" runat="server" CssClass="menuManual" NavigateUrl="~/Tecnologia/Asseponto/Manual/bancoHoras.aspx">Banco de Horas</asp:HyperLink>
            </td>
            <td>
                <asp:HyperLink ID="HyperRelatorios" runat="server" CssClass="menuManual" NavigateUrl="~/Tecnologia/Asseponto/Manual/relatorios.aspx">Relatórios</asp:HyperLink>
            </td>
            <td>
                <asp:HyperLink ID="HyperOcorrenciaTratamento" runat="server" CssClass="menuManual" NavigateUrl="~/Tecnologia/Asseponto/Manual/OcorrenciaTratamentos.aspx">Ocorrência Tratamento</asp:HyperLink>
            </td>
            <td>
                <asp:HyperLink ID="HyperBackup" runat="server" CssClass="menuManual" NavigateUrl="~/Tecnologia/Asseponto/Manual/Backup.aspx">Backup</asp:HyperLink>
            </td>
        </tr>
    </table>
</div>
