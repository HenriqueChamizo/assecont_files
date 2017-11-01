<%@ Page Title="Assecont Contabilidade" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="BoletoTodos.aspx.cs" Inherits="AssecontNovo.Grupo.Boletos.BoletoTodos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="../../Jquery/ControlVisible/Visible.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataBoletos" DataKeyNames="BOL_IND">
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
            </table>
        </ItemTemplate>
    </asp:FormView>

    <asp:UpdatePanel ID="UpdateCentralBoletos" runat="server">
        <ContentTemplate>
            <telerik:RadGrid ID="RadGridBoletos" runat="server" AllowPaging="True" DataSourceID="SqlDataBoletos"
                CellSpacing="0" GridLines="None" PageSize="24" PagerStyle-AlwaysVisible="true"
                EnableEmbeddedSkins="false" Skin="flv" PagerStyle-ShowPagerText="true" OnItemDataBound="RadGridBoletos_ItemDataBound"
                PagerTextFormat="{4} {5}">

                <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Boletos encontrados"></PagerStyle>

                <MasterTableView DataSourceID="SqlDataBoletos" AllowPaging="true" AutoGenerateColumns="false"
                    DataKeyNames="BOL_IND" ItemStyle-Height="50px" AlternatingItemStyle-Height="50px"
                    AlternatingItemStyle-BackColor="#F7F7F7">

                    <Columns>

                        <telerik:GridTemplateColumn DataField="BOL_NOSSO_NUMERO" HeaderText="Boleto">
                            <ItemTemplate>
                                <asp:Label ID="lbBoletoNN" runat="server" Font-Size="12pt" Text='<%# "Boleto " + Eval("BOL_NOSSO_NUMERO") %>'></asp:Label>
                                <br />
                                <asp:Label ID="lbOriginal" runat="server" Font-Bold="true" Text='<%# "R$ " + Eval("BOL_VALOR", "{0:n2}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="BOL_VENCIMENTO" HeaderText="Vencimento">
                            <ItemTemplate>
                                <asp:Label ID="lbVencimento" runat="server" Visible='<%# Convert.ToBoolean(Eval("MOSTRAR_VENC")) ? true : false %>' Text='<%# Eval("BOL_VENCIMENTO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="COD_VERIFICACAO" HeaderText="Nota">
                            <ItemTemplate>
                                <asp:Label ID="lbRisco" Visible='<%# Eval("COD_VERIFICACAO") is DBNull ? true : false %>' runat="server" Text=" - "></asp:Label>
                                <asp:HyperLink ID="HyNotaFiscal" CssClass="sitebutton" BackColor="brown" Visible='<%# Eval("COD_VERIFICACAO") is DBNull ? false : true %>' runat="server"
                                    NavigateUrl='<%# "https://nfe.prefeitura.sp.gov.br/contribuinte/notaprint.aspx?ccm=" + Eval("COD_MUNICIPAL") + "&nf=" + Eval("NOTS_NUMERO") + "&cod=" + Eval("COD_VERIFICACAO") %>'>
                                Nota Fiscal
                                </asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle Width="80px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn DataField="DATAENVIADO" HeaderText="Enviado em">
                            <ItemTemplate>
                                <asp:Label ID="lbEnvioAviso" runat="server" Text='<%# Eval("DATAENVIADO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="100px" />
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="BOL_DATA_VISUALIZACAO" HeaderText="Visualizado em">
                            <ItemTemplate>
                                <asp:Label ID="lbVisualizado" runat="server" Text='<%# Eval("BOL_VISUALIZADO_WEBEM", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="100px" />
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="PAGO" HeaderText="" UniqueName="PAGO">
                            <ItemTemplate>
                                <asp:Label ID="lbDescricao" runat="server" Visible='<%# Convert.ToInt32(Eval("PAGO")) == 1 ? true : false %>'>
                                    <%# (Convert.ToBoolean(Eval("BOL_CONTRA_APRESENTACAO")) ? "Contra Apresentação - " :  "") + "PAGO "  %>
                                    <asp:Image ID="imgCheck" runat="server" ImageUrl="~/Imagens/24x24/check24x24.png" />
                                </asp:Label>

                                <asp:LinkButton ID="btnGerarBoleto" runat="server" CssClass="sitebutton blue" OnClick="btnGerarBoleto_Click " Visible='<%# Convert.ToInt32(Eval("PAGO")) == 2  ? true : false %>'>
                                    <%# (Convert.ToBoolean(Eval("BOL_CONTRA_APRESENTACAO")) ? "Contra Apresentação - " :  "") + "Gerar Boleto "  %>
                                    <asp:Image ID="imgGerar1" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" />
                                </asp:LinkButton>

                                <div style='<%# Eval("BCO_NUMERO").ToString().Equals("33") ? "": "display:none"  %>'>
                                    <asp:LinkButton ID="btnEmAberto" runat="server" CssClass="sitebutton red" Visible='<%# Convert.ToInt32(Eval("PAGO")) == 0 ? true : false %>'>
                                        <%# (Convert.ToBoolean(Eval("BOL_CONTRA_APRESENTACAO")) ? "Contra Apresentação - " :  "") + "Em aberto "  %>
                                        <asp:Image ID="imgAberto" runat="server" ImageUrl="~/Imagens/24x24/Warning24x24.png" />
                                    </asp:LinkButton>
                                </div>

                                <asp:Panel ID="PanelVencimento" runat="server" CssClass="sitepadroesinvisible">
                                    <table style="background-color: bisque">
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
                                                <asp:LinkButton ID="btnEmAbertoGerar" runat="server" CssClass="sitebutton blue" OnClick="btnGerarBoletoEmAberto_Click">
                                                    Gerar Boleto 
                                                    <asp:Image ID="imgGerar2" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" />
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>

                                <table style='<%# Convert.ToInt32(Eval("PAGO")) == 0 && !Eval("BCO_NUMERO").ToString().Equals("33") ? "": "display:none"  %>'>
                                    <tr>
                                        <td style="border: 0px; padding-left: 0px; border-spacing: 0px;">
                                            <a class="sitebutton red" href='<%# "/grupo/Boletos/Boleto.aspx?cnpj=" + Request.QueryString["cnpj"] + "&id=" + Eval("BOL_IND") + "'"  %>'>Em aberto 

                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagens/24x24/Warning24x24.png" />  </a>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                            <HeaderStyle Width="300px" />
                        </telerik:GridTemplateColumn>
                    </Columns>

                    <NoRecordsTemplate>
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
                    </NoRecordsTemplate>
                </MasterTableView>
            </telerik:RadGrid>
        </ContentTemplate>
    </asp:UpdatePanel>

    <br />
    <br />
    <asp:LinkButton ID="lkVoltar" runat="server" CssClass="sitebutton grayDark" OnClick="lkVoltar_Click">Voltar para a Central de Boletos</asp:LinkButton>

    <asp:SqlDataSource ID="SqlDataBoletos" runat="server" OnLoad="SqlDataAssefin_Load"
        SelectCommand="SELECT CAD_IND, CAD_RAZAOSOCIAL, RTRIM(CAD_ENDERECO) AS ENDERECO, RTRIM(CAD_ENDERECO_NUMERO) AS NUMERO, RTRIM(CAD_COMPLEMENTO) AS COMPLEMENTO, 
                    RTRIM(CAD_BAIRRO) AS BAIRRO, (CAD_CIDADE) AS CIDADE, RTRIM(CAD_CEP) AS CEP, CAD_ESTADO,
                    CAD_FINANCEIRO_EMAIL, CAD_FINANCEIRO_EMAIL2, CAD_FINANCEIRO_EMAIL3, (CAD_FINANCEIRO_CELULAR1_DDD + ' ' + CAD_FINANCEIRO_CELULAR1) AS CELULAR, 

                    (CASE WHEN CAD_CELULAR_ACEITA IS NULL THEN 0 ELSE CAD_CELULAR_ACEITA END) AS CEL_ACEITA,

                    (CASE WHEN CTAR_VALOR_PAGTO IS NOT NULL THEN 1 ELSE 
                          (CASE WHEN BOL_CONTRA_APRESENTACAO_EXIBIR_VENCIMENTO = 0 AND BOL_CONTRA_APRESENTACAO = 1 THEN 2 ELSE
	                                  (CASE WHEN 
                                            BOL_VENCIMENTO &lt; CONVERT(DATE, GETDATE()) 
                                                    THEN 0 ELSE 2 END) END) END) AS PAGO,  
                    
                    (CASE WHEN BOL_CONTRA_APRESENTACAO_EXIBIR_VENCIMENTO = 0 AND BOL_CONTRA_APRESENTACAO = 1 THEN 0 ELSE 1 END) AS MOSTRAR_VENC,
                    (SELECT BCO_NUMERO FROM ContasParticulares INNER JOIN Bancos ON BCO_IND = CTAP_BANCO WHERE BOL_CONTAP = CTAP_IND) AS BCO_NUMERO,

                    BOL_IND, BOL_VALOR, BOL_NOSSO_NUMERO, BOL_VISUALIZADO_WEBEM, CAD_CADASTRO_ATUALIZADO_EM, BOL_CONTRA_APRESENTACAO,
                    BOL_VENCIMENTO, 
                    
                    RTRIM(GRU_INSCRICAO_MUNICIPAL) AS COD_MUNICIPAL, NOTS_NUMERO, RTRIM(NOTS_CODIGO_VERIFICACAO) AS COD_VERIFICACAO,
                    
                    (CASE WHEN BOL_FATURAMENTO_ENVIADOEM IS NULL THEN (CASE WHEN BOL_COBRANCA_ENVIADOEM IS NULL THEN 
		                    (CASE WHEN BOL_AVISO_ENVIADOEM IS NULL THEN BOL_ENVIADOEM ELSE BOL_AVISO_ENVIADOEM END)
	                ELSE BOL_COBRANCA_ENVIADOEM END) ELSE BOL_FATURAMENTO_ENVIADOEM END) AS DATAENVIADO

                    FROM Boletos 
                    INNER JOIN Cadastros ON BOL_CADASTRO = CAD_IND
                    INNER JOIN Grupos ON BOL_GRUPO = GRU_IND
                    LEFT JOIN ConfigBoletos ON BOL_CONTAP = CFGB_CONTAP
                    INNER JOIN ContasRegistros ON BOL_IND = CTAR_BOLETO
                    LEFT JOIN NotasServicos ON NOTS_NUMERO = BOL_NUMERO_DOCTO AND NOTS_CADASTRO = CAD_IND
                    WHERE BOL_CANCELADO = 0  AND BOL_IGNORAR = 0 AND CTAR_IGNORADO = 0 AND (dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj(@CNPJ) OR dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj(@CNPJ))
                    AND CONVERT(DATE, BOL_VENCIMENTO) &lt;= CONVERT(DATE, GETDATE() + 45)
                    ORDER BY BOL_VENCIMENTO DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="CNPJ" Type="String" QueryStringField="cnpj" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
