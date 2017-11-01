<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RevendasGoldPremium.aspx.cs"
    Inherits="Asseponto.Revenda.Arquivos.RevendasGoldPremium" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title></title>
    <link href="../../Styles/Site.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form2" runat="server">
        <header id="HeaderMain">
            <section id="SectionHeader">
                <section id="SectionLogo">
                    <a id="linkHome" runat="server">
                   <asp:Image ID="Logotipo" runat="server" ImageUrl="~/images/Logos/logoBranco.png" Width="250"
                            ImageAlign="Left" />
                    </a>
                </section>
            </section>
        </header>
        <div id="bodywrapper" style="width: 1300px;">
            <div style="margin-top: 20px; margin-left: 30px">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Revenda/REVENDAS.png" />
            </div>
        </div>
        <footer>
            <aside id="FootNote">
                <table id="FootNoteTable">
                    <tr>
                        <td valign="top" style="width: 230px; height: 40px;">
                            <asp:Image ID="logoVermelho" runat="server" ImageUrl="~/Images/Logos/logotipoVermelho.png" />
                            <br />
                            Nosso compromisso
                            <br />
                            <asp:HyperLink ID="HyperAssecontFutsal" runat="server" NavigateUrl="http://www.assecont.com.br/futebol/default.asp?time=1">Assecont Futsal</asp:HyperLink>
                            <br />
                            <asp:HyperLink ID="HyperFutsal" runat="server" NavigateUrl="http://www.assecont.com.br/fut/">Estrela de prata</asp:HyperLink>
                        </td>
                        <td valign="top" style="width: 200px; border-right: 2px solid #BC3636; height: 40px;">
                            <div style="color: #B8BABD; font-size: 12pt;">CONTABILIDADE</div>
                            Gestão Contabil
                            <br />
                            Gestão Fiscal e Tributaria
                            <br />
                            Gestão Trabalhista
                            <br />
                            Audiotria
                            <br />
                            Legalização
                        </td>
                        <td valign="top" style="width: 200px; border-right: 2px solid #BC3636; height: 40px;">
                            <div style="color: #B8BABD; font-size: 12pt;">TECNOLOGIA</div>
                            <a href="http://www.assecont.com.br/asseponto/index.asp">Asseponto4
                            </a>
                            <br />
                            <a href="http://www.assecont.com.br/asseponto/assefin.asp">Assefin</a>
                            <br />
                            AssecontWeb
                        </td>
                        <td valign="top" style="width: 200px;">
                            <div style="color: #B8BABD; font-size: 12pt;">CONSULTORIA</div>
                            Empresarial
                                       <br />
                            Tributária
                                      <br />
                            Societária
                                     <br />
                            Trabalhista
                                      <br />
                            Propriedade Intelectual
                                   <br />
                            Web Consulta PJ e PF
                        </td>
                        <td valign="top" style="width: 240px;">
                            <table>
                                <tr>
                                    <td colspan="2" style="padding-bottom: 10px;">Certificada pela
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Image ID="Iso" runat="server" ImageUrl="~/Images/Logos/iso9001.png" Width="91" />

                                    </td>
                                    <td>
                                        <asp:Image ID="pqc2013" runat="server" ImageUrl="~/Images/Logos/logo_pqec.png" Width="90" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <aside id="FootAddress">
                    <div id="FootNoteAddress">
                       Assecont Tecnologia Ltda | Rua Mário, 194 | Vila Romana | CEP 05048 - 010 | São Paulo/SP | 11 2173 - 8888
                    </div>
                </aside>
            </aside>
        </footer>
    </form>
</body>
</html>
