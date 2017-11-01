<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="contatoTec.aspx.cs" Inherits="Assecont2.Tecnologia.contatoTec" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <style type="text/css">
        .tableContact td
        {
            padding-top: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section class="ContentText">
        <table class="tableContact" style="width: 100%">
            <asp:Literal ID="LiteralSuporte" runat="server"></asp:Literal>
        </table>
    </section>
</asp:Content>
