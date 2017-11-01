<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="operacaoRealizadaSucesso.aspx.cs" Inherits="Assecont2.Curriculum.OperacaoRealizadaSucesso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <center>
        <table class="sectionSucessoTable">
            <tr>
                <td>
                       <asp:Image ID="Image1" runat="server" CssClass="green" Width="80" ImageUrl="../Imagens/Site/Sucess.png" />
                </td>
                <td style="color: #00ac59; padding-top: 30px;" class="titleSubs">
                    Enviado com sucesso !
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div style="padding: 12px 0px 0px 5px; font-size: 15px;">
                        Currículo enviado com sucesso para o RH da Assecont Contabilidade Ltda.<br />
                        <br />
                        Em breve entraremos em contato.
                        <br />
                    </div>
                </td>
            </tr>
        </table>
        </center>
</asp:Content>
