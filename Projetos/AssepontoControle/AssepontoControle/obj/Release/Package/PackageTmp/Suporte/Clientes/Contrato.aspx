<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Contrato.aspx.cs" Inherits="Asseponto.Suporte.Clientes.Contrato" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script type="text/javascript" src="http://www.asseponto.com.br/assepontocontrole/JQuery/Impressao.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server" />

<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <asp:RadioButtonList ID="RadioButtonList1" runat="server">
        <asp:ListItem Value="0" Text="Asseponto4"></asp:ListItem>
        <asp:ListItem Value="1" Text="AssepontoWeb"></asp:ListItem>
    </asp:RadioButtonList>
    <br />
    Valor
    <asp:TextBox ID="txtValor" Height="25" runat="server"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp; Descrição do valor extenso&nbsp;<asp:TextBox ID="txtDescricao" Height="25" runat="server"></asp:TextBox>&nbsp;&nbsp;
    <asp:Button ID="btValor" CssClass="sitebutton blue" runat="server" OnClick="btValor_Click" Text="Gerar com outro Valor" />
    <br />
    <flv:ManutencaoContrato runat="server" ID="ManutencaoContrato" />
</asp:Content>