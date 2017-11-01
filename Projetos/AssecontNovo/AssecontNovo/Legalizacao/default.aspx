<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AssecontNovo.Legalizacao._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <table style="margin-top: 6px;">
        <tr>
            <td valign="top" class="text">
                <p><span style="font-size: 16pt; text-shadow: 0 0 0;">Bem vindo !</span></p>
                <p>
                    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                </p>
                <p>
                    bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
                </p>
                <p>
                    Em caso de dúvida com relação ao acesso, entre em contato com a legalização 2173-88??.
                </p>
                <div style="border: 8px solid #E4E6E7; width: 450px; margin-left: 10%;">
                    <p style="text-align: center;"><span style="font-size: 16pt; text-shadow: 0 0 0;">Digite o protocolo </span></p>
                    <p style="text-align: center;">
                        <asp:TextBox ID="txtProtocolo" runat="server" CssClass="center" Font-Size="14pt"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFV_Protocolo" runat="server" CssClass="sitevalidator" ErrorMessage="Obrigatório" ControlToValidate="txtProtocolo"></asp:RequiredFieldValidator>
                    </p>
                    <p style="text-align: center;">
                        <asp:LinkButton ID="lbVerificar" runat="server" CausesValidation="false" OnClick="lbVerificar_Click" CssClass="sitebutton lightBlue"> 
                             Verificar
                        </asp:LinkButton>
                    </p>
                </div>
            </td>
            <td valign="top" id="boxLogin">
                <style>
                    .botoes a, botoes
                    {
                        width: 128px;
                        height: 128px;
                        color: white;
                        background-color: #336CAB;
                        text-align: center;
                        margin: 10px;
                        float: left;
                    }

                    .botoes img
                    {
                        padding-top: 25px;
                    }

                    .botoes:hover, .botoes a:hover
                    {
                        opacity: 0.6;
                        text-decoration: none;
                    }
                </style>

                <asp:Panel ID="PanelServicos" runat="server">
                    <p><span style="padding-left: 10px; font-size: 16pt; text-shadow: 0 0 0;">Escolha um Serviço</span></p>
                    <div style="width: 300px">
                        <div class="botoes">
                            <asp:LinkButton ID="lkAbertura" runat="server" CausesValidation="false"  OnClick="lkAbertura_Click"> 
                                    <img src="../Imagens/48x48/House48x48.png" /><br />
                                    Abertura
                            </asp:LinkButton>
                        </div>
                        <div class="botoes">
                            <asp:LinkButton ID="lkAlteracao" runat="server" CausesValidation="false"  OnClick="lkAlteracao_Click"> 
                                    <img src="../Imagens/48x48/ReportEditor48x48.png" /><br />
                                    Alteração
                            </asp:LinkButton>
                        </div>
                        <div class="botoes">
                            <asp:LinkButton ID="lkEncerramento" runat="server" CausesValidation="false"  OnClick="lkEncerramento_Click"> 
                                    <img src="../Imagens/48x48/BuildingClose48x48.png" /><br />
                                    Encerramento
                            </asp:LinkButton>
                        </div>
                        <div class="botoes">
                            <asp:LinkButton ID="lkOutros" runat="server" CausesValidation="false" OnClick="lkOutros_Click"> 
                                    <img src="../Imagens/48x48/House48x48.png" /><br />
                                    Outros
                            </asp:LinkButton>
                        </div>
                    </div>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
