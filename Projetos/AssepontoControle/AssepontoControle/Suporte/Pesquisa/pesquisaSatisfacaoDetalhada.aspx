<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="pesquisaSatisfacaoDetalhada.aspx.cs" Inherits="Asseponto.Suporte.Pesquisa.pesquisaSatisfacaoDetalhada" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <flv:menuleftpesquisa runat="server" id="MenuLeftPesquisa" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">

            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <table>
                        <tr>
                            <td style="width: 160px;">De<br />
                                <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Skin="Web20" AutoPostBack="true"
                                    OnSelectedDateChanged="RadDatePicker1_SelectedDateChanged">
                                    <Calendar Skin="Web20" UseColumnHeadersAsSelectors="False"
                                        UseRowHeadersAsSelectors="False" ViewSelectorText="x" />
                                    <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="" />
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>

                            </td>
                            <td style="width: 420px;">Para<br />
                                <telerik:RadDatePicker ID="RadDatePicker2" runat="server" Skin="Web20" OnSelectedDateChanged="RadDatePicker1_SelectedDateChanged" AutoPostBack="true">
                                    <Calendar Skin="Web20" UseColumnHeadersAsSelectors="False"
                                        UseRowHeadersAsSelectors="False" ViewSelectorText="x" />
                                    <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="" />
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                    </table>
                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlData" Width="780"
                        CellSpacing="0" GridLines="None" AllowPaging="True" PageSize="30" SortingSettings-SortToolTip="Classificar de A-Z ou Z-A"
                        GroupingSettings-CaseSensitive="false" AllowSorting="true" SortingSettings-EnableSkinSortStyles="false"
                        EnableEmbeddedSkins="false" Skin="flv" PagerStyle-ShowPagerText="true" pagertextformat="{4} {5}">

                        <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Registros encontrados"></PagerStyle>

                        <MasterTableView DataSourceID="SqlData" AllowPaging="true" AutoGenerateColumns="false"
                            ItemStyle-Height="40px" AlternatingItemStyle-Height="40px" DataKeyNames="LOGE_IND"
                            AlternatingItemStyle-BackColor="#F7F7F7" AllowAutomaticUpdates="true" NoMasterRecordsText="Nenhum registro encontrado">

                            <Columns>
                                <telerik:GridTemplateColumn DataField="LOGE_NOME" ShowSortIcon="true" HeaderText="Nome" SortExpression="LOGE_NOME" UniqueName="LOGE_NOME">
                                    <ItemTemplate>
                                        <asp:Label ID="lbNome" runat="server" Font-Size="14pt" Text='<%# Eval("LOGE_NOME") %>'></asp:Label><br />
                                        <asp:Label ID="lbRazaoSocial" runat="server" Text='<%# Eval("CLI_RAZAOSOCIAL")  %>'></asp:Label><br />
                                        <asp:Label ID="lbData" runat="server" Text='<%# "Respodindo em " + Eval("QUESRESP_DATA", "{0:dd/MM/yyyy}")  %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="350px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="Nota" ShowSortIcon="true" HeaderText="Nota" SortExpression="Nota" UniqueName="Nota">
                                    <ItemTemplate>
                                        <asp:Label ID="lbNota" runat="server" Font-Bold="true" Font-Size="25pt" ForeColor='<%# Convert.ToInt32(Eval("Nota")) > 8 ? System.Drawing.ColorTranslator.FromHtml("#009EFF") : Convert.ToInt32(Eval("Nota")) > 4 ? System.Drawing.Color.Orange : System.Drawing.Color.Red %>' Text='<%# Eval("Nota")  %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="LOGE_IND" HeaderText="Abrir" UniqueName="LOGE_IND" ShowSortIcon="false">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="HyperArquivo" runat="server" Target="_blank" NavigateUrl='<%# string.Format("~/pesquisas/pesquisaDepto.aspx?v=true&I={0}&S={1}&C={2}", Eval("LOGE_IND"), Eval("QUESRESP_SETOR"), Eval("CLI_IND") ) %>'>
                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagens/24x24/Open24x24.png" />
                                        </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle Width="80px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" OnLoad="SqlData_Load" OnSelecting="SqlData_Selecting"
                SelectCommand="SELECT LOGE_IND, LOGE_NOME, CLI_IND, CLI_RAZAOSOCIAL, CLI_CNPJ, QUESRESP_SETOR, QUESRESP_DATA, SUM(QUESRESP_ALTERNATIVA) AS NOTA FROM LoginsExternos 
                INNER JOIN LoginsExternosEmpresas ON LOGEE_LOGIN_EXTERNO = LOGE_IND
                INNER JOIN Clientes ON CLI_IND = LOGEE_EMPRESA
                OUTER APPLY
                (
	                SELECT * FROM QuestionariosRespostas WHERE QUESRESP_LOGIN_EXTERNO = LOGE_IND AND QUESRESP_EMPRESA = CLI_IND AND QUESRESP_SETOR = @SETOR
                ) a
                WHERE (@RESPONDERAM = 1 AND QUESRESP_DATA IS NOT NULL OR @RESPONDERAM = 0 AND QUESRESP_DATA IS NULL)
                GROUP BY  LOGE_IND, LOGE_NOME, CLI_IND, CLI_RAZAOSOCIAL, CLI_CNPJ, QUESRESP_SETOR, QUESRESP_DATA
                ORDER BY LOGE_NOME">
                <SelectParameters>
                    <asp:Parameter Name="RESPONDERAM" Type="Int32" />
                    <asp:Parameter Name="SETOR" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlData" runat="server" OnSelecting="SqlData_Selecting" ConnectionString="<%$ ConnectionStrings:AppConnectionStringAssecontweb %>"
        SelectCommand="EXEC rs_questionario_totalizado @P_PESQUISA_TIPO  = 3, @P_DATAINICIAL = @DATAINICIAL, @P_DATAFINAL = @DATAFINAL">
        <SelectParameters>
            <asp:Parameter Name="DATAINICIAL" Type="DateTime" />
            <asp:Parameter Name="DATAFINAL" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    </div>
</asp:Content>
