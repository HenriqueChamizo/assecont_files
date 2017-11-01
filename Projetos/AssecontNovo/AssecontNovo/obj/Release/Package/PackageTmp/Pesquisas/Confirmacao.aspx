<%@ Page Title="" Language="C#" MasterPageFile="~/Pesquisas/PesquisasModel.Master" AutoEventWireup="true" CodeBehind="Confirmacao.aspx.cs" Inherits="AssecontNovo.Pesquisas.Confirmacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section style="width: 790px; margin: 0 auto;">
        <table style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="titleSubs" style="padding-top: 10px; padding-bottom: 8px;">Pesquisa de Satisfação
                </td>
                <td style="text-align: right;">
                    <img src="http://www.assecont.com.br/Imagens/logos/Logo.png" />
                </td>
            </tr>
        </table>
        <center>
        <table style="margin-top: 40px;">
            <tr>
                <td>
                    <asp:Image ID="Image1" runat="server" CssClass="green" Width="80" ImageUrl="../Imagens/Site/Sucess.png" />
                </td>
                <td style="font-size: 14pt">
                    <div class="titleSubs" style="color: #00ac59;">
                        <b>Sucesso !</b>
                    </div>
                    Questionário enviado com sucesso.
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding-top: 30px; text-align: center; font-size: 12pt">Assecont agradece a sua participação !!!<br />
                </td>
            </tr>
        </table>
        </center>
    </section>
</asp:Content>
