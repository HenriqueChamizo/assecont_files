<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ForaMasterPage.Master" AutoEventWireup="true" CodeBehind="FormPedidoCliFinal.aspx.cs" Inherits="Asseponto.Suporte.Formulario.FormPedidoCliFinal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:FormView ID="FvClienteFinal" runat="server" DataKeyNames="PED_IND" DefaultMode="Insert" OnDataBound="FvClienteFinal_DataBound" DataSourceID="sqlPedidosRevendas">
                <InsertItemTemplate>
                    <asp:Panel ID="Panel1" runat="server" EnableViewState="false">
                        <table class="formviewtable">
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Razão Social<br />
                                                <asp:TextBox ID="PED_CLI_RAZAO" runat="server" Text='<%# Bind("PED_CLI_RAZAO") %>'
                                                    Width="400px" MaxLength="100" notnull="true" />
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
                                                    ID="txtCNPJ" Text='<%# Bind("PED_CLI_CNPJ") %>' MaxLength="20">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Fantasia<br />
                                                <asp:TextBox ID="PED_FANTASIA" runat="server" Text='<%# Bind("PED_FANTASIA") %>'
                                                    MaxLength="100" />
                                            </td>
                                            <td>Inscrição Estadual<br />
                                                <asp:TextBox ID="PED_CLI_IE" runat="server" Text='<%# Bind("PED_CLI_IE") %>' MaxLength="20" />
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
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td colspan="2">
                                                <b>Pessoa Física</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="RadMaskedTextBox">CPF<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="###.###.###-##" Mask="###.###.###-##"
                                                    ID="txtCPF" Text='<%# Bind("PED_CLI_CPF") %>' MaxLength="12">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>
                                                <br />
                                                <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="CNPJ ou CPF já existe no nosso cadastro"
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
                                                    Width="250px" MaxLength="100" notnull="true" />
                                            </td>
                                            <td>Número<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="########" Mask="########" Width="100px"
                                                    ID="PED_CLI_ENDERECO_NUMERO" Text='<%# Bind("PED_CLI_ENDERECO_NUMERO") %>' MaxLength="8">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Complemento<br />
                                                <asp:TextBox ID="PED_CLI_ENDERECO_COMPLEMENTO" runat="server" Text='<%# Bind("PED_CLI_ENDERECO_COMPLEMENTO") %>'
                                                    Width="200px" MaxLength="100" />
                                            </td>
                                            <td>Bairro<br />
                                                <asp:TextBox ID="PED_CLI_BAIRRO" runat="server" Text='<%# Bind("PED_CLI_BAIRRO") %>'
                                                    Width="200px" MaxLength="100" notnull="true" />
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
                                                    Width="200px" MaxLength="100" notnull="true" />
                                            </td>
                                            <td>CEP<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###-###" Mask="##.###-###"
                                                    ID="PED_CLI_CEP" Width="80px" Text='<%# Bind("PED_CLI_CEP") %>' MaxLength="8">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>UF<br />
                                                <telerik:RadComboBox ID="PED_CLI_UF" runat="server" Skin="flv" EnableEmbeddedSkins="false" Height="150"
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
                                                    Width="170px" MaxLength="100" notnull="true" />
                                            </td>
                                            <td>DDD<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##" Width="90px"
                                                    ID="PED_CLI_TELEFONE_DDD" notnull="true" Text='<%# Bind("PED_CLI_TELEFONE_DDD") %>' MaxLength="2">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Telefone<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##########" Mask="##########" Width="180px"
                                                    ID="PED_CLI_TELEFONE" notnull="true" Text='<%# Bind("PED_CLI_TELEFONE") %>' MaxLength="10">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>SKYPE<br />
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
                                            <td>E-mail do responsável pelo sistema<br />
                                                <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("PED_CLI_EMAIL") %>'
                                                    Width="200px" MaxLength="100" notnull="true" /><br />
                                                <div style="text-align: right">
                                                    <asp:RegularExpressionValidator ID="RegularExpressionEMAIL" runat="server" CssClass="sitevalidator2"
                                                        ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                                </div>
                                            </td>
                                            <td>Outro e-mail do responsável pelo sistema<br />
                                                <asp:TextBox ID="txtEmail2" runat="server" Text='<%# Bind("PED_EMAIL2") %>'
                                                    Width="200px" MaxLength="100" /><br />
                                                <div style="text-align: right">
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" CssClass="sitevalidator2"
                                                        ControlToValidate="txtEmail2" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            </tr>
                            <tr>
                                <td><b>Número de Funcionários na empresa: </b>
                                    <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server" DbValue='<%# Bind("PED_CLI_QTD_FUNCIONA") %>'
                                        Width="50px" MaxLength="4" Skin="Wr" EnableEmbeddedSkins="false" Display="True"
                                        notnull="true">
                                        <NumberFormat AllowRounding="False" ZeroPattern="n" />
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="formviewsubtitle">Dados do REP (Relógio de ponto)</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Fabricante do REP<br />
                                                <telerik:RadComboBox ID="PED_REP_FABRICANTE" runat="server" OnDataBinding="RadComboBox2_DataBinding"
                                                    Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione o REP" SelectedValue='<%# Bind("PED_REP_FABRICANTE") %>'
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
                                    <span class="formviewsubtitle">Dados da Revenda</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Nome da Revenda<br />
                                                <asp:TextBox ID="txtRevenda" runat="server" Text='<%# Bind("PED_REVENDA") %>'
                                                    Width="250" />
                                            </td>
                                            <td>Contato da Revenda<br />
                                                <asp:TextBox ID="txtContatoRevenda" runat="server" Text='<%# Bind("PED_REV_CONTATO") %>'
                                                    MaxLength="150" />
                                            </td>
                                            <td>Telefone da Revenda<br />
                                                  <telerik:RadMaskedTextBox runat="server" DisplayMask="############" Mask="############" Width="180px"
                                                    ID="txtTelRevenda" Text='<%# Bind("PED_REV_TEL") %>' MaxLength="12">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">E-mail da Revenda<br />
                                                <asp:TextBox ID="txtEmailRevenda" runat="server" Text='<%# Bind("PED_REV_EMAIL") %>'
                                                    Width="300" />
                                            </td>

                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="btSalvar" CommandName="Insert" runat="server" CssClass="sitebutton">
                                        Enviar Cadastro
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </InsertItemTemplate>
            </asp:FormView>
        </div>
        <asp:SqlDataSource ID="sqlPedidosRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            InsertCommand="INSERT INTO AssepontoPedidosRevendas(PED_REV_IND , PED_CLI_RAZAO , PED_CLI_CNPJ , PED_CLI_CPF, PED_CLI_IE , PED_CLI_ENDERECO , PED_DATA,
                                                                PED_CLI_ENDERECO_NUMERO, PED_CLI_ENDERECO_COMPLEMENTO, PED_CLI_CEP , PED_CLI_BAIRRO , PED_CLI_CIDADE , 
                                                                PED_CLI_UF , PED_CLI_EMAIL , PED_SKYPE, PED_CLI_TELEFONE , PED_CLI_TELEFONE_DDD, PED_CLI_QTD_FUNCIONA, 
                                                                PED_CLI_CONTATO , PED_VERSAO_AQUISICAO , PED_COM_MANUTENCAO , PED_MODELOREP , PED_REPINSTALADO, PED_DESCRICAO,
                                                                PED_SOLICITANTE , PED_REP_FABRICANTE , PED_FANTASIA , PED_STATUS, PED_EMAIL2, PED_ASSEPONTO4, PED_ASSEFIN,
                                                                PED_REVENDA, PED_REV_CONTATO, PED_REV_TEL, PED_REV_EMAIL) 
                                                    VALUES (@PED_REV_IND, @PED_CLI_RAZAO, @PED_CLI_CNPJ, @PED_CLI_CPF, @PED_CLI_IE, @PED_CLI_ENDERECO, GETDATE(),
                                                            @PED_CLI_ENDERECO_NUMERO, @PED_CLI_ENDERECO_COMPLEMENTO, @PED_CLI_CEP, @PED_CLI_BAIRRO, @PED_CLI_CIDADE, 
                                                            @PED_CLI_UF, @PED_CLI_EMAIL, @PED_SKYPE, @PED_CLI_TELEFONE, @PED_CLI_TELEFONE_DDD, @PED_CLI_QTD_FUNCIONA, 
                                                            @PED_CLI_CONTATO, 2, 0, @PED_MODELOREP, @PED_REPINSTALADO, 'CLIENTE FINAL',
                                                            'CLIENTE FINAL', @PED_REP_FABRICANTE, @PED_FANTASIA, 1, @PED_EMAIL2, 1, 0,
                                                            @PED_REVENDA, @PED_REV_CONTATO, @PED_REV_TEL, @PED_REV_EMAIL)"
            OnInserted="sqlPedidosRevendas_Inserted" InsertCommandType="Text">

            <InsertParameters>
                <asp:Parameter Name="PED_REV_IND" />
                <asp:Parameter Name="PED_CLI_RAZAO" />
                <asp:Parameter Name="PED_CLI_CNPJ" />
                <asp:Parameter Name="PED_CLI_CPF" />
                <asp:Parameter Name="PED_CLI_IE" />
                <asp:Parameter Name="PED_CLI_ENDERECO" />
                <asp:Parameter Name="PED_CLI_ENDERECO_NUMERO" />
                <asp:Parameter Name="PED_CLI_ENDERECO_COMPLEMENTO" />
                <asp:Parameter Name="PED_SOLICITANTE" />
                <asp:Parameter Name="PED_CLI_CEP" />
                <asp:Parameter Name="PED_CLI_BAIRRO" />
                <asp:Parameter Name="PED_CLI_CIDADE" />
                <asp:Parameter Name="PED_CLI_UF" />
                <asp:Parameter Name="PED_CLI_EMAIL" />
                <asp:Parameter Name="PED_SKYPE" />
                <asp:Parameter Name="PED_CLI_TELEFONE" />
                <asp:Parameter Name="PED_CLI_TELEFONE_DDD" />
                <asp:Parameter Name="PED_CLI_QTE_FUNCIONA" />
                <asp:Parameter Name="PED_CLI_CONTATO" />
                <asp:Parameter Name="PED_VERSAO_AQUISICAO" />
                <asp:Parameter Name="PED_COM_MANUTENCAO" />
                <asp:Parameter Name="PED_MODELOREP" />
                <asp:Parameter Name="PED_REPINSTALADO" DefaultValue="0" />
                <asp:Parameter Name="PED_DATA" />
                <asp:Parameter Name="PED_REP_FABRICANTE" />
                <asp:Parameter Name="PED_FANTASIA" />
                <asp:Parameter Name="PED_STATUS" />
                <asp:Parameter Name="PED_CLI_QTD_FUNCIONA" />
                <asp:Parameter Name="PED_EMAIL2" />
                <asp:Parameter Name="PED_ASSEFIN" />
                <asp:Parameter Name="PED_ASSEPONTO4" />
                <asp:Parameter Name="PED_REVENDA" />
                <asp:Parameter Name="PED_REV_CONTATO" />
                <asp:Parameter Name="PED_REV_TEL" />
                <asp:Parameter Name="PED_REV_EMAIL" />
            </InsertParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlAssepontoRepFabricantes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT [FABR_NOME], [FABR_COD], [FABR_ATIVO] FROM [AssepontoRepFabricantes] WHERE ([FABR_ATIVO] = 1) ORDER BY [FABR_NOME]"></asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlEstados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT [EST_SIGLA], [EST_NOME] FROM [Estados]"></asp:SqlDataSource>
    </div>
</asp:Content>
