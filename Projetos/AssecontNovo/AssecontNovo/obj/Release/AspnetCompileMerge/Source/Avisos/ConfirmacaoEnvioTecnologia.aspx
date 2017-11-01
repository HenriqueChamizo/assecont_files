<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="ConfirmacaoEnvioTecnologia.aspx.cs" Inherits="Assecont2.Avisos.ConfirmacaoEnvioTecnologia" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <center>
        <table class="sectionSucessoTable">
            <tr>
                <td>
                       <asp:Image ID="ImageCheck" runat="server" CssClass="green" Width="80" ImageUrl="../Imagens/Site/Sucess.png" />
                </td>
                <td style="color:  #00ac59; padding-top: 30px;" class="titleSubs">
                    Enviado com sucesso !
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div style="padding: 12px 0px 0px 5px; font-size: 15px;">
                        Solicitação enviada com sucesso para Assecont Tecnologia Ltda.<br />
                        <br />
                        Em breve entraremos em contato.
                        <br />
                    </div>
                </td>
            </tr>
        </table>
        </center>
</asp:Content>
