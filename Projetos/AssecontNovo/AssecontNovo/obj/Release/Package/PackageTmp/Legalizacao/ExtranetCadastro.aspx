<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="ExtranetCadastro.aspx.cs" Inherits="AssecontNovo.Legalizacao.ExtranetCadastro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="../Scripts/jquery.mask.js"></script>
    <script>
        function confirmarVoltar() {
            return (window.confirm('Tem certeza que desejar cancelar o envio ?'))
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <asp:Panel ID="PanelCadastro" runat="server">
        <table class="sitetable text">
            <tr>
                <td colspan="2">
                        <span style="font-size: 16pt; text-shadow: 0 0 0;">
                            <asp:Label ID="lbTituloPedido" runat="server" Text=""></asp:Label></span>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <p><span style="font-size: 16pt; text-shadow: 0 0 0;">Cadastro</span></p>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lbRazaoSocial" runat="server">Razão Social</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:RequiredFieldValidator ID="RqdRazaoSocial" runat="server" CssClass="sitevalidator" ControlToValidate="txtRazaoSocial" SetFocusOnError="true" ErrorMessage="Obrigatório" />
                                <asp:TextBox ID="txtRazaoSocial" runat="server" CssClass="textbox" MaxLength="200" Font-Size="12pt" Width="280px" Text='<%# Bind("LEGCLI_RAZAOSOCIAL") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="padding: 0px;"> 
                                <table id="PanelCnpj" runat="server" style="border-spacing: 0;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbCnpjCpf" runat="server">CNPJ/CPF </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:RequiredFieldValidator ID="RqdCnpjCPf" runat="server" CssClass="sitevalidator" ControlToValidate="txtCNPJ_CPF" SetFocusOnError="true" ErrorMessage="Obrigatório" />
                                            <asp:TextBox ID="txtCNPJ_CPF" runat="server" CssClass="textbox" MaxLength="14" Font-Size="12pt" Width="280px" Text='<%# Bind("LEGCLI_CNPJ_CPF") %>'></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lbContato" runat="server">Contato</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:RequiredFieldValidator ID="RqdContato" runat="server" CssClass="sitevalidator" ControlToValidate="txtContato" SetFocusOnError="true" ErrorMessage="Obrigatório" />
                                <asp:TextBox ID="txtContato" runat="server" CssClass="textbox" Width="280px" MaxLength="200" Font-Size="12pt" Text='<%# Bind("LEGCLI_CONTATO") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lbEmail" runat="server">E-mail</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:RequiredFieldValidator ID="RqdEmail" runat="server" CssClass="sitevalidator" ControlToValidate="txtEmail" SetFocusOnError="true" ErrorMessage="Obrigatório" />
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox" MaxLength="50" Font-Size="12pt" Width="280px" Text='<%# Bind("LEGCLI_EMAIL") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="Label3" runat="server">Confirmação de E-mail</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:RequiredFieldValidator ID="Rqd_confirmacaoEmail" runat="server" CssClass="sitevalidator" ControlToValidate="txtEmail" SetFocusOnError="true" ErrorMessage="Obrigatório" />
                                <asp:CompareValidator ID="CompareEmail" runat="server" CssClass="sitevalidator" ControlToValidate="txtEmail" ControlToCompare="txtEmailConfirmacao" ErrorMessage="E-mails não são iguais."></asp:CompareValidator>
                                <asp:TextBox ID="txtEmailConfirmacao" runat="server" CssClass="textbox" MaxLength="50" Font-Size="12pt" Width="280px" Text='<%# Bind("LEGCLI_EMAIL") %>'></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="padding-left: 50px;">
                    <table>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="Label1" runat="server">Telefone </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RequiredFieldValidator ID="RqdtelefoneDDD" runat="server" CssClass="sitevalidator" Style="margin-left: 40px;" ControlToValidate="txtTelefoneDDD" SetFocusOnError="true" ErrorMessage="Obrigatório" />
                                <asp:TextBox ID="txtTelefoneDDD" runat="server" CssClass="textbox" MaxLength="2" Font-Size="12pt" Width="50px" Text='<%# Bind("LEGCLI_TELEFONE_DDD") %>'></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="Rqdtelefone" runat="server" CssClass="sitevalidator" Style="margin-left: 185px;" ControlToValidate="txtTelefone" SetFocusOnError="true" ErrorMessage="Obrigatório" />
                                <asp:TextBox ID="txtTelefone" runat="server" CssClass="textbox" MaxLength="10" Font-Size="12pt" Width="200px" Text='<%# Bind("LEGCLI_TELEFONE") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="Label2" runat="server">Celular </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtCelularDDD" runat="server" CssClass="textbox" MaxLength="2" Font-Size="12pt" Width="50px" Text='<%# Bind("LEGCLI_CELULAR_DDD") %>'></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="txtCelular" runat="server" CssClass="textbox" MaxLength="10" Font-Size="12pt" Width="200px" Text='<%# Bind("LEGCLI_CELULAR") %>'></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">Observação do Pedido<br />
                                <asp:TextBox ID="txtObervacao" runat="server" CssClass="textbox" TextMode="MultiLine" Width="280" Height="90"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="lbVoltar2" runat="server" OnClick="lbVoltar_Click" CausesValidation="false"
                        CssClass="sitebutton red" ViewStateMode="Enabled" Text="Voltar" OnClientClick="return confirmarVoltar();" />
                </td>
                <td style="text-align: right">
                    <asp:LinkButton ID="btSalvar" runat="server" CommandArgument="insert" CommandName="insert"
                        CssClass="sitebutton lightBlue" ViewStateMode="Enabled" Text="Finalizar Pedido" OnClick="btSalvar_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>

    <asp:Panel ID="panelSucesso" runat="server" Visible="false">
        <table class="sectionSucessoTable">
            <tr>
                <td style="width: 100px;">
                    <asp:Image ID="ImageCheck" runat="server" CssClass="green" Width="80" ImageUrl="~/Imagens/Site/Sucess.png" />
                </td>
                <td style="color: #00ac59; padding-top: 30px;" class="titleSubs">Sucesso !
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div style="padding: 12px 0px 0px 5px; font-size: 15px;">
                        Solicitação realizada com sucesso.<br />
                        <br />
                        <span style="font-size: 16pt; text-shadow: 0 0 0;">Procolo
                                                <asp:Label ID="lbProtocolo" runat="server" Text=""></asp:Label>
                        </span>
                    </div>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
