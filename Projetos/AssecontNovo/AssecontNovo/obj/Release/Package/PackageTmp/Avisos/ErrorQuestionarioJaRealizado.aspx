<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="ErrorQuestionarioJaRealizado.aspx.cs" Inherits="AssecontNovo.Avisos.ErrorQuestionarioJaRealizado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <center>
    <table style="margin-top: 50px;">
        <tr>
            <td>
                <img src="../Imagens/Email/aviso/Aviso.png" width="80" />
            </td>
            <td style=" font-size: 14pt">
                <div class="titleSubs font_red">
                    <b>Ops !</b>
                </div>
                Você já realizou o questionário.
            </td>
        </tr>
        <tr>
            <td colspan="2" style="padding-top: 30px; font-size: 12pt">Agradecemos a preferencia !
                <br />
                <br />
                Se preferir voltar a página inicial: <a href="http://www.assecont.com.br/assecont">Clique aqui</a>
            </td>
        </tr>
    </table>
    </center>
</asp:Content>
