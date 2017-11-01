<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="pesquisaAvaliacaoFuncionario.aspx.cs" Inherits="AssecontNovo.Pesquisas.pesquisaAvaliacaoFuncionario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section style="width: 790px; margin: 0 auto;">

        <table style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="titleSubs" style="padding-top: 10px; padding-bottom: 8px;">Avaliação dos funcionarios
                </td>
                <td style="text-align: right;">
                    <img src="http://www.assecont.com.br/Imagens/logos/Logo.png" />
                </td>
            </tr>
        </table>

        <flv:ServerPesquisaFuncionario id="serverViews" runat="server" funcionario="188"/>

    </section>
</asp:Content>
