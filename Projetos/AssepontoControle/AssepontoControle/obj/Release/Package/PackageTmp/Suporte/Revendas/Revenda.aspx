<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="Revenda.aspx.cs" Inherits="Asseponto.Suporte.Revendas.Revenda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script type="text/javascript" src="../../Scripts/Scripts.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="divSiteMenuEsquerdo" runat="server">
        <div id="sitemenuesquerdo">
            <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
                Width="100%">
                <Items>
                    <telerik:RadMenuItem runat="server" Text="Clientes da Revenda" NavigateUrl="#">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Text="Manutenção" NavigateUrl="#">
                    </telerik:RadMenuItem>
                </Items>
            </telerik:RadMenu>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <flv:CadastroAssefin runat="server" ID="CadastroAssefin" />
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="REV_IND" DataSourceID="sqlRevendas"
                OnPreRender="FormView1_PreRender" Width="800px">
                <EditItemTemplate>
                    <asp:Panel ID="Panel1" runat="server" EnableViewState="false">
                        <table class="formviewtable">
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>
                                                <span class="formviewsubtitle">DADOS DA EMPRESA </span>
                                                <br />
                                                <br />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Razão Social<br />
                                                <asp:TextBox ID="REV_RAZAOSOCIAL" runat="server" Text='<%# Bind("REV_RAZAOSOCIAL") %>'
                                                    Width="340px" notnull="true" />
                                            </td>
                                            <td>CNPJ/ CPF<br />
                                                <asp:Label ID="lbCnpjCpf" runat="server" Width="160" Text='<%# Eval("CNPJ_CPF") %>'></asp:Label>
                                            </td>

                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Distribuidora<br />
                                                <asp:TextBox ID="REV_DISTRIBUIDORA" runat="server" Text='<%# Bind("REV_DISTRIBUIDORA") %>'
                                                    Width="300px" notnull="true" />
                                            </td>
                                            <td>Inscrição Estadual<br />
                                                <telerik:RadMaskedTextBox ID="txtIE" runat="server" DisplayMask="############" Mask="############"
                                                    Text='<%# Bind("REV_IE") %>' Width="130px" MaxLength="12" />
                                            </td>
                                            <td>Fantasia<br />
                                                <asp:TextBox ID="REV_FANTASIA" runat="server" Text='<%# Bind("REV_FANTASIA") %>'
                                                    Width="150px" MaxLength="30" />
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
                                                <asp:TextBox ID="REV_LOGRADOURO" runat="server" Text='<%# Bind("REV_LOGRADOURO") %>'
                                                    Width="300px" notnull="true" />
                                            </td>
                                            <td>Nº<br />
                                                <asp:TextBox ID="REV_NUMERO" runat="server" Text='<%# Bind("REV_NUMERO") %>'
                                                    Width="50px" MaxLength="100" />
                                            </td>
                                            <td>Complemento<br />
                                                <asp:TextBox ID="REV_COMPLEMENTO" runat="server" Text='<%# Bind("REV_COMPLEMENTO") %>'
                                                    Width="150px" />
                                            </td>
                                            <td>CEP<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###-###" Mask="##.###-###" notnull="true"
                                                    ID="REV_CEP" Width="80px" Text='<%# Bind("REV_CEP") %>'>
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
                                            <td>Bairro<br />
                                                <asp:TextBox ID="txtBairro" runat="server" Text='<%# Bind("REV_BAIRRO") %>' Width="200px" notnull="true" />
                                            </td>
                                            <td>Cidade<br />
                                                <asp:TextBox ID="REV_CIDADE" runat="server" Text='<%# Bind("REV_CIDADE") %>' Width="200px" notnull="true" />
                                            </td>
                                            <td>UF<br />
                                                <telerik:RadComboBox ID="REV_UF" runat="server" Skin="flv" EnableEmbeddedSkins="false"
                                                    OnDataBinding="RadComboBox1_DataBinding" Widht="60px" EmptyMessage="Selecione o Estado"
                                                    SelectedValue='<%# Bind("REV_UF") %>' notnull="true">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>Contato<br />
                                    <asp:TextBox ID="REV_CONTATO" runat="server" Text='<%# Bind("REV_CONTATO") %>' Width="200px" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>DDD<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##" Width="50px" notnull="true"
                                                    ID="txtTelefone_ddd" Text='<%# Bind("REV_DDD") %>' MaxLength="2" />
                                            </td>
                                            <td>Telefone<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########" Width="130px" notnull="true"
                                                    ID="txtTelefone" Text='<%# Bind("REV_TELEFONE") %>' MaxLength="10" />
                                            </td>
                                            <td>Skype/MSN<br />
                                                <asp:TextBox ID="REV_SKYPE" runat="server" Text='<%# Bind("REV_SKYPE") %>' Width="150px" MaxLength="50" />
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
                                                    ID="txtTelefone2_ddd" Text='<%# Bind("REV_TELEFONE2_DDD") %>' MaxLength="2">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Telefone 2<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########" Width="130px"
                                                    ID="txtTelefone2" Text='<%# Bind("REV_TELEFONE2") %>' MaxLength="10">
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
                                                    ID="txtDDD" Text='<%# Bind("REV_CEL_DDD") %>' MaxLength="2">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Celular<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########" Width="130px"
                                                    ID="txtCelular" Text='<%# Bind("REV_CELULAR") %>' MaxLength="9">
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
                                            <td>E-mail<br />
                                                <asp:TextBox ID="REV_EMAIL" runat="server" Text='<%# Bind("REV_EMAIL") %>' Width="250px" notnull="true" />
                                            </td>
                                            <td>E-mail 2<br />
                                                <asp:TextBox ID="txtEmail2" runat="server" Text='<%# Bind("REV_EMAIL2") %>' Width="250px" />
                                            </td>
                                            <td>E-mail 3<br />
                                                <asp:TextBox ID="txtEmail3" runat="server" Text='<%# Bind("REV_EMAIL3") %>' Width="250px" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Revenda ?<br />
                                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" CssClass="checkbox" RepeatDirection="Horizontal"
                                                    RepeatLayout="Flow" SelectedValue='<%# Bind("REV_STATUS") %>' notnull="true">
                                                    <asp:ListItem Value="0">GOLD</asp:ListItem>
                                                    <asp:ListItem Value="1">PREMIUM</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>

                                            <td>
                                                <br />
                                                <asp:CheckBox ID="chckBoletoGold" runat="server" CssClass="checkbox" Text="Gerar boleto dos clientes (Revenda Gold Master)" Checked='<%# Bind("REV_COBRAR_CLIENTES") %>' />
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
                                                <asp:TextBox ID="txtFinanceiroContato" runat="server" Width="240px" />
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
                                                <asp:TextBox ID="txtFinanceiroEmail" runat="server" Width="240px" />
                                            </td>
                                            <td>E-mail Finaneceiro 2<br />
                                                <asp:TextBox ID="txtFinanceiroEmail2" runat="server" Width="240px" />
                                            </td>
                                            <td>E-mail Finaneceiro 3<br />
                                                <asp:TextBox ID="txtFinanceiroEmail3" runat="server" Width="240px" />
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
                                                    ID="txtFinanceiroCelular_DDD" Width="50px" MaxLength="2" />
                                            </td>
                                            <td>Celular Financeiro
                                                <br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##########" Mask="##########"
                                                    ID="txtFinanceiroCelular" Width="130px" MaxLength="10" />
                                            </td>
                                            <td>
                                                <br />
                                                <asp:CheckBox ID="rbFinanceiroCelularAceita" runat="server" CssClass="checkbox" Text="Receber aviso por SMS " />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>Observações<br />
                                    <asp:TextBox ID="REV_OBS" runat="server" Text='<%# Bind("REV_OBS") %>' TextMode="MultiLine"
                                        Rows="6" Columns="45" Width="600px" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <br />
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="btSalvar" runat="server" CssClass="sitebutton" OnClick="Salvar_Click">
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
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="PanelREP" runat="server">
                                        <table class="formviewtable">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbFabricante" CssClass="formviewsubtitle" runat="server" Text="Fabricante do Rep Comercializado"></asp:Label>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table class="formviewtableinner">
                                                        <tr>
                                                            <td>
                                                                <telerik:RadComboBox ID="RadComboBox1" runat="server" DataSourceID="SqlRepFabricante"
                                                                    DataTextField="FABR_NOME" DataValueField="FABR_COD" Skin="flv" EnableEmbeddedSkins="false">
                                                                </telerik:RadComboBox>
                                                            </td>
                                                            <td class="formviewtableinner">
                                                                <asp:LinkButton ID="lbAdd" runat="server" CssClass="sitebutton" OnClick="lbAdd_Click1">Adicionar</asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Adicionar pelo menos um REP"
                                                                    OnServerValidate="CustomValidator1_ServerValidate1" CssClass="sitevalidator2"></asp:CustomValidator>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-top: 5px;">
                                                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlREP" CellSpacing="0"
                                                        GridLines="None" Width="200px" Skin="Wr" EnableEmbeddedSkins="false">
                                                        <ClientSettings>
                                                        </ClientSettings>
                                                        <MasterTableView DataSourceID="SqlREP" AllowAutomaticDeletes="true" AutoGenerateColumns="false"
                                                            DataKeyNames="REVREP_IND">
                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="REVREP_IND" Display="false" HeaderText="ID" UniqueName="REVREP_IND"
                                                                    SortExpression="REVREP_IND">
                                                                    <HeaderStyle Width="150px" />
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="FABR_NOME" HeaderText="Nome" UniqueName="FABR_NOME"
                                                                    SortExpression="FABR_NOME">
                                                                    <HeaderStyle Width="150px" />
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridTemplateColumn HeaderText="Remover">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" Text="Remover" OnClick="LinkButton1_Click"
                                                                            CommandArgument='<%# Eval("REVREP_IND") %>'></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </EditItemTemplate>
            </asp:FormView>
            <asp:Panel ID="PanelLoginsRevenda" runat="server">
                <div id="divLoginsRevenda" runat="server">
                    <asp:Label ID="Label6" runat="server" Text="Logins Associados à Revenda" CssClass="formviewsubtitle"></asp:Label><br />
                    <asp:DataList ID="DataList1" runat="server" DataKeyField="USUREV_IND" DataSourceID="sqlAssepontoUsuariosRevendas">
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/16x16/close.png"
                                CommandArgument='<%# Eval("USUREV_IND") %>' OnClick="ImageButton1_Click" ToolTip="Excluir"
                                ImageAlign="AbsMiddle" OnClientClick="return confirmarexclusao();" CausesValidation="false" ValidationGroup="loginREVS" />
                            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/16x16/emailsend.png"
                                CommandArgument='<%# Eval("USUREV_IND") %>' OnClick="ImageButton2_Click" ToolTip="Enviar senha por e-mail"
                                ImageAlign="AbsMiddle" CausesValidation="false" ValidationGroup="loginREVS" />
                            <asp:ImageButton ID="imageLogar" runat="server" ImageUrl="~/Images/16x16/KeyArrow.png"
                                CommandArgument='<%# Eval("USUREV_IND") %>' ToolTip="Logar" ImageAlign="AbsMiddle"
                                OnClick="imageLogar_Click" CausesValidation="false" ValidationGroup="loginREVS" />
                            <asp:ImageButton ID="imageSms" runat="server" ImageUrl="~/Images/Site/sms.png"
                                CommandArgument='<%# Eval("USUREV_IND") %>' ToolTip="Enviar senha por sms" ImageAlign="AbsMiddle"
                                OnClick="imageSms_Click" CausesValidation="false" ValidationGroup="loginREVS" />
                            <asp:Label ID="USUREV_LOGINLabel" runat="server" Text='<%# Eval("USUREV_LOGIN") %>' />
                            <asp:Label ID="USUREV_ULTIMO_ACESSOLabel" runat="server" Text='<%# Eval("USUREV_ULTIMO_ACESSO") is DBNull ? null : " | último acesso: " + Eval("USUREV_ULTIMO_ACESSO", "{0: dd/MM/yyyy}") %>' />
                            <asp:Label ID="USUREV_EMAIL_ENVIO_SENHALabel" runat="server" Text='<%# Eval("USUREV_EMAIL_ENVIO_SENHA") is DBNull ? null : " | enviada: " + Eval("USUREV_EMAIL_ENVIO_SENHA") + "|" + Eval("USUREV_EMAIL_ENVIO_SENHA2") %>' />
                            <asp:Label ID="USUREV_DATA_ENVIO_SENHALabel" runat="server" Text='<%# Eval("USUREV_DATA_ENVIO_SENHA") is DBNull ? null : " em " + Eval("USUREV_DATA_ENVIO_SENHA", "{0: dd/MM/yyyy HH:mm}") %>' />
                            <br />
                            <asp:Label ID="lbErro" runat="server" Text="" Visible="false" ForeColor="Red" OnLoad="lbErro_Load"></asp:Label>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:Panel ID="panelNovoLoginContainer" runat="server">
                        <asp:LinkButton ID="linkButtonExpandirNovoLogin" runat="server" CssClass="sitelinkpadraoazul"
                            CausesValidation="true">Criar novo login</asp:LinkButton><br />
                    </asp:Panel>
                </div>
            </asp:Panel>

            <asp:Panel ID="panelNovoLogin" runat="server" CssClass="sitepadroesinvisible">
                Novo Login<asp:RequiredFieldValidator ID="requiredfieldvalidatorLoginNovo" runat="server"
                    ControlToValidate="texteditNovoLogin" ErrorMessage=" Informe o novo login" CssClass="sitevalidator"
                    ValidationGroup="novologin" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="texteditNovoLogin" runat="server" MaxLength="10"></asp:TextBox>
                <asp:LinkButton ID="linkbuttonNovoLogin" runat="server" ValidationGroup="novologin"
                    OnClick="linkbuttonNovoLogin_Click" class="sitelinkpadraoazul">Salvar</asp:LinkButton>
            </asp:Panel>

            <asp:SqlDataSource ID="sqlRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                InsertCommand="INSERT INTO AssepontoRevendas
                                       (REV_RAZAOSOCIAL, REV_CNPJ, REV_DISTRIBUIDORA, REV_IE, 
			                            REV_FANTASIA, REV_LOGRADOURO, REV_NUMERO, REV_COMPLEMENTO, 
			                            REV_CEP, REV_BAIRRO, REV_CIDADE, REV_UF, REV_CONTATO,
			                            REV_DDD, REV_TELEFONE, REV_SKYPE, REV_TELEFONE2_DDD, 
                                        REV_TELEFONE2, REV_CEL_DDD, REV_CELULAR, REV_EMAIL, REV_EMAIL2, 
			                            REV_EMAIL3, REV_STATUS, REV_COBRAR_CLIENTES, REV_OBS, REV_REP_FABRICANTE
	                            VALUES (@REV_RAZAOSOCIAL, @REV_CNPJ, @REV_DISTRIBUIDORA, @REV_IE, 
			                            @REV_FANTASIA, @REV_LOGRADOURO, @REV_NUMERO, @REV_COMPLEMENTO, 
			                            @REV_CEP, @REV_BAIRRO, @REV_CIDADE, @REV_UF, @REV_CONTATO, 
			                            @REV_DDD, @REV_TELEFONE, @REV_SKYPE, @REV_TELEFONE2_DDD, 
			                            @REV_TELEFONE2, @REV_CEL_DDD, @REV_CELULAR, @REV_EMAIL, @REV_EMAIL2
			                            @REV_EMAIL3, @REV_STATUS, @REV_COBRAR_CLIENTES, @REV_OBS, @REV_REP_FABRICANTE)"
                SelectCommand="SELECT *, dbo.fn_Revenda_cnpj_cpf(REV_IND) AS CNPJ_CPF FROM AssepontoRevendas WHERE (REV_IND = @REV_IND)"
                UpdateCommand="UPDATE AssepontoRevendas 
                                SET REV_RAZAOSOCIAL = @REV_RAZAOSOCIAL, REV_DISTRIBUIDORA = @REV_DISTRIBUIDORA, REV_IE = @REV_IE, 
	                                REV_FANTASIA = @REV_FANTASIA, REV_LOGRADOURO = @REV_LOGRADOURO, REV_NUMERO = @REV_NUMERO, REV_COMPLEMENTO = @REV_COMPLEMENTO, 
	                                REV_CEP = @REV_CEP, REV_BAIRRO = @REV_BAIRRO, REV_CIDADE = @REV_CIDADE, REV_UF = @REV_UF, REV_CONTATO = @REV_CONTATO, 
	                                REV_DDD = @REV_DDD, REV_TELEFONE = @REV_TELEFONE, REV_SKYPE = @REV_SKYPE, REV_TELEFONE2_DDD = @REV_TELEFONE2_DDD, 
	                                REV_TELEFONE2 = @REV_TELEFONE2, REV_CEL_DDD = @REV_CEL_DDD, REV_CELULAR = @REV_CELULAR, REV_EMAIL = @REV_EMAIL, REV_EMAIL2 = @REV_EMAIL2, 
	                                REV_EMAIL3 = @REV_EMAIL3, REV_STATUS = @REV_STATUS, REV_COBRAR_CLIENTES = @REV_COBRAR_CLIENTES, REV_OBS = @REV_OBS, 
	                                REV_REP_FABRICANTE = @REV_REP_FABRICANTE
                                WHERE REV_IND = @REV_IND"
                OnUpdated="sqlRevendas_Updated" OnInserted="sqlRevendas_Inserted">

                <InsertParameters>
                    <asp:Parameter Name="REV_RAZAOSOCIAL" Type="String" />
                    <asp:Parameter Name="REV_DISTRIBUIDORA" Type="String" />
                    <asp:Parameter Name="REV_IE" Type="String" />
                    <asp:Parameter Name="REV_FANTASIA" Type="String" />
                    <asp:Parameter Name="REV_LOGRADOURO" Type="String" />
                    <asp:Parameter Name="REV_NUMERO" Type="String" />
                    <asp:Parameter Name="REV_COMPLEMENTO" Type="String" />
                    <asp:Parameter Name="REV_CEP" Type="String" />
                    <asp:Parameter Name="REV_BAIRRO" Type="String" />
                    <asp:Parameter Name="REV_CIDADE" Type="String" />
                    <asp:Parameter Name="REV_UF" Type="String" />
                    <asp:Parameter Name="REV_CONTATO" Type="String" />
                    <asp:Parameter Name="REV_DDD" Type="Int32" />
                    <asp:Parameter Name="REV_TELEFONE" Type="String" />
                    <asp:Parameter Name="REV_SKYPE" Type="String" />
                    <asp:Parameter Name="REV_TELEFONE2_DDD" Type="String" />
                    <asp:Parameter Name="REV_TELEFONE2" Type="String" />
                    <asp:Parameter Name="REV_CEL_DDD" Type="String" />
                    <asp:Parameter Name="REV_CELULAR" Type="String" />
                    <asp:Parameter Name="REV_EMAIL" Type="String" />
                    <asp:Parameter Name="REV_EMAIL2" Type="String" />
                    <asp:Parameter Name="REV_EMAIL3" Type="String" />
                    <asp:Parameter Name="REV_STATUS" Type="Int32" />
                    <asp:Parameter Name="REV_COBRAR_CLIENTES" Type="Int32" />
                    <asp:Parameter Name="REV_OBS" Type="String" />
                    <asp:Parameter Name="REV_REP_FABRICANTE" Type="Int32" />
                </InsertParameters>

                <SelectParameters>
                    <asp:QueryStringParameter Name="REV_IND" QueryStringField="ind" Type="Int32" />
                </SelectParameters>

                <UpdateParameters>
                    <asp:Parameter Name="REV_RAZAOSOCIAL" Type="String" />
                    <asp:Parameter Name="REV_DISTRIBUIDORA" Type="String" />
                    <asp:Parameter Name="REV_IE" Type="String" />
                    <asp:Parameter Name="REV_FANTASIA" Type="String" />
                    <asp:Parameter Name="REV_LOGRADOURO" Type="String" />
                    <asp:Parameter Name="REV_NUMERO" Type="String" />
                    <asp:Parameter Name="REV_COMPLEMENTO" Type="String" />
                    <asp:Parameter Name="REV_CEP" Type="String" />
                    <asp:Parameter Name="REV_BAIRRO" Type="String" />
                    <asp:Parameter Name="REV_CIDADE" Type="String" />
                    <asp:Parameter Name="REV_UF" Type="String" />
                    <asp:Parameter Name="REV_CONTATO" Type="String" />
                    <asp:Parameter Name="REV_DDD" Type="Int32" />
                    <asp:Parameter Name="REV_TELEFONE" Type="String" />
                    <asp:Parameter Name="REV_SKYPE" Type="String" />
                    <asp:Parameter Name="REV_TELEFONE2_DDD" Type="String" />
                    <asp:Parameter Name="REV_TELEFONE2" Type="String" />
                    <asp:Parameter Name="REV_CEL_DDD" Type="String" />
                    <asp:Parameter Name="REV_CELULAR" Type="String" />
                    <asp:Parameter Name="REV_EMAIL" Type="String" />
                    <asp:Parameter Name="REV_EMAIL2" Type="String" />
                    <asp:Parameter Name="REV_EMAIL3" Type="String" />
                    <asp:Parameter Name="REV_STATUS" Type="Int32" />
                    <asp:Parameter Name="REV_COBRAR_CLIENTES" Type="Int32" />
                    <asp:Parameter Name="REV_OBS" Type="String" />
                    <asp:Parameter Name="REV_REP_FABRICANTE" Type="Int32" />
                    <asp:QueryStringParameter Name="REV_IND" QueryStringField="ind" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlEstados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT EST_SIGLA, EST_NOME FROM Estados"></asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlAssepontoUsuariosRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                DeleteCommand="DELETE FROM AssepontoUsuariosRevendas WHERE USUREV_IND = @USUREV_IND"
                SelectCommand="SELECT USUREV_IND, USUREV_LOGIN, USUREV_EMAIL_ENVIO_SENHA, USUREV_EMAIL_ENVIO_SENHA2, USUREV_DATA_ENVIO_SENHA, USUREV_ULTIMO_ACESSO
                FROM AssepontoUsuariosRevendas
                WHERE (USUREV_REVENDA = @USUREV_REVENDA) 
                ORDER BY USUREV_LOGIN">
                <DeleteParameters>
                    <asp:Parameter Name="USUREV_IND" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="USUREV_REVENDA" QueryStringField="ind" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlRepFabricante" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT * FROM AssepontoRepFabricantes WHERE NOT EXISTS (SELECT * FROM AssepontoRevendasReps WHERE REVREP_REVENDA = @REVREP_REVENDA AND REVREP_REP = FABR_COD ) ORDER BY FABR_NOME">
                <SelectParameters>
                    <asp:QueryStringParameter Name="REVREP_REVENDA" Type="Int32" QueryStringField="ind" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlREP" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="Select * FROM assecont1.dbo.AssepontoRevendasReps
                                        INNER JOIN assecont1.dbo.AssepontoRevendas ON AssepontoRevendas.REV_IND = AssepontoRevendasReps.REVREP_REVENDA
                                        INNER JOIN assecont1.dbo.AssepontoRepFabricantes ON AssepontoRevendasReps.REVREP_REP = AssepontoRepFabricantes.FABR_COD
                                        WHERE REVREP_REVENDA = @REV_IND ">
                <DeleteParameters>
                    <asp:Parameter Name="REVREP_IND" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="REV_IND" QueryStringField="ind" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
