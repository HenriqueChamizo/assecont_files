<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AssecontNovo.Tecnologia.AssepontoWeb.Manual._default" %>

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
    <div id="sitetitle">
        <table id="Table1" style="width: 100%;">
            <tbody>
                <tr>
                    <td>
                        <div id="PageTitle_PageTitleWrapper" style="padding: 0px 5px 5px 0px;">
                            <table>
                                <tbody><tr>
                                    <td>
                                        <div id="PageTitle_imagewrapper">
                                             <img id="PageTitle_PageTitleImage" src="../../../Imagens/24x24/manual24x24.png">
                                        </div>
                                    </td>
                                    <td>
                                        <div id="PageTitle_PageTitleTexts">
                                        <span class="descricaoGrupo">Manual Operacional AssepontoWeb</span></div>
                                    </td>
                                </tr>
                            </tbody></table>
                        </div>
                    </td>
                    <td align="right"></td>
                </tr>
            </tbody>
        </table>
    </div>
    <flv:MenuLeftAssepontoWeb runat="server" ID="MenuLeftAsseponto4" />
    <section class="ContentText" style="width: 780px;">
        <table>
            <tr>
                <td>
                    <table class="linkVermelho Manual">
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperTranamento" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/AssepontoWeb/Manual/rotinasTratamento.aspx">1. Rotinas de Tratamento</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperCadastro" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/AssepontoWeb/Manual/cadastro.aspx">2. Cadastro</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperBancoHoras" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/AssepontoWeb/Manual/bancoHoras.aspx">3. Banco de Horas</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperRelatorios" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/AssepontoWeb/Manual/relatorios.aspx">4. Relatórios</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperOcorrenciaTratamento" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/AssepontoWeb/Manual/OcorrenciaTratamentos.aspx">5. Ocorrência Tratamento</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperBakcup" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/AssepontoWeb/Manual/backup.aspx">6. Backup</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperGerar" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/AssepontoWeb/Manual/backup.aspx">7. Gerar AFDT E ACJEF</asp:HyperLink>
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
