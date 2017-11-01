<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="Asseponto.Suporte.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div style="margin: 0 auto; width: 400px;">
        <div class="loginBackground">
            <asp:Login ID="Login1" runat="server" InstructionText="Informe o usuário e a senha para logar no sistema"
                LoginButtonText="Entrar" OnLoggingIn="Login1_LoggingIn" PasswordLabelText="Senha"
                PasswordRequiredErrorMessage="Senha obrigatória" RememberMeText="" TitleText="Login"
                UserNameLabelText="Usuário" UserNameRequiredErrorMessage="Usuário Obrigatório" Width="100%"
                DisplayRememberMe="False" TextLayout="TextOnTop" EnableTheming="True">
                <InstructionTextStyle HorizontalAlign="Left" />
                <LabelStyle HorizontalAlign="Left" Wrap="True" />
                <LayoutTemplate>
                    <asp:Panel ID="Panel1" runat="server" DefaultButton="btLogin">
                        <table class="sitetable" style="width: 100%; margin: 15px 20px 30px 30px;">
                            <tr>
                                <td colspan="2">
                                    <p><span style="font-size: 20pt; text-shadow: 0 0 0; color: white;">Asseponto Controle</span></p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lbUserName" runat="server" ForeColor="White" AssociatedControlID="UserName">Usuário</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:TextBox ID="UserName" notnull="true" runat="server" Font-Size="12pt" Style="background: rgb(250, 255, 189)" BorderWidth="0"
                                        ViewStateMode="Disabled" Width="300px" onkeypress="return event.keyCode!=13"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" SetFocusOnError="true"
                                        ErrorMessage="Obrigatório" CssClass="sitevalidator" ToolTip="Obrigatório" ValidationGroup="Login1"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lbSenha" runat="server" ForeColor="White" AssociatedControlID="Password">Senha</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:TextBox ID="Password" notnull="true" runat="server" TextMode="Password" Style="background: rgb(250, 255, 189)" BorderWidth="0"
                                        Font-Size="12pt" Width="300px" onkeypress="return event.keyCode!=13"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" SetFocusOnError="true"
                                        CssClass="sitevalidator" ErrorMessage="Obrigatório" ValidationGroup="Login1"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="color: rgb(250, 255, 189);">
                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-top: 10px;">
                                    <asp:LinkButton ID="btLogin" runat="server" BackColor="#0062A0" CssClass="sitebutton" CommandName="Login" ValidationGroup="Login1">
                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />Entrar
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </LayoutTemplate>
                <LoginButtonStyle CssClass="loginbutton" />
                <TitleTextStyle CssClass="logintitulo" HorizontalAlign="Left" />
            </asp:Login>
        </div>
    </div>
</asp:Content>
