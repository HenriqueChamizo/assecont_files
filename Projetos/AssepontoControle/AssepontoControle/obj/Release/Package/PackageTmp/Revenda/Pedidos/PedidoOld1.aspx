<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true" 
    CodeBehind="PedidoOld1.aspx.cs" Inherits="PedidoOld1" %>

<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <script>
                function ElementOnOrOff(ElementOn, ElementOff) {
                    document.getElementById(ElementOn).style = "display: block";
                    //document.getElementById(ElementOn).style.display = "block";
                    document.getElementById(ElementOff).style = "display: none";
                    //document.getElementById(ElementOff).style.display = "none";
                }
            </script>
            <asp:Panel ID="Panel1" runat="server" EnableViewState="false">
                <asp:HiddenField ID="hiddenRevenda" runat="server" />
                <asp:HiddenField ID="HiddenIndice" runat="server" />
                <asp:HiddenField ID="HiddenStatus" runat="server" />

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
                                        <asp:TextBox ID="PED_CLI_RAZAO" requerid="true" runat="server" Width="400px"  MaxLength="70" notnull="true" />
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
                                        <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###.###/####-##" Mask="##.###.###/####-##" ID="PED_CLI_CNPJ" MaxLength="20" 
                                            OnTextChanged="PED_CLI_CNPJ_TextChanged" AutoPostBack="true">
                                        </telerik:RadMaskedTextBox><br />
                                        <asp:Label ID="PED_CLI_CNPJ_ERRO" Font-Bold="true" ForeColor="Red" Text="CNPJ já cadastrado no sistema!" Visible="false" runat="server"></asp:Label>
                                        <asp:Label ID="PED_CLI_CNPJ_ERRO_TAMANHO" Font-Bold="true" ForeColor="Red" Text="Tamanho de CNPJ inválido!" Visible="false" runat="server"></asp:Label>
                                    </td>
                                    <td>Fantasia<br />
                                        <asp:TextBox ID="PED_FANTASIA" runat="server" MaxLength="30" />
                                    </td>
                                    <td>Inscrição Estadual<br />
                                            <telerik:RadMaskedTextBox runat="server" DisplayMask="############" Mask="############"
                                            ID="PED_CLI_IE" MaxLength="12">
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
                                        <telerik:RadMaskedTextBox runat="server" DisplayMask="###.###.###-##" Mask="###.###.###-##" ID="PED_CLI_CPF" MaxLength="12" 
                                            OnTextChanged="PED_CLI_CPF_TextChanged" AutoPostBack="true">
                                        </telerik:RadMaskedTextBox><br />
                                        <asp:Label ID="PED_CLI_CPF_ERRO" Font-Bold="true" ForeColor="Red" Text="CPF já cadastrado no sistema!" Visible="false" runat="server"></asp:Label>
                                        <asp:Label ID="PED_CLI_CPF_ERRO_TAMANHO" Font-Bold="true" ForeColor="Red" Text="Tamanho de CPF inválido!" Visible="false" runat="server"></asp:Label>
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
                                            AutoPostBack="true" />
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
                                        <asp:TextBox ID="PED_CLI_UF" Skin="flv" Width="50" runat="server" Enabled="false"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFV_UF" runat="server" ControlToValidate="PED_CLI_UF" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>Cidade<br />
                                        <asp:TextBox ID="PED_CLI_CIDADE" runat="server"
                                            Width="200px" notnull="true"  MaxLength="30" Enabled="false" />
                                        <asp:RequiredFieldValidator ID="RFV_Cidade" runat="server" ControlToValidate="PED_CLI_CIDADE" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>Bairro<br />
                                        <asp:TextBox ID="PED_CLI_BAIRRO" runat="server"
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
                                        <asp:TextBox ID="PED_CLI_ENDERECO" runat="server"
                                            Width="250px"  notnull="true"  MaxLength="70" Enabled="false" />
                                        <asp:RequiredFieldValidator ID="RFV_Endereco" runat="server" ControlToValidate="PED_CLI_ENDERECO" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>Número<br />
                                        <telerik:RadMaskedTextBox runat="server" DisplayMask="######" Mask="######"
                                            ID="PED_CLI_ENDERECO_NUMERO" MaxLength="7">
                                        </telerik:RadMaskedTextBox>
                                        <asp:RequiredFieldValidator ID="RFV_Numero" runat="server" ControlToValidate="PED_CLI_ENDERECO_NUMERO" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>Complemento<br />
                                        <asp:TextBox ID="PED_CLI_ENDERECO_COMPLEMENTO" runat="server"
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
                                        <asp:TextBox ID="PED_CLI_CONTATO" runat="server"
                                            Width="170px" notnull="true"  MaxLength="40" />
                                    </td>
                                    <td>SKYPE / MSN<br />
                                        <asp:TextBox ID="PED_SKYPE" runat="server" Width="170px"
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
                                            ID="PED_CLI_TELEFONE_DDD" MaxLength="2">
                                        </telerik:RadMaskedTextBox>
                                    </td>
                                    <td>Telefone<br />
                                        <asp:TextBox ID="PED_CLI_TELEFONE" runat="server"
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
                                            ID="PED_CLI_TELEFONE2_DDD" MaxLength="2">
                                        </telerik:RadMaskedTextBox>
                                    </td>
                                    <td>Telefone 2<br />
                                        <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########"
                                            ID="PED_CLI_TELEFONE2" Width="130px" MaxLength="9">
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
                                            ID="PED_CLI_CELULAR_DDD" MaxLength="2">
                                        </telerik:RadMaskedTextBox>
                                    </td>
                                    <td>Celular<br />
                                        <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########"
                                            ID="PED_CLI_CELULAR" Width="130px" MaxLength="9">
                                        </telerik:RadMaskedTextBox>
                                    </td>
                                    <td>
                                        <div class="fieldviewcaption">Receber avisos por SMS ?</div>
                                        <asp:RadioButtonList ID="CAD_CELULAR_ACEITA" runat="server" RepeatDirection="Horizontal"
                                            RepeatLayout="Flow" notnull="true">
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
                                        <asp:TextBox ID="txtEmail" runat="server"
                                            Width="200px" notnull="true" MaxLength="50" /><br />
                                        <div style="text-align: right">
                                            <asp:RegularExpressionValidator ID="RegularExpressionEMAIL" runat="server" CssClass="sitevalidator2"
                                                ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                        </div>
                                    </td>
                                    <td>Outro e-mail do responsável pelo sistema<br />
                                        <asp:TextBox ID="txtEmail2" runat="server" 
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
                    <%--</tr>--%>
                    <tr>
                        <td>
                            <br />
                            <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server" 
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
                                        <asp:TextBox ID="PED_SOLICITANTE" runat="server" 
                                            MaxLength="150" notnull="true" />
                                    </td>
                                    <td>Data do Pedido<br />
                                        <asp:TextBox ID="PED_DATA" runat="server" 
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
                                            RepeatLayout="Flow" notnull="true">
                                            <asp:ListItem Value="2"  Selected="true">Master</asp:ListItem>
                                            <asp:ListItem Value="8">AssepontoWeb</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Com Manutenção?<br />
                                        <asp:RadioButtonList ID="PED_COM_MANUTENCAO" runat="server" RepeatDirection="Horizontal"
                                            RepeatLayout="Flow" notnull="true">
                                            <asp:ListItem Value="True">Sim</asp:ListItem>
                                            <asp:ListItem Value="False"  Selected="true">Não</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td runat="server">
                            <asp:Panel ID="planFuncInsert" runat="server">
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
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td runat="server">
                            <asp:Panel ID="planFuncEdit" runat="server">
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>Planilha de Funcionarios do cliente<br />
                                            <br />
                                            <asp:LinkButton ID="lkPlanilha" CausesValidation="false" OnClick="lkPlanilha_Click" runat="server" CssClass="sitebutton blue">Baixar Planilha</asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
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
                                        <asp:RequiredFieldValidator ID="RFV_PED_REP_FABRICANTE" runat="server" ControlToValidate="PED_REP_FABRICANTE" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                        <%--<telerik:RadComboBox ID="PED_REP_FABRICANTE" runat="server" AutoPostBack="true" OnDataBinding="RadComboBox2_DataBinding" 
                                            Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione o REP" SelectedValue='<%# Bind("PED_REP_FABRICANTE") %>'
                                            EnableTextSelection="False" notnull="true">
                                        </telerik:RadComboBox>--%>
                                    </td>
                                    <td>Modelo do REP<br />
                                        <asp:TextBox ID="PED_MODELOREP" runat="server" 
                                            MaxLength="150" notnull="true" />
                                        <asp:RequiredFieldValidator ID="RFV_PED_MODELOREP" runat="server" ControlToValidate="PED_MODELOREP" ErrorMessage="Obrigatório" SetFocusOnError="true" CssClass="sitevalidator"></asp:RequiredFieldValidator>
                                    </td>
                                    <td style="padding-top: 15px;">REP Instalado?
                                        <asp:RadioButtonList ID="PED_REPINSTALADO" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            notnull="true" >
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
                            <asp:TextBox ID="PED_DESCRICAOTextBox" runat="server" 
                                Height="163px" TextMode="MultiLine" Width="532px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <div id="sitecorpoboxbottom" class="sitecorpoboxbottom" runat="server">
            <asp:LinkButton ID="btSalvar" runat="server" CssClass="sitebutton" OnClick="Salvar_Click" >
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />Salvar
                Alterações
            </asp:LinkButton>
        </div>
    </div>
    <asp:SqlDataSource ID="sqlAssepontoRepFabricantes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [FABR_NOME], [FABR_COD], [FABR_ATIVO] FROM [AssepontoRepFabricantes] WHERE ([FABR_ATIVO] = 1) ORDER BY [FABR_NOME]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlEstados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [EST_SIGLA], [EST_NOME] FROM [Estados]"></asp:SqlDataSource>
</asp:Content>
