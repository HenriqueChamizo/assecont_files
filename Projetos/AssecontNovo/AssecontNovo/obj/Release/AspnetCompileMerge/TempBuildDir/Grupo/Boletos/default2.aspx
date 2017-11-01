<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="Assecont2.Grupo.Boletos._default2" %>

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

        function OpenBoleto() {
            var data = getQueryStringValue("data");
            var id = getQueryStringValue("id");
            var cnpj = getQueryStringValue("cnpj");

            if (data != "") {
                var url = "http://www.assecont.com.br/assecont/Grupo/Boletos/Boleto2.aspx?cnpj=" + cnpj + "&data=" + data + "&id=" + id;

                OpenBolRad(url);
            }
        }

        function getQueryStringValue(key) {
            return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
        }

        function OpenBolRad(url) {
            var oWnd1 = $find("<%= RadWindowAtulizaEmail.ClientID %>");
            oWnd1.set_initialBehaviors(Telerik.Web.UI.WindowBehaviors.Pin);
            oWnd1.set_animation(Telerik.Web.UI.WindowAnimation.Fade);
            oWnd1.setUrl(url);
            oWnd1.show();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataBoletos" DataKeyNames="BOL_IND">
        <ItemTemplate>
            <div style="font-size: 15pt;">
                Boa tarde,
                <asp:Label ID="lbBoletoSacado" runat="server" ForeColor="SteelBlue" Text='<%# Wr.Classes.Strings.capitalizeWords(Eval("CAD_RAZAOSOCIAL").ToString()) %>'></asp:Label>
            </div>
            <br />
            Confira seus dados cadastrados:<br />
            <br />
            <table style="border-bottom: 1px dashed #BDBDBD;" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>

                        <asp:Label ID="lbEndereco" runat="server" Text='<%# Eval("ENDERECO") %>'></asp:Label>
                        <asp:Label ID="lbNumero" runat="server" Text='<%# Eval("NUMERO") %>'></asp:Label>
                        <br />
                        <asp:Label ID="lbBairro" runat="server" Text='<%# Eval("BAIRRO") %>'></asp:Label>
                        <asp:Label ID="lbCidade" runat="server" Text='<%# Eval("CIDADE") %>'></asp:Label>
                        <asp:Label ID="lbUF" runat="server" Text='<%# " - " + Eval("CAD_ESTADO") %>'></asp:Label>
                        <asp:Label ID="lbCep" runat="server" Text='<%# Eval("CEP") %>'></asp:Label>
                        <br />
                        <br />
                        Endereços para envio do email:
                        <asp:Label ID="lbEmail" runat="server" Font-Bold="true" Text='<%# Eval("CAD_EMAIL") %>'></asp:Label>
                        <asp:Label ID="lbEmail2" runat="server" Font-Bold="true" Visible='<%# Eval("CAD_EMAIL2") is DBNull ? false : true %>' Text='<%# ", " + Eval("CAD_EMAIL2") %>'></asp:Label>
                        <asp:Label ID="lbEmail3" runat="server" Font-Bold="true" Visible='<%# Eval("CAD_EMAIL3") is DBNull ? false : true %>' Text='<%# ", " + Eval("CAD_EMAIL3") %>'></asp:Label>
                        <br />
                        <br />
                        Celular para envio do aviso por SMS:
                        <asp:Label ID="lbCelular" runat="server" Font-Bold="true" Text='<%# Eval("CELULAR") is DBNull ? "-" : Eval("CELULAR") %>'></asp:Label>
                        <br />
                        <br />
                        <a id="lkAtualizaEmail" runat="server" class="sitebutton blue" onclick='<%# "OpenAtualizaEmail(" + Eval("CAD_IND") + ")"%>'>Atualizar Dados
                        <asp:Image ID="imgAtualiza" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" /></a>
                        <br />
                        <br />
                    </td>
                </tr>
            </table>
            <br />
            Para imprimir o boleto, clique no link "Gerar Boleto".
            <br />
            Pagamentos efetuados após esta data e hora irão constar como <span class="font_red">em aberto</span>.
            <br />
            <br />
        </ItemTemplate>
    </asp:FormView>

    <telerik:radwindowmanager id="RWM_AtulizaEmail" runat="server" enableshadow="true" reloadonshow="True" autosizebehaviors="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindowAtulizaEmail" runat="server" EnableEmbeddedSkins="false" Skin="flv" Title="Atualizar Dados"
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="550" Width="650" Behaviors="Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:radwindowmanager>
    <script>
        OpenBoleto();
    </script>
    <telerik:radgrid id="RadGridBoletos" runat="server" allowpaging="True" datasourceid="SqlDataBoletos"
        cellspacing="0" gridlines="None" pagesize="12" edititemstyle-horizontalalign="Justify"
        enableembeddedskins="false" skin="flv" onitemdatabound="RadGridBoletos_ItemDataBound"
        onitemcommand="RadGridBoletos_ItemCommand">

        <MasterTableView DataSourceID="SqlDataBoletos" AllowPaging="true" AutoGenerateColumns="false"
            DataKeyNames="BOL_IND" ItemStyle-Height="40px" AlternatingItemStyle-Height="40px"
            AlternatingItemStyle-BackColor="#F7F7F7">

            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
            </RowIndicatorColumn>
            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
            </ExpandCollapseColumn>
            <Columns>

                <telerik:GridTemplateColumn DataField="BOL_NOSSO_NUMERO"
                    HeaderText="Boleto" SortExpression="BOL_NOSSO_NUMERO">
                    <ItemTemplate>
                        <asp:Label ID="lbBoletoNN" runat="server" Text='<%# Eval("BOL_NOSSO_NUMERO") %>'></asp:Label>
                        <%-- <asp:Image ID="imgRegistrado" runat="server" ImageUrl="~/Imagens/16x16/Registrado16x16.png" Visible='<%# Eval("BOL_REGISTRO_DATA") is DBNull ? false : true %>' />--%>
                    </ItemTemplate>
                    <HeaderStyle Width="30px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="COD_VERIFICACAO"
                    HeaderText="Nota" SortExpression="COD_VERIFICACAO">
                    <ItemTemplate>
                        <asp:Label ID="lbRisco" Visible='<%# Eval("COD_VERIFICACAO") is DBNull ? true : false %>' runat="server" Text=" - "></asp:Label>
                        <asp:HyperLink ID="HyNotaFiscal" Class="sitebutton blue" Visible='<%# Eval("COD_VERIFICACAO") is DBNull ? false : true %>' runat="server"
                            NavigateUrl='<%# "https://nfe.prefeitura.sp.gov.br/contribuinte/notaprint.aspx?ccm=" + Eval("COD_MUNICIPAL") + "&nf=" + Eval("NOTS_NUMERO") + "&cod=" + Eval("COD_VERIFICACAO") %>'>
                            Nota Fiscal
                            <asp:Image ID="imgNotaFiscal" runat="server" ImageUrl="~/Imagens/24x24/Payment24x24.png" />
                        </asp:HyperLink>
                    </ItemTemplate>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="BOL_VENCIMENTO"
                    HeaderText="Vencimento" SortExpression="BOL_VENCIMENTO">
                    <ItemTemplate>
                        <asp:Label ID="lbVencimento" runat="server" Text='<%# Eval("BOL_VENCIMENTO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="60px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="BOL_VALOR"
                    HeaderText="Valor Original" SortExpression="BOL_VALOR" UniqueName="BOL_VALOR">
                    <ItemTemplate>
                        <asp:Label ID="lbOriginal" runat="server" Text='<%# "R$ " + Eval("BOL_VALOR", "{0:n2}") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="65px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="BOL_ENVIADOEM"
                    HeaderText="Enviado em" SortExpression="BOL_ENVIADOEM" UniqueName="BOL_ENVIADOEM">
                    <ItemTemplate>
                        <asp:Label ID="lbEnvioAviso" runat="server" Font-Size="9pt" Text='<%# Eval("BOL_ENVIADOEM") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="100px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="BOL_DATA_VISUALIZACAO"
                    HeaderText="Visualizado em" SortExpression="BOL_DATA_VISUALIZACAO" UniqueName="BOL_DATA_VISUALIZACAO">
                    <ItemTemplate>
                        <%--        <asp:Label ID="lbVisualizado" runat="server" Font-Size="9pt" Text='<%# Eval("BOL_DATA_VISUALIZACAO") %>'></asp:Label>--%>
                    </ItemTemplate>
                    <HeaderStyle Width="100px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="PAGO"
                    HeaderText="" SortExpression="PAGO" UniqueName="PAGO">
                    <ItemTemplate>
                        <asp:Label ID="lbDescricao" runat="server" Visible='<%# Convert.ToInt32(Eval("PAGO")) == 1 ? true : false %>'>PAGO
                            <asp:Image ID="imgCheck" runat="server" ImageUrl="~/Imagens/24x24/check24x24.png" />
                        </asp:Label>

                        <asp:LinkButton ID="lbBoletoPago" runat="server" CssClass="sitebutton blue" OnClick="lbBoletoPago_Click" Visible='<%# Convert.ToInt32(Eval("PAGO")) == 2 %>'>
                            Gerar Boleto
                            <asp:Image ID="imgGerar1" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" />
                        </asp:LinkButton>

                        <asp:LinkButton ID="lkGerarBoleto2" runat="server" CssClass="sitebutton red" Visible='<%# Convert.ToInt32(Eval("PAGO")) == 0 %>'>
                            Em aberto
                            <asp:Image ID="imgAberto" runat="server" ImageUrl="~/Imagens/24x24/Warning24x24.png" />
                        </asp:LinkButton>

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
            <NoRecordsTemplate>
                <div>
                    <table style="margin-top: 50px; width: 450px;">
                        <tr>
                            <td>
                                <img src="http://www.assecont.com.br/assecont/Imagens/Site/Error.png" width="80" />

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

    </telerik:radgrid>
    <asp:SqlDataSource ID="SqlDataBoletos" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionStringAssefin %>"
        SelectCommand="SELECT CAD_IND, CAD_RAZAOSOCIAL, RTRIM(CAD_ENDERECO) AS ENDERECO, RTRIM(CAD_ENDERECO_NUMERO) AS NUMERO, RTRIM(CAD_COMPLEMENTO) AS COMPLEMENTO, 
                    RTRIM(CAD_BAIRRO) AS BAIRRO, (CAD_CIDADE) AS CIDADE, RTRIM(CAD_CEP) AS CEP, CAD_ESTADO,  
                    CAD_EMAIL, CAD_EMAIL2, CAD_EMAIL3, (CAD_CELULAR_DDD + ' ' + CAD_CELULAR) AS CELULAR, 

                    (SELECT (CASE WHEN CTAR_VALOR_PAGTO IS NOT NULL THEN '1' 
                    ELSE (CASE WHEN BOL_VENCIMENTO &lt;= GETDATE() THEN '0' ELSE '2' END) 
                    END) FROM ContasRegistros WHERE BOL_IND = CTAR_BOLETO) AS PAGO,

                    BOL_IND, BOL_VALOR, BOL_ENVIADOEM, BOL_VENCIMENTO, BOL_NOSSO_NUMERO,
                    RTRIM(GRU_INSCRICAO_MUNICIPAL) AS COD_MUNICIPAL, NOTS_NUMERO, RTRIM(NOTS_CODIGO_VERIFICACAO) AS COD_VERIFICACAO,
                    (CASE WHEN CONVERT(DATE, BOL_VENCIMENTO) &gt;= CONVERT(DATE, GETDATE()) THEN 1 ELSE 0 END) AS PRAZO,
                    (SELECT (CASE WHEN CTAR_VALOR_PAGTO IS NULL THEN 0 ELSE 1 END) FROM ContasRegistros WHERE BOL_IND = CTAR_BOLETO) AS PAGO
                    FROM Boletos 
                    INNER JOIN Cadastros ON BOL_CADASTRO = CAD_IND
                    INNER JOIN Grupos ON BOL_GRUPO = GRU_IND
                    INNER JOIN ConfigBoletos ON BOL_CONTAP = CFGB_CONTAP
                    LEFT JOIN NotasServicos ON NOTS_NUMERO = BOL_NUMERO_DOCTO
                    Where dbo.fn_trim_cnpj(RTRIM(CAD_CNPJ)) = dbo.fn_trim_cnpj(RTRIM(@CNPJ)) OR dbo.fn_trim_cnpj(RTRIM(CAD_CPF)) = dbo.fn_trim_cnpj(RTRIM(@CNPJ))
                    ORDER BY BOL_VENCIMENTO DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="CNPJ" Type="String" QueryStringField="cnpj" />
            <asp:QueryStringParameter Name="ANO" Type="Int32" QueryStringField="ano" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
