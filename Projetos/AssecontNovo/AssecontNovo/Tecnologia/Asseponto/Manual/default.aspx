<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AssecontNovo.Teste.Asseponto4._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="http://www.assecont.com.br/Jquery/Arccodion/arccodion.js"></script>
    <link href="http://www.assecont.com.br/Styles/arccodion.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#buttons').akordeon({ buttons: true, toggle: true });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <flv:MenuLeftAsseponto4 runat="server" ID="MenuLeftAsseponto4" />
    <section class="ContentText" style="width: 780px;">
        <table>
            <tr>
                <td>
                    <table class="linkVermelho Manual">
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperTranamento" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/Asseponto/Manual/rotinasTratamento.aspx">1. Rotinas de Tratamento</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperCadastro" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/Asseponto/Manual/cadastro.aspx">2. Cadastro</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperBancoHoras" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/Asseponto/Manual/bancoHoras.aspx">3. Banco de Horas</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperRelatorios" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/Asseponto/Manual/relatorios.aspx">4. Relatórios</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperOcorrenciaTratamento" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/Asseponto/Manual/OcorrenciaTratamentos.aspx">5. Ocorrência Tratamento</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperBakcup" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/Asseponto/Manual/backup.aspx">6. Backup</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperGerar" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/Asseponto/Manual/Gerar.aspx">7. Gerar AFDT E ACJEF</asp:HyperLink>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <asp:Image ID="Image1" runat="server" Height="230" ImageUrl="~/Imagens/Tecnologia/Asseponto4/AssepontoSoftware.png" Style="float: left;" />
                </td>
            </tr>
        </table>

    </section>
</asp:Content>
