<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Asseponto.Suporte.Revendas._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Todas as Revendas" NavigateUrl="~/suporte/Revendas/Revendas.aspx?filtrorazaosocial=*">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Nova Revenda" NavigateUrl="~/RevendaCadastro/CadastroRevendas.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Solicitações Revenda" NavigateUrl="~/suporte/Atendimento/SolicitacoesDesbloqueioRevenda.aspx?liberado=1">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <wr:TextSearch ID="TextSearch1" runat="server" PostBackUrl="~/suporte/Revendas/Revendas.aspx" QueryStringField="filtrorazaosocial" />
        </div>
    </div>
</asp:Content>
