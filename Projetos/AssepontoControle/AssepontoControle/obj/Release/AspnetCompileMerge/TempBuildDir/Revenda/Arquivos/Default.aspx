<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Asseponto.Revenda.Arquivos.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:HyperLink ID="hyperlinkModelo" runat="server" NavigateUrl="~/Revenda/Arquivos/Modelo.xls"
                CssClass="sitelinkpadraoazul">Planilha Modelo</asp:HyperLink>
        </div>
    </div>
</asp:Content>
