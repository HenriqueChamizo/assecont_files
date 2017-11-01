<%@ Page Title="" Language="C#" MasterPageFile="~/Pesquisas/PesquisasModel.Master" AutoEventWireup="true" CodeBehind="pesquisaDepto.aspx.cs" Inherits="AssecontNovo.Pesquisas.pesquisaDepto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section style="width: 790px; margin: 0 auto;">

        <table style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="titleSubs" style="padding-top: 10px; padding-bottom: 8px;">Pesquisa de Satisfação
                </td>
                <td style="text-align: right;">
                    <img src="http://www.assecont.com.br/Imagens/logos/Logo.png" />
                </td>
            </tr>
        </table>

        <flv:ServerPesquisaDepartamento id="serverViews" runat="server" />
        
    </section>
</asp:Content>
