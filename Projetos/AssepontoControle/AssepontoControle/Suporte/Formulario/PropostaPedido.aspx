<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ForaMasterPage.Master" AutoEventWireup="true" CodeBehind="PropostaPedido.aspx.cs" Inherits="Asseponto.Suporte.Formulario.PropostaPedido" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <table style="width: 100%;">
        <tr>
            <td colspan="2">
                <asp:Label ID="lbTipoServico" runat="server" CssClass="titleSubs"></asp:Label>
                <br />
            </td>
        </tr>
        <tr>
            <td style="width: 480px; vertical-align: top;">
                <asp:Literal ID="lbDescricao" runat="server"></asp:Literal>
            </td>
            <td class="text">
                <table style="width: 100%; border-left: 2px solid #E4E6E7; padding-left: 15px;">
                    <tr>
                        <td>CNPJ/ CPF<br />
                            <asp:TextBox ID="txtCNPJCpf" runat="server" Width="280"></asp:TextBox>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>Contato<br />
                            <asp:TextBox ID="txtContato" runat="server" Width="280"></asp:TextBox>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>E-mail Principal<br />
                            <asp:TextBox ID="txtEmail" runat="server" Width="280"></asp:TextBox>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="btnAceitar" runat="server" CssClass="sitebutton blue" OnClick="btnAceitar_Click">Aceitar</asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
