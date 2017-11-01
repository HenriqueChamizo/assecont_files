<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Holerite.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AssecontNovo.HoleriteFunc._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function OpenAtualizarDados(id) {
            var oWnd1 = $find("<%= RadWindowAtualizarDados.ClientID %>");
            oWnd1.set_initialBehaviors(Telerik.Web.UI.WindowBehaviors.Pin);
            oWnd1.set_animation(Telerik.Web.UI.WindowAnimation.Fade);
            oWnd1.setUrl("AtualizarDados.aspx?ind=" + id);
            oWnd1.show();
        }

        function RefreshParentPage() {
            document.location.reload();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">

    <telerik:RadWindowManager ID="RWM" runat="server" EnableShadow="true" ReloadOnShow="True" AutoSizeBehaviors="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindowAtualizarDados" runat="server" EnableEmbeddedSkins="false" Skin="flv" Title="Atualizar Dados"
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="640" Width="720" Behaviors="Close">
            </telerik:RadWindow>

            <telerik:RadWindow ID="RadWindowAlterarSenha" runat="server" EnableEmbeddedSkins="false" Skin="flv" Title="Alterar Senha"
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="640" Width="720" Behaviors="Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <table>
        <tr>
            <td style="vertical-align: top;">
                <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataCadastro" DataKeyNames="FUNC_IND">
                    <ItemTemplate>
                        <table style="width: 1000px;">
                            <tr>
                                <td>
                                    <span style="font-size: 16pt; text-shadow: 0 0 0;">Seja bem vindo,</span>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 45px; padding-bottom: 20px;" colspan="2">
                                    <asp:Label ID="lbFuncionario" runat="server" Font-Size="16pt" Font-Bold="true" ForeColor="Orange" Text='<%# Wr.Classes.Strings.capitalizeWords(Eval("FUNC_NOME").ToString()) %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table style="margin: 10px; padding: 10px; border: 1px solid #C5C5C5; width: 350px;">
                                        <tr>
                                            <td valign="top" class="text">
                                                <p>
                                                    <span style="font-size: 16pt; text-shadow: 0 0 0; padding-right: 20px;">Meus Dados</span>
                                                    <a id="lkAtualizaEmail" runat="server" class="sitebutton blue" onclick='<%# "OpenAtualizaEmail(" + Eval("FUNC_IND") + ");" %>'>
                                                        <asp:Image ID="imgAtualiza" runat="server" ImageUrl="~/Imagens/24x24/Editor24x24.png" /></a>
                                                    <asp:HiddenField ID="HiddenUrl" runat="server" Value='<%# RadWindowAtualizarDados.NavigateUrl = "AtualizarDados.aspx?ind=" + Eval("FUNC_IND").ToString() %>' />
                                                </p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <p>
                                                    <b>E-Mail</b>
                                                    <asp:Label ID="lbEmail" runat="server" Text='<%# Eval("FUNC_EMAIL") %>'></asp:Label>
                                                </p>
                                                <p>
                                                    <b>Celular</b>
                                                    <asp:Label ID="lbCelular" runat="server" Text='<%# Eval("FUNC_CELULAR") is DBNull ? " " : Eval("FUNC_DDD") + " " + Eval("FUNC_CELULAR") %>'></asp:Label>
                                                </p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center; width: 100%">
                                                <p>
                                                    <a id="btAlterarSenha" runat="server" class="sitebutton lightBlue" onclick='<%# "OpenAlterarSenha(" + Eval("FUNC_IND") + ");" %>'>Alterar Senha
                                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagens/16x16/cadeado16x16.png" /></a>
                                                    <asp:HiddenField ID="HiddenAlterarSenha" runat="server" Value='<%# RadWindowAlterarSenha.NavigateUrl = "AlterarSenha.aspx?ind=" + Eval("FUNC_IND").ToString() %>' />
                                                </p>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td style="padding: 20px;">
                                                <asp:LinkButton ID="btnHolerite" runat="server" OnClick="btnHolerite_Click" CssClass="sitebutton lightBlue">Holerites</asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 20px;">
                                                <asp:LinkButton ID="btnInformeRendimento" runat="server" OnClick="btnInformeRendimento_Click" CssClass="sitebutton grayDark">Informes de Rendimento</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataCadastro" OnLoad="SqlData_Load" runat="server" OnSelecting="SqlDataCadastro_Selecting"
        SelectCommand="SELECT * 
                    FROM Funcionarios 
                    WHERE FUNC_IND = @CADASTRO">
        <SelectParameters>
            <asp:Parameter Type="Int32" Name="CADASTRO" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
