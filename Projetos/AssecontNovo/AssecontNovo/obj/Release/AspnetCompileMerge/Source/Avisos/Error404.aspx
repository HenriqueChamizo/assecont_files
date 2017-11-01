<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Error404.aspx.cs" Inherits="Assecont2.Avisos.Error404" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <center>
         <table style="margin-top: 50px;">
            <tr>
                <td>
                    <img src="../Imagens/Site/Error.png" width="80" />

                </td>
                <td style=" font-size: 14pt">
                    <div class="titleSubs font_red">
                        <b>ERRO 404</b>
                    </div>
                    A página que você procura não pode ser encontrada.
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding-top: 30px; font-size: 12pt">
                    <ul>
                        <b>Possíveis Motivos:</b>
                        <li style="padding-top:8px;">O conteúdo não está mais no ar;</li>
                        <li style="padding-top:8px;">A página mudou de lugar;</li>
                        <li style="padding-top:8px;">Você digitou o endereço errado.</li>
                    </ul>                  
                    <br />
                    <div style="padding-left: 20px;"><i>Voltar a página inicial: <a href="http://www.assecont.com.br/assecont">Clique aqui</a></i></div>
                 </td>
             </tr>
        </table>
      </center>
</asp:Content>
