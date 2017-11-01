<%@ Page Title="" Language="C#" MasterPageFile="~/Holerite/Default.Master" AutoEventWireup="true" CodeBehind="Dados.aspx.cs" Inherits="Assecont2.Holerite.Dados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <br />
    <asp:FormView ID="FormViewSenha" runat="server" DataSourceID="SqlDataSenha" DataKeyNames="FUNC_IND" DefaultMode="Edit" OnDataBound="FormView1_DataBound">
        <EditItemTemplate>
            <table style="width: 300px;" class="table">
                <tr>
                    <td class="tableTD" style="height: 50px;">
                        <asp:Label ID="Label1" runat="server" Text="Alterar Senha" Font-Bold="true" Font-Size="18px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tableTD">
                        <asp:Label ID="lbSenha" runat="server" Text="Digitar uma senha de 6 digitos."></asp:Label>
                        &nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldSenha" runat="server" ControlToValidate="txtSenha" ForeColor="Red" ErrorMessage="Obrigatorio" ValidationGroup="senha"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" MaxLength="6" Width="200px" Text='<%# Bind("FUNC_SENHA") %>' ValidationGroup="senha"></asp:TextBox>
                        <br />
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Senha deve conter 6 digitos." ForeColor="Red" OnServerValidate="CustomValidator1_ServerValidate" ValidationGroup="senha"></asp:CustomValidator>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="tableTD">
                        <asp:Label ID="lbConfirmacaoSenha" runat="server" Text="Confirmar Senha"></asp:Label>
                        &nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtConfirmaSenha" ForeColor="Red" ErrorMessage="Obrigatorio" ValidationGroup="senha"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="txtConfirmaSenha" runat="server" Width="200px" TextMode="Password" MaxLength="6" ValidationGroup="senha"></asp:TextBox><br />
                        &nbsp;&nbsp;<asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Senha invalida" ForeColor="red" ControlToValidate="txtConfirmaSenha" ControlToCompare="txtSenha" ValidationGroup="senha"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="tableTD">
                        <asp:LinkButton ID="btSalvar" runat="server" Text="Salvar" CommandName="Update" CssClass="sitebutton" OnClick="btSalvar_Click" ValidationGroup="senha"></asp:LinkButton>
                        <asp:LinkButton ID="btCancelar" runat="server" CausesValidation="false" Text="Cancelar" CssClass="sitebutton" OnClick="btCancelar_Click" ValidationGroup="senha"></asp:LinkButton>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
    <br />
    <asp:FormView ID="FormViewDados" runat="server" DataSourceID="SqlDataDados" DataKeyNames="FUNC_IND" DefaultMode="Edit" OnDataBound="FormView1_DataBound">
        <EditItemTemplate>
            <table style="width: 300px;" class="table">
                <tr>
                    <td class="tableTD" style="height: 50px;">
                        <asp:Label ID="Label1" runat="server" Text="Alterar Dados" Font-Bold="true" Font-Size="18px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tableTD">
                        <asp:Label ID="lbEmail" runat="server" Text="E-mail"></asp:Label>
                        &nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldRegistro" runat="server" ControlToValidate="txtEmail" ForeColor="Red" ErrorMessage="Obrigatorio" ValidationGroup="dados"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="txtEmail" runat="server" Width="250px" Text='<%# Bind("FUNC_EMAIL") %>' ValidationGroup="dados"></asp:TextBox><br />
                    </td>
                </tr>
                <tr>
                    <td class="tableTD">
                        <table>
                            <tr>
                                <td style="padding-top: 5px;">
                                    <asp:Label ID="lbDDD" runat="server" Text="DDD"></asp:Label>
                                    <br />
                                    <asp:TextBox ID="TextBox1" MaxLength="3" runat="server" Width="50px" Text='<%# Bind("FUNC_DDD") %>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lbCelular" runat="server" Text="Celular"></asp:Label><br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="#####-####" Mask="#####-####"
                                        ID="txtCelular" MaxLength="12" Text='<%# Bind("FUNC_CELULAR") %>'>
                                    </telerik:RadMaskedTextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="tableTD">
                        <asp:LinkButton ID="btGravar" runat="server" Text="Salvar" CommandName="Update" CssClass="sitebutton" ValidationGroup="dados" OnClick="btGravar_Click"></asp:LinkButton>
                        <asp:LinkButton ID="btCancela" runat="server" CausesValidation="false" Text="Cancelar" CssClass="sitebutton" OnClick="btCancelar_Click" ValidationGroup="dados"></asp:LinkButton>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
    <br />
    <asp:SqlDataSource ID="SqlDataSenha" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [FUNC_IND], [FUNC_SENHA] FROM Funcionarios WHERE ([FUNC_IND] = @FUNC_IND)"
        UpdateCommand="UPDATE Funcionarios SET [FUNC_SENHA] = @FUNC_SENHA WHERE [FUNC_IND] = @FUNC_IND">
        <SelectParameters>
            <asp:QueryStringParameter Name="FUNC_IND" Type="Int32" QueryStringField="ind" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FUNC_SENHA" Type="String" />
            <asp:QueryStringParameter Name="FUNC_IND" Type="Int32" QueryStringField="ind" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataDados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [FUNC_IND], [FUNC_EMAIL], [FUNC_DDD], [FUNC_CELULAR] FROM Funcionarios WHERE ([FUNC_IND] = @FUNC_IND)"
        UpdateCommand="UPDATE Funcionarios SET [FUNC_EMAIL] = @FUNC_EMAIL, [FUNC_DDD] = @FUNC_DDD, [FUNC_CELULAR] = @FUNC_CELULAR WHERE [FUNC_IND] = @FUNC_IND">
        <SelectParameters>
            <asp:QueryStringParameter Name="FUNC_IND" Type="Int32" QueryStringField="ind" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FUNC_EMAIL" Type="String" />
            <asp:Parameter Name="FUNC_DDD" Type="String" />
            <asp:Parameter Name="FUNC_CELULAR" Type="String" />
            <asp:QueryStringParameter Name="FUNC_IND" Type="Int32" QueryStringField="ind" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
