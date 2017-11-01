<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AssecontNovo.tecnologia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="/Jquery/Banner/jquery.skitter.js" type="text/javascript"></script>
    <script src="/Jquery/Slide/Slide.js"></script>

    <link href="/Styles/BannerPrincipal.css" rel="stylesheet" type="text/css" media="all" />

    <script src="/Jquery/Slide/jquery.bxslider.js"></script>
    <link href="/Styles/bxslider.css" rel="stylesheet" />

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
        <div><% 
                  string[] datas = new string[] { "16/12/2016", "19/12/2016", "23/12/2016", "26/12/2016", "30/12/2016" };
                  DateTime[] saidasFont = new DateTime[datas.Length];
                  for (int i = 0; i < datas.Length; i++)
                  {
                      saidasFont[i] = Convert.ToDateTime(datas[i]);
                  }
                  string dataVolta = "02/01/2017";
                  DateTime voltaFont = Convert.ToDateTime(dataVolta);
                  Response.Write(new AssecontNovo.Classes.Util().getAvisos(6/*2*/, null, null, null, 3)); %>
        </div>
        <div class="box_skitter box_skitter_large">
            <ul>
                <li>
                    <a href="http://www.assecont.com.br/tecnologia/AssepontoFolhaWeb.aspx" target="_blank">
                        <asp:Image ID="Banner03" runat="server" ImageUrl="~/Imagens/Banner/BannerTec/Banner1.png" alt="Banner 03" />
                    </a>
                </li>
                <li>
                    <a href="http://www.assecont.com.br/Tecnologia/Suporte/vantagensManutencao.aspx" target="_blank">
                        <asp:Image ID="Banner02" runat="server" ImageUrl="~/Imagens/Banner/BannerTec/Banner2.png" alt="Banner 02" />
                    </a>
                </li>
                <li>
                    <a href="http://www.assecont.com.br/Tecnologia/Asseponto/" target="_blank">
                        <asp:Image ID="Banner01" runat="server" ImageUrl="~/Imagens/Banner/BannerTec/Banner3.jpg" alt="Banner 01" />
                    </a>
                </li>
                <li>
                    <a href="http://www.assecont.com.br/tecnologia/AssecontWeb.aspx" target="_blank">
                        <asp:Image ID="Banner04" runat="server" ImageUrl="~/Imagens/Banner/BannerTec/Banner4.png" alt="Banner 04" />
                    </a>
                </li>
                <li>
                    <a href="http://www.assecont.com.br/Tecnologia/Assefin/" target="_blank">
                        <asp:Image ID="Banner05" runat="server" ImageUrl="~/Imagens/Banner/BannerTec/Banner5.png" alt="Banner 05" />
                    </a>
                </li>
            </ul>
        </div>
    </section>
    <section class="SectionContent">
        <table>
            <tr>
                <td valign="top" style="width: 400px;">
                    <article style="width: 400px; height: 300px;">
                        <header class="headerBlocks" style="height: 10px; width: 420px;">
                            <img src="http://www.assecont.com.br/Imagens/32x32/News32x32.png" class="img" width="32" />
                            Depoimentos de parceiros
                        </header>
                        <ul id="bxDepoimentos">
                            <asp:Literal ID="LiteralInformativos" runat="server"></asp:Literal>
                        </ul>
                    </article>
                </td>
                <td valign="top" style="width: 320px; padding-left: 10px; padding-right: 30px;">
                    <article style="width: 320px; height: 100px; text-align: center;">
                        <img src="../Imagens/logos/logoAsseponto.png" class="img" width="200" />
                        <p style="letter-spacing: 0.5px; text-align: left;">
                            <a style="text-shadow: 0px 0px 0px #A7ABB4; color: #1A4C83;" href="Asseponto/default.aspx">
                                <b>SOFTWARE PARA APONTAMENTO DE HORAS E CONTROLE DE FREQUÊNCIA DE FUNCIONÁRIOS</b></a>
                        </p>
                    </article>
                    <article style="width: 320px; padding-top: 46px;">
                        <a href="http://www.asseponto.com.br/assepontocontrole/revenda/login.aspx">
                            <img src="../Imagens/boxArticle/boxRevenda.png" class="img" width="320" />
                        </a>
                    </article>
                </td>
                <td valign="top" style="width: 220px;">
                    <header class="headerBlocks">
                        Canais de Atendimento
                    </header>
                    <article>
                        <a href="~/../suporte/contatoTec.aspx" target="_blank" class="opacity">
                            <asp:Image ID="imgSuporteCanais" runat="server" Width="220" ImageUrl="~/Imagens/boxArticle/supoteCanais.png" />
                        </a>
                    </article>

                    <article style="width: 200px; margin-right: 20px; margin-top: 40px;">
                        <header class="headerBlocks">
                            Informações
                        </header>
                        <ul id="bxPortaria">
                            <li style="width: 200px; height: 90px;">
                                <a target="_blank" href="http://www.assecont.com.br/Arquivos/portaria.pdf">
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
