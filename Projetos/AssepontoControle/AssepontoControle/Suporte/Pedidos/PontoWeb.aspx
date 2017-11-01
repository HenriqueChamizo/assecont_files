<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" 
    CodeBehind="PontoWeb.aspx.cs" Inherits="Asseponto.Suporte.Pedidos.PontoWeb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script type="text/javascript">
        function confirmdel() { return (window.confirm('Confirma a Exclusão?')) }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="PED_IND" DataSourceID="sqlPedidosRevendas" OnDataBound="FormView1_DataBound">
                <EditItemTemplate>
                    <asp:Panel ID="Panel1" runat="server" EnableViewState="false">
                        <asp:HiddenField ID="hiddenRevenda" runat="server" Value='<%# Bind("PED_REV_IND") %>' />
                        <asp:HiddenField ID="HiddenIndice" runat="server" Value='<%# Bind("PED_IND") %>' />
                        <asp:HiddenField ID="hiddenStatus" runat="server" Value='<%# Bind("PED_STATUS") %>' />

                        <table class="formviewtable">
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>
                                                <span class="formviewsubtitle">Revenda</span><br />
                                                <telerik:RadComboBox ID="comboboxRevenda" runat="server" OnDataBinding="RadComboBox2_DataBinding"
                                                    SelectedValue='<%# Bind("PED_REV_IND") %>' Width="500px" EmptyMessage="Selecione a Revenda"
                                                    notnull="true" Skin="flv" EnableEmbeddedSkins="false">
                                                </telerik:RadComboBox>
                                                <asp:SqlDataSource ID="sqlRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                                                    SelectCommand="SELECT * FROM [AssepontoRevendas] ORDER BY [REV_RAZAOSOCIAL]"></asp:SqlDataSource>
                                                <asp:Label ID="labelRevendaRazaoSocial" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
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
                                                <asp:TextBox ID="PED_CLI_RAZAO" runat="server" Text='<%# Bind("PED_CLI_RAZAO") %>' Width="400px" MaxLength="70" notnull="true" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td colspan="3">
                                                <b>Pessoa Jurídica</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="RadMaskedTextBox">CNPJ<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###.###/####-##" Mask="##.###.###/####-##"
                                                    ID="PED_CLI_CNPJ" Text='<%# Bind("PED_CLI_CNPJ") %>' MaxLength="20">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Inscrição Estadual<br />
                                               <telerik:RadMaskedTextBox runat="server" DisplayMask="############" Mask="############"
                                                    ID="RadMaskedTextBox4" Text='<%# Bind("PED_CLI_IE") %>' MaxLength="12">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Fantasia<br />
                                                <asp:TextBox ID="PED_FANTASIA" runat="server" Text='<%# Bind("PED_FANTASIA") %>' MaxLength="50" />
                                            </td>
                                            <td><br />
                                                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Informar Pessoa Fisica ou Juridica"
                                                    CssClass="sitevalidator2" OnServerValidate="CustomValidator1_ServerValidate1"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td colspan="2">
                                                <b>Pessoa Física</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="RadMaskedTextBox">CPF<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="###.###.###-##" Mask="###.###.###-##"
                                                    ID="PED_CLI_CPF" Text='<%# Bind("PED_CLI_CPF") %>' MaxLength="12">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>
                                                <br />
                                                <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Pedido já aceito"
                                                    CssClass="sitevalidator2" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
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
                                                    Width="250px" MaxLength="70" notnull="true" />
                                            </td>
                                            <td>Número<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="########" Mask="########"
                                                    ID="PED_CLI_ENDERECO_NUMERO" Text='<%# Bind("PED_CLI_ENDERECO_NUMERO") %>' MaxLength="7">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Complemento<br />
                                                <asp:TextBox ID="PED_CLI_ENDERECO_COMPLEMENTO" runat="server" Text='<%# Bind("PED_CLI_ENDERECO_COMPLEMENTO") %>'
                                                    Width="200px" MaxLength="60" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Bairro<br />
                                                <asp:TextBox ID="PED_CLI_BAIRRO" runat="server" Text='<%# Bind("PED_CLI_BAIRRO") %>'
                                                    Width="200px" MaxLength="25" notnull="true" />
                                            </td>
                                            <td>Cidade<br />
                                                <asp:TextBox ID="PED_CLI_CIDADE" runat="server" Text='<%# Bind("PED_CLI_CIDADE") %>'
                                                    Width="200px" MaxLength="30" notnull="true" />
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
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Responsável<br />
                                                <asp:TextBox ID="PED_CLI_CONTATO" runat="server" Text='<%# Bind("PED_CLI_CONTATO") %>'
                                                    Width="170px" MaxLength="40" notnull="true" />
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
                                                    ID="PED_CLI_TELEFONE_DDD" notnull="true" Text='<%# Bind("PED_CLI_TELEFONE_DDD") %>' MaxLength="2">
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
                                                    ID="RadMaskedTextBox1" Text='<%# Bind("PED_CLI_TELEFONE2_DDD") %>' MaxLength="2">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Telefone 2<br />
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("PED_CLI_TELEFONE2") %>'
                                                    Width="130px" MaxLength="9" />
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
                                                    ID="RadMaskedTextBox2" Text='<%# Bind("PED_CLI_CELULAR_DDD") %>' MaxLength="2">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Celular(Somente números)<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########" Width="130px"
                                                    ID="RadMaskedTextBox3" Text='<%# Bind("PED_CLI_CELULAR") %>' MaxLength="10">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>
                                                <div class="fieldviewcaption">Receber avisos por SMS ?</div>
                                                <asp:RadioButtonList ID="CAD_CELULAR_ACEITA" runat="server" RepeatDirection="Horizontal"
                                                    RepeatLayout="Flow" SelectedValue='<%# Bind("PED_CLI_CELULAR_ACEITA") %>' notnull="true">
                                                    <asp:ListItem Value="True">Sim</asp:ListItem>
                                                    <asp:ListItem Value="False">Não</asp:ListItem>
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
                                                    Width="200px" MaxLength="50" notnull="true" /><br />
                                                <div style="text-align: right">
                                                    <asp:RegularExpressionValidator ID="RegularExpressionEMAIL" runat="server" CssClass="sitevalidator2"
                                                        ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                                </div>
                                            </td>
                                            <td>Outro e-mail do responsável pelo sistema 2<br />
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
                                                O Email é do responsável pelo sistema
                                                da empresa que consta neste cadastro.
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div>
                                        <br />
                                        <telerik:RadNumericTextBox ID="PED_CLI_QTD_FUNCIONA" runat="server" DbValue='<%# Bind("PED_CLI_QTD_FUNCIONA") %>'
                                            Width="200px" MaxLength="4" Skin="Wr" EnableEmbeddedSkins="false" Display="True"
                                            Label="Número de Funcionários" notnull="true">
                                            <NumberFormat AllowRounding="False" ZeroPattern="n" />
                                        </telerik:RadNumericTextBox>
                                    </div>
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
                                            <td>Data de Fechamento<br />
                                                <asp:TextBox ID="PED_DATAFECHAMENTO" runat="server" Text='<%# Bind("PED_DATAFECHAMENTO", "{0:dd/MM/yyyy}") %>'
                                                    Width="100" ReadOnly="True" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner" style="display:none">
                                        <tr>
                                            <td>Versão do sistema?<br />
                                                <asp:RadioButtonList ID="radioVersao" runat="server" RepeatDirection="Horizontal"
                                                    RepeatLayout="Flow" SelectedValue='<%# Bind("PED_VERSAO_AQUISICAO") %>' notnull="true">
                                                    <asp:ListItem Value="2">Asseponto 4 (Master)</asp:ListItem>
                                                    <asp:ListItem Value="8" Selected="True">AssepontoWeb</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Com Manutenção?<br />
                                                <asp:RadioButtonList ID="PED_COM_MANUTENCAO" runat="server" RepeatDirection="Horizontal"
                                                    RepeatLayout="Flow" SelectedValue='<%# Bind("PED_COM_MANUTENCAO") %>' notnull="true">
                                                    <asp:ListItem Value="True" Selected="True">Sim</asp:ListItem>
                                                    <asp:ListItem Value="False">Não</asp:ListItem>
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
                                                <asp:CustomValidator ID="CV_Planilha" runat="server" OnServerValidat="CustomValidatorCurriculo_ServerValidate" ControlToValidate="FilePlanilha" CssClass="sitevalidator" ErrorMessage="Formato Inválido"></asp:CustomValidator>
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
                                            <td>
                                                <asp:CustomValidator ID="CustomValidator3" runat="server" ControlToValidate="FilePlanilha" CssClass="sitevalidator" ErrorMessage="Obrigatório"></asp:CustomValidator>
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
                                                <telerik:RadComboBox ID="PED_REP_FABRICANTE" runat="server" Skin="flv" EnableEmbeddedSkins="false"
                                                    OnDataBinding="RadComboBox3_DataBinding" EmptyMessage="Selecione o REP" SelectedValue='<%# Bind("PED_REP_FABRICANTE") %>'
                                                    EnableTextSelection="False" notnull="true">
                                                </telerik:RadComboBox>
                                            </td>
                                            <td>Modelo do REP<br />
                                                <asp:TextBox ID="PED_MODELOREP" runat="server" Text='<%# Bind("PED_MODELOREP") %>'
                                                    MaxLength="150" notnull="true" />
                                            </td>
                                            <td style="padding-top: 15px;">REP Instalado?
                                                    <asp:RadioButtonList ID="PED_REPINSTALADO" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal"
                                                        notnull="true" SelectedValue='<%# Bind("PED_REPINSTALADO") %>'>
                                                        <asp:ListItem Value="True">Sim</asp:ListItem>
                                                        <asp:ListItem Value="False">Não</asp:ListItem>
                                                    </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" CssClass="formviewsubtitle">Observações para a Implantação</asp:Label>
                                    <br />
                                    <asp:TextBox ID="textObsPedido" TextMode="MultiLine" Height="163px" Width="532px" runat="server" Text='<%# Bind("PED_DESCRICAO") %>'></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </EditItemTemplate>
            </asp:FormView>
        </div>
        <div id="sitecorpoboxbottom" class="sitecorpoboxbottom" runat="server">
            <asp:LinkButton ID="btSalvar" runat="server" CssClass="sitebutton" OnClick="btSalvar_Click">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />Salvar
                Alterações
            </asp:LinkButton>
            <asp:LinkButton ID="btFinalizarParaImplantacao" runat="server" CssClass="sitebutton"
                OnClick="btFinalizarParaImplantacao_Click" CausesValidation="False">Finalizar Pedido e Enviar para Implantação</asp:LinkButton>
            <asp:LinkButton ID="Excluir" runat="server" CssClass="sitebutton" OnClick="btExcluir_Click"
                CausesValidation="False" OnClientClick="return confirmdel();">
                <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/16x16/XisWhite.png" />Excluir
                Pedido
            </asp:LinkButton>
        </div>
    </div>
    <asp:SqlDataSource ID="sqlPedidosRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT PED_IND, PED_DATA, PED_DATAFECHAMENTO, PED_PLANILHA_EXCEL, PED_REV_IND , PED_CLI_RAZAO , PED_CLI_CNPJ , PED_CLI_CPF , PED_CLI_IE , PED_CLI_ENDERECO , PED_CLI_ENDERECO_NUMERO, PED_CLI_ENDERECO_COMPLEMENTO, 
        PED_CLI_CEP , PED_CLI_BAIRRO, PED_CLI_CIDADE , UPPER(PED_CLI_UF) AS PED_CLI_UF , PED_CLI_EMAIL , PED_SKYPE , PED_CLI_TELEFONE , PED_CLI_TELEFONE_DDD, 
        PED_CLI_QTD_FUNCIONA , PED_CLI_CONTATO, PED_COM_MANUTENCAO , PED_MODELOREP , PED_REPINSTALADO , PED_DESCRICAO , PED_SOLICITANTE , 
        PED_REP_FABRICANTE , PED_FANTASIA , PED_STATUS, PED_VERSAO_AQUISICAO, PED_EMAIL2, PED_ASSEPONTO4, PED_ASSEFIN,
        PED_CLI_TELEFONE2, PED_CLI_TELEFONE2_DDD, PED_CLI_CELULAR, PED_CLI_CELULAR_DDD, PED_CLI_CELULAR_ACEITA FROM AssepontoPedidosRevendas WHERE (PED_IND = @PED_IND)"
        DeleteCommand="DELETE FROM AssepontoPedidosRevendas WHERE ([PED_IND] = @PED_IND)"
        InsertCommand="INSERT INTO AssepontoPedidosRevendas
        (PED_REV_IND , PED_CLI_RAZAO , PED_CLI_CNPJ , PED_CLI_CPF , PED_CLI_IE , PED_CLI_ENDERECO , PED_CLI_ENDERECO_NUMERO, PED_CLI_ENDERECO_COMPLEMENTO, 
        PED_CLI_CEP , PED_CLI_BAIRRO, PED_CLI_CIDADE , PED_CLI_UF , PED_CLI_EMAIL , PED_SKYPE , PED_CLI_TELEFONE , PED_CLI_TELEFONE_DDD, 
        PED_CLI_QTD_FUNCIONA , PED_CLI_CONTATO, PED_COM_MANUTENCAO , PED_MODELOREP , PED_REPINSTALADO , PED_DESCRICAO , PED_SOLICITANTE , 
        PED_REP_FABRICANTE , PED_FANTASIA , PED_STATUS, PED_VERSAO_AQUISICAO, PED_EMAIL2, PED_ASSEPONTO4, PED_ASSEFIN,
        PED_CLI_TELEFONE2, PED_CLI_TELEFONE2_DDD, PED_CLI_CELULAR, PED_CLI_CELULAR_DDD, PED_CLI_CELULAR_ACEITA)         
        VALUES 
        (@PED_REV_IND, @PED_CLI_RAZAO, @PED_CLI_CNPJ, @PED_CLI_CPF, @PED_CLI_IE, @PED_CLI_ENDERECO, @PED_CLI_ENDERECO_NUMERO, @PED_CLI_ENDERECO_COMPLEMENTO, 
        @PED_CLI_CEP, @PED_CLI_BAIRRO, @PED_CLI_CIDADE, @PED_CLI_UF, @PED_CLI_EMAIL, @PED_SKYPE, @PED_CLI_TELEFONE, @PED_CLI_TELEFONE_DDD, 
        @PED_CLI_QTD_FUNCIONA, @PED_CLI_CONTATO, @PED_COM_MANUTENCAO, @PED_MODELOREP, @PED_REPINSTALADO, @PED_DESCRICAO, @PED_SOLICITANTE, 
        @PED_REP_FABRICANTE, @PED_FANTASIA, @PED_STATUS, @PED_VERSAO_AQUISICAO, @PED_EMAIL2, 1, 0,
        @PED_CLI_TELEFONE2, @PED_CLI_TELEFONE2_DDD, @PED_CLI_CELULAR, @PED_CLI_CELULAR_DDD, @PED_CLI_CELULAR_ACEITA)"
        OnInserted="sqlPedidosRevendas_Inserted">

        <DeleteParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="PED_IND" QueryStringField="ind" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="PED_IND" QueryStringField="ind" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="PED_REV_IND" />
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
            <asp:Parameter Name="PED_CLI_TELEFONE" />
            <asp:Parameter Name="PED_CLI_TELEFONE_DDD" />
            <asp:Parameter Name="PED_CLI_CELULAR" />
            <asp:Parameter Name="PED_CLI_CELULAR_ACEITA" />
            <asp:Parameter Name="PED_CLI_CELULAR_DDD" />
            <asp:Parameter Name="PED_CLI_TELEFONE2" />
            <asp:Parameter Name="PED_CLI_TELEFONE2_DDD" />
            <asp:Parameter Name="PED_CLI_QTE_FUNCIONA" />
            <asp:Parameter Name="PED_CLI_CONTATO" />
            <asp:Parameter Name="PED_COM_MANUTENCAO" />
            <asp:Parameter Name="PED_MODELOREP" />
            <asp:Parameter Name="PED_REPINSTALADO" />
            <asp:Parameter Name="PED_DATA" />
            <asp:Parameter Name="PED_SOLICITANTE" />
            <asp:Parameter Name="PED_REP_FABRICANTE" />
            <asp:Parameter Name="PED_STATUS" />
            <asp:Parameter Name="PED_DESCRICAO" />
            <asp:Parameter Name="PED_VERSAO_AQUISICAO" />
            <asp:Parameter Name="PED_CLI_QTD_FUNCIONA" />
            <asp:Parameter Name="PED_EMAIL2" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlAssepontoRepFabricantes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [FABR_NOME], [FABR_COD], [FABR_ATIVO] FROM [AssepontoRepFabricantes] WHERE ([FABR_ATIVO] = 1) ORDER BY [FABR_NOME]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlEstados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT EST_SIGLA, EST_NOME, (EST_NOME + ' - ' + EST_SIGLA) AS ESTADOS FROM [Estados]"></asp:SqlDataSource>
</asp:Content>
