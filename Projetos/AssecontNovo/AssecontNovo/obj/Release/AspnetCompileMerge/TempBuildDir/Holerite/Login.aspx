<%@ Page Title="" Language="C#" MasterPageFile="~/Holerite/Default.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Assecont2.Holerite.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        //<![CDATA[
        function confirmCallBackFn(arg) {
            radalert("<strong>radconfirm</strong> returned the following result: <h3 style='color: #ff0000;'>" + arg + "</h3>", 350, 240, "Result");
        }

        function promptCallBackFn(arg) {
            radalert("After 7.5 million years, <strong>Deep Thought</strong> answers:<h3 style='color: #ff0000;'>" + arg + "</h3>", 350, 240, "Deep Thought");
        }

        function OnClientShow() {
            $get("firstName").focus();
        }

        function closeWin() {
            $find('<%= RadWindowContentTemplate.ClientID%>').close();
        }
        //]]>
    </script>
    <style type="text/css">
        html, body, form
        {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        .contentDiv
        {
            width: 230px;
            margin: 0;
            padding: 10px 30px 30px 0;
            font-family: Calibri, Arial;
            color: #4f4236;
            font-size: 13px;
        }

            .contentDiv .inputWrap
            {
                clear: both;
            }

            .contentDiv label
            {
                width: 90px;
                margin: 0 20px 0 5px;
                display: block;
                float: left;
                white-space: nowrap;
            }

            .contentDiv input
            {
                width: 100px;
                margin-bottom: 5px;
            }

            .contentDiv .submitBtn
            {
                width: 108px;
                float: right;
                margin-right: 8px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:UpdatePanel ID="UpdateLogin" runat="server">
        <ContentTemplate>



            <asp:Login ID="Login1" runat="server" OnLoggingIn="Login1_LoggingIn" DisplayRememberMe="False" EnableTheming="True" CssClass="table">
                <InstructionTextStyle HorizontalAlign="Left" Height="40px" />
                <LabelStyle HorizontalAlign="Left" Wrap="True" />
                <LayoutTemplate>
                    <asp:Panel ID="Panel1" runat="server" DefaultButton="btEntrar">
                        <table cellpadding="1" cellspacing="0" style="border-collapse: collapse; width: 280px; height: 280px;" cssclass="table">
                            <tr>
                                <td style="padding: 6px;">
                                    <asp:Label ID="lbitulo" runat="server" Text="Login" Font-Size="18px"></asp:Label>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding: 6px;">
                                    <asp:Label ID="lbCPF" runat="server" AssociatedControlID="UserName" Text="CPF (Somente Números)"></asp:Label>
                                    &nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldCPF" runat="server" ControlToValidate="UserName" ErrorMessage="Obrigatório" ForeColor="Red" ToolTip="Obrigatorio." ValidationGroup="Login1"></asp:RequiredFieldValidator>
                                    <br />
                                    <asp:TextBox ID="UserName" runat="server" MaxLength="12" Width="200px"></asp:TextBox>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 6px;">
                                    <asp:Label ID="lbRegistro" runat="server" Text="Nº do Registro" AssociatedControlID="txtRegistro"></asp:Label>
                                    &nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldRegistro" runat="server" ControlToValidate="txtRegistro" ForeColor="Red" ErrorMessage="Obrigatório" ValidationGroup="Login1"></asp:RequiredFieldValidator>
                                    <br />
                                    <asp:TextBox ID="txtRegistro" runat="server" Width="200px" TextMode="Password" MaxLength="6" ValidationGroup="Login1"></asp:TextBox>
                                </td>
                                <td style="padding: 6px;">
                                    <br />
                                    <button style="width: 28px; height: 28px; padding: 0px 0px 0px 0px; margin: 0px 0px 0px 0px;" onclick="radalert('&lt;h4>Verificar o número do registro com o departamento pessoal da sua empresa.&lt;/h4>', 370, 200,'Informarção');  return false;">
                                        <asp:Image ID="Image1" runat="server" Height="24px" Width="24px" ImageUrl="~/holerite/Imagens/Info.png" /></button>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding: 6px;">&nbsp;<asp:Label ID="lbSenha" runat="server" AssociatedControlID="Password" Text="Senha"></asp:Label>&nbsp;&nbsp;
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Obrigatório" ToolTip="Obrigatório" ForeColor="Red" ValidationGroup="Login1"></asp:RequiredFieldValidator>
                                    <br />
                                    <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="200px" MaxLength="6"></asp:TextBox>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="color: Red;">
                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 6px;">
                                    <asp:LinkButton ID="lkbEsqueceuSenha" runat="server" ForeColor="Blue" CausesValidation="False" Font-Italic="False" Font-Underline="False" OnClick="lkbEsqueceuSenha_Click" ValidationGroup="Login1">Esqueceu a senha?</asp:LinkButton>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="padding: 6px;">
                                    <asp:LinkButton ID="btEntrar" runat="server" CssClass="sitebutton" CommandName="Login" Text="Entrar" ValidationGroup="Login1"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </LayoutTemplate>
            </asp:Login>
        </ContentTemplate>
    </asp:UpdatePanel>

    <telerik:RadWindowManager ID="RadWindowManager2" runat="server" EnableShadow="true"
        EnableAriaSupport="true">
        <Windows>
            <telerik:RadWindow ID="RadWindowContentTemplate" Title="RadWindow with ContentTemplate"
                Width="300px" Height="300px" runat="server" EnableAriaSupport="true" Modal="true"
                OnClientShow="OnClientShow">
                <ContentTemplate>
                    <div class="contentDiv">
                        <div class="inputWrap">
                            <input type="submit" value="Submit" name="btnSubmit" id="btnSubmit" class="submitBtn"
                                onclick="closeWin(); return false;" />
                        </div>
                    </div>
                </ContentTemplate>
            </telerik:RadWindow>
            <telerik:RadWindow ID="RadWindow2" Title="RadWindow with Content Page" Width="300px"
                Height="300px" runat="server" Modal="true" NavigateUrl="ContentPage.aspx" ReloadOnShow="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
