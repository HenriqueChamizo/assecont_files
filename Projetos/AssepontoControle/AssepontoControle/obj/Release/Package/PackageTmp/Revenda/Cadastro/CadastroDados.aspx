<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true"
    CodeBehind="CadastroDados.aspx.cs" Inherits="Asseponto.Revenda.Cadastro.CadastroDados" %>

<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="False"
            Width="100%" OnItemClick="RadMenu2_ItemClick">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Dados do REP" NavigateUrl="#">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div id="sitecorpoboxinner">
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="REV_IND" DataSourceID="sqlRevendas" DefaultMode="Edit"
                        OnDataBound="FormView1_DataBound">
                        <EditItemTemplate>
                            <asp:Panel ID="Panel1" runat="server" EnableViewState="false">
                                <table class="formviewtable">
                                    <tr>
                                        <td>
                                            <table class="formviewtableinner">
                                                <tr>
                                                    <td>
                                                        <div class="fieldviewcaptionfirst">
                                                            Razão Social
                                                        </div>
                                                        <div class="fieldviewtext">
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("REV_RAZAOSOCIAL") %>' Width="300px"></asp:Label>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="fieldviewcaptionfirst">
                                                            CNPJ
                                                        </div>
                                                        <div class="fieldviewtext">
                                                            <asp:Label ID="lbCNPJ" runat="server" Text='<%# Bind("REV_CNPJ") %>' Width="115px"></asp:Label>
                                                        </div>
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
                                                        <asp:TextBox ID="REV_FANTASIA" runat="server" Text='<%# Bind("REV_FANTASIA") %>'
                                                            Width="300px" notnull="true" />
                                                    </td>
                                                    <td>Distribuidora<br />
                                                        <asp:TextBox ID="REV_DISTRIBUIDORA" runat="server" Text='<%# Bind("REV_DISTRIBUIDORA") %>'
                                                            Width="300px" notnull="true" />
                                                    </td>
                                                    <td>Inscrição Estadual<br />
                                                        <asp:TextBox ID="REV_IE" runat="server" Text='<%# Bind("REV_IE") %>' Width="130px"
                                                            notnull="true" MaxLength="20" />
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
                                                        <asp:TextBox ID="REV_NUMERO" runat="server" Text='<%# Bind("REV_NUMERO") %>' Width="50px"
                                                            notnull="true" />
                                                    </td>
                                                    <td>Complemento<br />
                                                        <asp:TextBox ID="REV_COMPLEMENTO" runat="server" Text='<%# Bind("REV_COMPLEMENTO") %>'
                                                            Width="150px" />
                                                    </td>
                                                    <td class="RadMaskedTextBox">CEP<br />
                                                        <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###-###" Mask="##.###-###"
                                                            ID="RadMaskedTextBox1" Text='<%# Bind("REV_CEP") %>' notnull="true" Width="70px">
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
                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("REV_BAIRRO") %>' Width="200px"
                                                            notnull="true" />
                                                    </td>
                                                    <td>Cidade<br />
                                                        <asp:TextBox ID="REV_CIDADE" runat="server" Text='<%# Bind("REV_CIDADE") %>' Width="200px"
                                                            notnull="true" />
                                                    </td>
                                                    <td>UF<br />
                                                        <telerik:RadComboBox ID="REV_UF" runat="server" Skin="flv" EnableEmbeddedSkins="false"
                                                            DataSourceID="sqlEstados" DataTextField="EST_NOME" DataValueField="EST_SIGLA"
                                                            Widht="60px" EmptyMessage="Selecione o Estado" SelectedValue='<%# Bind("REV_UF") %>'
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
                                                    <td>Contato<br />
                                                        <asp:TextBox ID="REV_CONTATO" runat="server" Text='<%# Bind("REV_CONTATO") %>' Width="200px" />
                                                    </td>
                                                    <td>DDD<br />
                                                        <asp:TextBox ID="REV_DDD" runat="server" Text='<%# Bind("REV_DDD") %>' Width="50px"
                                                            MaxLength="3" notnull="true" />
                                                    </td>
                                                    <td>Telefone<br />
                                                        <asp:TextBox ID="REV_TELEFONE" runat="server" Text='<%# Bind("REV_TELEFONE") %>'
                                                            Width="135px" MaxLength="10" notnull="true" />
                                                    </td>
                                                    <td>Skype<br />
                                                        <asp:TextBox ID="REV_SKYPE" runat="server" Text='<%# Bind("REV_SKYPE") %>' Width="150px"
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
                                                        <telerik:RadMaskedTextBox runat="server" DisplayMask="##" Mask="##" ID="RadMaskedTextBox2"
                                                            MaxLength="2" Width="50px" Text='<%# Bind("REV_CEL_DDD") %>'>
                                                        </telerik:RadMaskedTextBox>
                                                    </td>
                                                    <td>Celular (somente numeros)<br />
                                                        <asp:TextBox ID="txtCelular" runat="server" Text='<%# Bind("REV_CELULAR") %>'
                                                            Width="135px" MaxLength="10" />
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
                                                        <asp:TextBox ID="REV_EMAIL" runat="server" Text='<%# Bind("REV_EMAIL") %>' Width="300px"
                                                            notnull="true" />
                                                    </td>
                                                    <td>E-mail2<br />
                                                        <asp:TextBox ID="txtxEmail2" runat="server" Text='<%# Bind("REV_EMAIL2") %>' Width="300px" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </EditItemTemplate>
                    </asp:FormView>
                    <div class="sitecorpoboxbottom">
                        <asp:LinkButton ID="btSalvar" runat="server" CssClass="sitebutton">
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />Salvar
                        </asp:LinkButton>
                    </div>
                    <asp:SqlDataSource ID="sqlRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                        SelectCommand="SELECT * FROM AssepontoRevendas WHERE (REV_IND = @REV_IND)"
                        UpdateCommand="UPDATE AssepontoRevendas SET REV_EMAIL2 = @REV_EMAIL2, REV_CEL_DDD = @REV_CEL_DDD, REV_CELULAR = @REV_CELULAR, REV_FANTASIA = @REV_FANTASIA, REV_DISTRIBUIDORA = @REV_DISTRIBUIDORA, REV_IE = @REV_IE, REV_TELEFONE = @REV_TELEFONE, REV_EMAIL = @REV_EMAIL, REV_CONTATO = @REV_CONTATO, REV_REP_FABRICANTE = @REV_REP_FABRICANTE, REV_LOGRADOURO = @REV_LOGRADOURO, REV_BAIRRO = @REV_BAIRRO, REV_CIDADE = @REV_CIDADE, REV_UF = @REV_UF, REV_CEP = @REV_CEP, REV_DDD = @REV_DDD, REV_COMPLEMENTO = @REV_COMPLEMENTO, REV_NUMERO = @REV_NUMERO, REV_SKYPE = @REV_SKYPE WHERE REV_IND = @REV_IND"
                        ProviderName="<%$ ConnectionStrings:AppConnectionString.ProviderName %>" OnUpdated="sqlRevendasProvisorios_Updated">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="REV_IND" QueryStringField="ind" Type="Int32" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:QueryStringParameter Name="REV_IND" QueryStringField="ind" Type="Int32" />
                            <asp:Parameter Name="REV_FANTASIA" Type="String" />
                            <asp:Parameter Name="REV_IE" Type="String" />
                            <asp:Parameter Name="REV_TELEFONE" Type="String" />
                            <asp:Parameter Name="REV_EMAIL" Type="String" />
                            <asp:Parameter Name="REV_EMAIL2" Type="String" />
                            <asp:Parameter Name="REV_CONTATO" Type="String" />
                            <asp:Parameter Name="REV_REP_FABRICANTE" Type="Int32" />
                            <asp:Parameter Name="REV_LOGRADOURO" Type="String" />
                            <asp:Parameter Name="REV_BAIRRO" Type="String" />
                            <asp:Parameter Name="REV_CIDADE" Type="String" />
                            <asp:Parameter Name="REV_UF" Type="String" />
                            <asp:Parameter Name="REV_CEP" Type="String" />
                            <asp:Parameter Name="REV_DDD" Type="Int32" />
                            <asp:Parameter Name="REV_COMPLEMENTO" Type="String" />
                            <asp:Parameter Name="REV_NUMERO" Type="String" />
                            <asp:Parameter Name="REV_SKYPE" Type="String" />
                            <asp:Parameter Name="REV_CEL_DDD" Type="String" />
                            <asp:Parameter Name="REV_CELULAR" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sqlEstados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                        SelectCommand="SELECT [EST_SIGLA], [EST_NOME] FROM [Estados]"></asp:SqlDataSource>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
