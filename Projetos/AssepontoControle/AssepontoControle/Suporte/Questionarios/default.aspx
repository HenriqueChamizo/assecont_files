<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Asseponto.Suporte.Questionarios._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Software" NavigateUrl="~/suporte/Questionarios/RelatorioSoftware.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Atendimento" NavigateUrl="~/suporte/Questionarios/RelatorioAtendimento.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Treinamento" NavigateUrl="~/suporte/Questionarios/RelatorioTreinamento.aspx">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Quest/questionario.png" />
        </div>
    </div>
</asp:Content>
