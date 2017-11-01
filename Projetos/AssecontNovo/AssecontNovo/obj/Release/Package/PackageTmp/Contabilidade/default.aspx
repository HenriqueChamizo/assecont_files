<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Accounting.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AssecontNovo.contabilidade" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="/Jquery/Banner/jquery.skitter.js" type="text/javascript"></script>
    <script src="/Jquery/Slide/Slide.js"></script>

    <link href="/Styles/BannerPrincipal.css" rel="stylesheet" type="text/css" media="all" />

    <script type="text/javascript">
        $(document).ready(function () {
            $('.box_skitter_large').skitter(
                { animation: "blind", EspacoNumero: "760px" });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section id="SectionBanner">
        <div class="box_skitter box_skitter_large">
            <ul>
                <li>
                    <a href="gestaoContabilidade.aspx" target="_blank">
                        <asp:Image ID="Banner01" runat="server" ImageUrl="~/Imagens/Banner/BannerContabil/Banner1.png" alt="Banner 01" />
                    </a>
                </li>
                <li>
                    <a href="gestaoFiscal.aspx" target="_blank">
                        <asp:Image ID="Banner02" runat="server" ImageUrl="~/Imagens/Banner/BannerContabil/Banner2.png" alt="Banner 02" />
                    </a>
                </li>
                <li>
                    <a href="gestaoTrabalhista.aspx" target="_blank">
                        <asp:Image ID="Banner03" runat="server" ImageUrl="~/Imagens/Banner/BannerContabil/Banner3.png" alt="Banner 03" />
                    </a>
                </li>
                <li>
                    <a href="auditoria.aspx" target="_blank">
                        <asp:Image ID="Banner04" runat="server" ImageUrl="~/Imagens/Banner/BannerContabil/Banner4.png" alt="Banner 04" />
                    </a>
                </li>
                <li>
                    <a href="legalizacao.aspx" target="_blank">
                        <asp:Image ID="Banner05" runat="server" ImageUrl="~/Imagens/Banner/BannerContabil/Banner5.png" alt="Banner 05" />
                    </a>
                </li>
                <li>
                    <a href="../Grupo/AtendPersonalizado.aspx" target="_blank">
                        <asp:Image ID="Banner06" runat="server" ImageUrl="~/Imagens/Banner/BannerContabil/Banner6.png" alt="Banner 06" />
                    </a>
                </li>
                <li>
                    <a href="../Contabilidade/AsseAdmin.aspx" target="_blank">
                        <asp:Image ID="Banner07" runat="server" ImageUrl="~/Imagens/Banner/BannerContabil/Banner7.png" alt="Banner 07" />
                    </a>
                </li>
            </ul>
        </div>
    </section>

    <section class="SectionContent">
        <table>
            <tr>
                <td valign="top" style="width: 400px; padding-right: 30px;">
                    <article style="width: 400px; height: 230px;">
                        <header class="headerBlocks">
                            <img src="../Imagens/boxArticle/userIntegration.png" class="imgFloat" width="200" />
                            Integração de sistemas
                        </header>
                        <p>
                            A integração de sistemas elimina repetição de processos, produz a redução de custos e possibilita 
                        o ganho de tempo e produtividade.
                        </p>
                        <p>
                            <asp:HyperLink ID="HyperIntegracao" runat="server" NavigateUrl="../Contabilidade/IntegracaoSistema.aspx" CssClass="sitebutton blue">Saiba mais
                                   <img src="http://www.assecont.com.br/Imagens/24x24/OpenWhite24x24.png" />
                            </asp:HyperLink>
                        </p>
                    </article>
                </td>
                <td valign="top" style="width: 300px; padding-right: 30px;">
                    <article style="width: 300px; height: 230px;">
                        <header class="headerBlocks">
                            Retenção de Impostos e Contribuições sobre Serviços Tomados.
                        </header>
                        <br />
                        <img src="../Imagens/boxArticle/UserRetencoes.png" class="imgFloat" />
                        <p>
                            Faça pela Assecontweb. É simples, é rápido.
                        </p>
                        <p>
                            <asp:HyperLink ID="HyperRetencoes" runat="server" NavigateUrl="../Grupo/RetencaoImpostos.aspx" CssClass="sitebutton blue">Saiba mais
                                   <img src="http://www.assecont.com.br/Imagens/24x24/OpenWhite24x24.png" />
                            </asp:HyperLink>
                        </p>
                    </article>
                </td>
                <td valign="top" style="width: 230px;">
                    <article class="MiniArticleBox">
                        <header class="headerBlocks">
                            Home Office
                        </header>
                        <table style="padding-bottom: 8px;">
                            <tr>
                                <td class="texto"><a target="_blank" href="http://www.assecont.com.br/Grupo/HomeOffice.aspx">Trabalhando em casa</a>
                                </td>
                                <td>
                                    <asp:Image runat="server" ID="Image4" CssClass="imgHover" alt="Home Office" ImageUrl="~/Imagens/boxArticle/xicaraCafe.png" />
                                </td>
                            </tr>
                        </table>
                    </article>
                    <article style="width: 220px;">
                        <a id="lkOlhoNoImposto" class="opacity" target="_blank" href="~/Grupo/ImpostoIbit/default.aspx" runat="server">
                            <asp:Image ID="Image3" runat="server" ImageUrl="~/Imagens/boxArticle/DeOlhoNoImposto.png" Width="220" /></a>
                    </article>

                </td>
            </tr>
        </table>
    </section>
</asp:Content>
