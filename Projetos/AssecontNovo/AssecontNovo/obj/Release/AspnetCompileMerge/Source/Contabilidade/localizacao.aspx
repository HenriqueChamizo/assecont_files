<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Accounting.Master" AutoEventWireup="true" CodeBehind="localizacao.aspx.cs" Inherits="Assecont2.Contabilidade.localizacao" %>

<%@ Register Src="~/WebControl/WbLocalizacao.ascx" TagPrefix="flv" TagName="WbLocalizacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <flv:WbLocalizacao runat="server" ID="WbLocalizacao" />
</asp:Content>