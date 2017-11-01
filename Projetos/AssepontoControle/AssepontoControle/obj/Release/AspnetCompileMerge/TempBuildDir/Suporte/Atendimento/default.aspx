<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="default.aspx.cs" Inherits="Asseponto.Suporte.Atendimento._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Pendências em Aberto" NavigateUrl="~/Suporte/Atendimento/Pendencias.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Pendências Solucionadas" NavigateUrl="~/Suporte/Atendimento/Pendencias.aspx?situacao=2">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Solicitações Desbloqueio" NavigateUrl="~/Suporte/Atendimento/SolicitacoesDesbloqueio.aspx">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            
            <wr:TextSearch ID="TextSearch1" runat="server" PostBackUrl="~/Suporte/Atendimento/Clientes.aspx"
                QueryStringField="filtronome" ShowTableFilter ="true" QueryStringFieldFixed1="filTipo" QueryStringValueFixed1="1"/>
            <br />
            <wr:UltimasEmpresas runat="server" NavigateUrl="~/Suporte/Atendimento/Cliente.aspx" ImageUrl="../Images/48x48/Factory.png"/>
        </div>
    </div>
</asp:Content>
