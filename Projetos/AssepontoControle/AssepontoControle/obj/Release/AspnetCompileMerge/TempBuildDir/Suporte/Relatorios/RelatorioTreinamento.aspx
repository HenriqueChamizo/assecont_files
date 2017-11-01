<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="RelatorioTreinamento.aspx.cs" Inherits="Asseponto.Suporte.Relatorios.RelatorioTreinamento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
    <style type="text/css">
        .rgExpand, .rgCollapse
        {
            display: none;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%" OnItemClick="RadMenu1_ItemClick" OnPreRender="RadMenu1_PreRender">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Janeiro" Value="1" />
                <telerik:RadMenuItem runat="server" Text="Fevereiro" Value="2" />
                <telerik:RadMenuItem runat="server" Text="Março" Value="3" />
                <telerik:RadMenuItem runat="server" Text="Abril" Value="4" />
                <telerik:RadMenuItem runat="server" Text="Maio" Value="5" />
                <telerik:RadMenuItem runat="server" Text="Junho" Value="6" />
                <telerik:RadMenuItem runat="server" Text="Julho" Value="7" />
                <telerik:RadMenuItem runat="server" Text="Agosto" Value="8" />
                <telerik:RadMenuItem runat="server" Text="Setembro" Value="9" />
                <telerik:RadMenuItem runat="server" Text="Outubro" Value="10" />
                <telerik:RadMenuItem runat="server" Text="Novembro" Value="11" />
                <telerik:RadMenuItem runat="server" Text="Dezembro" Value="12" />
                <telerik:RadMenuItem runat="server" Value="ano" Text="" />
                <telerik:RadMenuItem runat="server" Value="anoAnterior" Text="" />
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <div class="DivImpressao">
                <link href="http://www.assecont.com.br/Assepontocontrole/skins/Grid.flv.css" rel="stylesheet" />
                <link href="http://www.assecont.com.br/Assepontocontrole/Styles/Site.css" rel="stylesheet" />
                <link href="http://www.assecont.com.br/Assepontocontrole/Styles/FormView.css" rel="stylesheet" />
                <link href="http://www.assecont.com.br/Assepontocontrole/Skins/ComboBox.flv.css" rel="stylesheet" />

                <table style="width: 830px;">
                    <tr>
                        <td>Data<br />
                            <telerik:RadComboBox ID="comboboxDataHora" Width="400" EmptyMessage="Selecione uma Data" CausesValidation="false" DataSourceID="SqlAgendaAdmin" AutoPostBack="true" OnDataBound="comboboxDataHora_DataBound"
                                OnSelectedIndexChanged="comboboxDataHora_SelectedIndexChanged" DataTextField="DATAHORA" DataValueField="DATAHORA" runat="server" Skin="flv" DataTextFormatString="{0:dd/MM/yyyy}" EnableEmbeddedSkins="false">
                            </telerik:RadComboBox>

                            <asp:SqlDataSource ID="SqlAgendaAdmin" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelecting="SqlAgendaAdmin_Selecting"
                                SelectCommand="SELECT DISTINCT AGE_REALIZADO, AGE_CANCELADO, (CONVERT(NVARCHAR, AGE_DATA_HORA, 103)) AS DATAHORA
                                            FROM AssepontoAgendaTreinamentos 
                                            WHERE MONTH(AGE_DATA_HORA) = @IND AND YEAR(AGE_DATA_HORA) = @ANO AND AGE_ASSEPONTO4 = 1 AND AGE_REALIZADO = 1">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="IND" Type="Int32" QueryStringField="ind" />
                                    <asp:QueryStringParameter Name="ANO" Type="Int32" QueryStringField="ano" DefaultValue="0" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td style="text-align: right; width: 280px;">
                            <input type="button" value="Imprimir Relatório" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebuttonwhite" />
                        </td>
                    </tr>
                    <tr>
                        <td>Visualizar<br />
                            <telerik:RadComboBox ID="ComboboxCompareceu" Width="400" EmptyMessage="Selecione" CausesValidation="false" runat="server" AutoPostBack="true"
                                OnSelectedIndexChanged="ComboboxCompareceu_SelectedIndexChanged" Skin="flv" EnableEmbeddedSkins="false">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Não Compareceu" Value="0" />
                                    <telerik:RadComboBoxItem Text="Compareceu" Value="1" />
                                    <telerik:RadComboBoxItem Text="Todos" Value="2" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td style="text-align: right; width: 280px;">
                            <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlTreinamentoTotalizado" DefaultMode="Edit">
                                <EditItemTemplate>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lbMesAno" runat="server" ForeColor="#EF461D" Style="font-weight: 600"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="width: 250px;">
                                                <asp:Label ID="lbClientesManutencao" runat="server" Text='<%# Eval("MANUTENCAO") + " Clientes com manutenção atualmente." %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="width: 250px;">
                                                <asp:Label ID="lbForaPrazo" runat="server" Text='<%# Eval("FORA_PRAZO") + " Clientes fora do prazo." %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="width: 250px;">
                                                <asp:Label ID="lbFora" runat="server" Text='<%# Eval("PRAZO") + " Clientes dentro do prazo." %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </EditItemTemplate>
                            </asp:FormView>
                        </td>
                    </tr>
                </table>
                <br />
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlClientes" PagerStyle-AlwaysVisible="true"
                            CellSpacing="0" GridLines="None" AllowPaging="True" PageSize="30" EditItemStyle-HorizontalAlign="Justify" Width="830"
                            GroupingSettings-CaseSensitive="false" AllowSorting="true" SortingSettings-EnableSkinSortStyles="false"
                            EnableEmbeddedSkins="false" Skin="flv" PagerStyle-ShowPagerText="true" PagerTextFormat="{4} {5}">

                            <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Clientes"></PagerStyle>

                            <ExportSettings IgnorePaging="true" OpenInNewWindow="true">
                                <Pdf PageHeight="210mm" PageWidth="297mm" PageTopMargin="45mm"></Pdf>
                            </ExportSettings>

                            <MasterTableView DataSourceID="SqlClientes" AllowPaging="true" AutoGenerateColumns="false"
                                ItemStyle-Height="45px" AlternatingItemStyle-Height="45px" DataKeyNames="CAD_IND" AlternatingItemStyle-BackColor="#F7F7F7">

                                <NoRecordsTemplate>
                                    <table style="height: 80px; font-size: 12pt;">
                                        <tr>
                                            <td>Nenhum registro encontrado.</td>
                                        </tr>
                                    </table>
                                </NoRecordsTemplate>

                                <Columns>

                                    <telerik:GridTemplateColumn DataField="CAD_RAZAOSOCIAL"
                                        HeaderText="Empresa" SortExpression="CAD_RAZAOSOCIAL" UniqueName="CAD_RAZAOSOCIAL">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="lbRazaoSocial" runat="server" Target="_blank" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/Atendimento/Cliente.aspx?ind={0}") %>'><%# Eval("CAD_RAZAOSOCIAL").ToString().Length > 20 ? Eval("CAD_RAZAOSOCIAL").ToString().Substring(0, 20) : Eval("CAD_RAZAOSOCIAL") %></asp:HyperLink>
                                            <br />
                                            <asp:Label ID="lbCnpjCpf" runat="server" Text='<%# Eval("CNPJ_CPF") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Width="300px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="DIASCORRRIDOS"
                                        HeaderText="Prazo" SortExpression="DIASCORRRIDOS" UniqueName="DIASCORRRIDOS">
                                        <ItemTemplate>
                                            <asp:Label ID="lbStatus" runat="server" ForeColor='<%# Eval("DIASCORRRIDOS") is DBNull ? System.Drawing.Color.Black : Convert.ToInt32(Eval("DIASCORRRIDOS")) > 60 ? System.Drawing.Color.Red : System.Drawing.Color.Black %>'
                                                Text='<%# Eval("DIASCORRRIDOS") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle Width="100px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="MANUTENCAO"
                                        HeaderText="Manutenção" SortExpression="MANUTENCAO" UniqueName="MANUTENCAO">
                                        <ItemTemplate>
                                            <asp:Label ID="lbStatus" runat="server" Text='<%# Eval("MANUTENCAO") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle Width="100px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="AGE_DATA_HORA"
                                        HeaderText="Data" SortExpression="AGE_DATA_HORA" UniqueName="AGE_DATA_HORA">
                                        <ItemTemplate>
                                            <asp:Label ID="lbAgedaHora" runat="server" Text='<%# Eval("AGE_DATA_HORA", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle Width="110px" />
                                    </telerik:GridTemplateColumn>

                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>

        <asp:SqlDataSource ID="SqlClientes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelecting="SqlData_Selecting"
            SelectCommand="SELECT CAD_IND, CAD_RAZAOSOCIAL, dbo.fn_cliente_cnpj_cpf(CAD_IND) AS CNPJ_CPF, SUP_NOME, AGE_DATA_HORA, AGE_DESCRICAO, 
                    (CASE WHEN  dbo.fn_asseponto_cliente_tem_manutencao_ativa(AGECLI_CLIENTE) = 1 THEN NULL ELSE Solicitacao.DIAS END) AS DIASCORRRIDOS,
                    (SELECT TOP 1 (CASE WHEN MNT_CANCELADO = 1 THEN 'Cancelado' ELSE 'Manutenção desde ' + dbo.fn_asseponto_datetostr(MNT_DATA) END) FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND ORDER BY MNT_DATA DESC, MNT_IND DESC) AS MANUTENCAO
                    FROM AssepontoAgendaTreinamentos 
                    INNER JOIN AssepontoAgendaClientes ON AGE_IND = AGECLI_AGENDA
                    INNER JOIN AssepontoClientes ON AGECLI_CLIENTE = CAD_IND 
                    INNER JOIN AssepontoSuporte ON AGE_FINALIZADO_POR = SUP_IND
                    CROSS APPLY
                    (
	                    SELECT TOP 1 (DATEDIFF(DAY, NSE_DATA, AGE_DATA_HORA)) AS DIAS FROM AssepontoNSeries WHERE CAD_IND = NSE_CLIENTE  ORDER BY NSE_DATA ASC
                    ) Solicitacao
                    WHERE ((MONTH(AGE_DATA_HORA) = @IND AND YEAR(AGE_DATA_HORA) = @ANO AND @DATAHORA = '01/01/2001') OR 
					(CONVERT(DATE, AGE_DATA_HORA) = @DATAHORA)) AND
                    AGE_REALIZADO = 1 AND AGE_CANCELADO = 0 AND AGE_ASSEPONTO4 = 1 AND 
					(AGECLI_COMPARECEU = @COMPARECEU OR @COMPARECEU = 2)
                    ORDER BY AGE_DATA_HORA ASC">
            <SelectParameters>
                <asp:QueryStringParameter Name="IND" Type="Int32" QueryStringField="ind" />
                <asp:QueryStringParameter Name="ANO" Type="Int32" QueryStringField="ano" DefaultValue="0" />
                <asp:QueryStringParameter Name="DATAHORA" Type="DateTime" QueryStringField="agenda" DefaultValue="01/01/2001" />
                <asp:QueryStringParameter Name="COMPARECEU" Type="Byte" QueryStringField="comp" DefaultValue="2" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlTreinamentoTotalizado" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelecting="SqlData_Selecting"
            SelectCommand="SELECT COUNT(AGE_DESCRICAO) AS CLIENTE,
                SUM(CONVERT(int, dbo.fn_asseponto_cliente_tem_manutencao_ativa(AGECLI_CLIENTE))) AS MANUTENCAO,

                SUM(CASE WHEN dbo.fn_asseponto_cliente_tem_manutencao_ativa(AGECLI_CLIENTE) = 1 THEN 0 ELSE 
	                                    (CASE WHEN Solicitacao.DIAS &gt; 60 THEN 1 ELSE 0 END) END) AS FORA_PRAZO,

                SUM(CASE WHEN dbo.fn_asseponto_cliente_tem_manutencao_ativa(AGECLI_CLIENTE) = 1 THEN 0 ELSE 
	                                    (CASE WHEN Solicitacao.DIAS &lt;= 60 THEN 1 ELSE 0 END) END) AS PRAZO
                FROM AssepontoAgendaTreinamentos 
                INNER JOIN AssepontoAgendaClientes ON AGE_IND = AGECLI_AGENDA
                CROSS APPLY
                (
                    SELECT TOP 1 (DATEDIFF(DAY, NSE_DATA, AGE_DATA_HORA)) AS DIAS FROM AssepontoNSeries WHERE AGECLI_CLIENTE = NSE_CLIENTE  ORDER BY NSE_DATA ASC
                ) Solicitacao
                WHERE ((MONTH(AGE_DATA_HORA) = @IND AND YEAR(AGE_DATA_HORA) = @ANO AND @DATAHORA ='01/01/2001') OR 
				(CONVERT(DATE, AGE_DATA_HORA) = @DATAHORA) ) AND AGE_REALIZADO = 1 AND 
                AGE_CANCELADO = 0 AND AGE_ASSEPONTO4 = 1 
                AND (AGECLI_COMPARECEU = @COMPARECEU OR @COMPARECEU = 2)">
            <SelectParameters>
                <asp:QueryStringParameter Name="IND" Type="Int32" QueryStringField="ind" />
                <asp:QueryStringParameter Name="ANO" Type="Int32" QueryStringField="ano" />
                <asp:QueryStringParameter Name="DATAHORA" Type="DateTime" QueryStringField="agenda" DefaultValue="01/01/2001" />
                <asp:QueryStringParameter Name="COMPARECEU" Type="Byte" QueryStringField="comp" DefaultValue="2" />
            </SelectParameters>
        </asp:SqlDataSource>
</asp:Content>