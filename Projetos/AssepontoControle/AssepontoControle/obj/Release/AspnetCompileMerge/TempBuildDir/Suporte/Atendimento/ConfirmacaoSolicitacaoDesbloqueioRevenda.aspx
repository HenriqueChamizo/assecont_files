<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="ConfirmacaoSolicitacaoDesbloqueioRevenda.aspx.cs" Inherits="Asseponto.Suporte.Atendimento.ConfirmacaoSolicitacaoDesbloqueioRevenda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <table>
                <tr>
                    <td>
                        <asp:Image ID="Image1" runat="server" Style="float: left; padding: 5px" ImageUrl="~/Images/48x48/Check.png" />
                    </td>
                    <td>
                        <div style="padding: 12px 0px 0px 5px">
                            Cadastro liberado com sucesso.<br />
                            <br />
                            E-mail encaminhando para a revenda com login e senha com sucesso.<br />
                            <br />
                            <br />
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="sitelinkpadraoazul" OnClick="LinkButton1_Click">Ir para o cadastro da Revenda ?</asp:LinkButton>
                            <br />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
