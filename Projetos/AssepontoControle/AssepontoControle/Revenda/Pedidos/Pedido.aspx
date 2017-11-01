<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true" CodeBehind="Pedido.aspx.cs" Inherits="Asseponto.Revenda.Pedidos.Pedido" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
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
                                <tr>
                                    <td>
                                        <asp:Label ID="lblErroRazao" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="juridica">
                        <td>
                            <table class="formviewtableinner">
                                <tr>
                                    <td colspan="4">
                                        <b>Jurídica</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="RadMaskedTextBox">CNPJ<br />
                                        <asp:TextBox runat="server" ID="PED_CLI_CNPJ" MaxLength="18" OnTextChanged="PED_CLI_CNPJ_TextChanged" AutoPostBack="true"></asp:TextBox><br />
                                        
                                    </td>
                                    <td>Fantasia<br />
                                        <asp:TextBox ID="PED_FANTASIA" runat="server" MaxLength="30" />
                                    </td>
                                    <td>Inscrição Estadual<br />
                                        <asp:TextBox runat="server" ID="PED_CLI_IE" MaxLength="12" OnTextChanged="PED_CLI_IE_TextChanged" AutoPostBack="true"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="fisica">
                        <td>
                            <table class="formviewtableinner">
                                <tr>
                                    <td colspan="2">
                                        <b>Física</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="RadMaskedTextBox">CPF<br />
                                        <asp:TextBox runat="server" ID="PED_CLI_CPF" MaxLength="14" OnTextChanged="PED_CLI_CPF_TextChanged" AutoPostBack="true"></asp:TextBox><br />
                                        
                                    </td>
                                    <td>
                                        <br />
                                        <asp:Label ID="PED_CLI_CNPJ_ERRO" Font-Bold="true" ForeColor="Red" Text="" Visible="false" runat="server"></asp:Label>
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
                                        <asp:TextBox runat="server" ID="PED_CLI_CEP" Width="100px" MaxLength="10" OnTextChanged="PED_CLI_CEP_TextChanged" AutoPostBack="true"></asp:TextBox>
                                        
                                    </td>
                                    <td>UF<br />
                                        <asp:TextBox ID="PED_CLI_UF" Skin="flv" Width="50" runat="server" Enabled="false"></asp:TextBox>
                                        
                                    </td>
                                    <td>Cidade<br />
                                        <asp:TextBox ID="PED_CLI_CIDADE" runat="server"
                                            Width="200px" notnull="true"  MaxLength="30" Enabled="false" />
                                        
                                    </td>
                                    <td>Bairro<br />
                                        <asp:TextBox ID="PED_CLI_BAIRRO" runat="server"
                                            Width="200px" notnull="true"  MaxLength="25" Enabled="false" />
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblErroCEP" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label></td>
                                    <td><asp:Label ID="lblErroUF" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label></td>
                                    <td><asp:Label ID="lblErroCIDADE" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label></td>
                                    <td><asp:Label ID="lblErroBAIRRO" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label></td>
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
                                        
                                    </td>
                                    <td>Número<br />
                                        <asp:TextBox runat="server" ID="PED_CLI_ENDERECO_NUMERO" MaxLength="7" AutoPostBack="true"></asp:TextBox>
                                        
                                    </td>
                                    <td>Complemento<br />
                                        <asp:TextBox ID="PED_CLI_ENDERECO_COMPLEMENTO" runat="server"
                                            Width="180px" MaxLength="60" />
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblErroEndereco" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label></td>
                                    <td><asp:Label ID="lblErroNumero" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
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
                                <tr>
                                    <td><asp:Label ID="lblErroResponsavel" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label></td>
                                    <td></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="formviewtableinner">
                                <tr>
                                    <td>DDD<br />
                                        <asp:TextBox runat="server" ID="PED_CLI_TELEFONE_DDD" MaxLength="2" Width="50px"></asp:TextBox>
                                    </td>
                                    <td>Telefone<br />
                                        <asp:TextBox ID="PED_CLI_TELEFONE" runat="server"
                                            Width="130px" MaxLength="10" notnull="true" />
                                    </td>
                                    
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblErroTelefone" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label>
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
                                        <asp:TextBox runat="server" ID="PED_CLI_TELEFONE2_DDD" MaxLength="2" Width="50px"></asp:TextBox>
                                    </td>
                                    <td>Telefone 2<br />
                                        <asp:TextBox ID="PED_CLI_TELEFONE2" runat="server"
                                            Width="130px" MaxLength="10" notnull="true" />
                                    </td>
                                    
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblErroTelefone2" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="formviewtableinner">
                                <tr>
                                    <td>DDD<br />
                                        <asp:TextBox runat="server" ID="PED_CLI_CELULAR_DDD" MaxLength="2" Width="50px"></asp:TextBox>
                                    </td>
                                    <td>Celular<br />
                                        <asp:TextBox ID="PED_CLI_CELULAR" runat="server"
                                            Width="130px" MaxLength="10" notnull="true" />
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
                                <tr>
                                    <td><asp:Label ID="lblErroCelular" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label></td>
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
                                            Width="200px" notnull="true" MaxLength="50" OnTextChanged="txtEmail_TextChanged" AutoPostBack="true" /><br />
                                        
                                    </td>
                                    <td>Outro e-mail do responsável pelo sistema<br />
                                        <asp:TextBox ID="txtEmail2" runat="server" OnTextChanged="txtEmail2_TextChanged" AutoPostBack="true"
                                            Width="200px" MaxLength="50" /><br />
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblErroEmail" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label></td>
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
                    <tr>
                        <td>
                            <br />
                            <label>Número de Funcionários</label>
                            <asp:TextBox runat="server" ID="PED_CLI_QTD_FUNCIONA" Width="200px" MaxLength="4" SkinID="Wr"></asp:TextBox>
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
                                            <asp:ListItem Value="2"  Selected="true">Asseponto 4 (Master)</asp:ListItem>
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
                                        <telerik:RadComboBox ID="PED_REP_FABRICANTE" runat="server" AutoPostBack="true" 
                                            Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione o REP" 
                                                EnableViewState="true">
                                            <%--OnDataBinding="RadComboBox2_Dat-aBinding" OnDataBound="RadComboBox2_DataBound"--%> 
                                        </telerik:RadComboBox>
                                        <br />
                                        <asp:Label ID="lblErroFabricante" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label>
                                    </td>
                                    <td>Modelo do REP<br />
                                        <asp:TextBox ID="PED_MODELOREP" runat="server" 
                                            MaxLength="150" notnull="true" />
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
    <%--<asp:SqlDataSource ID="sqlAssepontoRepFabricantes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [FABR_NOME], [FABR_COD], [FABR_ATIVO] FROM [AssepontoRepFabricantes] WHERE ([FABR_ATIVO] = 1) ORDER BY [FABR_NOME]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlEstados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [EST_SIGLA], [EST_NOME] FROM [Estados]"></asp:SqlDataSource>--%>
</asp:Content>
