<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="FormularioSolicitacao.aspx.cs" Inherits="AssecontNovo.Teste.Formularios.FormularioSolicitacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <table class="formviewtable">
        <tr>
            <td style="font-size: 14px; height: 50px;">
                <asp:Label ID="lblIntroducao" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbFormulario" runat="server" CssClass="formviewsubtitle">FORMULÁRIO</asp:Label>
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>Razão Social<br />
                            <asp:TextBox ID="txtRazaoSocial" runat="server" Text=""
                                Width="400px" MaxLength="100" notnull="true" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td colspan="3">
                            <b>Pessoa Jurídica</b>
                        </td>
                    </tr>
                    <tr>
                        <td>CNPJ<br />
                            <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###.###/####-##" Mask="##.###.###/####-##"
                                ID="txtCnpj" Text="" MaxLength="20">
                            </telerik:RadMaskedTextBox>
                        </td>
                        <td>Inscrição Estadual<br />
                            <asp:TextBox ID="txtIE" runat="server" Text="" MaxLength="20" />
                        </td>
                        <td>Fantasia<br />
                            <asp:TextBox ID="txtFantasia" runat="server" Text=""
                                MaxLength="100" />
                        </td>
                        <td>
                            <br />
                            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Informar Pessoa Fisica ou Juridica"
                                CssClass="sitevalidator2" OnServerValidate="CustomValidator1_ServerValidate1"></asp:CustomValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td colspan="2">
                            <b>Pessoa Física</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">CPF<br />
                            <telerik:RadMaskedTextBox runat="server" DisplayMask="###.###.###-##" Mask="###.###.###-##"
                                ID="txtCpf" Text="" MaxLength="12">
                            </telerik:RadMaskedTextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>Endereço<br />
                            <asp:TextBox ID="txtEndereco" runat="server" Text=""
                                Width="250px" MaxLength="100" notnull="true" />
                        </td>
                        <td>Número<br />
                            <asp:TextBox ID="txtEnderecoNumero" runat="server" Text=""
                                Width="100px" MaxLength="10" notnull="true" />
                        </td>
                        <td>Complemento<br />
                            <asp:TextBox ID="txtComplemento" runat="server" Text=""
                                Width="200px" MaxLength="100" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>Bairro<br />
                            <asp:TextBox ID="txtBairro" runat="server" Text="" Width="200px" MaxLength="100" notnull="true" />
                        </td>
                        <td>Cidade<br />
                            <asp:TextBox ID="txtCidade" runat="server" Text=""
                                Width="200px" MaxLength="100" notnull="true" />
                        </td>
                        <td>CEP<br />
                            <asp:TextBox ID="txtCep" runat="server" Text="" Width="80px"
                                MaxLength="10" notnull="true" />
                        </td>
                        <td>UF<br />
                            <asp:TextBox ID="txtUf" runat="server" Text="" Width="80px"
                                MaxLength="2" notnull="true" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>Contato<br />
                            <asp:TextBox ID="txtContato" runat="server" Text=""
                                Width="170px" MaxLength="100" notnull="true" />
                        </td>
                        <td>DDD<br />
                            <asp:TextBox ID="txtDDD" runat="server" Text=""
                                Width="80px" MaxLength="3" notnull="true" />
                        </td>
                        <td>Telefone<br />
                            <asp:TextBox ID="txtTelefone" runat="server" Text=""
                                Width="180px" MaxLength="50" notnull="true" />
                        </td>
                        <td>SKYPE<br />
                            <asp:TextBox ID="txtSkype" runat="server" Text="" Width="170px"
                                MaxLength="50" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>E-mail<br />
                            <asp:TextBox ID="txtEmail" runat="server" Text=""
                                Width="250px" MaxLength="100" notnull="true" /><br />
                            <div style="text-align: right">
                                <asp:RegularExpressionValidator ID="RegularExpressionEMAIL" runat="server" CssClass="sitevalidator2"
                                    ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                            </div>
                        </td>
                        <td>Quantidade de funcionários na empresa:&nbsp;&nbsp;
                            <asp:TextBox ID="txtFuncionario" runat="server" MaxLength="4" Width="60px" notnull="true"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="height: 50px">
                <br />
                <asp:LinkButton ID="btEnviar" runat="server" CssClass="sitebutton grayDark" OnClick="btEnviar_Click">Enviar Solicitação</asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
