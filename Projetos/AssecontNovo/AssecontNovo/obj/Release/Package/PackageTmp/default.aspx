<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AssecontNovo.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script type="text/javascript">
        function OpenHoleriteOnline() {
            var oWnd1 = $find("<%= RadWindowLogin.ClientID %>");
            oWnd1.set_initialBehaviors(Telerik.Web.UI.WindowBehaviors.Pin);
            oWnd1.set_animation(Telerik.Web.UI.WindowAnimation.Fade);
            oWnd1.setUrl("HoleriteOnline/default.aspx");
            oWnd1.show();
        }
    </script>
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
                mouse: false
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

<asp:content id="Content2" contentplaceholderid="ContentPlaceWebSite" runat="server">
    <telerik:RadWindowManager ID="RWM_Login" runat="server" EnableShadow="true" ReloadOnShow="True" AutoSizeBehaviors="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindowLogin" runat="server" EnableEmbeddedSkins="false" Skin="flv" Title="Holerite Online"
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="600" Width="680" Behaviors="Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <section id="sectioBanner">
        <div> <% 
                  string[] datas = new string[] { "16/12/2016", "19/12/2016", "23/12/2016", "26/12/2016", "30/12/2016" };
                  DateTime[] saidasFont = new DateTime[datas.Length];
                  for (int i = 0; i < datas.Length; i++)
                  {
                      saidasFont[i] = Convert.ToDateTime(datas[i]);
                  }
                  string dataVolta = "02/01/2017";
                  DateTime voltaFont = Convert.ToDateTime(dataVolta);
                  //Response.Write(new AssecontNovo.Classes.Util().getAvisos(6/*1*/, saidasFont, null, voltaFont, 2)); 
                  //Response.Write(new AssecontNovo.Classes.Util().getAvisos(1));
                  Response.Write(new AssecontNovo.Classes.Util().getAvisos(6));
        %>  </div>
        <div class="carousel">
            <div class="slides">
                <div>
                    <a href="../Contabilidade" target="_blank">
                        <asp:Image ID="Banner01" runat="server" ImageUrl="Imagens/Banner/Banner1.png" alt="Banner 01" />
                    </a>
                </div>
                <div>
                    <a href="../Tecnologia" target="_blank">
                        <asp:Image ID="Banner02" runat="server" ImageUrl="Imagens/Banner/Banner2.png" alt="Banner 02" />
                    </a>
                </div>
                <div>
                    <%--<a href="http://martinsfontes.adv.br/" target="_blank">
                        <asp:Image ID="Banner03" runat="server" ImageUrl="Imagens/Banner/Banner3.png" alt="Banner 03" />
                    </a>--%>
                    <a href="../Consultoria/default.aspx" target="_blank">
                        <asp:Image ID="Image1" runat="server" ImageUrl="Imagens/Banner/Banner3-consultoria.png" alt="Banner 03" />
                    </a>
                </div>
                <div>
                    <a href="../Tecnologia" target="_blank">
                        <asp:Image ID="Banner04" runat="server" ImageUrl="Imagens/Banner/Banner2.png" alt="Banner 04" />
                    </a>
                </div>
            </div>
        </div>
    </section>

    <section class="SectionContent">
        <table>
            <tr>
                <td style="vertical-align: top; width: 400px; padding-right: 35px;">
                    <article style="width: 400px; height: 250px;">
                        <header class="headerBlocks" style="height: 32px; border-bottom: 1px solid;">
                            <img src="Imagens/32x32/home32x32.png" class="img" />
                            Conheça nossa empresa
                        </header>
                        <asp:Image ID="Image3" runat="server" alt="Fachada" ImageUrl="Imagens/Assecont/assecontFachada.png" Width="150" CssClass="imgFloat" />
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

                    <article style="width: 400px; height: 250px;">
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

                    <article style="width: 400px; height: 250px;">
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

                    <article style="width: 400px; height: 250px;">
                        <header class="headerBlocks" style="height: 10px; width: 420px;">
                            <img src="Imagens/32x32/News32x32.png" class="img" width="32" />
                            Informativo
                        </header>
                        <ul id="bxInformativo">
                            <asp:Literal ID="LiteralInformativos" runat="server"></asp:Literal>
                        </ul>
                    </article>
                </td>

                <td style="vertical-align: top; width: 300px; padding-right: 35px;">
                    <article style="width: 300px; height: 230px;">
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

                    <%--<article style="width: 300px; height: 270px;">
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
                    </article>--%>

                    <article style="width: 300px; height: 250px;">
                        <header class="headerBlocks" style="height: 32px; border-bottom: 1px solid;">
                            Transferência Responsabilidade Técnica
                        </header>
                        <img src="Imagens/boxArticle/userRespons.jpg" width="160" class="imgFloat" />
                        <header class="headerBlocks" style="padding-top: 50px;">
                            Por que mudar?
                        </header>
                        <p>
                            <asp:HyperLink ID="HyperLink6" runat="server" CssClass="sitebutton blue" NavigateUrl="Contabilidade/Cotacao/default.aspx">Saiba mais
                                 <img src="Imagens/24x24/OpenWhite24x24.png" />
                            </asp:HyperLink>
                        </p>
                    </article>

                    <article style="width: 300px; height: 250px;">
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
                <td style="vertical-align:top; width: 200px; padding-top: 30px; padding-left: 5px;">
                    <article class="MiniArticleBox" style="min-height: 120px; background-color: #F5F5F5;">
                        <header class="headerBlocks">
                            <img src="Imagens/16x16/frasesIcon.png" style="padding: 7px 5px 5px 5px; background-color: #424242;" />
                            Frases
                        </header>
                        <p style="padding: 0px 6px 0px 8px;">
                            <asp:Label ID="lbfrases" Font-Size="9pt" runat="server" Text=""></asp:Label>
                        </p>
                    </article>

                    <article class="MiniArticleBox divisao" style="position: relative;">
                        <header>
                            <img alt="Boleto2Via" src="Imagens/boxArticle/2ViaBoleto.png" />
                        </header>
                        <a href="javaScript: void(0)" onclick="Open('Boleto');" id="ButtonBoleto" style="background: #F5F3EE; Color: #ed1c24; text-shadow: 0 0 0; height: 20px;" class="siteButtonBoleto font_red">Clique aqui para imprimir
                        </a>
                        <div id="OpenBoxBoleto" class="OpenBox">
                            <div id="OpenFormBoleto" class="OpenForm">
                                <div class="seta-cima"></div>
                                <asp:UpdatePanel ID="UpdateBoleto" runat="server">
                                    <ContentTemplate>
                                        <table id="OpenTableBoleto" class="OpenTable" style="width: 100%;">
                                            <tr>
                                                <td colspan="2">Informe o <b>CNPJ</b> ou <b>CPF</b> da empresa para acessar a Central de Boletos.</td>
                                            </tr>
                                            <tr>
                                                <td style="width: 250px;">
                                                    <asp:CustomValidator ID="CVBOLETO" runat="server" Display="Dynamic" CssClass="sitevalidator" Style="margin-left: 150px !important;" ErrorMessage="CNPJ/CPF não consta no sistema." OnServerValidate="CVBOLETO_ServerValidate" ValidationGroup="boleto"></asp:CustomValidator>
                                                    <asp:RequiredFieldValidator ID="RFVBoleto" runat="server" ErrorMessage="Obrigatório" CssClass="sitevalidator" ControlToValidate="txtBoleto" ValidationGroup="boleto"></asp:RequiredFieldValidator>
                                                    <asp:TextBox ID="txtBoleto" runat="server" MaxLength="18" ValidationGroup="boleto" Width="250px" Font-Size="14pt"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lkBoleto" CssClass="sitebutton" OnClick="lkBoleto_Click" runat="server" ValidationGroup="boleto"><img src="Imagens/24x24/Open24x24.png" /></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
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



                    <article class="MiniArticleBox divisao">
                        <header class="headerBlocks">
                            <img src="Imagens/boxArticle/Boxholerite.png" />
                        </header>
                        <a <%--href="javaScript: void(0)"--%> <%--onclick="Open('Holerite');"--%> href="HoleriteFunc/Login.aspx" id="ButtonHolerite" style="width: 165px; text-align: center;" class="sitebutton blue">Clique aqui para acessar
                        </a>
                        <div id="OpenBoxHolerite" class="OpenBox">
                            <div id="OpenFormHolerite" class="OpenForm">
                                <div class="seta-cima"></div>
                                <asp:UpdatePanel ID="UpdateHolerite" runat="server">
                                    <ContentTemplate>
                                        <table id="OpenTableHolerite" class="OpenTable" style="width: 100%;">
                                            <tr>
                                                <td colspan="2">Informe o seu <b>CPF</b> para acessar o holerite eletrônico. 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 250px;">
                                                    <asp:CustomValidator ID="CV_Holerite" Style="margin-left: 150px !important;" CssClass="sitevalidator" runat="server" ErrorMessage="CPF não consta no sistema." OnServerValidate="CV_Holerite_ServerValidate" ValidationGroup="holerite"></asp:CustomValidator>
                                                    <asp:RequiredFieldValidator ID="RFieldsHolerite" CssClass="sitevalidator" runat="server" Display="Dynamic" ErrorMessage="Obrigatório" ControlToValidate="txtHolerite" ValidationGroup="holerite"></asp:RequiredFieldValidator>
                                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="###.###.###-##" Mask="###.###.###-##" ID="txtHolerite" Font-Size="14pt" MaxLength="12" Width="250px" ValidationGroup="holerite" />

                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lkHolerite" CssClass="sitebutton" OnClick="lkHolerite_Click" runat="server" ValidationGroup="holerite"> 
                                                        <img src="Imagens/24x24/Open24x24.png" /></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </article>

                    <article class="MiniArticleBox divisao">
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
                            <li style="width: 200px; height: 90px;">
                                <a target="_blank" href="Social/Paraciclismo.aspx">
                                    <img src="Imagens/social/paraciclismo-de-estrada.png" />
                                </a>
                            </li>
                        </ul>
                    </article>
                </td>
            </tr>
        </table>
    </section>
</asp:content>
