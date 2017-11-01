<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="localizacao.aspx.cs" Inherits="AssecontNovo.Teste.localizacao" %>

<%@ Register Src="~/WebControl/WbLocalizacao.ascx" TagPrefix="flv" TagName="WbLocalizacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <flv:WbLocalizacao runat="server" ID="WbLocalizacao" />
</asp:Content>