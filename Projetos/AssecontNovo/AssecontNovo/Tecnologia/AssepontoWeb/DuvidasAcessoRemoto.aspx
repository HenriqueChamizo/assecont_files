<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="DuvidasAcessoRemoto.aspx.cs" Inherits="AssecontNovo.Tecnologia.AssepontoWeb.DuvidasAcessoRemoto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <div id="sitetitle">
        <table id="Table1" style="width: 100%;">
            <tbody><tr>
                <td>
                    <div id="PageTitle_PageTitleWrapper" style="padding: 0px 5px 5px 0px;">
                        <table>
                            <tbody><tr>
                                <td>
                                    <div id="PageTitle_imagewrapper">
                                         <img id="PageTitle_PageTitleImage" src="../../Imagens/24x24/requerimentos24x24.png">
                                    </div>
                                </td>
                                <td>
                                    <div id="PageTitle_PageTitleTexts">
                                    <span class="descricaoGrupo">Requisitos para instalação Asseponto4</span></div>
                                </td>
                            </tr>
                        </tbody></table>
                    </div>
                </td>
                <td align="right"></td>
            </tr>
        </tbody></table>
    </div>
    <img src="../../Imagens/BA/procedimentoBA.png" width="1010" />

    <b class="font_red">*Caso não consiga realizar o procedimento a cima, entre em contato com o suporte técnico:</b>
    <flv:WbCanaisSuporte runat="server" id="WbCanaisSuporte" />
</asp:Content>
