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

    </script>
    <link href="../../Styles/arccodion.css" rel="stylesheet" />

</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceWebSite" runat="server">

    <telerik:RadWindowManager ID="RWM_AtulizaEmail" runat="server" EnableShadow="true" ReloadOnShow="True" AutoSizeBehaviors="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindowAtulizaEmail" runat="server" EnableEmbeddedSkins="false" Skin="flv" Title="Atualizar Dados"
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="640" Width="680" Behaviors="Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <telerik:RadWindowManager ID="RWM_AtualizaCelular" runat="server" EnableShadow="true" ReloadOnShow="true" AutoSizeBehaviors="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindowAtualizaCelular" runat="server" EnableEmbeddedSkins="false" Skin="flv" VisibleTitlebar="false"
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="640" Width="720" Behaviors="None">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td valign="top" style="width: 620px">
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataCadastro" DataKeyNames="CAD_IND">
                                        <EmptyDataTemplate>
                                            <div>
                                                <table style="margin-top: 50px; width: 450px;">
                                                    <tr>
                                                        <td>
                                                            <img src="http://www.assecont.com.br/Imagens/Site/Error.png" width="80" />

                                                        </td>
                                                        <td style="font-size: 14pt">
                                                            <div class="titleSubs font_red">
                                                                <b>Cnpj ou Cpf Inválido.</b>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding: 20px;" colspan="2">
                                                            <i>Voltar a página inicial: <a href="http://www.assecont.com.br/assecont">Clique aqui</a></i>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </EmptyDataTemplate>
                                        <ItemTemplate>
                                            <table>
                                                <tr>
                                                    <td colspan="2">
                                                        <span style="font-size: 16pt; text-shadow: 0 0 0;">Seja bem vindo,</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-left: 45px; padding-bottom: 20px;" colspan="2">
                                                        <asp:Label ID="lbBoletoSacado" runat="server" Font-Size="16pt" Font-Bold="true" ForeColor="Orange" Text='<%# Wr.Classes.Strings.capitalizeWords(Eval("CAD_RAZAOSOCIAL").ToString()) %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 620px;" valign="top">         
                                                        <div class="font_blue">  Meus Dados</div>                                         
                                                         <table border="0" cellspacing="0" cellpadding="0" style="max-width: 500px; background: #F8F8F8; padding-bottom: 10px;">
                                                             <tr>
                                                                 <td>
                                                                     <asp:Label ID="lbEndereco" runat="server" Text='<%# Eval("ENDERECO") %>'></asp:Label>
                                                                     <asp:Label ID="lbNumero" runat="server" Text='<%# Eval("NUMERO") %>'></asp:Label>
                                                                     <br />
                                                                     <asp:Label ID="lbBairro" runat="server" Text='<%# Eval("BAIRRO") + " - "  %>'></asp:Label>
                                                                     <asp:Label ID="lbCidade" runat="server" Text='<%# Eval("CIDADE") + " - " %>'></asp:Label>
                                                                     <asp:Label ID="lbUF" runat="server" Text='<%#  Eval("CAD_ESTADO") %>'></asp:Label>
                                                                     <br />
                                                                     CEP
                                                                     <asp:Label ID="lbCep" runat="server" Text='<%# Eval("CEP") %>'></asp:Label>
                                                                     <br />
                                                                     <br />
                                                                     <b>E-Mail financeiro: </b>
                                                                     <br />
                                                                     <asp:Label ID="lbEmail" runat="server" Text='<%# Eval("CAD_FINANCEIRO_EMAIL") %>'></asp:Label>
                                                                     <asp:Label ID="lbEmail2" runat="server" Visible='<%# Eval("CAD_FINANCEIRO_EMAIL2") is DBNull ? false : true %>' Text='<%# ", " + Eval("CAD_FINANCEIRO_EMAIL2") %>'></asp:Label>
                                                                     <asp:Label ID="lbEmail3" runat="server" Visible='<%# Eval("CAD_FINANCEIRO_EMAIL3") is DBNull ? false : true %>' Text='<%# ", " + Eval("CAD_FINANCEIRO_EMAIL3") %>'></asp:Label>
                                                                     <br />
                                                                     <br />
                                                                     <b>Telefone financeiro:</b>
                                                                     <br />
                                                                     <asp:Label ID="lbTel1" runat="server" Text='<%# Eval("CAD_FINANCEIRO_TELEFONE1") is DBNull ? " " : (Eval("CAD_FINANCEIRO_TELEFONE1_DDD") + " " + Eval("CAD_FINANCEIRO_TELEFONE1")) %>'></asp:Label>
                                                                     <asp:Label ID="lbTel2" runat="server" Text='<%# Eval("CAD_FINANCEIRO_TELEFONE2") is DBNull ? " " : (" / " + Eval("CAD_FINANCEIRO_TELEFONE2_DDD") + " " + Eval("CAD_FINANCEIRO_TELEFONE2")) %>'></asp:Label>
                                                                     <br />
                                                                     <br />
                                                                     Celular:
                                                                     <asp:Label ID="lbCelular" runat="server" Text='<%# Eval("CELULAR") is DBNull ? " " : Eval("CELULAR") %>'></asp:Label>
                                                                     <asp:Label ID="ChckCelular" runat="server" Text='<%# Convert.ToBoolean(Eval("CEL_ACEITA")) ? " - Ativo" : " - Não habilitado" %>'></asp:Label>
                                                                     <br />
                                                                     <br />
                                                                     <a id="lkAtualizaEmail" runat="server" class="sitebutton blue" onclick='<%# "OpenAtualizaEmail(" + Eval("CAD_IND") + ");" %>'>Editar Dados
                                                                     <asp:Image ID="imgAtualiza" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" /></a>

                                                                     <asp:HiddenField ID="HiddenUrl" runat="server" Value='<%# RadWindowAtulizaEmail.NavigateUrl = "AtualizaEmail.aspx?ind=" + Eval("CAD_IND").ToString() %>' />
                                                                     <br />
                                                                     <br />
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
                                    <div class="font_red">  Boletos Em Aberto </div>
                                    <asp:FormView ID="FormView2" runat="server" DataSourceID="SqlDataCountBoletos" Visible='<%# FormView1.DataItemCount > 0 ? true : false %>'>
                                        <ItemTemplate>
                                            <table style="width: 520px; height: 120px; background: #fdeaea;">
                                                <tr>
                                                    <td style="padding-left: 30px; width: 60px; padding-top: 20px">
                                                        <img src="../../Imagens/Site/barras48x48.png" />
                                                    </td>
                                                    <td style="padding-top: 20px">
                                                        <asp:Label ID="lbQtdBoletos" runat="server" Font-Size="16pt" Text='<%# Eval("Total") + (Convert.ToInt32(Eval("Total")) > 1 ? " Boletos" : " Boleto") %>'></asp:Label>
                                                        <br />
                                                        <asp:LinkButton ID="lBEmAberto" runat="server" CssClass="sitebutton red" Visible='<%# Convert.ToInt32(Eval("Total")) == 0 ? false : true %>' OnClick="lBEmAberto_Click">Clique aqui</asp:LinkButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right; padding-right: 15px;" colspan="2">
                                                        <asp:LinkButton ID="lkTodos" runat="server" CssClass="sitebutton" BackColor="darkcyan" OnClick="lkTodos_Click">Visualizar Todos os Boletos</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:FormView>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top">
                        <table>
                            <tr>
                                <td>
                                    <asp:FormView ID="FormViewCelular" runat="server" DataSourceID="SqlDataCadastro" DataKeyNames="CAD_IND">
                                        <ItemTemplate>
                                            <table style='<%# Convert.ToBoolean(Eval("CEL_ACEITA")) ? "display: none;": ""  %>'>
                                                <tr>
                                                    <td>
                                                        <img src="../../Imagens/boxArticle/BoletoSms.png" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center; padding-top: 6px; padding-bottom: 60px;">
                                                        <a id="Celular" runat="server" class="sitebutton red" onclick='<%# "OpenAtualizaCelular(" + Eval("CAD_IND") + ");" %>'>Ative Agora</a>

                                                        <asp:HiddenField ID="HiddenUrlCelular" runat="server" Value='<%# RadWindowAtualizaCelular.NavigateUrl = "AtualizaCelular.aspx?ind=" + Eval("CAD_IND").ToString() %>' />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:FormView>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="background: #F8F8F8;">
                                    <img src="../../Imagens/boxArticle/BoletoVencimento.png" />
                                    <asp:DataList ID="dtBoletoVencimendo" runat="server" DataSourceID="SqlDataVencimentos">
                                        <ItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="padding-left: 40px; padding-top: 8px;">
                                                        <a href='<%# "/grupo/Boletos/Boleto.aspx?cnpj=" + Eval("CPF_CNPJ") + "&data=" + Eval("BOL_VENCIMENTO") + "&id=" + Eval("BOL_IND") + "'"  %>' class="font_blue"><%# (Convert.ToBoolean(Eval("BOL_CONTRA_APRESENTACAO")) ? "Contra Apresentação" :  "") + " - " + Eval("BOL_VENCIMENTO", "{0:dd/MM/yyyy}") %></a>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <asp:Panel ID="PanelEmAbertos" runat="server">
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="false" DataSourceID="SqlDataBoletosAbertos"
                    CellSpacing="0" GridLines="None" PagerStyle-AlwaysVisible="true"
                    EnableEmbeddedSkins="false" Skin="flv" PagerStyle-ShowPagerText="true" OnItemDataBound="RadGridBoletos_ItemDataBound"
                    pagertextformat="{4} {5}">

                    <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Boletos em aberto"></PagerStyle>

                    <MasterTableView DataSourceID="SqlDataBoletosAbertos" AllowPaging="false" AutoGenerateColumns="false"
                        DataKeyNames="BOL_IND" ItemStyle-Height="40px" AlternatingItemStyle-Height="40px"
                        AlternatingItemStyle-BackColor="#F7F7F7">

                        <NoRecordsTemplate>Nenhum Registro Encontrado.</NoRecordsTemplate>

                        <Columns>

                            <telerik:GridTemplateColumn DataField="BOL_NOSSO_NUMERO" HeaderText="Boleto" SortExpression="BOL_NOSSO_NUMERO">
                                <ItemTemplate>
                                    <asp:Label ID="lbBoletoNN" runat="server" Text='<%# Eval("BOL_NOSSO_NUMERO") %>'></asp:Label>
                                    <%-- <asp:Image ID="imgRegistrado" runat="server" ImageUrl="~/Imagens/16x16/Registrado16x16.png" Visible='<%# Eval("BOL_REGISTRO_DATA") is DBNull ? false : true %>' />--%>
                                </ItemTemplate>
                                <HeaderStyle Width="30px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="COD_VERIFICACAO" HeaderText="Nota" SortExpression="COD_VERIFICACAO">
                                <ItemTemplate>
                                    <asp:Label ID="lbRisco" Visible='<%# Eval("COD_VERIFICACAO") is DBNull ? true : false %>' runat="server" Text=" - "></asp:Label>
                                    <asp:HyperLink ID="HyNotaFiscal" CssClass="font_blue" Style="text-shadow: 0 0 0;" Visible='<%# Eval("COD_VERIFICACAO") is DBNull ? false : true %>' runat="server"
                                        NavigateUrl='<%# "https://nfe.prefeitura.sp.gov.br/contribuinte/notaprint.aspx?ccm=" + Eval("COD_MUNICIPAL") + "&nf=" + Eval("NOTS_NUMERO") + "&cod=" + Eval("COD_VERIFICACAO") %>'>Nota Fiscal
                                    </asp:HyperLink>
                                </ItemTemplate>
                                <HeaderStyle Width="80px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="BOL_VENCIMENTO" HeaderText="Vencimento" SortExpression="BOL_VENCIMENTO">
                                <ItemTemplate>
                                    <asp:Label ID="lbVencimento" runat="server" Text='<%# (Convert.ToBoolean(Eval("BOL_CONTRA_APRESENTACAO")) ? "Conta Apresentação - " :  "") + Eval("BOL_VENCIMENTO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="60px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="BOL_VALOR" HeaderText="Valor Original" SortExpression="BOL_VALOR" UniqueName="BOL_VALOR">
                                <ItemTemplate>
                                    <asp:Label ID="lbOriginal" runat="server" Text='<%# "R$ " + Eval("BOL_VALOR", "{0:n2}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="80px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="DATAENVIADO" HeaderText="Enviado em" SortExpression="DATAENVIADO" UniqueName="DATAENVIADO">
                                <ItemTemplate>
                                    <asp:Label ID="lbEnvioAviso" runat="server" Font-Size="9pt" Text='<%# Eval("DATAENVIADO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="BOL_DATA_VISUALIZACAO" HeaderText="Visualizado em" SortExpression="BOL_DATA_VISUALIZACAO" UniqueName="BOL_DATA_VISUALIZACAO">
                                <ItemTemplate>
                                    <asp:Label ID="lbVisualizado" runat="server" Font-Size="9pt" Text='<%# Eval("BOL_VISUALIZADO_WEBEM", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="PAGO" HeaderText="" SortExpression="PAGO" UniqueName="PAGO">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lkGerarBoleto2" runat="server" CssClass="sitebutton red">
                                        <%# (Convert.ToBoolean(Eval("BOL_CONTRA_APRESENTACAO")) ? "Contra Apresentação - " :  "") + "Em aberto "  %>
                                        <asp:Image ID="imgAberto" runat="server" ImageUrl="~/Imagens/24x24/Warning24x24.png" />
                                    </asp:LinkButton>

                                    <asp:Panel ID="PanelVencimento" runat="server" CssClass="sitepadroesinvisible">
                                        <table style="border-left: 1px solid #BDBDBD">
                                            <tr>
                                                <td>Data do pagamento >
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="RadComboBoxVencimentos" Height="200" Skin="flv" EnableEmbeddedSkins="false" runat="server" Width="120px"></telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:HiddenField ID="hidden_ind" runat="server" Value='<%# Eval("BOL_IND") %>' />
                                                    <asp:LinkButton ID="lkBoletos" runat="server" CssClass="sitebutton blue" OnClick="lkBoletos_Click">
                                                        Gerar Boleto
                                                                <asp:Image ID="imgGerar2" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" />
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </ItemTemplate>
                                <HeaderStyle Width="300px" />
                            </telerik:GridTemplateColumn>
                        </Columns>

                    </MasterTableView>
                </telerik:RadGrid>

            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="SqlDataCadastro" OnLoad="SqlData_Load" runat="server"
        SelectCommand="SELECT CAD_IND, CAD_RAZAOSOCIAL, RTRIM(CAD_ENDERECO) AS ENDERECO, RTRIM(CAD_ENDERECO_NUMERO) AS NUMERO, RTRIM(CAD_COMPLEMENTO) AS COMPLEMENTO, 
                    RTRIM(CAD_BAIRRO) AS BAIRRO, (CAD_CIDADE) AS CIDADE, RTRIM(CAD_CEP) AS CEP, CAD_ESTADO, CAD_CADASTRO_ATUALIZADO_EM,
                    CAD_FINANCEIRO_EMAIL, CAD_FINANCEIRO_EMAIL2, CAD_FINANCEIRO_EMAIL3, (CAD_FINANCEIRO_CELULAR1_DDD + ' ' + CAD_FINANCEIRO_CELULAR1) AS CELULAR, 
                    (CASE WHEN CAD_CELULAR_ACEITA IS NULL THEN 0 ELSE CAD_CELULAR_ACEITA END) AS CEL_ACEITA,
                    CAD_FINANCEIRO_TELEFONE1_DDD, CAD_FINANCEIRO_TELEFONE1, CAD_FINANCEIRO_TELEFONE2, CAD_FINANCEIRO_TELEFONE2_DDD

                    FROM Boletos 
                    INNER JOIN Cadastros ON BOL_CADASTRO = CAD_IND
                    INNER JOIN Grupos ON BOL_GRUPO = GRU_IND
                    INNER JOIN ContasRegistros ON BOL_IND = CTAR_BOLETO
                    WHERE dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj(@CNPJ) OR dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj(@CNPJ)">
        <SelectParameters>
            <asp:QueryStringParameter Name="CNPJ" Type="String" QueryStringField="cnpj" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataBoletosAbertos" OnLoad="SqlData_Load" runat="server"
        SelectCommand="SELECT BOL_IND, BOL_VALOR, BOL_CONTRA_APRESENTACAO, 
                    (CASE WHEN dbo.fn_data_eh_feriado(dbo.fn_dia_util(BOL_VENCIMENTO)) = 1 THEN DATEADD(DAY, 1, dbo.fn_dia_util(BOL_VENCIMENTO)) ELSE dbo.fn_dia_util(BOL_VENCIMENTO) END) AS BOL_VENCIMENTO, BOL_NOSSO_NUMERO, BOL_VISUALIZADO_WEBEM, 
                     CAD_IND, CAD_CADASTRO_ATUALIZADO_EM, RTRIM(GRU_INSCRICAO_MUNICIPAL) AS COD_MUNICIPAL, NOTS_NUMERO, RTRIM(NOTS_CODIGO_VERIFICACAO) AS COD_VERIFICACAO,
                    
                    (CASE WHEN BOL_FATURAMENTO_ENVIADOEM IS NULL THEN (CASE WHEN BOL_COBRANCA_ENVIADOEM IS NULL THEN 
		                    (CASE WHEN BOL_AVISO_ENVIADOEM IS NULL THEN BOL_ENVIADOEM ELSE BOL_AVISO_ENVIADOEM END)
	                ELSE BOL_COBRANCA_ENVIADOEM END) ELSE BOL_FATURAMENTO_ENVIADOEM END) AS DATAENVIADO

                    FROM Boletos 
                    INNER JOIN Cadastros ON BOL_CADASTRO = CAD_IND
                    INNER JOIN Grupos ON BOL_GRUPO = GRU_IND
                    LEFT JOIN ConfigBoletos ON BOL_CONTAP = CFGB_CONTAP
                    INNER JOIN ContasRegistros ON BOL_IND = CTAR_BOLETO
                    LEFT JOIN NotasServicos ON NOTS_NUMERO = BOL_NUMERO_DOCTO AND NOTS_CADASTRO = CAD_IND
                    WHERE BOL_CANCELADO = 0 AND CTAR_VALOR_PAGTO IS NULL AND BOL_IGNORAR = 0 AND CTAR_IGNORADO = 0 
                    AND (dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj(@CNPJ) OR dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj(@CNPJ))
                    AND 
                    (CASE WHEN dbo.fn_data_eh_feriado(dbo.fn_dia_util(BOL_VENCIMENTO)) = 1 THEN DATEADD(DAY, 1, dbo.fn_dia_util(BOL_VENCIMENTO)) ELSE dbo.fn_dia_util(BOL_VENCIMENTO) END)
                    &lt; CONVERT(DATE, GETDATE()) AND BOL_CONTRA_APRESENTACAO = 0
                    ORDER BY BOL_VENCIMENTO DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="CNPJ" Type="String" QueryStringField="cnpj" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataVencimentos" OnLoad="SqlData_Load" runat="server"
        SelectCommand="SELECT BOL_IND, 
                    (CASE WHEN dbo.fn_data_eh_feriado(dbo.fn_dia_util(BOL_VENCIMENTO)) = 1 THEN DATEADD(DAY, 1, dbo.fn_dia_util(BOL_VENCIMENTO)) ELSE dbo.fn_dia_util(BOL_VENCIMENTO) END) AS BOL_VENCIMENTO, 
                    CAD_CADASTRO_ATUALIZADO_EM, (CASE WHEN CAD_CNPJ IS NULL THEN CAD_CPF ELSE CAD_CNPJ END) AS CPF_CNPJ, BOL_CONTRA_APRESENTACAO
                    FROM Boletos 
                    INNER JOIN Cadastros ON BOL_CADASTRO = CAD_IND
                    INNER JOIN ContasRegistros ON BOL_IND = CTAR_BOLETO
                    WHERE BOL_CANCELADO = 0 AND CTAR_VALOR_PAGTO IS NULL AND BOL_IGNORAR = 0 AND CTAR_IGNORADO = 0 AND
                    (dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj(@CNPJ) OR dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj(@CNPJ))
                    AND CONVERT(DATE, BOL_VENCIMENTO) &lt;= CONVERT(DATE, GETDATE() + 45)  AND
                    (CASE WHEN dbo.fn_data_eh_feriado(dbo.fn_dia_util(BOL_VENCIMENTO)) = 1 THEN DATEADD(DAY, 1, dbo.fn_dia_util(BOL_VENCIMENTO)) ELSE dbo.fn_dia_util(BOL_VENCIMENTO) END)
                     &gt;= CONVERT(DATE, GETDATE())
                    ORDER BY BOL_VENCIMENTO DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="CNPJ" Type="String" QueryStringField="cnpj" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataCountBoletos" OnLoad="SqlData_Load" runat="server"
        SelectCommand="SELECT ISNULL(COUNT(*), 0) AS Total FROM Boletos 
                        INNER JOIN Cadastros ON BOL_CADASTRO = CAD_IND
                        INNER JOIN ContasRegistros ON BOL_IND = CTAR_BOLETO
                        WHERE BOL_CANCELADO = 0 AND CTAR_VALOR_PAGTO IS NULL AND BOL_IGNORAR = 0 AND CTAR_IGNORADO = 0 AND 
                        (dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj(@CNPJ) OR dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj(@CNPJ))
					    AND 
                        (CASE WHEN dbo.fn_data_eh_feriado(dbo.fn_dia_util(BOL_VENCIMENTO)) = 1 THEN DATEADD(DAY, 1, dbo.fn_dia_util(BOL_VENCIMENTO)) ELSE dbo.fn_dia_util(BOL_VENCIMENTO) END)
                        &lt; CONVERT(DATE, GETDATE()) AND BOL_CONTRA_APRESENTACAO = 0 ">
        <SelectParameters>
            <asp:QueryStringParameter Name="CNPJ" Type="String" QueryStringField="cnpj" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:content>
