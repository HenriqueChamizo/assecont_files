<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true"
    CodeBehind="Pedido.old.aspx.cs" Inherits="PedidoOld" %>

<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <script>
                function ElementOnOrOff(ElementOn, ElementOff) {
                    document.getElementById(ElementOn).style.display = "block";
                    document.getElementById(ElementOff).style.display = "none";
                }
            </script>
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="PED_IND" DataSourceID="sqlPedidosRevendas" OnDataBound="FormView1_DataBound">
                <EditItemTemplate>
                    <asp:Panel ID="Panel1" runat="server" EnableViewState="false">
                        <asp:HiddenField ID="hiddenRevenda" runat="server" Value='<%# Bind("PED_REV_IND") %>' />
                        <asp:HiddenField ID="HiddenIndice" runat="server" Value='<%# Bind("PED_IND") %>' />
                        <asp:HiddenField ID="HiddenStatus" runat="server" Value='<%# Bind("PED_STATUS") %>' />

                        <table class="formviewtable">
                            <tr>
                                <td>
                                    <span class="formviewsubtitle">Dados do Cliente</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Razão Social<br />
                                                <asp:TextBox ID="PED_CLI_RAZAO" requerid="true" runat="server" Text='<%# Bind("PED_CLI_RAZAO") %>' Width="400px"  MaxLength="70" notnull="true" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Pessoa<br />
                                                <label>
                                                    <input type="radio" name="PessoaFJ" onclick="ElementOnOrOff('fisica', 'juridica')"> Fisica 
                                                </label><br />
                                                <label>
                                                    <input type="radio" name="PessoaFJ" onclick="ElementOnOrOff('juridica', 'fisica')"> Juridica
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="juridica" style="display: none">
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td colspan="4">
                                                <!--<b>Jurídica</b>-->
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="RadMaskedTextBox">CNPJ<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###.###/####-##" Mask="##.###.###/####-##" ID="PED_CLI_CNPJ" Text='<%# Bind("PED_CLI_CNPJ") %>' MaxLength="20">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Fantasia<br />
                                                <asp:TextBox ID="PED_FANTASIA" runat="server" Text='<%# Bind("PED_FANTASIA") %>' MaxLength="30" />
                                            </td>
                                            <td>Inscrição Estadual<br />
                                                  <telerik:RadMaskedTextBox runat="server" DisplayMask="############" Mask="############"
                                                    ID="PED_CLI_IE" Text='<%# Bind("PED_CLI_IE") %>' MaxLength="12">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>
                                                <br />
                                                <asp:CustomValidator ID="CV_PessoaFisicaJuridica" runat="server" SetFocusOnError="true" ErrorMessage="Informar Pessoa Física ou Jurídica"
                                                    CssClass="sitevalidator2" OnServerValidate="CustomValidator1_ServerValidate1"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="fisica" style="display: none">
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td colspan="2">
                                                <!--<b>Física</b>-->
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="RadMaskedTextBox">CPF<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="###.###.###-##" Mask="###.###.###-##" ID="PED_CLI_CPF" Text='<%# Bind("PED_CLI_CPF") %>' MaxLength="12">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>
                                                <br />
                                                <asp:CustomValidator ID="CV_Cadastro_existente" runat="server" ErrorMessage="CNPJ ou CPF já existe no nosso cadastro" SetFocusOnError="true"
                                                    CssClass="sitevalidator2" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
                                            </td>
                                            <td>
                                                <br />
                                                <asp:CustomValidator ID="CV_Pedido" runat="server" ErrorMessage="Solicitação de pedido já realizado." SetFocusOnError="true"
                                                    CssClass="sitevalidator2" OnServerValidate="CV_Pedido_ServerValidate"></asp:CustomValidator>
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
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###-###" Mask="##.###-###" ID="PED_CLI_CEP" Width="100px" MaxLength="8" OnTextChanged="PED_CLI_CEP_TextChanged" 
                                                    AutoPostBack="true" Text='<%# Bind("PED_CLI_CEP") %>' />
                                                <asp:RequiredFieldValidator ID="RFV_CEP" runat="server" ControlToValidate="PED_CLI_CEP" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                            </td>
                                            <%--<td class="RadMaskedTextBox">UF<br />--%>
                                            <td>UF<br />
                                                <%--<telerik:RadComboBox ID="PED_CLI_UF" runat="server" Skin="flv" EnableEmbeddedSkins="false" Width="200"
                                                    OnDataBinding="RadComboBox1_DataBinding" EmptyMessage="Selecione o Estado" SelectedValue='<%# Bind("PED_CLI_UF") %>'
                                                    notnull="true">
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lbUF" runat="server" Font-Size="10pt" Text='<%# "(" + Eval("EST_SIGLA") + ") " + Eval("EST_NOME") %>'></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </telerik:RadComboBox>--%>
                                                <%--<asp:HiddenField ID="PED_CLI_UF" runat="server" Value='<%# Bind("PED_CLI_UF") %>' />--%>
                                                <asp:TextBox ID="PED_CLI_UF" Skin="flv" Width="50" runat="server" Text='<%# Bind("PED_CLI_UF") %>' Enabled="false"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RFV_UF" runat="server" ControlToValidate="PED_CLI_UF" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>Cidade<br />
                                                <asp:TextBox ID="PED_CLI_CIDADE" runat="server" Text='<%# Bind("PED_CLI_CIDADE") %>'
                                                    Width="200px" notnull="true"  MaxLength="30" Enabled="false" />
                                                <asp:RequiredFieldValidator ID="RFV_Cidade" runat="server" ControlToValidate="PED_CLI_CIDADE" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>Bairro<br />
                                                <asp:TextBox ID="PED_CLI_BAIRRO" runat="server" Text='<%# Bind("PED_CLI_BAIRRO") %>'
                                                    Width="200px" notnull="true"  MaxLength="25" Enabled="false" />
                                                <asp:RequiredFieldValidator ID="RFV_Bairro" runat="server" ControlToValidate="PED_CLI_BAIRRO" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
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
                                                <asp:TextBox ID="PED_CLI_ENDERECO" runat="server" Text='<%# Bind("PED_CLI_ENDERECO") %>'
                                                    Width="250px"  notnull="true"  MaxLength="70" Enabled="false" />
                                                <asp:RequiredFieldValidator ID="RFV_Endereco" runat="server" ControlToValidate="PED_CLI_ENDERECO" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>Número<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="######" Mask="######"
                                                    ID="PED_CLI_ENDERECO_NUMERO" Text='<%# Bind("PED_CLI_ENDERECO_NUMERO") %>' MaxLength="7">
                                                </telerik:RadMaskedTextBox>
                                                <asp:RequiredFieldValidator ID="RFV_Numero" runat="server" ControlToValidate="PED_CLI_ENDERECO_NUMERO" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>Complemento<br />
                                                <asp:TextBox ID="PED_CLI_ENDERECO_COMPLEMENTO" runat="server" Text='<%# Bind("PED_CLI_ENDERECO_COMPLEMENTO") %>'
                                                    Width="180px"   MaxLength="60" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <%--<tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Endereço<br />
                                                <asp:TextBox ID="PED_CLI_ENDERECO" runat="server" Text='<%# Bind("PED_CLI_ENDERECO") %>'
                                                    Width="250px"  notnull="true"  MaxLength="70" />
                                            </td>
                                            <td>Número<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="######" Mask="######"
                                                    ID="PED_CLI_ENDERECO_NUMERO" Text='<%# Bind("PED_CLI_ENDERECO_NUMERO") %>' MaxLength="7">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Complemento<br />
                                                <asp:TextBox ID="PED_CLI_ENDERECO_COMPLEMENTO" runat="server" Text='<%# Bind("PED_CLI_ENDERECO_COMPLEMENTO") %>'
                                                    Width="200px"   MaxLength="60" />
                                            </td>
                                            <td>Bairro<br />
                                                <asp:TextBox ID="PED_CLI_BAIRRO" runat="server" Text='<%# Bind("PED_CLI_BAIRRO") %>'
                                                    Width="200px" notnull="true"  MaxLength="25" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Cidade<br />
                                                <asp:TextBox ID="PED_CLI_CIDADE" runat="server" Text='<%# Bind("PED_CLI_CIDADE") %>'
                                                    Width="200px" notnull="true"  MaxLength="30" />
                                            </td>
                                            <td>CEP<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###-###" Mask="##.###-###" notnull="true"
                                                    ID="PED_CLI_CEP" Width="80px" Text='<%# Bind("PED_CLI_CEP") %>' MaxLength="8">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>UF<br />
                                                <telerik:RadComboBox ID="PED_CLI_UF" runat="server" Skin="flv" EnableEmbeddedSkins="false" Width="200"
                                                    OnDataBinding="RadComboBox1_DataBinding" EmptyMessage="Selecione o Estado" SelectedValue='<%# Bind("PED_CLI_UF") %>'
                                                    notnull="true">
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lbUF" runat="server" Font-Size="10pt" Text='<%# "(" + Eval("EST_SIGLA") + ") " + Eval("EST_NOME") %>'></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>--%>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Responsável<br />
                                                <asp:TextBox ID="PED_CLI_CONTATO" runat="server" Text='<%# Bind("PED_CLI_CONTATO") %>'
                                                    Width="170px" notnull="true"  MaxLength="40" />
                                            </td>
                                            <td>SKYPE / MSN<br />
                                                <asp:TextBox ID="PED_SKYPE" runat="server" Text='<%# Bind("PED_SKYPE") %>' Width="170px"
                                                    MaxLength="50" />
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
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##" Width="50px"
                                                    ID="PED_CLI_TELEFONE_DDD" Text='<%# Bind("PED_CLI_TELEFONE_DDD") %>' MaxLength="2">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Telefone<br />
                                                <asp:TextBox ID="PED_CLI_TELEFONE" runat="server" Text='<%# Bind("PED_CLI_TELEFONE") %>'
                                                    Width="130px" MaxLength="10" notnull="true" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>DDD 2<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##" Width="50px"
                                                    ID="PED_CLI_TELEFONE2_DDD" Text='<%# Bind("PED_CLI_TELEFONE2_DDD") %>' MaxLength="2">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Telefone 2<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########"
                                                    ID="RdmTxt_Telefone2" Width="130px" Text='<%# Bind("PED_CLI_TELEFONE2") %>' MaxLength="9">
                                                </telerik:RadMaskedTextBox>
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
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##" Width="50px"
                                                    ID="PED_CLI_CELULAR_DDD" Text='<%# Bind("PED_CLI_CELULAR_DDD") %>' MaxLength="2">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Celular<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########"
                                                    ID="PED_CLI_CELULAR" Width="130px" Text='<%# Bind("PED_CLI_CELULAR") %>' MaxLength="9">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>
                                                <div class="fieldviewcaption">Receber avisos por SMS ?</div>
                                                <asp:RadioButtonList ID="CAD_CELULAR_ACEITA" runat="server" RepeatDirection="Horizontal"
                                                    RepeatLayout="Flow" SelectedValue='<%# Bind("PED_CLI_CELULAR_ACEITA") %>' notnull="true">
                                                    <asp:ListItem Value="True">Sim</asp:ListItem>
                                                    <asp:ListItem Value="False" Selected="true">Não</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>E-mail do responsável pelo sistema<br />
                                                <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("PED_CLI_EMAIL") %>'
                                                    Width="200px" notnull="true" MaxLength="50" /><br />
                                                <div style="text-align: right">
                                                    <asp:RegularExpressionValidator ID="RegularExpressionEMAIL" runat="server" CssClass="sitevalidator2"
                                                        ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                                </div>
                                            </td>
                                            <td>Outro e-mail do responsável pelo sistema<br />
                                                <asp:TextBox ID="txtEmail2" runat="server" Text='<%# Bind("PED_EMAIL2") %>'
                                                    Width="200px" MaxLength="50" /><br />
                                                <div style="text-align: right">
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" CssClass="sitevalidator2"
                                                        ControlToValidate="txtEmail2" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <b style="color: red">Observações:</b><br />
                                                O Email é do responsável pelo sistema da empresa que consta neste cadastro.
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            </tr>
                            <tr>
                                <td>
                                    <br />
                                    <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server" DbValue='<%# Bind("PED_CLI_QTD_FUNCIONA") %>'
                                        Label="Número de Funcionários" Width="200px" MaxLength="4" Skin="Wr" EnableEmbeddedSkins="false" Display="True"
                                        notnull="true">
                                        <NumberFormat AllowRounding="False" ZeroPattern="n" />
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="formviewsubtitle">Dados do Pedido</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Solicitante<br />
                                                <asp:TextBox ID="PED_SOLICITANTE" runat="server" Text='<%# Bind("PED_SOLICITANTE") %>'
                                                    MaxLength="150" notnull="true" />
                                            </td>
                                            <td>Data do Pedido<br />
                                                <asp:TextBox ID="PED_DATA" runat="server" Text='<%# Bind("PED_DATA", "{0:dd/MM/yyyy}") %>'
                                                    Width="100" ReadOnly="True" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Versão?<br />
                                                <asp:RadioButtonList ID="radioVersao" runat="server" RepeatDirection="Horizontal"
                                                    RepeatLayout="Flow" SelectedValue='<%# Bind("PED_VERSAO_AQUISICAO") %>' notnull="true">
                                                    <asp:ListItem Value="2"  Selected="true">Master</asp:ListItem>
                                                    <asp:ListItem Value="8">AssepontoWeb</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Com Manutenção?<br />
                                                <asp:RadioButtonList ID="PED_COM_MANUTENCAO" runat="server" RepeatDirection="Horizontal"
                                                    RepeatLayout="Flow" SelectedValue='<%# Bind("PED_COM_MANUTENCAO") %>' notnull="true">
                                                    <asp:ListItem Value="True">Sim</asp:ListItem>
                                                    <asp:ListItem Value="False"  Selected="true">Não</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style='<%# FormView1.CurrentMode == FormViewMode.Insert ? "": "display: none;" %>'>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Planilha de Funcionarios do cliente (Opcional)<br />
                                                <asp:FileUpload ID="FilePlanilha" runat="server" />

                                            </td>
                                            <td>
                                                <br />
                                                <asp:CustomValidator ID="CV_Planilha" runat="server" OnServerValidate="CustomValidatorPlanilha_ServerValidate" ControlToValidate="FilePlanilha" CssClass="sitevalidator2" ErrorMessage="Formato Inválido! O arquivo deve estar em formato .xls ou .xlsx"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style='<%# FormView1.CurrentMode == FormViewMode.Insert || Eval("PED_PLANILHA_EXCEL") is DBNull ?  "display: none;": "padding-bottom: 10px;" %>'>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Planilha de Funcionarios do cliente<br />
                                                <br />
                                                <asp:LinkButton ID="lkPlanilha" CausesValidation="false" OnClick="lkPlanilha_Click" runat="server" CssClass="sitebutton blue">Baixar Planilha</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="formviewsubtitle">Dados do REP</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Fabricante do REP<br />
                                                <telerik:RadComboBox ID="PED_REP_FABRICANTE" runat="server" AutoPostBack="true" OnDataBinding="RadComboBox2_DataBinding" OnDataBound="RadComboBox2_DataBound" 
                                                    Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione o REP" 
                                                     EnableViewState="true">
                                                </telerik:RadComboBox>
                                                <%--<asp:RequiredFieldValidator ID="RFV_PED_REP_FABRICANTE" runat="server" ControlToValidate="PED_REP_FABRICANTE" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>--%>
                                                <%--<telerik:RadComboBox ID="PED_REP_FABRICANTE" runat="server" AutoPostBack="true" OnDataBinding="RadComboBox2_DataBinding" 
                                                    Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione o REP" SelectedValue='<%# Bind("PED_REP_FABRICANTE") %>'
                                                    EnableTextSelection="False" notnull="true">
                                                </telerik:RadComboBox>--%>
                                            </td>
                                            <td>Modelo do REP<br />
                                                <asp:TextBox ID="PED_MODELOREP" runat="server" Text='<%# Bind("PED_MODELOREP") %>'
                                                    MaxLength="150" notnull="true" />
                                                <asp:RequiredFieldValidator ID="RFV_PED_MODELOREP" runat="server" ControlToValidate="PED_MODELOREP" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                            </td>
                                            <td style="padding-top: 15px;">REP Instalado?
                                                <asp:RadioButtonList ID="PED_REPINSTALADO" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal"
                                                    notnull="true" SelectedValue='<%# Bind("PED_REPINSTALADO") %>'>
                                                    <asp:ListItem Value="True">Sim</asp:ListItem>
                                                    <asp:ListItem Value="False" Selected="true">Não</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>Observações<br />
                                    <asp:TextBox ID="PED_DESCRICAOTextBox" runat="server" Text='<%# Bind("PED_DESCRICAO") %>'
                                        Height="163px" TextMode="MultiLine" Width="532px" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </EditItemTemplate>
            </asp:FormView>
        </div>
        <div id="sitecorpoboxbottom" class="sitecorpoboxbottom" runat="server">
            <asp:LinkButton ID="btSalvar" runat="server" CssClass="sitebutton" OnClick="Salvar_Click" >
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />Salvar
                Alterações
            </asp:LinkButton>
        </div>
        <asp:SqlDataSource ID="sqlPedidosRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT [PED_IND], [PED_REV_IND], [PED_CLI_RAZAO], [PED_CLI_CNPJ], PED_CLI_CPF, [PED_CLI_IE], [PED_CLI_ENDERECO], [PED_CLI_ENDERECO_NUMERO], [PED_CLI_ENDERECO_COMPLEMENTO], [PED_CLI_CEP], [PED_CLI_BAIRRO], [PED_CLI_CIDADE], [PED_CLI_UF], [PED_CLI_EMAIL], [PED_SKYPE], [PED_CLI_TELEFONE], [PED_CLI_TELEFONE_DDD], [PED_CLI_QTD_FUNCIONA], [PED_CLI_CONTATO], [PED_VERSAO_AQUISICAO], [PED_EMAIL2], CASE PED_COM_MANUTENCAO WHEN 1 THEN 'True' ELSE 'False' END AS PED_COM_MANUTENCAO, [PED_MODELOREP], CASE WHEN PED_REPINSTALADO = 1 THEN 'True' ELSE 'False' END AS PED_REPINSTALADO, [PED_DESCRICAO], [PED_SITUACAO], [PED_SOLICITANTE], [PED_DATA_FECHAMENTO], [PED_REP_FABRICANTE], PED_CLI_TELEFONE2, PED_CLI_TELEFONE2_DDD, PED_CLI_CELULAR, PED_CLI_CELULAR_DDD, PED_CLI_CELULAR_ACEITA, [PED_FANTASIA], PED_DATA, PED_STATUS, PED_PLANILHA_EXCEL FROM [AssepontoPedidosRevendas] WHERE ([PED_IND] = @PED_IND)"
            InsertCommand="INSERT INTO AssepontoPedidosRevendas(PED_REV_IND , 
                                                                PED_CLI_RAZAO , 
                                                                PED_CLI_CNPJ , 
                                                                PED_CLI_CPF, 
                                                                PED_CLI_IE , 
                                                                PED_CLI_ENDERECO , 
                                                                PED_CLI_ENDERECO_NUMERO, 
                                                                PED_CLI_ENDERECO_COMPLEMENTO, 
                                                                PED_CLI_CEP , 
                                                                PED_CLI_BAIRRO , 
                                                                PED_CLI_CIDADE , 
                                                                PED_CLI_UF , 
                                                                PED_CLI_EMAIL , 
                                                                PED_SKYPE, 
                                                                PED_CLI_TELEFONE , 
                                                                PED_CLI_TELEFONE_DDD, PED_CLI_QTD_FUNCIONA , PED_CLI_CONTATO , PED_VERSAO_AQUISICAO , PED_COM_MANUTENCAO , PED_MODELOREP , PED_REPINSTALADO , PED_DESCRICAO , PED_SOLICITANTE , PED_REP_FABRICANTE , PED_FANTASIA , PED_STATUS, PED_EMAIL2, PED_ASSEPONTO4, PED_ASSEFIN,
                                            PED_CLI_TELEFONE2, PED_CLI_TELEFONE2_DDD, PED_CLI_CELULAR, PED_CLI_CELULAR_DDD, PED_CLI_CELULAR_ACEITA)         
                                             VALUES (@PED_REV_IND, @PED_CLI_RAZAO, @PED_CLI_CNPJ, @PED_CLI_CPF, @PED_CLI_IE, @PED_CLI_ENDERECO, @PED_CLI_ENDERECO_NUMERO, @PED_CLI_ENDERECO_COMPLEMENTO, @PED_CLI_CEP, @PED_CLI_BAIRRO, @PED_CLI_CIDADE, @PED_CLI_UF, @PED_CLI_EMAIL, @PED_SKYPE, @PED_CLI_TELEFONE, @PED_CLI_TELEFONE_DDD, @PED_CLI_QTD_FUNCIONA, @PED_CLI_CONTATO, @PED_VERSAO_AQUISICAO, @PED_COM_MANUTENCAO, @PED_MODELOREP, @PED_REPINSTALADO, @PED_DESCRICAO, @PED_SOLICITANTE, @PED_REP_FABRICANTE, @PED_FANTASIA, @PED_STATUS, @PED_EMAIL2, 1, 0,
                                             @PED_CLI_TELEFONE2, @PED_CLI_TELEFONE2_DDD, @PED_CLI_CELULAR, @PED_CLI_CELULAR_DDD, @PED_CLI_CELULAR_ACEITA)"
            UpdateCommand="UPDATE AssepontoPedidosRevendas SET PED_CLI_RAZAO = @PED_CLI_RAZAO , PED_CLI_CNPJ = @PED_CLI_CNPJ , PED_CLI_CPF = @PED_CLI_CPF , PED_CLI_IE = @PED_CLI_IE , PED_CLI_ENDERECO = @PED_CLI_ENDERECO , PED_CLI_ENDERECO_NUMERO = @PED_CLI_ENDERECO_NUMERO, PED_CLI_ENDERECO_COMPLEMENTO = @PED_CLI_ENDERECO_COMPLEMENTO, PED_CLI_CEP = @PED_CLI_CEP , PED_CLI_BAIRRO = @PED_CLI_BAIRRO , PED_CLI_CIDADE = @PED_CLI_CIDADE , PED_CLI_UF = @PED_CLI_UF , PED_CLI_EMAIL = @PED_CLI_EMAIL , PED_SKYPE = @PED_SKYPE, PED_CLI_TELEFONE = @PED_CLI_TELEFONE , PED_CLI_TELEFONE_DDD = @PED_CLI_TELEFONE_DDD, PED_CLI_QTD_FUNCIONA = @PED_CLI_QTD_FUNCIONA , PED_CLI_CONTATO = @PED_CLI_CONTATO , PED_VERSAO_AQUISICAO = @PED_VERSAO_AQUISICAO , PED_COM_MANUTENCAO = @PED_COM_MANUTENCAO , PED_MODELOREP = @PED_MODELOREP , PED_REPINSTALADO = @PED_REPINSTALADO , PED_DESCRICAO = @PED_DESCRICAO , PED_SOLICITANTE = @PED_SOLICITANTE , PED_REP_FABRICANTE = @PED_REP_FABRICANTE , PED_FANTASIA = @PED_FANTASIA, PED_EMAIL2 = @PED_EMAIL2,
                                            PED_CLI_TELEFONE2 = @PED_CLI_TELEFONE2, PED_CLI_TELEFONE2_DDD = @PED_CLI_TELEFONE2_DDD, PED_CLI_CELULAR = @PED_CLI_CELULAR, PED_CLI_CELULAR_DDD = @PED_CLI_CELULAR_DDD, PED_CLI_CELULAR_ACEITA = @PED_CLI_CELULAR_ACEITA WHERE PED_IND = @PED_IND"
            OnInserted="sqlPedidosRevendas_Inserted" InsertCommandType="Text" OnUpdated="sqlPedidosRevendas_Updated">
            <InsertParameters>
                <asp:FormParameter Name="PED_REV_IND" />
                <asp:FormParameter Name="PED_CLI_RAZAO" />
                <asp:FormParameter Name="PED_CLI_CNPJ" />
                <asp:FormParameter Name="PED_CLI_CPF" />
                <asp:FormParameter Name="PED_CLI_IE" />
                <asp:FormParameter Name="PED_CLI_ENDERECO" />
                <asp:FormParameter Name="PED_CLI_ENDERECO_NUMERO" />
                <asp:FormParameter Name="PED_CLI_ENDERECO_COMPLEMENTO" />
                <asp:FormParameter Name="PED_CLI_CEP" />
                <asp:FormParameter Name="PED_CLI_BAIRRO" />
                <asp:FormParameter Name="PED_CLI_CIDADE" />
                <asp:FormParameter Name="PED_CLI_UF" />
                <asp:FormParameter Name="PED_CLI_EMAIL" />
                <asp:FormParameter Name="PED_SKYPE" />
                <asp:FormParameter Name="PED_CLI_TELEFONE" />
                <asp:FormParameter Name="PED_CLI_TELEFONE_DDD" />
                <asp:FormParameter Name="PED_CLI_QTE_FUNCIONA" />
                <asp:FormParameter Name="PED_CLI_CONTATO" />
                <asp:FormParameter Name="PED_VERSAO_AQUISICAO" />
                <asp:FormParameter Name="PED_COM_MANUTENCAO" />
                <asp:FormParameter Name="PED_MODELOREP" />
                <asp:FormParameter Name="PED_REPINSTALADO" />
                <asp:FormParameter Name="PED_DESCRICAO" Size="-1" />
                <asp:FormParameter Name="PED_DATA" />
                <asp:FormParameter Name="PED_SOLICITANTE" />
                <asp:FormParameter Name="PED_REP_FABRICANTE" />
                <asp:FormParameter Name="PED_FANTASIA" />
                <asp:FormParameter Name="PED_STATUS" />
                <asp:FormParameter Name="PED_CLI_QTD_FUNCIONA" />
                <asp:FormParameter Name="PED_EMAIL2" />
                <asp:FormParameter Name="PED_ASSEFIN" />
                <asp:FormParameter Name="PED_ASSEPONTO4" />
                <asp:FormParameter Name="PED_CLI_CELULAR" />
                <asp:FormParameter Name="PED_CLI_CELULAR_ACEITA" />
                <asp:FormParameter Name="PED_CLI_CELULAR_DDD" />
                <asp:FormParameter Name="PED_CLI_TELEFONE2" />
                <asp:FormParameter Name="PED_CLI_TELEFONE2_DDD" />
            </InsertParameters>
            <UpdateParameters>
                <asp:QueryStringParameter DefaultValue="0" Name="PED_IND" QueryStringField="ind"
                    Type="Int32" />
                <asp:Parameter Name="PED_CLI_RAZAO" />
                <asp:Parameter Name="PED_CLI_CNPJ" />
                <asp:Parameter Name="PED_CLI_CPF" />
                <asp:Parameter Name="PED_CLI_IE" />
                <asp:Parameter Name="PED_CLI_ENDERECO" />
                <asp:Parameter Name="PED_CLI_ENDERECO_NUMERO" />
                <asp:Parameter Name="PED_CLI_ENDERECO_COMPLEMENTO" />
                <asp:Parameter Name="PED_CLI_CEP" />
                <asp:Parameter Name="PED_CLI_BAIRRO" />
                <asp:Parameter Name="PED_CLI_CIDADE" />
                <asp:Parameter Name="PED_CLI_UF" />
                <asp:Parameter Name="PED_CLI_EMAIL" />
                <asp:Parameter Name="PED_SKYPE" />
                <asp:Parameter Name="PED_CLI_TELEFONE_DDD" />
                <asp:Parameter Name="PED_CLI_QTE_FUNCIONA" />
                <asp:Parameter Name="PED_CLI_CONTATO" />
                <asp:Parameter Name="PED_VERSAO_AQUISICAO" />
                <asp:Parameter Name="PED_COM_MANUTENCAO" />
                <asp:Parameter Name="PED_MODELOREP" />
                <asp:Parameter Name="PED_REPINSTALADO" />
                <asp:Parameter Name="PED_DESCRICAO" Size="-1" />
                <asp:Parameter Name="PED_DATA" />
                <asp:Parameter Name="PED_SOLICITANTE" />
                <asp:Parameter Name="PED_REP_FABRICANTE" />
                <asp:Parameter Name="PED_FANTASIA" />
                <asp:Parameter Name="PED_CLI_QTD_FUNCIONA" />
                <asp:Parameter Name="PED_EMAIL2" />
                <asp:Parameter Name="PED_CLI_CELULAR" />
                <asp:Parameter Name="PED_CLI_CELULAR_ACEITA" />
                <asp:Parameter Name="PED_CLI_CELULAR_DDD" />
                <asp:Parameter Name="PED_CLI_TELEFONE2" />
                <asp:Parameter Name="PED_CLI_TELEFONE2_DDD" />
            </UpdateParameters>
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="0" Name="PED_IND" QueryStringField="ind"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlAssepontoRepFabricantes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT [FABR_NOME], [FABR_COD], [FABR_ATIVO] FROM [AssepontoRepFabricantes] WHERE ([FABR_ATIVO] = 1) ORDER BY [FABR_NOME]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlEstados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT [EST_SIGLA], [EST_NOME] FROM [Estados]"></asp:SqlDataSource>
    </div>
</asp:Content>
