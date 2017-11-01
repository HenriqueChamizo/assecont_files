<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Assecont2.tecnologia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="http://www.assecont.com.br/assecont/Jquery/Banner/jquery.skitter.js" type="text/javascript"></script>
    <script src="http://www.assecont.com.br/assecont/Jquery/Slide/Slide.js"></script>

    <link href="http://www.assecont.com.br/assecont/Styles/BannerPrincipal.css" rel="stylesheet" type="text/css" media="all" />

    <script src="http://www.assecont.com.br/assecont/Jquery/Slide/jquery.bxslider.js"></script>
    <link href="http://www.assecont.com.br/assecont/Styles/bxslider.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {
            $('.box_skitter_large').skitter(
                { animation: "blind", EspacoNumero: "820px" }
                );

            $('#bxPortaria').bxSlider({
                pager: false,
                slideMargin: 5,
                auto: true,
                autoHover: true
            });

            $('#bxDepoimentos').bxSlider({
                pager: true,
                auto: false,
                autoHover: true,
                controls: false
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section id="SectionBanner">
        <div class="box_skitter box_skitter_large">
            <ul>
                <li>
                    <a href="http://www.assecont.com.br/assecont/tecnologia/AssepontoWeb.aspx" target="_blank">
                        <asp:Image ID="Banner03" runat="server" ImageUrl="~/Imagens/Banner/BannerTec/Banner1.png" alt="Banner 03" />
                    </a>
                </li>
                <li>

                    <a href="http://www.assecont.com.br/Assecont/Tecnologia/Suporte/vantagensManutencao.aspx" target="_blank">
                        <asp:Image ID="Banner02" runat="server" ImageUrl="~/Imagens/Banner/BannerTec/Banner2.png" alt="Banner 02" />
                    </a>
                </li>
                <li>
                    <a href="http://www.assecont.com.br/Assecont/Tecnologia/Asseponto/" target="_blank">
                        <asp:Image ID="Banner01" runat="server" ImageUrl="~/Imagens/Banner/BannerTec/Banner3.jpg" alt="Banner 01" />
                    </a>
                </li>
                <li>
                    <a href="http://www.assecont.com.br/assecont/tecnologia/AssecontWeb.aspx" target="_blank">
                        <asp:Image ID="Banner04" runat="server" ImageUrl="~/Imagens/Banner/BannerTec/Banner4.png" alt="Banner 04" />
                    </a>
                </li>
                <li>
                    <a href="http://www.assecont.com.br/Assecont/Tecnologia/Assefin/" target="_blank">
                        <asp:Image ID="Banner05" runat="server" ImageUrl="~/Imagens/Banner/BannerTec/Banner5.png" alt="Banner 05" />
                    </a>
                </li>
            </ul>
        </div>
    </section>
    <section class="SectionContent">
        <table>
            <tr>
                <td valign="top" style="width: 420px; padding-right: 25px;">
                    <article style="width: 420px; height: 260px;">
                        <header class="headerBlocks" style="height: 10px; width: 420px;">
                            <img src="http://www.assecont.com.br/assecont/Imagens/32x32/News32x32.png" class="img" width="32" />
                            Depoimentos de parceiros
                        </header>
                        <ul id="bxDepoimentos">
                            <asp:Literal ID="LiteralInformativos" runat="server"></asp:Literal>
                        </ul>
                    </article>
                </td>
                <td valign="top" style="width: 300px; padding-right: 25px;">

                    <article style="width: 300px; height: 100px; border-bottom: 1px dashed black; text-align: center; padding: 5px 5px 15px 5px;">
                        <img src="../Imagens/logos/logoAsseponto.png" class="img" width="200" />
                        <p style="letter-spacing: 0.5px; text-align: left;">
                            <a style="text-shadow: 0px 0px 0px #A7ABB4; color: #1A4C83;" href="Asseponto/default.aspx">
                                <b>SOFTWARE PARA APONTAMENTO DE HORAS E CONTROLE DE FREQUÊNCIA DE FUNCIONÁRIOS</b></a>
                        </p>
                    </article>

                    <article style="width: 300px; height: 100px; margin-top: 8px;">
                        <a href="http://www.assecont.com.br/assepontocontrole/revenda/login.aspx" >
                        <img src="../Imagens/boxArticle/boxRevenda.png" class="img"/>
                            </a>
                    </article>
                </td>
                <td valign="top" style="width: 220px;">
                    <header class="headerBlocks" style="padding-bottom: 10px;">
                        Canais de Atendimento
                    </header>
                    <article>
                        <a href="~/../suporte/contatoTec.aspx" target="_blank" class="opacity">
                            <asp:Image ID="imgSuporteCanais" runat="server" Width="220" ImageUrl="~/Imagens/boxArticle/supoteCanais.png" />
                        </a>
                    </article>

                    <article style="width: 200px; margin-left: 10px; margin-top: 15px;">
                        <header class="headerBlocks">
                            Informações
                        </header>
                        <ul id="bxPortaria">
                            <li style="width: 200px; height: 90px;">
                                <a target="_blank" href="http://www.assecont.com.br/assecont/Arquivos/portaria.pdf">
                                    <img src="../imagens/boxArticle/portaria1510.png" />
                                </a>
                            </li>
                            <li style="width: 200px; height: 90px;">
                                <a target="_blank" href="http://carep.mte.gov.br/sistemas/carep/login/login.asp">
                                    <img src="../Imagens/boxArticle/Carep.png" /></a>
                            </li>
                        </ul>
                    </article>
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
