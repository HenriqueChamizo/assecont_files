<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Holerite.Master" AutoEventWireup="true" CodeBehind="Login1.aspx.cs" Inherits="AssecontNovo.HoleriteFunc.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Skins/Window.flv.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <table>
        <tr>
            <td valign="top" class="text">
                <p><span style="font-size: 16pt; text-shadow: 0 0 0;">Bem vindo !</span></p>
                <p>
                    Consulte aqui informações sobre sua vida funcional. Este serviço permite acesso aos demonstrativos de Salários, adiantamentos, 13º salários e participações de resultados com segurança e de uso restrito.
                </p>
                <p>
                    Para fazer o login, informe seu CPF e Registro Funcional no campo Número do Registro com 5 dígitos e sua senha no campo correspondente.
                </p>
                Em caso de dúvida com relação ao acesso, entre em contato com o RH da sua empresa.
            </td>
            <td id="boxLogin">
                <asp:Login ID="Login1" runat="server" OnLoggingIn="Login1_LoggingIn" DisplayRememberMe="False" EnableTheming="True">
                    <InstructionTextStyle HorizontalAlign="Left" />
                    <LabelStyle HorizontalAlign="Left" Wrap="True" />
                    <LayoutTemplate>
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="btEntrar">
                            <table class="sitetable">
                                <tr>
                                    <td>
                                        <p><span style="font-size: 16pt; text-shadow: 0 0 0;">Login</span></p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbCPF" runat="server" AssociatedControlID="UserName">CPF (Somente Números)</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" SetFocusOnError="true"
                                            ErrorMessage="Obrigatório" CssClass="sitevalidator" ToolTip="Obrigatório" ValidationGroup="Login1"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="UserName" runat="server" MaxLength="12" ViewStateMode="Disabled" Font-Size="12pt" Width="280px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbRegistro" runat="server" Text="Número do Registro" AssociatedControlID="txtRegistro"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldRegistro" runat="server" ControlToValidate="txtRegistro" SetFocusOnError="true"
                                            CssClass="sitevalidator" ErrorMessage="Obrigatório" ValidationGroup="Login1"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="txtRegistro" runat="server" Width="280px" TextMode="Password" MaxLength="6" Font-Size="12pt" ValidationGroup="Login1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbSenha" runat="server" AssociatedControlID="Password">Senha</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" SetFocusOnError="true"
                                            CssClass="sitevalidator" ErrorMessage="Obrigatório" ValidationGroup="Login1"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="Password" runat="server" ViewStateMode="Disabled" Font-Size="12pt" Width="280px" TextMode="Password"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="color: red;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:LinkButton ID="lkbEsqueceuSenha" runat="server" ForeColor="#0086E7" CausesValidation="false" OnClick="lkbEsqueceuSenha_Click" ValidationGroup="Login1">Esqueceu a senha?</asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="btEntrar" runat="server" CssClass="sitebutton lightBlue" CommandName="Login" ValidationGroup="Login1" ViewStateMode="Enabled">
                                            <asp:Image ID="Image3" runat="server" ImageUrl="~/Imagens/16x16/cadeado16x16.png" />&nbsp;&nbsp;Entrar
                                        </asp:LinkButton>
                                    </td>
                                    <%--    <td>
                                    <a href="http://www.assecont.com.br/manualholerite.html" Class="sitebutton bt_red">Ajuda</a>
                                </td>--%>
                                </tr>
                            </table>
                        </asp:Panel>
                    </LayoutTemplate>
                </asp:Login>
            </td>
        </tr>
    </table>

<%--    <telerik:RadWindowManager ID="RWM_PrimeiroLogin" runat="server" EnableShadow="true" ReloadOnShow="True" AutoSizeBehaviors="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindowPrimeiroLogin" runat="server" EnableEmbeddedSkins="false" Skin="flv" Title="CADASTRO"
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="520" Width="620" Behaviors="Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>--%>
</asp:Content>
