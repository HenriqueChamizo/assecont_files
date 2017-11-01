<%@ Page Title="" Language="C#" MasterPageFile="~/Holerite/Default.Master" AutoEventWireup="true" CodeBehind="PrimeiroLogin.aspx.cs" Inherits="Assecont2.Holerite.PrimeiroLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <br />
    <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDatadboFuncionarios" DataKeyNames="FUNC_IND" DefaultMode="Edit" OnDataBound="FormView1_DataBound">
        <EditItemTemplate>
            <table style="width: 310px;" class="table">
                <tr>
                    <td class="tableTD" style="height: 50px;">
                        <asp:Label ID="Label1" runat="server" Text="Bem-vindo(a)," Font-Bold="true" Font-Size="18px"></asp:Label>
                        <br />
                        <asp:Label ID="lbBemVindo" runat="server" Text='<%# Eval("FUNC_NOME") %>' Font-Bold="true" Font-Size="18px"></asp:Label>
                        <br />
                        <br />
                        Para maior segurança, a partir do primeiro login, será exigido o CPF, Nº Registro e Senha.
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="tableTD">
                        <b style="font-size: 16px;">Cadastro</b><br />
                        <br />
                        <asp:Label ID="lbSenha" runat="server" Text="Digitar uma senha de 6 digitos."></asp:Label>
                        &nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldSenha" runat="server" ControlToValidate="txtSenha" ForeColor="Red" ErrorMessage="Obrigatorio"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" MaxLength="6" Width="200px" Text='<%# Bind("FUNC_SENHA") %>'></asp:TextBox>
                        <br />
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Senha deve conter 6 digitos." ForeColor="Red" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="tableTD">
                        <asp:Label ID="lbConfirmacaoSenha" runat="server" Text="Confirmar Senha"></asp:Label>
                        &nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtConfirmaSenha" ForeColor="Red" ErrorMessage="Obrigatorio"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="txtConfirmaSenha" runat="server" Width="200px" TextMode="Password" MaxLength="6"></asp:TextBox><br />
                        &nbsp;&nbsp;<asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Senha invalida" ForeColor="red" ControlToValidate="txtConfirmaSenha" ControlToCompare="txtSenha"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="tableTD">
                        <asp:Label ID="lbEmail" runat="server" Text="E-mail"></asp:Label>
                        &nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldRegistro" runat="server" Display="Dynamic" ControlToValidate="SAL_EMAIL" ForeColor="Red" ErrorMessage="Obrigatorio"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionEmail" Display="Dynamic" runat="server" ErrorMessage="Email Invalido" ForeColor="Red" ControlToValidate="SAL_EMAIL" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        <br />
                        <asp:TextBox ID="SAL_EMAIL" runat="server" Width="250px" Text='<%# Bind("FUNC_EMAIL") %>'></asp:TextBox><br />
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
                        <asp:LinkButton ID="btSalvar" runat="server" Text="Salvar" CommandName="Update" CssClass="sitebutton" OnClick="btSalvar_Click"></asp:LinkButton>
                        <br />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
    <br />
    <asp:SqlDataSource ID="SqlDatadboFuncionarios" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        InsertCommand="INSERT INTO Funcionarios (FUNC_SENHA, FUNC_EMAIL, FUNC_DDD, FUNC_CELULAR, FUNC_DATA_CADASTRO) VALUES (@FUNC_SENHA, @FUNC_EMAIL, @FUNC_DDD, @FUNC_CELULAR, @FUNC_DATA_CADASTRO)"
        SelectCommand="SELECT * FROM Funcionarios WHERE FUNC_IND = @FUNC_IND"
        UpdateCommand="UPDATE Funcionarios SET FUNC_SENHA = @FUNC_SENHA, FUNC_EMAIL = @FUNC_EMAIL, FUNC_CELULAR = @FUNC_CELULAR, FUNC_DATA_CADASTRO = GETDATE(), FUNC_DDD = @FUNC_DDD WHERE FUNC_IND = @FUNC_IND">
        <InsertParameters>
            <asp:Parameter Name="FUNC_SENHA" Type="String" />
            <asp:Parameter Name="FUNC_DDD" Type="String" />
            <asp:Parameter Name="FUNC_EMAIL" Type="String" />
            <asp:Parameter Name="FUNC_CELULAR" Type="String" />
            <asp:Parameter Name="FUNC_DATA_CADASTRO" Type="DateTime" />
        </InsertParameters>
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
