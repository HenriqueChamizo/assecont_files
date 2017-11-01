<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="Asseponto.Revenda.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <table style="width: 100%;     border-top: 2px solid #E4E6E7;">
        <tr>
            <td style="vertical-align: top; width: 800px;" class="text">
                <p>
                    <img src="../Images/Logos/logoRevendasGold.png" width="450" />
                </p>
                <p>
                    A Revenda Gold contará com toda a estrutura e equipe técnica da Assecont. 
                    A Assecont garantirá às Revendas Gold total funcionamento do Software AssePonto desde sua 
                    implantação. Com uma equipe altamente treinada oferecemos aos nossos parceiros e usuários 
                    total garantia de funcionamento do software AssePonto, 
                   <asp:HyperLink ID="hlinkGold" runat="server" ForeColor="#0086E7" NavigateUrl="http://www.assecont.com.br/tecnologia/Revendas/rvGold.aspx" 
                       Target="_blank" Text="continuar lendo ..." />
                </p>
                <table style="width: 100%; padding-top: 15px;">
                    <tr>
                        <td colspan="2">
                            <span style="font-size: 16pt; text-shadow: 0 0 0;">Softwares</span>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;">
                            <asp:ImageButton ID="ImageButton2" BorderWidth="0" runat="server" CausesValidation="False" ImageUrl="~/Images/Revenda/logoAsseponto.png"
                                OnClick="ImageButton2_Click" Width="250px" />
                        </td>
                        <td style="text-align: left;">
                            <asp:ImageButton ID="ImageButton1" BorderWidth="0" runat="server" CausesValidation="False" ImageUrl="~/Images/Assefin/2-logo-assefin.png"
                                OnClick="ImageButton1_Click" Width="250px" />
                        </td>
                    </tr>
                    <tr>
                        <td class="text" colspan="2" style="text-align: justify; padding: 0px 0px 0px 0px">Cerca de 1.000 revendedores e 15.000 usuários em
                                todo Brasil. Estamos integrados com alguns dos melhores fabricantes de REP do país,
                                atendendo empresas de todos os portes e segmentos: Indústria, Serviços, Varejo,
                                Educacional, Saúde, Manufatura, Logística, Construção, Agroindústria, entre outros.
                        </td>
                    </tr>
                </table>
                    <%--<asp:HyperLink ID="hypLogoAssefin" runat="server" NavigateUrl="http://www.assecont.com.br/Tecnologia/assefin/">
                        <img src="../Images/Assefin/2-logo-assefin.png" style="width: 40%; margin: 15px 0px 0px 0px" />
                    </asp:HyperLink>--%>
                <p style="padding-top: 20px;"><span style="font-size: 16pt; text-shadow: 0 0 0;">Folha de Pagamento</span></p>
                <p>
                    A Assecont Tecnologia visando oferecer uma solução completa para os seus parceiros,
                                clientes e usuários, está lançando uma nova solução, AssePonto <span style="color: red;">COM FOLHA DE PAGAMENTO VIA WEB.</span>
                    <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="#0086E7" NavigateUrl="http://www.assecont.com.br/tecnologia/FolhaPagWeb.aspx" Target="_blank" Text="   Saiba Mais" />
                </p>
                <p style="padding-top: 20px;"><span style="font-size: 16pt; text-shadow: 0 0 0;">Vídeo demonstrativo - Asseponto 4 </span></p>
                <p>
                    <asp:ImageButton ID="ImageButtonVideo" Style="border: 0px;" runat="server" CausesValidation="False" ImageUrl="~/Images/Revenda/videoPromocional.png"
                        OnClick="ImageButtonVideo_Click" Width="265px" /><br />
                </p>
            </td>
            <td id="boxLogin" >
                <div class="loginBackground">
                    <asp:Login ID="LoginRevenda" runat="server" InstructionText="Informe o usuário e a senha para logar no sistema"
                        LoginButtonText="Entrar" OnLoggingIn="Login1_LoggingIn" PasswordLabelText="Senha"
                        PasswordRequiredErrorMessage="Senha obrigatória" RememberMeText="" TitleText="Login"
                        UserNameLabelText="Usuário" UserNameRequiredErrorMessage="Usuário Obrigatório" Width="100%"
                        DisplayRememberMe="False" TextLayout="TextOnTop" EnableTheming="True">
                        <InstructionTextStyle HorizontalAlign="Left" />
                        <LabelStyle HorizontalAlign="Left" Wrap="True" />
                        <LayoutTemplate>
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="btLogin">
                                <table class="sitetable" style="width: 100%; padding: 15px 20px 30px 30px;">
                                    <tr>
                                        <td colspan="2">
                                            <p><span style="font-size: 20pt; text-shadow: 0 0 0; color: white;">Acesso Revendas</span></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label ID="lbUserName" runat="server" ForeColor="White" AssociatedControlID="UserName">Usuário</asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:TextBox ID="UserName" notnull="true" runat="server" Font-Size="12pt" Style="background: rgb(250, 255, 189);" BorderWidth="0"
                                                 ViewStateMode="Disabled" Width="300px" OnTextChanged="UserName_TextChanged" onkeypress="return event.keyCode!=13"></asp:TextBox>
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
                                            <asp:TextBox ID="Password" notnull="true" runat="server" TextMode="Password" Style="background: rgb(250, 255, 189); " BorderWidth="0"
                                                Font-Size="12pt" Width="300px" onkeypress="return event.keyCode!=13"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" SetFocusOnError="true"
                                                CssClass="sitevalidator" ErrorMessage="Obrigatório" ValidationGroup="Login1"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="color: yellow;">
                                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-top: 10px;">
                                            <asp:LinkButton ID="btLogin" runat="server" BackColor="#0062A0" CssClass="sitebutton" CommandName="Login"
                                                ValidationGroup="Login1">
                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />Entrar
                                            </asp:LinkButton>
                                        </td>
                                        <td style="text-align:right; padding-top: 10px;">
                                            <asp:LinkButton ID="linkbCadastro" runat="server" BackColor="#0062A0" CssClass="sitebutton" 
                                                OnClick="linkbCadastro_Click">Registrar</asp:LinkButton>

                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </LayoutTemplate>
                        <LoginButtonStyle CssClass="loginbutton" />
                        <TitleTextStyle CssClass="logintitulo" HorizontalAlign="Left" />
                    </asp:Login>
                </div>
                <div style="background-color: rgb(255, 244, 221); font-size: 12pt; margin-top: 30px; padding: 8px; border: 2px solid rgb(228, 170, 44);">
                    Caro Revendedor,
                                            <br />
                    para mais informações entre em contato conosco.<br />
                    <br />
                    E-mail: comercial@assecont.com.br
                                                <br />
                    Skype: asseponto<br />
                    Telefone: 11 2173-8860
                </div>
            </td>
        </tr>
    </table>
    <%--<table style="width: 100%; padding-top: 40px; text-align: center;">
        <tr>
            <td colspan="2">
                <span style="font-size: 16pt; text-shadow: 0 0 0;">Softwares</span>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                <asp:ImageButton ID="ImageButton2" BorderWidth="0" runat="server" CausesValidation="False" ImageUrl="~/Images/Revenda/logoAsseponto.png"
                    OnClick="ImageButton2_Click" Width="250px" />
            </td>
            <td style="text-align: left;">
                <asp:ImageButton ID="ImageButton1" BorderWidth="0" runat="server" CausesValidation="False" ImageUrl="~/Images/Revenda/logoAssefin.png"
                    OnClick="ImageButton1_Click" Width="250px" />
            </td>
        </tr>
        <tr>
            <td class="text" colspan="2" style="text-align: center; padding-left: 80px; padding-right: 80px;">Cerca de 400 revendedores e 7000 usuários em
                    todo Brasil. Estamos integrados com alguns dos melhores fabricantes de REP do país,
                    atendendo empresas de todos os portes e segmentos: Indústria, Serviços, Varejo,
                    Educacional, Saúde, Manufatura, Logística, Construção, Agroindústria, entre outros.
            </td>
        </tr>
    </table>--%>

    <%--  <asp:SqlDataSource ID="sqlRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [CADP_REV_IND], [CADP_REV_CNPJ], [CADP_REV_RAZAOSOCIAL] FROM [AssepontoRevendasProvisorios]">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ind" Name="CADP_REV_IND" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
</asp:Content>
