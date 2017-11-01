<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="AssepontoFolhaWeb.aspx.cs" Inherits="AssecontNovo.Teste.AssepontoFolhaWeb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <img src="../Imagens/Comunicado/AssepontoWeb.jpg" width="760" />

    <section class="ContentText">
        <table style="width: 100%">
            <tr>
                <td>Consulte nossa solução para Folha de pagamento com integração via Web pelo Asseponto
                    <asp:HyperLink ID="HyperFolhaWe" runat="server" NavigateUrl="~/Tecnologia/FolhaPagWeb.aspx" CssClass="sitebutton blue" >
                        Saiba mais <img src="../Imagens/24x24/OpenWhite24x24.png" />

                    </asp:HyperLink>
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
