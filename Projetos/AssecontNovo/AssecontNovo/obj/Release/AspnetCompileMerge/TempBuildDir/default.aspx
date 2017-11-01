<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Assecont2.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="Jquery/Slide/jquery.bxslider.js"></script>
    <link href="Styles/bxslider.css" rel="stylesheet" />

    <script src="Jquery/Carroseul/jquery.mousewheel.min.js"></script>
    <script src="Jquery/Carroseul/jquery.carousel-1.1.js"></script>
    <link href="Styles/carousel.css" rel="stylesheet" />

    <script type="text/javascript">

        $(document).ready(function () {
            $('#bxSocial').bxSlider({
                pager: false,
                slideMargin: 5,
                auto: true,
                autoHover: true
            });

            $('#bxInformativo').bxSlider({
                pager: true,
                auto: true,
                autoHover: true,
                controls: false
            });

            $('.carousel').carousel({
                hAlign: 'center',
                vAlign: 'bottom',
                hMargin: 0.05,
                frontWidth: 920,
                frontHeight: 320,
                carouselWidth: 1000,
                carouselHeight: 320,
                directionNav: true,
            });
        });
    </script>

    <script>
        function Open(indetificador) {
            var button = $('#OpenButton' + indetificador);
            var box = $('#OpenBox' + indetificador);
            var form = $('#OpenForm' + indetificador);

            button.removeAttr('href');

            if (!button.hasClass('active'))
                box.toggle();

            form.mouseup(function () {
                return false;
            });

            $(this).mouseup(function (login) {
                if (!($(login.target).parent(button).length > 0)) {
                    button.removeClass('active');
                }
            });
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section id="sectioBanner">
        <div class="carousel">
            <div class="slides">
                <div>
                    <a href="../Assecont/Contabilidade" target="_blank">
                        <asp:Image ID="Banner01" runat="server" ImageUrl="http://www.assecont.com.br/assecont/Imagens/Banner/Banner1.png" alt="Banner 01" />
                    </a>
                </div>
                <div>
                    <a href="../Assecont/Tecnologia" target="_blank">
                        <asp:Image ID="Banner02" runat="server" ImageUrl="http://www.assecont.com.br/assecont/Imagens/Banner/Banner2.png" alt="Banner 02" />
                    </a>
                </div>
                <div>
                    <a href="http://martinsfontes.adv.br/" target="_blank">
                        <asp:Image ID="Banner03" runat="server" ImageUrl="http://www.assecont.com.br/assecont/Imagens/Banner/Banner3.png" alt="Banner 03" />
                    </a>
                </div>
                <div>
                    <a href="../Assecont/Tecnologia" target="_blank">
                        <asp:Image ID="Banner04" runat="server" ImageUrl="http://www.assecont.com.br/assecont/Imagens/Banner/Banner2.png" alt="Banner 04" />
                    </a>
                </div>
            </div>
        </div>
    </section>

    <section class="SectionContent">
        <table>
            <tr>
                <td valign="top" style="width: 420px; padding-right: 25px;">
                    <article style="width: 420px; height: 220px;">
                        <header class="headerBlocks " style="height: 32px; border-bottom: 1px solid;">
                            <img src="Imagens/32x32/home32x32.png" class="img" />
                            Conheça nossa empresa
                        </header>
                        <asp:Image ID="Image3" runat="server" alt="Simbolo" ImageUrl="~/Imagens/Assecont/assecontFachada.png" Width="150" CssClass="imgFloat" />
                        <p>
                            Empresa em busca da constante modernização que investe fortemente em instalações físicas, em ferramentas e inovações tecnológicas e 
                                no capital humano, buscando o comprometimento com a nossa missão.
                        </p>
                        <p>
                            <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitebutton blue" NavigateUrl="~/Grupo/NossaEmpresa.aspx">Continue lendo
                                 <img src="Imagens/24x24/OpenWhite24x24.png" />
                            </asp:HyperLink>
                        </p>
                    </article>

                    <article style="width: 420px; height: 220px;">
                        <header class="headerBlocks " style="height: 32px; border-bottom: 1px solid;">
                            <img src="Imagens/32x32/megaPhone32x32.png" class="img" />
                            Destaque
                        </header>
                        <asp:Image ID="Image6" runat="server" alt="Fachada" ImageUrl="~/Imagens/boxArticle/userAssecontWeb.png" Width="160" CssClass="imgFloat" />
                        <header class="headerBlocks font_blue">
                            AssecontWeb
                        </header>
                        <p>
                            <b>Sistema gerencial de controle de serviços e documentos</b>
                        </p>
                        <p>
                            Tudo sob Controle !
                        </p>
                        <p>
                            <asp:HyperLink ID="HyperLink2" runat="server" CssClass="sitebutton blue" NavigateUrl="~/tecnologia/assecontweb.aspx">Saiba mais
                                 <img src="Imagens/24x24/OpenWhite24x24.png" />
                            </asp:HyperLink>
                        </p>
                    </article>

                    <article style="width: 420px; height: 220px;">
                        <header class="headerBlocks" style="height: 32px; border-bottom: 1px solid;">
                            Assessoria Administrativa
                        </header>
                        <asp:Image ID="Image5" runat="server" alt="Consultoria" CssClass="imgFloat" ImageUrl="~/Imagens/boxArticle/userCOnsultoria.png" />
                        <p>
                            Prepare sua empresa nas áreas Administrativo/ Financeira para o Sistema de Gestão da Qualidade ISO 9001.
                        </p>
                        <p>
                            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Contabilidade/AsseAdmin.aspx" CssClass="sitebutton blue">Saiba mais
                                 <img src="Imagens/24x24/OpenWhite24x24.png" />
                            </asp:HyperLink>
                        </p>
                    </article>

                    <article style="width: 420px; height: 230px;">
                        <header class="headerBlocks" style="height: 10px; width: 420px;">
                            <img src="Imagens/32x32/News32x32.png" class="img" width="32" />
                            Informativo
                        </header>
                        <ul id="bxInformativo">
                            <asp:Literal ID="LiteralInformativos" runat="server"></asp:Literal>
                        </ul>
                    </article>
                </td>

                <td valign="top" style="width: 300px; padding-right: 25px;">
                    <article style="width: 300px; height: 200px;">
                        <header class="headerBlocks" style="border-bottom: 1px solid;">
                            <img src="Imagens/logos/logoAtendPers.png" class="img" width="300" />
                        </header>
                        <img src="Imagens/boxArticle/impContador.png" class="imgFloat" />
                        <p>
                            <b>Tenha um contador dentro da sua empresa.</b>
                        </p>
                        <p>
                            <asp:HyperLink ID="HyperLink4" runat="server" CssClass="sitebutton blue" NavigateUrl="Grupo/AtendPersonalizado.aspx">Saiba mais 
                                <img src="Imagens/24x24/OpenWhite24x24.png" />
                            </asp:HyperLink>
                        </p>
                    </article>

                    <article style="width: 300px; height: 240px;">
                        <header class="headerBlocks" style="border-bottom: 1px solid;">
                            <img src="Imagens/logos/logo_asseJur.png" />
                        </header>
                        <img src="Imagens/boxArticle/useJur.jpg" class="imgFloat" />
                        <p>
                            Assessoria jurídica especializada, com atuação consultiva e litigiosa, visando abranger as demandas jurídicas empresariais.
                        </p>
                        <p>
                            <asp:HyperLink ID="HyperLink5" runat="server" Target="_blank" NavigateUrl="http://martinsfontes.adv.br/areas/" CssClass="sitebutton blue">Saiba mais
                                 <img src="Imagens/24x24/OpenWhite24x24.png" />
                            </asp:HyperLink>
                        </p>
                    </article>

                    <article style="width: 300px; height: 230px;">
                        <header class="headerBlocks" style="height: 32px; border-bottom: 1px solid;">
                            Transferência Responsabilidade Técnica
                        </header>
                        <img src="Imagens/boxArticle/userRespons.jpg" width="160" class="imgFloat" />
                        <header class="headerBlocks font_blue">
                            Por que mudar?
                        </header>
                        <p>
                            <asp:HyperLink ID="HyperLink6" runat="server" CssClass="sitebutton blue" NavigateUrl="Contabilidade/Cotacao/default.aspx">Saiba mais
                                 <img src="Imagens/24x24/OpenWhite24x24.png" />
                            </asp:HyperLink>
                        </p>
                    </article>

                    <article style="width: 300px; height: 230px;">
                        <header class="headerBlocks font_indianred" style="border-top: 1px dotted;">
                            <asp:Image ID="Image7" runat="server" Width="300" alt="Consultoria" Height="120" ImageUrl="~/Imagens/boxArticle/userCelular.png" />

                        </header>

                        <b style="color: #ed1c24;">•	Vencimentos de Impostos e Contribuições</b><br />
                        <p>
                            Receba as informações, via SMS, dos vencimentos de seus tributos, contribuições e obrigações.
                            <br />
                            Acesse a Assecontweb e cadastre o numero do seu telefone celular.
                        </p>
                    </article>
                </td>
                <td valign="top" style="width: 200px; padding-left: 5px;">
                    <article class="MiniArticleBox" style="position: relative;">
                        <header>
                            <img alt="Boleto2Via" src="Imagens/boxArticle/2ViaBoleto.png" />
                        </header>
                        <a href="javaScript: void(0)" onclick="Open('Boleto');" id="ButtonBoleto" style="width: 180px; height: 20px;" class="siteButtonBoleto red">Clique aqui para imprimir
                        </a>
                        <div id="OpenBoxBoleto" class="OpenBox">
                            <div id="OpenFormBoleto" class="OpenForm">
                                <div class="seta-cima" style="margin-left: 120px;">
                                </div>
                                <asp:UpdatePanel ID="UpdateBoleto" runat="server">
                                    <ContentTemplate>
                                        <table id="OpenTableBoleto" class="OpenTable" style="width: 100%;">
                                            <tr>
                                                <td colspan="2">Digite CNPJ/CPF:
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtBoleto" runat="server" MaxLength="18" ValidationGroup="boleto"></asp:TextBox>
                                                    <asp:RequiredFieldValidator Class="sitevalidator font_red" ID="RFVBoleto" runat="server" ErrorMessage="Obrigatório" ControlToValidate="txtBoleto" ValidationGroup="boleto"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lkBoleto" CssClass="sitebutton" OnClick="lkBoleto_Click" runat="server" ValidationGroup="boleto"><img src="Imagens/24x24/Open24x24.png" /></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CustomValidator ID="CVBOLETO" Class="font_red" runat="server" ErrorMessage="CNPJ/CPF não consta no sistema." OnServerValidate="CVBOLETO_ServerValidate" ValidationGroup="boleto"></asp:CustomValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </article>

                    <article class="MiniArticleBox" style="margin-top: 10px;">
                        <header class="headerBlocks">
                            <img src="Imagens/boxArticle/Boxholerite.png" />
                        </header>
                        <a href="javaScript: void(0)" onclick="Open('Holerite');" id="ButtonHolerite" style="width: 180px; height: 20px;" class="siteButtonBoleto blue">Clique aqui para acessar !
                        </a>
                        <div id="OpenBoxHolerite" class="OpenBox">
                            <div id="OpenFormHolerite" class="OpenForm">
                                <div class="seta-cima" style="margin-left: 121px;">
                                </div>
                                <asp:UpdatePanel ID="UpdateHolerite" runat="server">
                                    <ContentTemplate>
                                        <table id="OpenTableHolerite" class="OpenTable" style="width: 100%;">
                                            <tr>
                                                <td colspan="2">Digite o CPF (Somente Números) :
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtHolerite" runat="server" MaxLength="11" ValidationGroup="holerite"></asp:TextBox>
                                                    <asp:RequiredFieldValidator Class="sitevalidator font_red" ID="RFieldsHolerite" runat="server" ErrorMessage="Obrigatório" ControlToValidate="txtHolerite" ValidationGroup="holerite"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lkHolerite" CssClass="sitebutton" OnClick="lkHolerite_Click" runat="server" ValidationGroup="holerite">
                                                                        <img src="Imagens/24x24/Open24x24.png" /></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CustomValidator ID="CV_Holerite" CssClass="font_red" runat="server" ErrorMessage="CPF INVALIDO" OnServerValidate="CV_Holerite_ServerValidate" ValidationGroup="holerite"></asp:CustomValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </article>

                    <article class="MiniArticleBox" style="margin-top: 10px; border-top: 1px dashed #ccc; border-bottom: 1px dashed #ccc;">
                        <header class="headerBlocks">
                            Trabalhe Conosco
                        </header>
                        <table>
                            <tr>
                                <td class="texto"><a target="_blank" href="Curriculum/">Envie seu curriculo</a>
                                </td>
                                <td>
                                    <asp:Image runat="server" ID="imgTrabalheConosco" CssClass="imgHover" alt="Trabalhe Conosco" ImageUrl="~/Imagens/boxArticle/articleTrabalheConosco.png" Width="85" />
                                </td>
                            </tr>
                        </table>
                    </article>

                    <article class="MiniArticleBox divisao">
                        <header class="headerBlocks">
                            Home Office
                        </header>
                        <table>
                            <tr>
                                <td class="texto"><a target="_blank" href="Grupo/HomeOffice.aspx">Trabalhando em casa</a>
                                </td>
                                <td>
                                    <asp:Image runat="server" ID="Image4" CssClass="imgHover" alt="Home Office" ImageUrl="~/Imagens/boxArticle/xicaraCafe.png" />
                                </td>
                            </tr>
                        </table>
                    </article>

                    <article style="margin-top: 5px;">
                        <div id="cont_52fd0d683f355c751dcb3d032806f060">
                            <span id="h_52fd0d683f355c751dcb3d032806f060">Tempo <a id="a_52fd0d683f355c751dcb3d032806f060" href="http://www.tempo.com/sao-paulo_sao-paulo-l115701.htm" target="_blank" rel="nofollow" style="color: #424242; font-family: Arial; font-size: 14px;">S&atilde;o Paulo</a></span>
                            <script type="text/javascript" src="http://www.tempo.com/wid_loader/52fd0d683f355c751dcb3d032806f060"></script>
                        </div>
                    </article>

                    <article class="MiniArticleBox" style="min-height: 120px; background-color: #FDEDED; border-bottom: 1px dashed #ccc;">
                        <header class="headerBlocks font_red" style="margin-top: -5px; border-top: 1px solid;">
                            <img src="Imagens/16x16/frasesIcon.png" class="red" style="padding: 7px 5px 5px 5px;" />
                            Frases
                        </header>
                        <p style="padding: 0px 6px 0px 6px; text-indent: 10px;">
                            <asp:Label ID="lbfrases" Font-Size="9pt" Font-Italic="true" runat="server" Text=""></asp:Label>
                        </p>
                    </article>


                    <article class="MiniArticleBox divisao">
                        <header class="headerBlocks">
                        </header>
                        <p style="font-size: 9pt;">
                            Para visualizar os arquivos na AssecontWeb é necessário instalar o Adobe Reader.
                        </p>
                        <p>
                            <a id="lkAdobeReader" href="http://get.adobe.com/br/reader/" class="sitebutton blue">Baixar Adobe Reader
                                <img src="Imagens/24x24/AdobeAcrobat24x24.png" />
                            </a>
                        </p>
                    </article>

                    <article class="MiniArticleBox">
                        <header class="headerBlocks">
                            Social
                        </header>
                        <ul id="bxSocial">
                            <li style="width: 200px; height: 90px;">
                                <a target="_blank" href="http://www.assecont.com.br/fut/">
                                    <img src="imagens/social/assecontestrela.jpg" />
                                </a>
                            </li>
                            <li style="width: 200px; height: 90px;">
                                <a target="_blank" href="http://www.futeboldasquintas.com.br/">
                                    <img src="Imagens/social/assecontFutebolQuintas.png" /></a>
                            </li>
                            <li style="width: 200px; height: 90px;">
                                <a target="_blank" href="http://www.assecont.com.br/futebol/default.asp?time=1">
                                    <img src="Imagens/social/assecontfutsal.png" />
                                </a>
                            </li>
                        </ul>
                    </article>
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
