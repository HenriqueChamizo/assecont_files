<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ForaMasterPage.Master"
    AutoEventWireup="true" CodeBehind="CadastroRevendas.aspx.cs" Inherits="Asseponto.Revenda.Cadastro.CadastroRevendas" %>

<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpoboxinner">
        <asp:Panel ID="hiddenStatus" runat="server" EnableViewState="false">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="CADP_REV_IND" DataSourceID="sqlRevendas" Width="500px" OnDataBound="FormView1_DataBound1">
                <EditItemTemplate>
                    <span class="formviewsubtitle">DADOS DA EMPRESA</span>
                    <br />
                    <br />
                    <table>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>Razão Social<br />
                                            <asp:TextBox ID="CADP_REV_RAZAOSOCIAL" runat="server" Text='<%# Bind("CADP_REV_RAZAOSOCIAL") %>'
                                                Width="340px" notnull="true"></asp:TextBox>

                                        </td>
                                        <td>Distribuidora<br />
                                            <asp:TextBox ID="CADP_REV_DISTRIBUIDORA" runat="server" Text='<%# Bind("CADP_REV_DISTRIBUIDORA") %>'
                                                Width="300px" notnull="true" />
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
                                                ID="CADP_REV_CNPJ" Text='<%# Bind("CADP_REV_CNPJ") %>' MaxLength="20" Width="115px">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                        <td>Inscrição Estadual<br />
                                            <telerik:RadMaskedTextBox runat="server" DisplayMask="############" Mask="############"
                                                ID="CADP_REV_IE" Width="130px" Text='<%# Bind("CADP_REV_IE") %>' MaxLength="12">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                        <td>Fantasia<br />
                                            <asp:TextBox ID="CADP_REV_FANTASIA" runat="server" Text='<%# Bind("CADP_REV_FANTASIA") %>'
                                                Width="300px" />
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
                                                ID="CADP_REV_CPF" Text='<%# Bind("CADP_REV_CPF") %>' MaxLength="12">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                        <td>
                                            <br />
                                            <asp:CustomValidator ID="Customv_LGIN_CPF" runat="server" ErrorMessage="Informar Pessoa Fisica ou Juridica"
                                                CssClass="sitevalidator2" OnServerValidate="Customv_LGIN_CPF_ServerValidate"></asp:CustomValidator>
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
                                            <asp:TextBox ID="CADP_REV_LOGRADOURO" runat="server" Text='<%# Bind("CADP_REV_LOGRADOURO") %>'
                                                Width="300px" notnull="true" />
                                        </td>
                                        <td>Nº<br />
                                            <asp:TextBox ID="CADP_REV_NUMERO" runat="server" Text='<%# Bind("CADP_REV_NUMERO") %>'
                                                Width="50px" notnull="true" />
                                        </td>
                                        <td>Complemento<br />
                                            <asp:TextBox ID="CADP_REV_COMPLEMENTO" runat="server" Text='<%# Bind("CADP_REV_COMPLEMENTO") %>'
                                                Width="150px" />
                                        </td>
                                        <td>CEP<br />
                                            <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###-###" Mask="##.###-###" notnull="true"
                                                ID="CADP_REV_CEP" Text='<%# Bind("CADP_REV_CEP") %>' Width="70px" MaxLength="8">
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
                                            <asp:TextBox ID="CADP_REV_BAIRRO" runat="server" Text='<%# Bind("CADP_REV_BAIRRO") %>'
                                                Width="200px" notnull="true" />
                                        </td>
                                        <td>Cidade<br />
                                            <asp:TextBox ID="CADP_REV_CIDADE" runat="server" Text='<%# Bind("CADP_REV_CIDADE") %>'
                                                Width="200px" notnull="true" />
                                        </td>
                                        <td>UF<br />
                                            <telerik:RadComboBox ID="CADP_REV_UF" runat="server" Skin="flv" EnableEmbeddedSkins="false"
                                                OnDataBinding="RadComboBox1_DataBinding" Widht="150px" EmptyMessage="Selecione o Estado"
                                                SelectedValue='<%# Bind("CADP_REV_UF") %>' notnull="true">
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
                                        <td>Contato<br />
                                            <asp:TextBox ID="CADP_REV_CONTATO" runat="server" Text='<%# Bind("CADP_REV_CONTATO") %>'
                                                Width="200px" notnull="true" />
                                        </td>
                                        <td>DDD<br />
                                            <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##" notnull="true"
                                                ID="CADP_REV_DDD" Text='<%# Bind("CADP_REV_DDD") %>' Width="50px" MaxLength="2">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                        <td>Telefone<br />
                                            <telerik:RadMaskedTextBox runat="server" DisplayMask="########" Mask="########" notnull="true"
                                                ID="CADP_REV_TELEFONE" Text='<%# Bind("CADP_REV_TELEFONE") %>' Width="130px" MaxLength="8">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                        <td>Skype/MSN<br />
                                            <asp:TextBox ID="CADP_REV_SKYPE" runat="server" Text='<%# Bind("CADP_REV_SKYPE") %>'
                                                Width="150px" MaxLength="50" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td style="width: 50px;">DDD<br />
                                            <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##"
                                                ID="txtCelularDDD" Text='<%# Bind("CADP_REV_CEL_DDD") %>' Width="50px" MaxLength="2">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                        <td>Celular<br />
                                            <telerik:RadMaskedTextBox runat="server" DisplayMask="#########" Mask="#########"
                                                ID="txtCelular" Text='<%# Bind("CADP_REV_CELULAR") %>' Width="130px" MaxLength="10">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                        <%--              <td>Revenda?<br />
                                            <asp:RadioButtonList ID="CADP_REV_STATUS" runat="server" RepeatDirection="Horizontal"
                                                RepeatLayout="Flow" SelectedValue='<%# Bind("CADP_REV_STATUS") %>' notnull="true">
                                                <asp:ListItem Value="0">GOLD</asp:ListItem>
                                                <asp:ListItem Value="1">PREMIUM</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>--%>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>E-mail<br />
                                            <asp:TextBox ID="CADP_REV_EMAIL" runat="server" Text='<%# Bind("CADP_REV_EMAIL") %>'
                                                Width="250px" notnull="true" />
                                            <asp:RegularExpressionValidator ID="RegularExpressionEMAIL" runat="server" CssClass="sitevalidator"
                                                Display="Dynamic" ControlToValidate="CADP_REV_EMAIL" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                        </td>
                                        <td>E-mail2<br />
                                            <asp:TextBox ID="txtRevEmail2" runat="server" Text='<%# Bind("CADP_REV_EMAIL2") %>'
                                                Width="250px" />
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" CssClass="sitevalidator"
                                                Display="Dynamic" ControlToValidate="CADP_REV_EMAIL" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                        </td>

                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>Login(Somente Letras e Números)<br />
                                            <asp:TextBox ID="CADP_REV_LOGIN" runat="server" Text='<%# Bind("CADP_REV_LOGIN") %>'
                                                Width="200px" notnull="true" MaxLength="25">
                                            </asp:TextBox>
                                            <br />
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                            <asp:CustomValidator ID="CustomValidatorLOGIN" runat="server" ErrorMessage="Login Já Existente"
                                                CssClass="sitevalidator2" ControlToValidate="CADP_REV_LOGIN" OnServerValidate="CustomValidatorLOGIN_ServerValidate"></asp:CustomValidator>
                                        </td>
                                        <td>
                                            <br />
                                            <asp:CustomValidator ID="CustomValidatorCNPJ" runat="server" ErrorMessage="CNPJ JÁ EXISTENTE"
                                                CssClass="sitevalidator2" OnServerValidate="CustomValidatorCNPJ_ServerValidate"></asp:CustomValidator>
                                        </td>
                                        <td>
                                            <br />
                                            <asp:CustomValidator ID="CustomValidatorCPF" runat="server" ErrorMessage="CPF JÁ EXISTENTE"
                                                CssClass="sitevalidator2" OnServerValidate="CustomValidatorCPF_ServerValidate"></asp:CustomValidator>

                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:LinkButton ID="btSalvarCadastro" runat="server" CssClass="sitebutton" CommandName="Insert">Salvar</asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
            </asp:FormView>
        </asp:Panel>
        <asp:Panel ID="Panel2" runat="server">
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
                                    <asp:LinkButton ID="lbAdd" runat="server" CssClass="sitebutton" OnClick="lbAdd_Click1"> Adicionar</asp:LinkButton>
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
                                DataKeyNames="CADP_REVREP_IND">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="CADP_REVREP_IND" Display="false" HeaderText="ID"
                                        UniqueName="CADP_REVREP_IND" SortExpression="CADP_REVREP_IND">
                                        <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="FABR_NOME" HeaderText="Nome" UniqueName="FABR_NOME"
                                        SortExpression="FABR_NOME">
                                        <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn HeaderText="Remover">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" Text="Remover" OnClick="LinkButton1_Click"
                                                CommandArgument='<%# Eval("CADP_REVREP_IND") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </td>
                </tr>
            </table>
            <div id="sitecorpoboxbottom" runat="server" class="sitecorpoboxbottom">
                <asp:LinkButton ID="btConcluir" runat="server" CssClass="sitebutton" OnClick="btConcluir_Click">Concluir Cadastro</asp:LinkButton>
            </div>
        </asp:Panel>
        <asp:SqlDataSource ID="sqlRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT * FROM AssepontoRevendasProvisorios WHERE (CADP_REV_IND = @CADP_REV_IND)"
            DeleteCommand="DELETE FROM AssepontoRevendasProvisorios WHERE CADP_REV_IND = @CADP_REV_IND"
            InsertCommand="INSERT INTO AssepontoRevendasProvisorios (CADP_REV_EMAIL2, CADP_REV_RAZAOSOCIAL, CADP_REV_FANTASIA, CADP_REV_CNPJ, CADP_REV_IE, CADP_REV_TELEFONE, CADP_REV_EMAIL, CADP_REV_CONTATO, CADP_REV_LOGRADOURO,
                             CADP_REV_BAIRRO, CADP_REV_CIDADE, CADP_REV_UF, CADP_REV_CEP, CADP_REV_DISTRIBUIDORA, CADP_REV_DDD, CADP_REV_COMPLEMENTO, CADP_REV_NUMERO, CADP_REV_SKYPE, CADP_REV_STATUS, CADP_REV_LIBERADOEM, 
                             CADP_REV_LOGIN, CADP_REV_CPF, CADP_REV_CEL_DDD, CADP_REV_CELULAR) VALUES (@CADP_REV_EMAIL2, @CADP_REV_RAZAOSOCIAL, @CADP_REV_FANTASIA, @CADP_REV_CNPJ, @CADP_REV_IE, @CADP_REV_TELEFONE, @CADP_REV_EMAIL, @CADP_REV_CONTATO, @CADP_REV_LOGRADOURO, @CADP_REV_BAIRRO, 
                            @CADP_REV_CIDADE, @CADP_REV_UF, @CADP_REV_CEP, @CADP_REV_DISTRIBUIDORA, @CADP_REV_DDD, @CADP_REV_COMPLEMENTO, @CADP_REV_NUMERO, @CADP_REV_SKYPE, 0, 0, @CADP_REV_LOGIN, @CADP_REV_CPF,
                            @CADP_REV_CEL_DDD, @CADP_REV_CELULAR)"
            OnInserted="sqlRevendas_Inserted">
            <DeleteParameters>
                <asp:QueryStringParameter Name="CADP_REV_IND" QueryStringField="ind" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="CADP_REV_IND" QueryStringField="ind" Type="Int32" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="CADP_REV_RAZAOSOCIAL" Type="String" />
                <asp:Parameter Name="CADP_REV_FANTASIA" Type="String" />
                <asp:Parameter Name="CADP_REV_CNPJ" Type="String" />
                <asp:Parameter Name="CADP_REV_IE" Type="String" />
                <asp:Parameter Name="CADP_REV_TELEFONE" Type="String" />
                <asp:Parameter Name="CADP_REV_EMAIL" Type="String" />
                <asp:Parameter Name="CADP_REV_EMAIL2" Type="String" />
                <asp:Parameter Name="CADP_REV_CONTATO" Type="String" />
                <asp:Parameter Name="CADP_REV_LOGRADOURO" Type="String" />
                <asp:Parameter Name="CADP_REV_BAIRRO" Type="String" />
                <asp:Parameter Name="CADP_REV_CIDADE" Type="String" />
                <asp:Parameter Name="CADP_REV_UF" Type="String" />
                <asp:Parameter Name="CADP_REV_CEP" Type="String" />
                <asp:Parameter Name="CADP_REV_DISTRIBUIDORA" Type="String" />
                <asp:Parameter Name="CADP_REV_DDD" Type="Int32" />
                <asp:Parameter Name="CADP_REV_COMPLEMENTO" Type="String" />
                <asp:Parameter Name="CADP_REV_NUMERO" Type="String" />
                <asp:Parameter Name="CADP_REV_SKYPE" Type="String" />
                <asp:Parameter Name="CADP_REV_STATUS" Type="Byte" />
                <asp:Parameter Name="CADP_REV_LIBERADOEM" Type="Int32" />
                <asp:Parameter Name="CADP_REV_LOGIN" Type="String" />
                <asp:Parameter Name="CADP_REV_CPF" Type="String" />
                <asp:Parameter Name="CADP_REV_CEL_DDD" Type="String" />
                <asp:Parameter Name="CADP_REV_CELULAR" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlEstados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT [EST_SIGLA], [EST_NOME] FROM [Estados]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlRepFabricante" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT * FROM [AssepontoRepFabricantes] WHERE NOT EXISTS (SELECT * FROM AssepontoRevendasRepsProvisorios WHERE CADP_REVREP_REVENDA = @CADP_REVREP_REVENDA AND CADP_REVREP_REP = FABR_COD ) ORDER BY [FABR_NOME]">
            <SelectParameters>
                <asp:QueryStringParameter Name="CADP_REVREP_REVENDA" Type="Int32" QueryStringField="ind" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlREP" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="Select * FROM [assecont1].[dbo].[AssepontoRevendasRepsProvisorios]
                                        INNER JOIN [assecont1].[dbo].[AssepontoRevendasProvisorios] ON AssepontoRevendasProvisorios.CADP_REV_IND = AssepontoRevendasRepsProvisorios.CADP_REVREP_REVENDA
                                        INNER JOIN [assecont1].[dbo].[AssepontoRepFabricantes] ON AssepontoRevendasRepsProvisorios.CADP_REVREP_REP = AssepontoRepFabricantes.FABR_COD
                                        WHERE CADP_REVREP_REVENDA = @CADP_REV_IND ">
            <DeleteParameters>
                <asp:Parameter Name="CADP_REVREP_IND" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="CADP_REV_IND" QueryStringField="ind" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
