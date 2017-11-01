<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Asseponto.Suporte.Util.Default1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div>
        <asp:Label ID="lbTexto" runat="server" Text="Digite um E-mail para teste"></asp:Label>
        <br />
        <asp:TextBox ID="TextBox1" runat="server" Width="340px"></asp:TextBox>
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" CssClass="sitebutton blue" Text="Testar" />
        <br />
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
        <br />
    </div>
</asp:Content>
