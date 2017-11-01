<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true"
    CodeBehind="PedidoEnviado.aspx.cs" Inherits="Asseponto.Revenda.Pedidos.PedidoEnviado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:Image ID="Image1" runat="server" Style="float: left; padding: 5px" ImageUrl="../../Images/48x48/Check.png" />
            <div style="padding: 12px 0px 0px 5px">
                Pedido enviado com sucesso<br />
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Revenda/Pedidos/Default.aspx" CssClass="sitelinkpadraoazul">Ir para meus pedidos</asp:HyperLink>
            </div>
        </div>
    </div>
</asp:Content>
