<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="RelatorioRevenda.aspx.cs" Inherits="Asseponto.Suporte.Relatorios.RelatorioRevenda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
    <style type="text/css">
        .align-center {
            text-align:center;
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
            <table style="Width: 835px">
                <tr>
                    <td style="vertical-align: top;">
                        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" Font-Size="14px" Width="100%">
                            <EditItemTemplate>
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbMes" runat="server" ForeColor="#EF461D" Style="font-weight: 600" Text='<%# Asseponto.Classes.Utils.getMesAnoFormat(Convert.ToInt32(Request.QueryString["ind"]), Convert.ToInt32(Request.QueryString["ano"]))  %>'></asp:Label>
                                            -
                                            <asp:Label ID="lbqtdevidada" runat="server" Style="font-weight: 600" Text='<%# Eval("NOME") + " Cadastros" %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </EditItemTemplate>
                        </asp:FormView>
                        <br />
                        <b>Pesquisa</b>
                        <telerik:RadComboBox ID="comboboxRep" Width="400" EmptyMessage="Selecione um fabricante" CausesValidation="false" DataSourceID="SqlRep" AutoPostBack="true" OnDataBound="comboboxRep_DataBound"
                            OnSelectedIndexChanged="comboboxRep_SelectedIndexChanged" DataTextField="FABR_NOME" DataValueField="FABR_COD" runat="server" Skin="flv" EnableEmbeddedSkins="false">
                        </telerik:RadComboBox>

                        <asp:SqlDataSource ID="SqlRep" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                            SelectCommand="SELECT FABR_NOME, FABR_COD FROM AssepontoRepFabricantes WHERE FABR_ATIVO = 1"></asp:SqlDataSource>
                    </td>
                    <td style="vertical-align: top; text-align: right;">
                        <input type="button" value="Imprimir Relatório" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebutton" />
                    </td>
                    <td style="vertical-align: top;">
                        <asp:ImageButton ID="ImageWorld" runat="server" ImageUrl="~/Images/48x48/Word.PNG" AlternateText="Exportar" OnClick="ImageWorld_Click" />
                    </td>
                </tr>
            </table>
            <br />
            <br />


            <div id="DivImpressao">
                
                <telerik:RadGrid ID="RadGridGoldPremium" DataSourceID="SqlDataRevendaGoldPremium" runat="server" Skin="flv"
                    EnableEmbeddedSkins="false" AllowSorting="false" AllowMultiRowSelection="False" ShowGroupPanel="false" 
                    AutoGenerateColumns="False" GridLines="none" GroupingSettings-CaseSensitive="false"
                    MasterTableView-ExpandCollapseColumn-Display="false" PagerStyle-ShowPagerText="true" PagerTextFormat="{4} {5}" 
                    AllowAutomaticInserts="false" AllowAutomaticUpdates="true" OnUpdateCommand="RadGridGoldPremium_UpdateCommand" 
                    RenderMode="Lightweight" >

                    <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Registros"></PagerStyle>

                    <MasterTableView Width="810" AlternatingItemStyle-Height="40px" DataSourceID="SqlDataRevendaGoldPremium" 
                        DataKeyNames="REV_IND" EditMode="InPlace" AllowFilteringByColumn="False" AllowSorting="False" 
                        AutoGenerateColumns="false">
                        <NoRecordsTemplate>
                            <div>
                                Nenhum Registro Encontrado.
                            </div>
                        </NoRecordsTemplate>

                        <GroupByExpressions>
                            <telerik:GridGroupByExpression>
                                <SelectFields>
                                    <telerik:GridGroupByField FieldAlias="REVSTATUS" FieldName="REVSTATUS" HeaderText="Revenda" HeaderValueSeparator=" "></telerik:GridGroupByField>
                                </SelectFields>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldName="REVSTATUS" SortOrder="Ascending"></telerik:GridGroupByField>
                                </GroupByFields>
                            </telerik:GridGroupByExpression>
                        </GroupByExpressions>

                        <Columns>
                            <telerik:GridTemplateColumn DataField="REV_RAZAOSOCIAL"
                                HeaderText="Revendas" SortExpression="REV_RAZAOSOCIAL" UniqueName="REV_RAZAOSOCIAL">
                                <ItemTemplate>
                                    <asp:HyperLink ID="lbNome" runat="server" Target="_blank" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("REV_IND", "~/suporte/Revendas/Revenda.aspx?ind={0}") %>'><%# Eval("REV_RAZAOSOCIAL")%></asp:HyperLink></b>
                                    <br />
                                    Quantidade de Clientes:
                                <asp:Label ID="lbQtdClientes" runat="server" Text='<%# Eval("NCLIENTES") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="300px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="REV_DATA_CADASTRO" ItemStyle-Font-Size="11px" AllowFiltering="false"
                                HeaderText="Cadastrado" SortExpression="REV_DATA_CADASTRO" UniqueName="REV_DATA_CADASTRO">
                                <ItemTemplate>
                                    <asp:Label ID="lbDataCadastro" runat="server" Text='<%# Eval("REV_DATA_CADASTRO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="80px" />
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="RELOGIOS" ItemStyle-Font-Size="11px" AllowFiltering="false"
                                HeaderText="Relogios Comercializados" SortExpression="RELOGIOS" UniqueName="RELOGIOS">
                                <ItemTemplate>
                                    <asp:Label ID="lbREP" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RELOGIOS").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" />
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>

                            
                            <telerik:GridCheckBoxColumn DataField="REV_ETIQUETA" ItemStyle-Font-Size="11px" AllowFiltering="false"
                                HeaderText="Etiqueta" SortExpression="REV_ETIQUETA" UniqueName="REV_ETIQUETA" ItemStyle-Font-Underline="true"
                                HeaderStyle-Width="80px">
                            </telerik:GridCheckBoxColumn>
                            
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditColumn" EditText="Editar" EditImageUrl="../../Images/16x16/file_edit.png" 
                                UpdateText="Salvar" UpdateImageUrl="../../Images/16x16/save.png" CancelText="Voltar" CancelImageUrl="../../Images/16x16/back.png" >
                                <ItemStyle Width="50px" CssClass="align-center" />
                            </telerik:GridEditCommandColumn>

                        </Columns>
                        <EditFormSettings ColumnNumber="4">
                            <EditColumn ButtonType="ImageButton" />
                        </EditFormSettings>
                    </MasterTableView>
                    <ClientSettings AllowKeyboardNavigation="true"></ClientSettings>
                </telerik:RadGrid>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataRevendaGoldPremium" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelecting="SqlData_Selecting" 
        SelectCommand="SELECT DISTINCT REV_IND, REV_ETIQUETA, 
                            (CASE WHEN REV_STATUS = 1 THEN 'Premium' ELSE 'Gold' END) as REVSTATUS,
                             REV_RAZAOSOCIAL, REV_DATA_CADASTRO , dbo.fn_asseponto_n_clientes_revenda(REV_IND) AS NCLIENTES, 
                            (SELECT FABR_NOME + CHAR (13) + CHAR (10) FROM AssepontoRevendasReps LEFT JOIN AssepontoRepFabricantes ON FABR_COD = REVREP_REP
                                WHERE REVREP_REVENDA = REV_IND FOR XML PATH('')) AS RELOGIOS
                            FROM AssepontoRevendas
                            INNER JOIN AssepontoRevendasReps ON REVREP_REVENDA = REV_IND
                            WHERE (MONTH(REV_DATA_CADASTRO) = @ind AND YEAR(REV_DATA_CADASTRO) = @ano AND REVREP_REP = @rep)
                            OR (MONTH(REV_DATA_CADASTRO) = @ind AND YEAR(REV_DATA_CADASTRO) = @ano AND @rep = 0)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" Type="Int32" QueryStringField="ind" />
            <asp:QueryStringParameter Name="ano" Type="Int32" QueryStringField="ano" />
            <asp:QueryStringParameter Name="rep" DefaultValue="0" QueryStringField="rep" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelecting="SqlData_Selecting"
        SelectCommand="SELECT COUNT(DISTINCT REV_RAZAOSOCIAL) AS NOME FROM AssepontoRevendas
                            INNER JOIN AssepontoRevendasReps ON REVREP_REVENDA = REV_IND
                            WHERE (MONTH(REV_DATA_CADASTRO) = @ind
                            AND YEAR(REV_DATA_CADASTRO) = @ano AND REVREP_REP = @rep)
                            OR (MONTH(REV_DATA_CADASTRO) = @ind
                            AND YEAR(REV_DATA_CADASTRO) = @ano AND @rep = 0)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" Type="Int32" QueryStringField="ind" />
            <asp:QueryStringParameter Name="ano" Type="Int32" QueryStringField="ano" />
            <asp:QueryStringParameter Name="rep" DefaultValue="0" QueryStringField="rep" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
