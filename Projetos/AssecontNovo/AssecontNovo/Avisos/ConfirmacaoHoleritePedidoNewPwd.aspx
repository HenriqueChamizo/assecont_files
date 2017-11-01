<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/HoleriteCliente.Master" CodeBehind="ConfirmacaoHoleritePedidoNewPwd.aspx.cs" Inherits="AssecontNovo.Avisos.ConfirmacaoHoleritePedidoNewPwd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <center>
    <table class="sectionSucessoTable">
        <tr>
            <td>
                <asp:Image ID="ImageCheck" runat="server" CssClass="green" Width="80" ImageUrl="../Imagens/Site/Sucess.png" />
            </td>
            <td style="color: #00ac59; padding-top: 30px;" class="titleSubs">Pedido enviado com sucesso !
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div style="padding: 12px 0px 0px 5px; text-align: center; font-size: 12pt;">
                    Dentro de alguns minutos receberá a nova senha no seu e-mail.
                    <br />
                    <br />
                    <asp:Label ID="lbEmail" runat="server" ForeColor="#0086E7" Text=""></asp:Label>
                    <br />
                    <br />
                    <br />
                    Atenciosamente,
                    <br />
                    Assecont Contabilidade LTDA
                    <br />
                    <br />
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="http://www.assecont.com.br/"
                        CssClass="sitebutton" BackColor="#0086E7">Ir para páginal principal</asp:HyperLink><br />
                    <br />
                </div>
            </td>
        </tr>
    </table>
    </center>
</asp:Content>

