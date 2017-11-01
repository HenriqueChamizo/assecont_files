<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="contatoTec.aspx.cs" Inherits="AssecontNovo.Teste.contatoTec" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <style type="text/css">
        .tableContact
        {
            padding-bottom: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section class="ContentText">
        <table style="width: 100%">
              <tr>
                <td style="font-size: 16pt; color: crimson" colspan="2">
                    Gerentes
                </td>
            </tr>
            <asp:Literal ID="LiteralGerente" runat="server"></asp:Literal>
    <%--        <tr>
                <td  colspan="2" class="tableContact"> <a class="sitebutton blue" href="https://secure.corporate.beanywhere.com/integration/integration2.php?uid=20ea03c4-63cc-11e2-b330-1231392ccdf2|2604 "> Acesso remoto agora para Suporte
                        <img src="../../Imagens/16x16/OpenWhite16x16.png" />
                    </a>
                </td>
            </tr> --%>
            <tr>
                <td style="font-size: 16pt; color: crimson" colspan="2">
                    Setor Suporte
                </td>
            </tr>
            <asp:Literal ID="LiteralSuporte" runat="server"></asp:Literal>
            <tr>
                <td  colspan="2" class="tableContact"> <a class="sitebutton blue" href="https://secure.corporate.beanywhere.com/integration/integration2.php?uid=20ea03c4-63cc-11e2-b330-1231392ccdf2|2604 "> Acesso remoto agora para Suporte
                        <img src="../../Imagens/16x16/OpenWhite16x16.png" />
                    </a>
                </td>
            </tr>
            <tr>
                <td style="font-size: 16pt; color: crimson" colspan="2"> Setor Implantação
                </td>
            </tr>
            <asp:Literal ID="LiteralImplantacao" runat="server"></asp:Literal>
           <tr>
                <td colspan="2"><a class="sitebutton blue" href="https://secure.corporate.beanywhere.com/integration/integration2.php?uid=20ea03c4-63cc-11e2-b330-1231392ccdf2|774"> Acesso remoto agora para implantação
                        <img src="../../Imagens/16x16/OpenWhite16x16.png" />
                    </a>
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
