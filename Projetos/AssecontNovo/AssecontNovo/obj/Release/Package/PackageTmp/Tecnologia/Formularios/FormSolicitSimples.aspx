<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="FormSolicitSimples.aspx.cs" Inherits="AssecontNovo.Teste.Formularios.FormSolicitSimples" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <asp:FormView ID="FormViewFormulario" runat="server" DefaultMode="Insert" DataSourceID="SqlDataFormulario" OnDataBound="FormView1_DataBound">
        <InsertItemTemplate>
            <table class="formviewtable">
                <tr>
                    <td colspan="4">
                        <asp:Label ID="lbFormulario" runat="server" CssClass="formviewsubtitle">Solicitação</asp:Label>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">Razão Social<br />
                        <asp:TextBox ID="txtRazaoS" runat="server" Text=""
                            Width="400px" MaxLength="100" notnull="true" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">CNPJ<br />
                        <asp:TextBox ID="txtCnpj" runat="server" Text="" Width="200px" MaxLength="20" />
                    </td>
                </tr>

                <tr>
                    <td>Contato<br />
                        <asp:TextBox ID="txtContato1" runat="server" Text=""
                            Width="170px" MaxLength="100" notnull="true" />
                    </td>
                    <td>Telefone<br />
                        <asp:TextBox ID="txtTelefone1" runat="server" Text=""
                            Width="180px" MaxLength="50" notnull="true" />
                    </td>
                    <td>E-mail<br />
                        <asp:TextBox ID="txtEmail1" runat="server" Text=""
                            Width="250px" MaxLength="100" notnull="true" />
                    </td>
                    <td style="text-align: right">
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" CssClass="sitevalidator2"
                            ControlToValidate="txtEmail1" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 30px" colspan="4">
                        <asp:LinkButton ID="btEnviar" runat="server" CssClass="sitebutton grayDark" OnClick="btEnviar_Click">Enviar</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDataFormulario" runat="server"></asp:SqlDataSource>
</asp:Content>
