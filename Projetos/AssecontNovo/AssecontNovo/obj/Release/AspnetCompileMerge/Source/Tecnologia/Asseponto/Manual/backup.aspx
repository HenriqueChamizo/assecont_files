<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="backup.aspx.cs" Inherits="Assecont2.Tecnologia.Asseponto.Manual.backup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <flv:MenuTopManulAsseponto runat="server" id="MenuTopManulAsseponto" />
    <table>
        <tr>
            <td class="titleSubs font_red" colspan="2">Backup
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p>
                    Você pode realizar o backup dos dados do asseponto a qualquer momento.
                <br />
                    Defina se o SQL esta instalado nesta maquina ou em outro local.
                <br />
                    Abaixo selecione a pasta que deseja salvar o arquivo, e clique em realizar backup.
                </p>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p>
                    <b class="font_red">Obs: Jamais clique na opção restaurar backup sem antes consultar o suporte asseponto.</b>
                </p>
            </td>
        </tr>
        <tr>
            <td valign="top" style="padding-right: 25px; border-right: 1px solid gray;">
                <img src="../../../Imagens/Tecnologia/Asseponto4/Backup2.png" /></td>
            <td valign="top" style="padding-left: 25px;">
                <img src="../../../Imagens/Tecnologia/Asseponto4/Backup1.png" /></td>
        </tr>
    </table>
</asp:Content>
