<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Holerite.Master" AutoEventWireup="true" CodeBehind="Dados.aspx.cs" Inherits="AssecontNovo.HoleriteFunc.Dados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <table>
        <tr>
            <td colspan="2">
                <asp:Label ID="LbNome" Font-Size="16pt" Font-Bold="true" runat="server" Text=""></asp:Label></td>
        </tr>
        <tr>
            <td style="padding-top: 25px;">
                <asp:FormView ID="FormViewSenha" runat="server" DataSourceID="SqlDataSenha" DataKeyNames="FUNC_IND" DefaultMode="Edit" OnDataBound="FormView1_DataBound">
                    <EditItemTemplate>
                        <table class="sitetable">
                            <tr>
                                <td>
                                      <p><span style="font-size: 16pt; text-shadow: 0 0 0;">Alterar Senha</span></p>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                  <asp:Label ID="lbSenha" runat="server" Text="Digitar uma senha de 6 a 10 caracteres."></asp:Label>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldSenha" runat="server" ControlToValidate="txtSenha" CssClass="sitevalidator" ErrorMessage="Obrigatorio" ValidationGroup="senha"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Senha deve conter de 6 a 10 caracteres." CssClass="sitevalidator" OnServerValidate="CustomValidator1_ServerValidate" ValidationGroup="senha"></asp:CustomValidator>
                                    <asp:TextBox ID="txtSenha" runat="server" Font-Size="12pt" TextMode="Password" MaxLength="10" Width="280px" Text='<%# Bind("FUNC_SENHA") %>' ValidationGroup="senha"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbConfirmacaoSenha" runat="server" Text="Confirmar Senha"></asp:Label>
                                    <br />
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="As senhas que você digitou não coincidem...." CssClass="sitevalidator" ControlToValidate="txtConfirmaSenha" ControlToCompare="txtSenha" ValidationGroup="senha"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtConfirmaSenha" CssClass="sitevalidator" ErrorMessage="Obrigatorio" ValidationGroup="senha"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="txtConfirmaSenha" runat="server" Font-Size="12pt" Width="280px" TextMode="Password" MaxLength="10" ValidationGroup="senha"></asp:TextBox><br />
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top:15px;">
                                    <asp:LinkButton ID="btSalvar" runat="server" Text="Salvar" CommandName="Update" CssClass="sitebutton lightBlue" OnClick="btSalvar_Click" ValidationGroup="senha"></asp:LinkButton>
                                    <asp:LinkButton ID="btCancelar" runat="server" CausesValidation="false" Text="Cancelar" CssClass="sitebutton grayDark" OnClick="btCancelar_Click" ValidationGroup="senha"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </EditItemTemplate>
                </asp:FormView>
            </td>
            <td style="padding-left: 100px; padding-top: 25px;">
                <asp:FormView ID="FormViewDados" runat="server" DataSourceID="SqlDataDados" DataKeyNames="FUNC_IND" DefaultMode="Edit" OnDataBound="FormView1_DataBound">
                    <EditItemTemplate>
                        <table class="sitetable" style="border-left: 2px solid #E4E6E7;">
                              <tr>
                                <td>
                                      <p><span style="font-size: 16pt; text-shadow: 0 0 0;">Meus Dados</span></p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbEmail" runat="server" Text="E-mail"></asp:Label>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldRegistro" runat="server" ControlToValidate="txtEmail" CssClass="sitevalidator" ErrorMessage="Obrigatorio" ValidationGroup="dados"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="txtEmail" runat="server" Width="280px" Font-Size="12pt" Text='<%# Bind("FUNC_EMAIL") %>' ValidationGroup="dados"></asp:TextBox><br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="padding: 0px">
                                                <asp:Label ID="lbDDD" runat="server" Text="DDD"></asp:Label>
                                                <br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##" Width="40"
                                                    ID="txtDDD" MaxLength="2" Text='<%# Bind("FUNC_DDD") %>' Font-Size="12pt">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lbCelular" runat="server" Text="Celular"></asp:Label><br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="#####-####" Mask="#####-####" Width="220"
                                                    ID="txtCelular" MaxLength="12" Text='<%# Bind("FUNC_CELULAR") %>' Font-Size="12pt">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top:15px;">
                                    <asp:LinkButton ID="btGravar" runat="server" Text="Salvar" CommandName="Update" CssClass="sitebutton lightBlue" ValidationGroup="dados" OnClick="btGravar_Click"></asp:LinkButton>
                                    <asp:LinkButton ID="btCancela" runat="server" CausesValidation="false" Text="Cancelar" CssClass="sitebutton grayDark" OnClick="btCancelar_Click" ValidationGroup="dados"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </EditItemTemplate>
                </asp:FormView>
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="SqlDataSenha" runat="server" OnLoad="SqlData_Load" OnSelecting="SqlDataSenha_Selecting"
        SelectCommand="SELECT FUNC_NOME, FUNC_IND, FUNC_SENHA FROM Funcionarios WHERE (FUNC_IND = @FUNC_IND)"
        UpdateCommand="UPDATE Funcionarios SET FUNC_SENHA = @FUNC_SENHA WHERE FUNC_IND = @FUNC_IND">
        <SelectParameters>
            <asp:Parameter Name="FUNC_IND" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FUNC_SENHA" Type="String" />
            <asp:Parameter Name="FUNC_IND" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataDados" runat="server" OnLoad="SqlData_Load" OnSelecting="SqlDataSenha_Selecting"
        SelectCommand="SELECT FUNC_IND, FUNC_EMAIL, FUNC_DDD, FUNC_CELULAR FROM Funcionarios WHERE (FUNC_IND = @FUNC_IND)"
        UpdateCommand="UPDATE Funcionarios SET FUNC_EMAIL = @FUNC_EMAIL, FUNC_DDD = @FUNC_DDD, FUNC_CELULAR = @FUNC_CELULAR WHERE FUNC_IND = @FUNC_IND">
        <SelectParameters>
            <asp:QueryStringParameter Name="FUNC_IND" Type="Int32" QueryStringField="ind" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FUNC_EMAIL" Type="String" />
            <asp:Parameter Name="FUNC_DDD" Type="String" />
            <asp:Parameter Name="FUNC_CELULAR" Type="String" />
            <asp:Parameter Name="FUNC_IND" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
