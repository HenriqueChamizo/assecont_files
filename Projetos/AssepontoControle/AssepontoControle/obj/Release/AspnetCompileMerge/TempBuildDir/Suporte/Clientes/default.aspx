<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="default.aspx.cs" Inherits="Asseponto.Suporte.Clientes._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Todos os Clientes" NavigateUrl="~/suporte/Clientes/Clientes.aspx?filtronome=*">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Manutenções" NavigateUrl="~/suporte/Clientes/Manutencoes.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Pesquisa Assefin" NavigateUrl="~/suporte/Clientes/Clientes.aspx?banco=fin">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <wr:TextSearch ID="TextSearch1" runat="server" PostBackUrl="~/suporte/Clientes/Clientes.aspx" ShowTableFilter="true"
                QueryStringField="filtronome" QueryStringFieldFixed1="filTipo" />
                <br />
            <wr:UltimasEmpresas ID="UltimasEmpresas1" runat="server" NavigateUrl="~/suporte/Clientes/Cliente.aspx" ImageUrl="../Images/48x48/Factory.png" />
        </div>
    </div>
</asp:Content>
