<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/HoleriteCliente.Master" CodeBehind="PrimeiroLogin.aspx.cs" Inherits="AssecontNovo.HoleriteFunc.PrimeiroLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <div style="padding-left: 14px;">
        <span style="font-size: 16pt; text-shadow: 0 0 0;">Bem-vindo(a),</span>
        <br />
        <asp:Label ID="lbNome" runat="server" Text='<%# Eval("FUNC_NOME") %>' CssClass="font_red" Font-Size="14pt"></asp:Label>
    </div>
    <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDatadboFuncionarios" DataKeyNames="FUNC_IND" DefaultMode="Edit" OnDataBound="FormView1_DataBound">
        <EditItemTemplate>
            <table class="sitetable">
                <tr>
                    <td colspan="2">Para maior segurança, a partir do primeiro login, será exigido o CPF, Número do Registro e Senha.</td>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lbSenha" runat="server" Text="Digitar uma senha de 6 a 10 caracteres."></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Senha deve conter 6 digitos." CssClass="sitevalidator" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldSenha" runat="server" ControlToValidate="txtSenha" CssClass="sitevalidator" ErrorMessage="Obrigatorio"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" MaxLength="10" Width="280px" Font-Size="12pt" Text='<%# Bind("FUNC_SENHA") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lbConfirmacaoSenha" runat="server" Text="Confirmar Senha"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtConfirmaSenha" CssClass="sitevalidator" ErrorMessage="Obrigatorio"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Senha invalida" CssClass="sitevalidator" ControlToValidate="txtConfirmaSenha" ControlToCompare="txtSenha"></asp:CompareValidator>
                        <asp:TextBox ID="txtConfirmaSenha" runat="server" Width="280px" TextMode="Password" Font-Size="12pt" MaxLength="10"></asp:TextBox><br />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lbEmail" runat="server" Text="E-mail"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:RequiredFieldValidator ID="RequiredFieldRegistro" runat="server" Display="Dynamic" ControlToValidate="SAL_EMAIL" CssClass="sitevalidator" ErrorMessage="Obrigatorio"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionEmail" Display="Dynamic" runat="server" ErrorMessage="Email Invalido" CssClass="sitevalidator" ControlToValidate="SAL_EMAIL" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="SAL_EMAIL" runat="server" Width="280px" Font-Size="12pt" Text='<%# Bind("FUNC_EMAIL") %>'></asp:TextBox><br />
                    </td>
                </tr>
                <tr>
                    <td style="width: 40px;">
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
                <tr>
                    <td colspan="2">
                        <asp:LinkButton ID="btSalvar" runat="server" Text="Salvar" CommandName="Update" CssClass="sitebutton lightBlue" OnClick="btSalvar_Click"></asp:LinkButton>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="SqlDatadboFuncionarios" runat="server" OnLoad="SqlData_Load" OnSelecting="SqlDatadboFuncionarios_Selecting"
        SelectCommand="SELECT * FROM Funcionarios WHERE FUNC_IND = @FUNC_IND"
        UpdateCommand="UPDATE Funcionarios SET FUNC_SENHA = @FUNC_SENHA, FUNC_EMAIL = @FUNC_EMAIL, FUNC_CELULAR = @FUNC_CELULAR, FUNC_DATA_CADASTRO = GETDATE(), FUNC_DDD = @FUNC_DDD WHERE FUNC_IND = @FUNC_IND">
        <SelectParameters>
            <asp:QueryStringParameter Name="FUNC_IND" Type="Int32" QueryStringField="ind" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FUNC_SENHA" Type="String" />
            <asp:Parameter Name="FUNC_DDD" Type="String" />
            <asp:Parameter Name="FUNC_EMAIL" Type="String" />
            <asp:Parameter Name="FUNC_CELULAR" Type="String" />
            <asp:Parameter Name="FUNC_DATA_CADASTRO" Type="DateTime" />
            <asp:QueryStringParameter Name="FUNC_IND" Type="Int32" QueryStringField="ind" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
