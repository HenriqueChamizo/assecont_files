<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="Cliente.aspx.cs" Inherits="Asseponto.Suporte.Clientes.Cliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <style>
        .sitevalidator
        {
            margin-top: -64px !important;
            z-index: 99989;
            margin-left: 36px!important;
        }

        .formviewtable tr
        {
            padding-bottom: 20px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Histórico de Pendências" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Manutenção" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Contrato" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Faturamento" NavigateUrl="#">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <table class="formviewtable">
                <tr>
                    <td>
                        <div class="fieldviewcaption">
                            CNPJ /CPF
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbCnpjCpf" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="fieldviewcaption">
                            Revenda
                        </div>
                        <telerik:RadComboBox ID="comboboxRevenda" runat="server" DataSourceID="sqlRevendas" DataTextField="REV_RAZAOSOCIAL" DataValueField="REV_IND"
                            Skin="flv" Width="580px" EnableEmbeddedSkins="false" EmptyMessage="Selecione a Revenda" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="fieldviewcaption">
                            Dados Básicos
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>Razão Social<br />
                                    <asp:TextBox ID="txtRazaoSocial" runat="server" Width="340px" MaxLength="70" />
                                    <asp:RequiredFieldValidator ID="RFV_RAZAOSOCIAL" runat="server" ControlToValidate="txtRazaoSocial" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>Fantasia<br />
                                    <asp:TextBox ID="txtFantasia" runat="server" Width="200px" MaxLength="50" />
                                </td>
                                <td>Inscrição Estadual<br />
                                    <telerik:RadMaskedTextBox ID="txtIE" runat="server" DisplayMask="############" Mask="############" MaxLength="12" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>CEP<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###-###" Mask="##.###-###" ID="txtCEP" Width="100px" MaxLength="8" OnTextChanged="txtCEP_TextChanged" 
                                        AutoPostBack="true" />
                                    <asp:RequiredFieldValidator ID="RFV_CEP" runat="server" ControlToValidate="txtCEP" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                </td>
                                <td class="RadMaskedTextBox">UF<br />
                                    <telerik:RadComboBox ID="comboboxUF" runat="server" Skin="flv" EnableEmbeddedSkins="false" Width="80"
                                        DataSourceID="sqlEstados" DataTextField="EST_SIGLA" DataValueField="EST_SIGLA" EmptyMessage="Selecione o Estado" />
                                    <asp:RequiredFieldValidator ID="RFV_UF" runat="server" ControlToValidate="comboboxUF" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                </td>
                                <td>Cidade<br />
                                    <asp:TextBox ID="txtCidade" runat="server" Width="200px" MaxLength="30" />
                                    <asp:RequiredFieldValidator ID="RFV_Cidade" runat="server" ControlToValidate="txtCidade" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                </td>
                                <td>Bairro<br />
                                    <asp:TextBox ID="txtBairro" runat="server" Width="180px" MaxLength="25" />
                                    <asp:RequiredFieldValidator ID="RFV_Bairro" runat="server" ControlToValidate="txtBairro" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>Endereço<br />
                                    <asp:TextBox ID="txtEndereco" runat="server" Width="300px" MaxLength="70" />
                                    <asp:RequiredFieldValidator ID="RFV_Endereco" runat="server" ControlToValidate="txtEndereco" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                </td>
                                <td>Número<br />
                                    <asp:TextBox ID="txtEnderecoNumero" runat="server" Width="50px" MaxLength="7" />
                                    <asp:RequiredFieldValidator ID="RFV_Numero" runat="server" ControlToValidate="txtEnderecoNumero" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                </td>
                                <td>Complemento<br />
                                    <asp:TextBox ID="txtEnderecoComplemento" runat="server" Width="180px" MaxLength="60" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="fieldviewcaption">
                            Comercial
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>Qtd. de Funcionarios<br />
                                    <telerik:RadMaskedTextBox ID="txtQtdFuncionario" runat="server" DisplayMask="###" Mask="###" MaxLength="3" Width="50px" />
                                    <asp:RequiredFieldValidator ID="RFV_QTD_Funcionario" runat="server" ControlToValidate="txtQtdFuncionario" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="fieldviewcaption">
                            Contatos
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>Contato 1<br />
                                    <asp:TextBox ID="txtContato" runat="server" Width="200px" MaxLength="40" />
                                    <asp:RequiredFieldValidator ID="RFV_Contato" runat="server" ControlToValidate="txtContato" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                </td>
                                <td>DDD<br />
                                    <telerik:RadMaskedTextBox ID="txtTelefone1_DDD" runat="server" DisplayMask="##" Mask="##" MaxLength="2" Width="20px" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtTelefone1_DDD" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                </td>
                                <td>Telefone<br />
                                    <asp:TextBox ID="txtTelefone1" runat="server" MaxLength="10" Width="100px" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTelefone1" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td style="width: 240px;">E-mail<br />
                                    <asp:TextBox ID="txtEmail" runat="server" Width="240px" MaxLength="50" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_Email1" runat="server" CssClass="sitevalidator2"
                                        ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                </td>
                                <td>
                                    <br />
                                    <asp:CheckBox ID="chckEmail1" runat="server" CssClass="checkbox" Text="Receber aviso por Email" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>Contato 2<br />
                                    <asp:TextBox ID="txtContato2" runat="server" Width="200px" MaxLength="40" />
                                </td>
                                <td>DDD<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##"
                                        ID="txtTelefone2_DDD" Width="20px" MaxLength="2" />
                                </td>
                                <td>Telefone<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="##########" Mask="##########"
                                        ID="txtTelefone2" Width="80px" MaxLength="10" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td style="width: 240px;" >E-mail<br />
                                    <asp:TextBox ID="txtEmail2" runat="server" Width="240px" MaxLength="50" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEmail" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" CssClass="sitevalidator2"
                                        ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                </td>
                                <td>
                                    <br />
                                    <asp:CheckBox ID="chckEmail2" runat="server" CssClass="checkbox" Text="Receber aviso por Email" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>Contato 3<br />
                                    <asp:TextBox ID="txtContato3" runat="server" Width="200px" MaxLength="40" />
                                </td>
                                <td>DDD<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##" ID="txtTelefone3_DDD" Width="20px" MaxLength="2" />
                                </td>
                                <td>Telefone<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="##########" Mask="##########" ID="txtTelefone3" Width="80px" MaxLength="10" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td style="width: 240px;" >E-mail<br />
                                    <asp:TextBox ID="txtEmail3" runat="server" Width="240px" MaxLength="50" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEmail" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" CssClass="sitevalidator2"
                                        ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                </td>
                                <td>
                                    <br />
                                    <asp:CheckBox ID="chckEmail3" runat="server" CssClass="checkbox" Text="Receber aviso por Email" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="fieldviewcaption">
                            Skype
                        </div>
                        <asp:TextBox ID="txtSkype" runat="server" Width="130px" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="fieldviewcaption">
                            Celular
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>DDD<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##"
                                        ID="txtCelularDDD" Width="50px" MaxLength="2">
                                    </telerik:RadMaskedTextBox>
                                </td>
                                <td>Celular<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########"
                                        ID="txtCelular" Width="130px" MaxLength="10" />
                                </td>
                                <td>
                                    <br />
                                    <asp:CheckBox ID="rbCelularAceita" runat="server"  CssClass="checkbox" Text="Receber aviso por SMS " />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="fieldviewcaption">
                            Financeiro
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>Contato Financeiro<br />
                                    <asp:TextBox ID="txtFinanceiroContato" runat="server" Width="240px" MaxLength="40" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>DDD<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##"
                                        ID="txtFinanceiroTelefone_DDD" Width="20px" MaxLength="2">
                                    </telerik:RadMaskedTextBox>
                                </td>
                                <td>Telefone Financeiro<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########"
                                        ID="txtFinanceiroTelefone" Width="80px" MaxLength="10" />
                                </td>
                                <td>DDD 2<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##"
                                        ID="txtFinanceiroTelefone2_DDD" Width="20px" MaxLength="2" />
                                </td>
                                <td>Telefone Financeiro 2<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########"
                                        ID="txtFinanceiroTelefone2" Width="80px" MaxLength="10" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>E-mail Financeiro<br />
                                    <asp:TextBox ID="txtFinanceiroEmail" runat="server" Width="240px" MaxLength="50" />
                                    <asp:RegularExpressionValidator ID="REV_EMAIL_FINANCEIRO1" runat="server" CssClass="sitevalidator2"
                                        ControlToValidate="txtFinanceiroEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                </td>
                                <td>E-mail Finaneceiro 2<br />
                                    <asp:TextBox ID="txtFinanceiroEmail2" runat="server" Width="240px" MaxLength="50" />
                                    <asp:RegularExpressionValidator ID="REV_EMAIL_FINANCEIRO2" runat="server" CssClass="sitevalidator2"
                                        ControlToValidate="txtFinanceiroEmail2" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                </td>
                                <td>E-mail Finaneceiro 3<br />
                                    <asp:TextBox ID="txtFinanceiroEmail3" runat="server" Width="240px" MaxLength="50" />
                                    <asp:RegularExpressionValidator ID="REV_EMAIL_FINANCEIRO3" runat="server" CssClass="sitevalidator2"
                                        ControlToValidate="txtFinanceiroEmail3" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>DDD<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##" ID="txtFinanceiroCelular_DDD" Width="50px" MaxLength="2" />
                                </td>
                                <td>Celular Financeiro<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="##########" Mask="##########" ID="txtFinanceiroCelular" Width="130px" MaxLength="10" />
                                </td>
                                <td> <br />
                                    <asp:CheckBox ID="rbListFinanceiroCelular"  CssClass="checkbox" runat="server" Text="Receber aviso por SMS " />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="fieldviewcaption">
                            REP
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td>Possui Asseponto4?<br />
                                    <asp:RadioButtonList ID="rbListAsseponto4" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Value="1">Sim</asp:ListItem>
                                        <asp:ListItem Value="0">Não</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td>Fabricante do Rep<br />
                                    <telerik:RadComboBox ID="comboboxRepFabricante" runat="server" Skin="flv" EnableEmbeddedSkins="false"
                                        DataSourceID="sqlAssepontoRepFabricantes" EmptyMessage="Selecione o REP" EnableTextSelection="False"
                                        DataTextField="FABR_NOME" DataValueField="FABR_COD" />
                                    <asp:RequiredFieldValidator ID="RVF_FABRICANTE" runat="server" ControlToValidate="comboboxRepFabricante" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>

                                </td>
                                <td>Modelo do REP<br />
                                    <asp:TextBox ID="txtModeloRep" runat="server" MaxLength="250" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="fieldviewcaption">
                            Assefin
                        </div>
                        <table class="formviewtableinner">
                            <tr>
                                <td>Possui Assefin?<br />
                                    <asp:RadioButtonList ID="rbListAssefin" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" notnull="true">
                                        <asp:ListItem Value="1">Sim</asp:ListItem>
                                        <asp:ListItem Value="0">Não</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td>Versão do Assefin<br />
                                    <telerik:RadComboBox ID="comboboxAssefin" runat="server" Skin="flv" EnableEmbeddedSkins="false"
                                        EmptyMessage="Selecione a versão" DataSourceID="SqlAssepontoAssefin" DataTextField="VER_ASSEF_NOME"
                                        EnableTextSelection="False" DataValueField="VER_ASSEF_IND" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="fieldviewcaption">
                            Observações
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtObs" runat="server" TextMode="MultiLine" Rows="10" Columns="45" />
                    </td>
                </tr>
            </table>
            <div class="sitecorpoboxbottom">
                <table>
                    <tr>
                        <td>
                            <asp:LinkButton ID="btSalvar" runat="server" CssClass="sitebutton" CommandName="Update" OnClick="btSalvar_Click">
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />Salvar
                            </asp:LinkButton>
                        </td>
                        <td style="padding-right: 100px">
                            <asp:LinkButton ID="btAssefin" runat="server" CssClass="sitebutton" BackColor="cadetblue" OnClick="btAssefin_Click">
                               Exportar para o Assefin
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </div>

            <%--         <asp:SqlDataSource ID="sqlClientes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT * FROM AssepontoClientes WHERE (CAD_IND = @CAD_IND)"
                UpdateCommand="UPDATE AssepontoClientes SET CAD_REVENDA = @CAD_REVENDA, CAD_RAZAOSOCIAL = @CAD_RAZAOSOCIAL, 
                                        CAD_FANTASIA = @CAD_FANTASIA, CAD_IE = @CAD_IE, CAD_CNPJ = @CAD_CNPJ, CAD_CPF = @CAD_CPF,
                                        CAD_EMAIL = @CAD_EMAIL, CAD_EMAIL2 = @CAD_EMAIL2,  CAD_EMAIL3 = @CAD_EMAIL3,  
                                        
                                        CAD_CONTATO = @CAD_CONTATO, CAD_CONTATO2 = @CAD_CONTATO2, CAD_CONTATO3 = @CAD_CONTATO3, 
                                        CAD_ENDERECO = @CAD_ENDERECO, CAD_ENDERECO_NUMERO = @CAD_ENDERECO_NUMERO, CAD_ENDERECO_COMPLEMENTO = @CAD_ENDERECO_COMPLEMENTO, 
                                        CAD_BAIRRO = @CAD_BAIRRO, CAD_CIDADE = @CAD_CIDADE, CAD_UF = @CAD_UF, CAD_CEP = @CAD_CEP, CAD_OBS = @CAD_OBS, CAD_SKYPE = @CAD_SKYPE, 
                                       
                                        CAD_ASSEFIN = @CAD_ASSEFIN, CAD_VERSAO_ASSEFIN = @CAD_VERSAO_ASSEFIN, CAD_ASSEPONTO4 = @CAD_ASSEPONTO4, CAD_REP_FABRICANTE = @CAD_REP_FABRICANTE, CAD_MODELOREP = @CAD_MODELOREP, 
                
                                        CAD_TELEFONE1 = @CAD_TELEFONE1, CAD_TELEFONE1_DDD = @CAD_TELEFONE1_DDD,  CAD_TELEFONE2_DDD = @CAD_TELEFONE2_DDD, CAD_TELEFONE2 = @CAD_TELEFONE2, CAD_TELEFONE3_DDD = @CAD_TELEFONE3_DDD, CAD_TELEFONE3 = @CAD_TELEFONE3,
                                        CAD_CELULAR_DDD = @CAD_CELULAR_DDD, CAD_CELULAR = @CAD_CELULAR, CAD_CELULAR_ACEITA = @CAD_CELULAR_ACEITA,

                                        CAD_FINANCEIRO_CONTATO = @CAD_FINANCEIRO_CONTATO, CAD_FINANCEIRO_TELEFONE1_DDD = @CAD_FINANCEIRO_TELEFONE1_DDD, CAD_FINANCEIRO_TELEFONE2_DDD = @CAD_FINANCEIRO_TELEFONE2_DDD, 
                                        CAD_FINANCEIRO_TELEFONE1 = @CAD_FINANCEIRO_TELEFONE1, CAD_FINANCEIRO_TELEFONE2 = @CAD_FINANCEIRO_TELEFONE2, CAD_FINANCEIRO_CELULAR_ACEITA = @CAD_FINANCEIRO_CELULAR_ACEITA, 
                                        CAD_FINANCEIRO_CELULAR = @CAD_FINANCEIRO_CELULAR, @CAD_FINANCEIRO_CELULAR_DDD = CAD_FINANCEIRO_CELULAR_DDD,

                                        CAD_FINANCEIRO_EMAIL = @CAD_FINANCEIRO_EMAIL, CAD_FINANCEIRO_EMAIL2 = @CAD_FINANCEIRO_EMAIL2, CAD_FINANCEIRO_EMAIL3 = @CAD_FINANCEIRO_EMAIL3
                                        WHERE CAD_IND = @CAD_IND"
                OnUpdated="sqlClientes_Updated">
                <DeleteParameters>
                    <asp:QueryStringParameter Name="CAD_IND" QueryStringField="ind" Type="Int32" />
                </DeleteParameters>

                <SelectParameters>
                    <asp:QueryStringParameter Name="CAD_IND" QueryStringField="ind" Type="Int32" />
                </SelectParameters>

                <UpdateParameters>
                    <asp:Parameter Name="CAD_REVENDA" Type="Int32" />
                    <asp:Parameter Name="CAD_RAZAOSOCIAL" Type="String" />
                    <asp:Parameter Name="CAD_FANTASIA" Type="String" />
                    <asp:Parameter Name="CAD_IE" Type="String" />

                    <asp:Parameter Name="CAD_CONTATO" Type="String" />
                    <asp:Parameter Name="CAD_CONTATO2" Type="String" />
                    <asp:Parameter Name="CAD_CONTATO3" Type="String" />

                    <asp:Parameter Name="CAD_TELEFONE1" Type="String" />
                    <asp:Parameter Name="CAD_TELEFONE2" Type="String" />
                    <asp:Parameter Name="CAD_TELEFONE3" Type="String" />

                    <asp:Parameter Name="CAD_TELEFONE1_DDD" Type="String" />
                    <asp:Parameter Name="CAD_TELEFONE2_DDD" Type="String" />
                    <asp:Parameter Name="CAD_TELEFONE3_DDD" Type="String" />

                    <asp:Parameter Name="CAD_EMAIL" Type="String" />
                    <asp:Parameter Name="CAD_EMAIL2" Type="String" />
                    <asp:Parameter Name="CAD_EMAIL3" Type="String" />

                    <asp:Parameter Name="CAD_SKYPE" Type="String" />
                    <asp:Parameter Name="CAD_CELULAR" Type="String" />
                    <asp:Parameter Name="CAD_CELULAR_DDD" Type="String" />
                    <asp:Parameter Name="CAD_CELULAR_ACEITA" Type="Boolean" />

                    <asp:Parameter Name="CAD_FINANCEIRO_CONTATO" Type="String" />
                    <asp:Parameter Name="CAD_FINANCEIRO_TELEFONE1_DDD" Type="String" />
                    <asp:Parameter Name="CAD_FINANCEIRO_TELEFONE1" Type="String" />
                    <asp:Parameter Name="CAD_FINANCEIRO_TELEFONE2_DDD" Type="String" />
                    <asp:Parameter Name="CAD_FINANCEIRO_TELEFONE2" Type="String" />

                    <asp:Parameter Name="CAD_FINANCEIRO_EMAIL" Type="String" />
                    <asp:Parameter Name="CAD_FINANCEIRO_EMAIL2" Type="String" />
                    <asp:Parameter Name="CAD_FINANCEIRO_EMAIL3" Type="String" />

                    <asp:Parameter Name="CAD_FINANCEIRO_CELULAR_DDD" Type="String" />
                    <asp:Parameter Name="CAD_FINANCEIRO_CELULAR" Type="String" />
                    <asp:Parameter Name="CAD_FINANCEIRO_CELULAR_ACEITA" Type="Boolean" />

                    <asp:Parameter Name="CAD_ENDERECO" Type="String" />
                    <asp:Parameter Name="CAD_ENDERECO_NUMERO" Type="String" />
                    <asp:Parameter Name="CAD_ENDERECO_COMPLEMENTO" Type="String" />
                    <asp:Parameter Name="CAD_BAIRRO" Type="String" />
                    <asp:Parameter Name="CAD_CIDADE" Type="String" />
                    <asp:Parameter Name="CAD_UF" Type="String" />
                    <asp:Parameter Name="CAD_CEP" Type="String" />
                    <asp:Parameter Name="CAD_REP_FABRICANTE" Type="Byte" />
                    <asp:Parameter Name="CAD_MODELOREP" Type="String" />
                    <asp:Parameter Name="CAD_OBS" Type="String" />
                    <asp:Parameter Name="CAD_VERSAO_ASSEFIN" Type="Int32" />
                    <asp:Parameter Name="CAD_ASSEFIN" Type="Boolean" />
                    <asp:Parameter Name="CAD_CNPJ" Type="String" />
                    <asp:Parameter Name="CAD_CPF" Type="String" />
                    <asp:Parameter Name="CAD_ASSEPONTO4" Type="Boolean" />
                    <asp:QueryStringParameter Name="CAD_IND" QueryStringField="ind" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>--%>

            <asp:SqlDataSource ID="sqlEstados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT [EST_SIGLA], [EST_NOME] FROM [Estados]"></asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlAssepontoRepFabricantes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT [FABR_NOME], [FABR_COD], [FABR_ATIVO] FROM [AssepontoRepFabricantes] WHERE ([FABR_ATIVO] = 1) ORDER BY [FABR_NOME]"></asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlAssepontoAssefin" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT * FROM [AssepontoAssefinVersoes] WHERE ([VER_ASSEF_ATIVO] = 1)"></asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT [REV_IND], [REV_RAZAOSOCIAL] FROM [AssepontoRevendas] ORDER BY [REV_RAZAOSOCIAL]"></asp:SqlDataSource>

        </div>
    </div>
</asp:Content>
