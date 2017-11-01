<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Asseponto.Suporte.Relatorios._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Questionários" NavigateUrl="~/Suporte/Questionarios/default.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Relatório Contrato Não Recebido" NavigateUrl="~/suporte/Relatorios/RelatorioContratoNotRecebido.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Relatório Revendas Credenciadas" NavigateUrl="~/suporte/Relatorios/RelatorioRevenda.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Relatório Clientes Expirados(60 Dias)" NavigateUrl="~/suporte/Relatorios/RelatorioClientesExpirados.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Relatório Pedidos Asseponto4 por Periodo" NavigateUrl="~/suporte/Relatorios/RelatorioImplatacoesPeriodo.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Relatório Pedidos Asseponto4" NavigateUrl="~/suporte/Relatorios/RelatorioImplatacoes.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Relatório Implantações Finalizadas Completa" NavigateUrl="~/suporte/Relatorios/RelatorioImplantacoesFinalizadasCompleta.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Relatório Implantações Finalizadas incompletas" NavigateUrl="~/suporte/Relatorios/RelatorioImplantacoesFinalizadasIncompleta.aspx">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <img alt="" src="../../Images/Quest/report.png" width="500px" />
        </div>
    </div>
</asp:Content>
