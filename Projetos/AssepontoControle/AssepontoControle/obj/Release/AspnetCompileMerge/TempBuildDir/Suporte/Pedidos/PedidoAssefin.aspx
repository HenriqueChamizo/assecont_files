<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="PedidoAssefin.aspx.cs" Inherits="Asseponto.Suporte.Pedidos.PedidoAssefin" %>

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
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="PED_IND" DataSourceID="sqlPedidosRevendas"
                OnDataBound="FormView1_DataBound">
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
                                                    ID="PED_CLI_CNPJ" Text='<%# Bind("PED_CLI_CNPJ") %>' MaxLength="20">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Inscrição Estadual<br />
                                                <asp:TextBox ID="PED_CLI_IE" runat="server" Text='<%# Bind("PED_CLI_IE") %>' MaxLength="20" />
                                            </td>
                                            <td>Fantasia<br />
                                                <asp:TextBox ID="PED_FANTASIA" runat="server" Text='<%# Bind("PED_FANTASIA") %>'
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
                                                    Width="250px" MaxLength="100" notnull="true" />
                                            </td>
                                            <td>Número<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="########" Mask="########"
                                                    ID="PED_CLI_ENDERECO_NUMERO" Text='<%# Bind("PED_CLI_ENDERECO_NUMERO") %>' MaxLength="8">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Complemento<br />
                                                <asp:TextBox ID="PED_CLI_ENDERECO_COMPLEMENTO" runat="server" Text='<%# Bind("PED_CLI_ENDERECO_COMPLEMENTO") %>'
                                                    Width="200px" MaxLength="100" />
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
                                                    Width="200px" MaxLength="100" notnull="true" />
                                            </td>
                                            <td>Cidade<br />
                                                <asp:TextBox ID="PED_CLI_CIDADE" runat="server" Text='<%# Bind("PED_CLI_CIDADE") %>'
                                                    Width="200px" MaxLength="100" notnull="true" />
                                            </td>
                                            <td>CEP<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###-###" Mask="##.###-###" notnull="true"
                                                    ID="PED_CLI_CEP" Width="80px" Text='<%# Bind("PED_CLI_CEP") %>' MaxLength="8">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>UF<br />
                                                <telerik:RadComboBox ID="PED_CLI_UF" runat="server" Skin="flv" EnableEmbeddedSkins="false"
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
                                                    ID="RadMaskedTextBox2" notnull="true" Text='<%# Bind("PED_CLI_CELULAR_DDD") %>' MaxLength="2">
                                                </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>Celular(Somente números)<br />
                                                <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########" Width="130px"
                                                    ID="RadMaskedTextBox3" notnull="true" Text='<%# Bind("PED_CLI_CELULAR") %>' MaxLength="10">
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
                                            <td style="color: red">Observações: O Email é do responsável<br />
                                                pelo sistema da empresa que consta neste cadastro.
                                            </td>
                                            <td>E-mail do responsável pelo sistema<br />
                                                <asp:TextBox ID="PED_CLI_EMAIL" runat="server" Text='<%# Bind("PED_CLI_EMAIL") %>'
                                                    Width="200px" MaxLength="100" notnull="true" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionEMAIL" runat="server" CssClass="sitevalidator"
                                                    Display="Dynamic" ControlToValidate="PED_CLI_EMAIL" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                            </td>
                                            <td>E-mail do responsável pelo sistema 2<br />
                                                <asp:TextBox ID="txtPED_EMAIL2" runat="server" Text='<%# Bind("PED_EMAIL2") %>'
                                                    Width="200px" MaxLength="100" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" CssClass="sitevalidator"
                                                    Display="Dynamic" ControlToValidate="txtPED_EMAIL2" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                    </table>
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
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>Com Manutenção?<br />
                                                <asp:RadioButtonList ID="PED_COM_MANUTENCAO" runat="server" RepeatDirection="Horizontal"
                                                    RepeatLayout="Flow" SelectedValue='<%# Bind("PED_COM_MANUTENCAO") %>' notnull="true">
                                                    <asp:ListItem Value="True">Sim</asp:ListItem>
                                                    <asp:ListItem Value="False">Não</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                            <td>Versão?<br />
                                                <telerik:RadComboBox ID="PED_ASSEF_VERSAO" runat="server" Width="215px" Skin="flv" EnableEmbeddedSkins="false"
                                                    OnDataBinding="RadComboBox3_DataBinding" EmptyMessage="Qual versão do Assefin?" SelectedValue='<%# Bind("PED_VERSAO_AQUISICAO") %>'
                                                    notnull="true">
                                                </telerik:RadComboBox>
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
            <%--<asp:Panel ID="panelObsPedido" runat="server">
                <asp:Label ID="labelTituloObsPedido" runat="server" Text="Implantação" CssClass="formviewsubtitle"></asp:Label><br />
                <asp:Label ID="labelSubTituloObsPedido" runat="server" Text="Observações para a Implantação"></asp:Label>
                <br />
                <asp:TextBox ID="ObsPedido" runat="server" Height="163px" TextMode="MultiLine" Width="532px" />
            </asp:Panel>--%>
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
        <asp:Label Visible="false" Text="" ID="lbErro" runat="server"></asp:Label>
        <asp:Label Visible="false" Text="" ID="lbErro2" runat="server"></asp:Label>
    </div>
    <asp:SqlDataSource ID="sqlPedidosRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT * FROM AssepontoPedidosRevendas WHERE (PED_IND = @PED_IND)"
        DeleteCommand="DELETE FROM AssepontoPedidosRevendas WHERE (PED_IND = @PED_IND)"
        InsertCommand="INSERT INTO AssepontoPedidosRevendas
        (PED_REV_IND , PED_CLI_RAZAO , PED_CLI_CNPJ , PED_CLI_CPF , PED_CLI_IE , PED_CLI_ENDERECO , PED_CLI_ENDERECO_NUMERO, PED_CLI_ENDERECO_COMPLEMENTO, PED_CLI_CEP, PED_CLI_BAIRRO, 
        PED_CLI_CIDADE , PED_CLI_UF , PED_CLI_EMAIL , PED_SKYPE, PED_CLI_TELEFONE , PED_CLI_TELEFONE_DDD, PED_CLI_QTD_FUNCIONA , PED_CLI_CONTATO, PED_COM_MANUTENCAO , 
        PED_MODELOREP , PED_REPINSTALADO , PED_DESCRICAO , PED_SOLICITANTE , PED_REP_FABRICANTE, PED_FANTASIA , PED_STATUS, PED_VERSAO_AQUISICAO, PED_EMAIL2, PED_ASSEPONTO4, PED_ASSEFIN,
        PED_CLI_TELEFONE2, PED_CLI_TELEFONE2_DDD, PED_CLI_CELULAR, PED_CLI_CELULAR_DDD, PED_CLI_CELULAR_ACEITA)         
        VALUES 
        (@PED_REV_IND, @PED_CLI_RAZAO, @PED_CLI_CNPJ, @PED_CLI_CPF, @PED_CLI_IE, @PED_CLI_ENDERECO, @PED_CLI_ENDERECO_NUMERO, @PED_CLI_ENDERECO_COMPLEMENTO, @PED_CLI_CEP, @PED_CLI_BAIRRO, 
        @PED_CLI_CIDADE, @PED_CLI_UF, @PED_CLI_EMAIL, @PED_SKYPE, @PED_CLI_TELEFONE, @PED_CLI_TELEFONE_DDD, @PED_CLI_QTD_FUNCIONA, @PED_CLI_CONTATO, @PED_COM_MANUTENCAO, 
        @PED_MODELOREP, @PED_REPINSTALADO, @PED_DESCRICAO, @PED_SOLICITANTE, @PED_REP_FABRICANTE, @PED_FANTASIA, @PED_STATUS, @PED_VERSAO_AQUISICAO, @PED_EMAIL2, 0, 1,
        @PED_CLI_TELEFONE2, @PED_CLI_TELEFONE2_DDD, @PED_CLI_CELULAR, @PED_CLI_CELULAR_DDD, @PED_CLI_CELULAR_ACEITA)"
        OnInserted="sqlPedidosRevendas_Inserted">

        <DeleteParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="PED_IND" QueryStringField="ind"
                Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="PED_IND" QueryStringField="ind"
                Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:FormParameter Name="PED_REV_IND" FormField="PED_REV_IND" />
            <asp:FormParameter Name="PED_CLI_RAZAO" FormField="PED_CLI_RAZAO" />
            <asp:FormParameter Name="PED_CLI_CNPJ" FormField="PED_CLI_CNPJ" />
            <asp:FormParameter Name="PED_CLI_CPF" FormField="PED_CLI_CPF" />
            <asp:FormParameter Name="PED_CLI_IE" FormField="PED_CLI_IE" />
            <asp:FormParameter Name="PED_CLI_ENDERECO" FormField="PED_CLI_ENDERECO" />
            <asp:FormParameter Name="PED_CLI_ENDERECO_NUMERO" FormField="PED_CLI_ENDERECO_NUMERO" />
            <asp:FormParameter Name="PED_CLI_ENDERECO_COMPLEMENTO" FormField="PED_CLI_ENDERECO_COMPLEMENTO" />
            <asp:FormParameter Name="PED_CLI_CEP" FormField="PED_CLI_CEP" />
            <asp:FormParameter Name="PED_CLI_BAIRRO" FormField="PED_CLI_BAIRRO" />
            <asp:FormParameter Name="PED_CLI_CIDADE" FormField="PED_CLI_CIDADE" />
            <asp:FormParameter Name="PED_CLI_UF" FormField="PED_CLI_UF" />
            <asp:FormParameter Name="PED_CLI_EMAIL" FormField="PED_CLI_EMAIL" />
            <asp:FormParameter Name="PED_SKYPE" FormField="PED_SKYPE" />
            <asp:FormParameter Name="PED_CLI_TELEFONE" FormField="PED_CLI_TELEFONE" />
            <asp:FormParameter Name="PED_CLI_TELEFONE_DDD" FormField="PED_CLI_TELEFONE_DDD" />
            <asp:FormParameter Name="PED_CLI_CELULAR" FormField="PED_CLI_CELULAR" />
            <asp:FormParameter Name="PED_CLI_CELULAR_ACEITA" FormField="PED_CLI_CELULAR_ACEITA" />
            <asp:FormParameter Name="PED_CLI_CELULAR_DDD" FormField="PED_CLI_CELULAR_DDD" />
            <asp:FormParameter Name="PED_CLI_TELEFONE2" FormField="PED_CLI_TELEFONE2" />
            <asp:FormParameter Name="PED_CLI_TELEFONE2_DDD" FormField="PED_CLI_TELEFONE2_DDD" />
            <asp:FormParameter Name="PED_CLI_QTE_FUNCIONA" FormField="PED_CLI_QTE_FUNCIONA" />
            <asp:FormParameter Name="PED_CLI_CONTATO" FormField="PED_CLI_CONTATO" />
            <asp:FormParameter Name="PED_COM_MANUTENCAO" FormField="PED_COM_MANUTENCAO" />
            <asp:FormParameter Name="PED_MODELOREP" FormField="PED_MODELOREP" />
            <asp:FormParameter Name="PED_REPINSTALADO" FormField="PED_REPINSTALADO" />
            <asp:FormParameter Name="PED_DATA" FormField="PED_DATA" />
            <asp:FormParameter Name="PED_SOLICITANTE" FormField="PED_SOLICITANTE" />
            <asp:FormParameter Name="PED_REP_FABRICANTE" FormField="PED_REP_FABRICANTE" />
            <asp:FormParameter Name="PED_FANTASIA" FormField="PED_FANTASIA" />
            <asp:FormParameter Name="PED_STATUS" FormField="PED_STATUS" />
            <asp:FormParameter Name="PED_DESCRICAO" FormField="PED_DESCRICAO" />
            <asp:FormParameter Name="PED_VERSAO_AQUISICAO" FormField="PED_VERSAO_AQUISICAO" />
            <asp:FormParameter Name="PED_CLI_QTD_FUNCIONA" FormField="PED_CLI_QTD_FUNCIONA" />
            <asp:FormParameter Name="PED_EMAIL2" FormField="PED_EMAIL2" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLAssefinVersoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT * FROM [AssepontoAssefinVersoes] WHERE [VER_ASSEF_ATIVO] = 1 ORDER BY [VER_ASSEF_NOME]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlEstados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [EST_SIGLA], [EST_NOME] FROM [Estados]"></asp:SqlDataSource>
</asp:Content>
