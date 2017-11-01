<%@ Page Title="Assecont Contabilidade" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AssecontNovo.Grupo.Boletos._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="../../Jquery/ControlVisible/Visible.js"></script>

    <script type="text/javascript">
        function OpenAtualizaEmail(id) {
            var oWnd1 = $find("<%= RadWindowAtulizaEmail.ClientID %>");
            oWnd1.set_initialBehaviors(Telerik.Web.UI.WindowBehaviors.Pin);
            oWnd1.set_animation(Telerik.Web.UI.WindowAnimation.Fade);
            oWnd1.setUrl("AtualizaEmail.aspx?ind=" + id);
            oWnd1.show();
        }

        function OpenAtualizaCelular(id) {
            var oWnd1 = $find("<%= RadWindowAtualizaCelular.ClientID %>");
            oWnd1.set_initialBehaviors(Telerik.Web.UI.WindowBehaviors.Pin);
            oWnd1.set_animation(Telerik.Web.UI.WindowAnimation.Fade);
            oWnd1.setUrl("AtualizaCelular.aspx?ind=" + id);
            oWnd1.show();
        }

        function RefreshParentPage() {
            document.location.reload();
        }
    </script>

    <link href="../../Styles/arccodion.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">

    <telerik:RadWindowManager ID="RWM_AtulizaEmail" runat="server" EnableShadow="true" ReloadOnShow="True" AutoSizeBehaviors="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindowAtulizaEmail" runat="server" EnableEmbeddedSkins="false" Skin="flv" Title="Atualizar Dados"
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="640" Width="720" Behaviors="Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <telerik:RadWindowManager ID="RWM_AtualizaCelular" runat="server" EnableShadow="true" ReloadOnShow="True" AutoSizeBehaviors="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindowAtualizaCelular" runat="server" EnableEmbeddedSkins="false" Skin="flv" Title="Ativar SMS"
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="320" Width="680" Behaviors="Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <table>
        <tr>
            <td valign="top">
                <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataCadastro" DataKeyNames="CAD_IND">
                    <EmptyDataTemplate>
                        <table style="float: left; margin-top: 50px; width: 450px;">
                            <tr>
                                <td>
                                    <img src="/Imagens/Site/Error.png" width="80" />
                                </td>
                                <td style="font-size: 14pt">
                                    <div class="titleSubs font_red">
                                        <b>Cnpj ou Cpf Inválido.</b>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 20px;" colspan="2">
                                    <i>Voltar a página inicial: <a href="http://www.assecont.com.br/">Clique aqui</a></i>
                                </td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <table style="width: 1000px;">
                            <tr>
                                <td>
                                    <span style="font-size: 16pt; text-shadow: 0 0 0;">Seja bem vindo,</span>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 45px; padding-bottom: 20px;" colspan="2">
                                    <asp:Label ID="lbBoletoSacado" runat="server" Font-Size="16pt" Font-Bold="true" ForeColor="Orange" Text='<%# Wr.Classes.Strings.capitalizeWords(Eval("CAD_RAZAOSOCIAL").ToString()) %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table style="float: left; padding: 8px 50px 20px 20px; border: 1px solid #C5C5C5; min-width: 480px; background: #F8F8F8;">
                                        <tr>
                                            <td valign="top" class="text">
                                                <p><span style="font-size: 16pt; font-style: italic; text-shadow: 0 0 0;">Meus Dados</span></p>
                                            </td>
                                            <td style="text-align: right; vertical-align: top; padding-top: 18px;">
                                                <p>
                                                    <a id="lkAtualizaEmail" runat="server" class="sitebutton blue" onclick='<%# "OpenAtualizaEmail(" + Eval("CAD_IND") + ");" %>'>Editar
                                                        <asp:Image ID="imgAtualiza" runat="server" ImageUrl="~/Imagens/24x24/Editor24x24.png" /></a>
                                                    <asp:HiddenField ID="HiddenUrl" runat="server" Value='<%# RadWindowAtulizaEmail.NavigateUrl = "AtualizaEmail.aspx?ind=" + Eval("CAD_IND").ToString() %>' />
                                                </p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="padding-left: 20px;">
                                                <b>Endereço</b>
                                                <br />
                                                <asp:Label ID="lbEndereco" runat="server" Text='<%# Eval("ENDERECO") %>'></asp:Label>
                                                <asp:Label ID="lbNumero" runat="server" Text='<%# Eval("NUMERO") %>'></asp:Label>
                                                <br />
                                                <asp:Label ID="lbBairro" runat="server" Text='<%# Eval("BAIRRO") + " - "  %>'></asp:Label>
                                                <asp:Label ID="lbCidade" runat="server" Text='<%# Eval("CIDADE") + " - " %>'></asp:Label>
                                                <asp:Label ID="lbUF" runat="server" Text='<%#  Eval("CAD_ESTADO") %>'></asp:Label>
                                                <br />
                                                CEP
                                                <asp:Label ID="lbCep" runat="server" Text='<%# Eval("CEP") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="padding-left: 20px;">
                                                <br />
                                                <b>E-Mail financeiro</b>
                                                <br />
                                                <asp:Label ID="lbEmail" runat="server" Text='<%# Eval("CAD_FINANCEIRO_EMAIL") %>'></asp:Label>
                                                <asp:Label ID="lbEmail2" runat="server" Visible='<%# Eval("CAD_FINANCEIRO_EMAIL2") is DBNull ? false : true %>' Text='<%# ", " + Eval("CAD_FINANCEIRO_EMAIL2") %>'></asp:Label>
                                                <asp:Label ID="lbEmail3" runat="server" Visible='<%# Eval("CAD_FINANCEIRO_EMAIL3") is DBNull ? false : true %>' Text='<%# "<br />, " + Eval("CAD_FINANCEIRO_EMAIL3") %>'></asp:Label>
                                                <br />
                                                <br />
                                                <b>Telefone financeiro</b>
                                                <br />
                                                <asp:Label ID="lbTel1" runat="server" Text='<%# Eval("CAD_FINANCEIRO_TELEFONE1") is DBNull ? " " : (Eval("CAD_FINANCEIRO_TELEFONE1_DDD") + " " + Eval("CAD_FINANCEIRO_TELEFONE1")) %>'></asp:Label>
                                                <asp:Label ID="lbTel2" runat="server" Text='<%# Eval("CAD_FINANCEIRO_TELEFONE2") is DBNull ? " " : (" / " + Eval("CAD_FINANCEIRO_TELEFONE2_DDD") + " " + Eval("CAD_FINANCEIRO_TELEFONE2")) %>'></asp:Label>
                                                <br />
                                                <br />
                                                <b>Celular financeiro</b>
                                                <asp:Label ID="lbCelular" runat="server" Text='<%# Eval("CELULAR") is DBNull ? " " : Eval("CELULAR") %>'></asp:Label>
                                                <asp:Label ID="ChckCelular" runat="server" Text='<%# Convert.ToBoolean(Eval("CEL_ACEITA")) ? " - Ativo" : " - Não habilitado" %>'></asp:Label>
                                            </t>
                                        </tr>
                                    </table>
                                    <table style='<%# Convert.ToBoolean(Eval("CEL_ACEITA")) ? "display: none;": "float: right; "  %>'>
                                        <tr>
                                            <td>
                                                <img src="../../Imagens/boxArticle/userCelular.png" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="text-align: center;">
                                                <p><span style="font-size: 16pt; font-style: italic; text-shadow: 0 0 0;">Receba seu boleto por SMS</span></p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center; padding-top: 6px; padding-bottom: 60px;">
                                                <a id="Celular" runat="server" class="sitebutton red" onclick='<%# "OpenAtualizaCelular(" + Eval("CAD_IND") + ");" %>'>Ative Agora</a>

                                                <asp:HiddenField ID="HiddenUrlCelular" runat="server" Value='<%# RadWindowAtualizaCelular.NavigateUrl = "AtualizaCelular.aspx?ind=" + Eval("CAD_IND").ToString() %>' />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table style="width: 1000px; padding-top: 20px;">
                            <tr>
                                <td valign="top">
                                    <table style="float: left; padding: 8px 50px 20px 20px; border: 1px solid #fcd9d9; min-width: 480px; min-height: 160px; background: #fdeaea;">
                                        <tr>
                                            <td valign="top">
                                                <span style="font-size: 16pt; font-style: italic; text-shadow: 0 0 0;">Boletos Em Aberto</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="padding-left: 20px;">
                                                <table>
                                                    <tr>
                                                        <td style="padding-left: 30px; width: 60px; padding-top: 20px">
                                                            <img src="../../Imagens/Site/barras48x48.png" />
                                                        </td>
                                                        <td style="padding-top: 20px">
                                                            <asp:Label ID="lbQtdBoletos" runat="server" Font-Size="16pt" Text="0"></asp:Label>
                                                            <br />
                                                            <asp:LinkButton ID="lBEmAberto" runat="server" CssClass="sitebutton red" OnClick="lBEmAberto_Click">Visualizar boletos em Aberto</asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <table style="float: right; padding: 8px 50px 8px 20px; border: 1px solid #C5C5C5; min-height: 160px; min-width: 350px; background: #F8F8F8;">
                                        <tr>
                                            <td valign="top">
                                                <p><span style="font-size: 16pt; font-style: italic; text-shadow: 0 0 0;">Próximos Vencimentos</span></p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="font-size: 12pt; padding-left: 30px;">
                                                <asp:DataList ID="dtBoletoVencimendo" runat="server" DataSourceID="SqlDataVencimentos" Style="width: 100%">
                                                    <ItemTemplate>
                                                        <p>
                                                            <a href='<%# "/grupo/Boletos/Boleto.aspx?cnpj=" + Request.QueryString["cnpj"] + "&data=" + Eval("BOL_VENCIMENTO") + "&id=" + Eval("BOL_IND") + "'"  %>' class="font_blue"><%# (Convert.ToBoolean(Eval("BOL_CONTRA_APRESENTACAO")) ? "Contra Apresentação" :  "") + " - " + Eval("BOL_VENCIMENTO", "{0:dd/MM/yyyy}") %></a>
                                                        </p>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <p>
                                                            <asp:Label Visible='<%# dtBoletoVencimendo.Items.Count == 0 %>' runat="server" ID="lblMsg" Text="Nenhum boleto encontrado."></asp:Label>
                                                        </p>
                                                    </FooterTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right;">
                                                <asp:LinkButton ID="lkTodos" runat="server" CssClass="sitebutton" BackColor="darkcyan" OnClick="lkTodos_Click">Visualizar Todos os Boletos</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="PanelEmAbertos" runat="server" Style="padding-top: 40px;">
                            <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="false" DataSourceID="SqlDataBoletosAbertos"
                                CellSpacing="0" GridLines="None" PagerStyle-ShowPagerText="true" EnableEmbeddedSkins="false" Skin="flv"
                                PagerStyle-AlwaysVisible="true" Width="100%"
                                OnItemDataBound="RadGridBoletos_ItemDataBound">

                                <MasterTableView DataSourceID="SqlDataBoletosAbertos" AlternatingItemStyle-BackColor="#FDEAEA" AutoGenerateColumns="false"
                                    DataKeyNames="BOL_IND" ItemStyle-Height="40px" AlternatingItemStyle-Height="40px">

                                    <NoRecordsTemplate></NoRecordsTemplate>

                                    <Columns>
                                        <telerik:GridTemplateColumn DataField="BOL_NOSSO_NUMERO" HeaderText="Boletos" SortExpression="PAGO" UniqueName="PAGO">
                                            <ItemTemplate>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td valign="top" style="border: 0px; width: 250px;">
                                                            <asp:Label ID="lbBoletoNN" Font-Size="12pt" runat="server" Text='<%# "Boleto " + Eval("BOL_NOSSO_NUMERO") + (Convert.ToBoolean(Eval("BOL_CONTRA_APRESENTACAO")) ? " - Conta Apresentação" : string.Empty) %>'></asp:Label><br />
                                                            <asp:Label ID="lbVencimento" runat="server" Text='<%#  "Vencimento " + Eval("BOL_VENCIMENTO", "{0:dd/MM/yyyy}") %>'></asp:Label><br />
                                                            <asp:Label ID="lbOriginal" runat="server" Text='<%# "R$ " + Eval("BOL_VALOR", "{0:n2}") %>'></asp:Label>

                                                        </td>
                                                        <td style="border: 0px; width: 380px;">
                                                            <asp:Label ID="lbEnvioAviso" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("DATAENVIADO").ToString())  %>' Text='<%# "Ultimo e-mail enviado em " + Eval("DATAENVIADO", "{0:dd/MM/yyyy}") %>'></asp:Label><br />
                                                            <asp:Label ID="lbVisualizado" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("BOL_VISUALIZADO_WEBEM").ToString()) %>' Text='<%# "Visualizado na web em " + Eval("BOL_VISUALIZADO_WEBEM", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label><br />
                                                        </td>
                                                        <td valign="top" style="border: 0px;">
                                                            <table style='<%# Eval("BCO_NUMERO").ToString().Equals("33") ? "" : "display:none"  %>'>
                                                                <tr>
                                                                    <td style="border: 0px;">Data do pagamento<br />
                                                                        <telerik:RadComboBox ID="RadComboBoxVencimentos" Height="200" Skin="flv" EnableEmbeddedSkins="false" runat="server" Width="120px"></telerik:RadComboBox>
                                                                    </td>
                                                                    <td style="border: 0px;">
                                                                        <br />
                                                                        <asp:HiddenField ID="hidden_ind" runat="server" Value='<%# Eval("BOL_IND") %>' />
                                                                        <asp:LinkButton ID="lkBoletos" runat="server" CssClass="sitebutton red" OnClick="lkBoletos_Click">
                                                                            Gerar Boleto <asp:Image ID="imgGerar2" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" />
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table style='<%# !Eval("BCO_NUMERO").ToString().Equals("33") ? "" : "display:none"  %>'>
                                                                <tr>
                                                                    <td style="border: 0px;">
                                                                        <a class="sitebutton red"  href='<%# "/grupo/Boletos/Boleto.aspx?cnpj=" + Request.QueryString["cnpj"] + "&id=" + Eval("BOL_IND") + "'"  %>'>Gerar Boleto 
                                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" />  
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="SqlDataCadastro" OnLoad="SqlData_Load" runat="server" OnSelecting="SqlData_Selecting" ConnectionString='<%$ ConnectionStrings:AppConnectionStringAssefin %>'
        SelectCommand="SELECT CAD_IND, CAD_RAZAOSOCIAL, RTRIM(CAD_ENDERECO) AS ENDERECO, RTRIM(CAD_ENDERECO_NUMERO) AS NUMERO, RTRIM(CAD_COMPLEMENTO) AS COMPLEMENTO, 
                    RTRIM(CAD_BAIRRO) AS BAIRRO, (CAD_CIDADE) AS CIDADE, RTRIM(CAD_CEP) AS CEP, CAD_ESTADO, CAD_CADASTRO_ATUALIZADO_EM,
                    CAD_FINANCEIRO_EMAIL, CAD_FINANCEIRO_EMAIL2, CAD_FINANCEIRO_EMAIL3, (CAD_FINANCEIRO_CELULAR1_DDD + ' ' + CAD_FINANCEIRO_CELULAR1) AS CELULAR, 
                    (CASE WHEN CAD_CELULAR_ACEITA IS NULL THEN 0 ELSE CAD_CELULAR_ACEITA END) AS CEL_ACEITA,
                    CAD_FINANCEIRO_TELEFONE1_DDD, CAD_FINANCEIRO_TELEFONE1, CAD_FINANCEIRO_TELEFONE2, CAD_FINANCEIRO_TELEFONE2_DDD
                    FROM Cadastros 
                    WHERE CAD_IND = @CADASTRO">
        <SelectParameters>
            <asp:Parameter Type="Int32" Name="CADASTRO" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataBoletosAbertos" OnLoad="SqlData_Load" runat="server" OnSelecting="SqlData_Selecting" ConnectionString='<%$ ConnectionStrings:AppConnectionStringAssefin %>'
        SelectCommand=" SELECT BOL_IND, BOL_VALOR, BOL_CONTRA_APRESENTACAO, BOL_NOSSO_NUMERO, BOL_VISUALIZADO_WEBEM,
                 (SELECT BCO_NUMERO FROM ContasParticulares INNER JOIN Bancos ON BCO_IND = CTAP_BANCO WHERE BOL_CONTAP = CTAP_IND) AS BCO_NUMERO,
                 BOL_VENCIMENTO, 
	                                
                (CASE WHEN  BOL_COBRANCA_ENVIADOEM IS NULL THEN (CASE WHEN BOL_AVISO_ENVIADOEM  IS NULL 
			    THEN (CASE WHEN BOL_FATURAMENTO_ENVIADOEM IS NULL THEN BOL_ENVIADOEM ELSE BOL_FATURAMENTO_ENVIADOEM END)
	            ELSE BOL_AVISO_ENVIADOEM END) ELSE BOL_COBRANCA_ENVIADOEM  END) AS DATAENVIADO

                FROM Boletos 
                INNER JOIN ContasRegistros ON BOL_IND = CTAR_BOLETO
                WHERE BOL_CANCELADO = 0 AND CTAR_VALOR_PAGTO IS NULL AND BOL_IGNORAR = 0 AND CTAR_IGNORADO = 0 AND BOL_CADASTRO = @CADASTRO
                AND BOL_VENCIMENTO
                &lt; CONVERT(DATE, GETDATE()) AND BOL_CONTRA_APRESENTACAO = 0
	            ORDER BY BOL_VENCIMENTO DESC">
        <SelectParameters>
            <asp:Parameter Type="Int32" Name="CADASTRO" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataVencimentos" OnLoad="SqlData_Load" runat="server" OnSelecting="SqlData_Selecting" ConnectionString='<%$ ConnectionStrings:AppConnectionStringAssefin %>'
        SelectCommand="SELECT BOL_IND, BOL_VENCIMENTO, BOL_CONTRA_APRESENTACAO
	                FROM Boletos 
	                INNER JOIN ContasRegistros ON BOL_IND = CTAR_BOLETO
	                WHERE BOL_CANCELADO = 0 AND CTAR_VALOR_PAGTO IS NULL AND BOL_IGNORAR = 0 AND CTAR_IGNORADO = 0 AND CONVERT(DATE, BOL_VENCIMENTO) &lt;= CONVERT(DATE, GETDATE() + 45) AND
	                BOL_VENCIMENTO &gt;= CONVERT(DATE, GETDATE())  
	                AND BOL_CADASTRO = @CADASTRO
	                ORDER BY BOL_VENCIMENTO DESC">
        <SelectParameters>
            <asp:Parameter Type="Int32" Name="CADASTRO" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
