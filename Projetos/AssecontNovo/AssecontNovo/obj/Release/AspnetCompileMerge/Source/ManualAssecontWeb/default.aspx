<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Assecont2.AssecontWeb._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section class="ContentText">
        <table style="padding-top: 40px;">
            <tr>
                <td>
                    <table class="linkVermelho" style="width: 316px; height: 353px; padding-top: 15px; font-style: italic; font-size: 15pt; background: url('../Imagens/Tecnologia/folhaCaderno.png') no-repeat;">
                        <tr>
                            <td style="text-align: center; text-decoration: underline;"><b>AssecontWeb</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 20px;">
                                <asp:HyperLink ID="HyperDepContabil" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/Asseponto/Manual/rotinasTratamento.aspx">- Departamento Contabil</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 20px;">
                                <asp:HyperLink ID="HyperDepFiscal" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/Asseponto/Manual/cadastro.aspx">- Departamento Fiscal</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 20px; padding-bottom: 50px;">
                                <asp:HyperLink ID="HyperDepPessoal" CssClass="linkVermelho" Target="_blank" runat="server" NavigateUrl="~/Tecnologia/Asseponto/Manual/bancoHoras.aspx">- Departamento Pessoal</asp:HyperLink>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="padding-left: 25px;">
                    <asp:Image ID="imgLapisAsseInvertidov" runat="server" Height="350" ImageUrl="~/Imagens/AssecontWeb/AssecontWeb1.png" />
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
