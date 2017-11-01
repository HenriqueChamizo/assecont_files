<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="pesquisaTecnicoDetalhado.aspx.cs" Inherits="Asseponto.Suporte.Pesquisa.pesquisaTecnicoDetalhado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <flv:MenuLeftPesquisa runat="server" ID="MenuLeftPesquisa" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <table>
                <tr>
                    <td>De<br />
                        <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Skin="Web20" AutoPostBack="true"
                            OnSelectedDateChanged="RadDatePicker1_SelectedDateChanged">
                            <Calendar Skin="Web20" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x" />
                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="" />
                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                        </telerik:RadDatePicker>

                    </td>
                    <td style="padding-left: 30px;">Até<br />
                        <telerik:RadDatePicker ID="RadDatePicker2" runat="server" Skin="Web20" OnSelectedDateChanged="RadDatePicker1_SelectedDateChanged" AutoPostBack="true">
                            <Calendar Skin="Web20" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x" />
                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="" />
                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                        </telerik:RadDatePicker>
                    </td>
                    <td style="padding-left: 200px;">Técnico(a)<br />
                        <telerik:RadComboBox ID="comboboxTecnico" Width="250px" runat="server" DataValueField="SUP_IND" DataSourceID="SqlDataTecnico"
                            AutoPostBack="true" Skin="flv" EnableEmbeddedSkins="false" OnSelectedIndexChanged="Combobox_SelectedIndexChanged"
                            DataTextField="SUP_NOME" EmptyMessage="Selecione" OnDataBound="comboboxTecnico_DataBound">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 10px;">Rápido<br />
                        <telerik:RadComboBox ID="comboboxRapido" runat="server" OnSelectedIndexChanged="Combobox_SelectedIndexChanged"
                            AutoPostBack="true" Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione">
                            <Items>
                                <telerik:RadComboBoxItem Text="Sim" Value="1" />
                                <telerik:RadComboBoxItem Text="Não" Value="0" />
                                <telerik:RadComboBoxItem Text="Todos" Value="2" TabIndex="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="padding-left: 30px; padding-top: 10px;">Prestativo<br />
                        <telerik:RadComboBox ID="comboboxPrestativo" runat="server" OnSelectedIndexChanged="Combobox_SelectedIndexChanged"
                            AutoPostBack="true" Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione">
                            <Items>
                                <telerik:RadComboBoxItem Text="Sim" Value="1" />
                                <telerik:RadComboBoxItem Text="Não" Value="0" />
                                <telerik:RadComboBoxItem Text="Todos" Value="2" TabIndex="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="padding-left: 200px; padding-top: 10px;">Filtro do status<br />
                        <telerik:RadComboBox ID="ComboboxStatus" runat="server" Width="250px" AppendDataBoundItems="true"
                            AutoPostBack="true" Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione"
                            OnSelectedIndexChanged="Combobox_SelectedIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="Ótimo" Value="4" />
                                <%--<telerik:RadComboBoxItem Text="Bom" Value="3" />--%>
                                <telerik:RadComboBoxItem Text="Regular" Value="2" />
                                <telerik:RadComboBoxItem Text="Ruim" Value="1" />
                                <telerik:RadComboBoxItem Text="Todos" Value="0" TabIndex="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <tr>
                        <td colspan="2" style="padding-top: 10px;">Gentil<br />
                            <telerik:RadComboBox ID="comboboxGentil" runat="server" OnSelectedIndexChanged="Combobox_SelectedIndexChanged"
                                AutoPostBack="true" Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Sim" Value="1" />
                                    <telerik:RadComboBoxItem Text="Não" Value="0" />
                                    <telerik:RadComboBoxItem Text="Todos" Value="2" TabIndex="0" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td style="padding-left: 200px; padding-top: 10px;">Responderam a OBS<br />
                            <telerik:RadComboBox ID="comboboxResponderam" Width="250px" runat="server" AppendDataBoundItems="true"
                                AutoPostBack="true" Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione"
                                OnSelectedIndexChanged="Combobox_SelectedIndexChanged">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Sim" Value="1" />
                                    <telerik:RadComboBoxItem Text="Não" Value="0" />
                                    <telerik:RadComboBoxItem Text="Todos" Value="2" TabIndex="0" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
            </table>
            <br />
            <telerik:RadFormDecorator ID="QsfFromDecorator" runat="server" DecoratedControls="All" EnableRoundedCorners="false" />
            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="RadGrid1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManager>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
            <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataQuestAtendimento" EnableEmbeddedSkins="false" Skin="flv"
                PagerStyle-ShowPagerText="true" PagerTextFormat="{4} {5}" PagerStyle-AlwaysVisible="true">

                <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Clientes"></PagerStyle>

                <MasterTableView DataSourceID="SqlDataQuestAtendimento" AutoGenerateColumns="false" PageSize="50"
                    DataKeyNames="QUEST_IND" ItemStyle-Height="50px" AlternatingItemStyle-Height="50px" AllowPaging="true">

                    <NoRecordsTemplate>
                        <table style="height: 80px; font-size: 12pt;">
                            <tr>
                                <td>Nenhum registro encontrado.</td>
                            </tr>
                        </table>
                    </NoRecordsTemplate>

                    <Columns>
                        <telerik:GridTemplateColumn DataField="CAD_RAZAOSOCIAL"
                            HeaderText="Atendimento" SortExpression="CAD_RAZAOSOCIAL" UniqueName="CAD_RAZAOSOCIAL">
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td style="width: 450px; border: 0; vertical-align: top">
                                            <asp:Label ID="lbTecnico" runat="server" Font-Size="12pt" Text='<%# "Técnico(a) " + Eval("SUP_NOME").ToString() %>'></asp:Label><br />
                                            <asp:HyperLink ID="lbRazaoSocial" runat="server" Font-Size="10pt" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/Atendimento/Cliente.aspx?ind={0}") %>'><%# Eval("CAD_RAZAOSOCIAL")%></asp:HyperLink></b>
                                                <asp:Label ID="lbData" runat="server" Font-Size="9pt" ForeColor="#378746" Text='<%#  "<br />Respondido em  " + Eval("QUEST_DATA_ATUALIZACAO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                        </td>
                                        <td style="border-bottom: 0px; border-left: 1px solid #cbcbcb">
                                            <asp:Label ID="lbRapido" runat="server" Text='<%# "Rápido ? " + (Convert.ToBoolean(Eval("QUEST_6")) ? "SIM" : "NÃO") %>'></asp:Label><br />
                                            <p>
                                                <asp:Label ID="lbPrestativo" runat="server" Text='<%# "Prestativo ? " + (Convert.ToBoolean(Eval("QUEST_5")) ? "SIM" : "NÃO") %>'></asp:Label><br />
                                            </p>
                                            <asp:Label ID="lbGentil" runat="server" Text='<%# "Gentil ? " + (Convert.ToBoolean(Eval("QUEST_4")) ? "SIM" : "NÃO") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="border: 0">
                                            <span style='<%# string.IsNullOrEmpty(Eval("QUEST_OBS").ToString()) ? "display:none;": "text-shadow: 0 0 0;" %>' class="font_red">
                                                <br />
                                                Obs</span>
                                            <asp:Label ID="Label1" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("QUEST_OBS").ToString())  %>' Text='<%# Eval("QUEST_OBS") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                            <HeaderStyle Width="800px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="QUEST_3"
                            HeaderText="Avaliação" SortExpression="QUEST_3" UniqueName="QUEST_3">
                            <ItemTemplate>
                                <asp:Image ID="imgSmile" runat="server" ImageUrl='<%# "~/Images/Quest/" + (Convert.ToInt32(Eval("QUEST_3")) == 4 ? "SmileOtimo48x48.png" :  Convert.ToInt32(Eval("QUEST_3")) == 3 ? "SmileRegular48x48.png" : Convert.ToInt32(Eval("QUEST_3")) == 2 ? "SmileRegular48x48.png" : "SmilePessimo48x48.png") %>' />
                                <br />
                                <asp:Label ID="lbavaliacao" runat="server" Text='<%# Convert.ToInt32(Eval("QUEST_3")) == 4 ? "Ótimo" :  Convert.ToInt32(Eval("QUEST_3")) == 3 ? "Regular" : Convert.ToInt32(Eval("QUEST_3")) == 2 ? "Regular" : "Ruim" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataQuestAtendimento" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelecting="SqlDataQuestAtendimento_Selecting"
        SelectCommand="SELECT SUP_IND, SUP_NOME, QUEST_IND, CAD_IND, CAD_RAZAOSOCIAL, QUEST_3, QUEST_4, QUEST_5, QUEST_6, QUEST_DATA_ATUALIZACAO, QUEST_OBS
                FROM AssepontoQuestAtendimento 
                INNER JOIN AssepontoSuporte ON QUEST_TECNICO = SUP_IND
                INNER JOIN AssepontoClientes ON QUEST_CLIENTE = CAD_IND 
                WHERE CONVERT(DATE, QUEST_DATA_ATUALIZACAO) &gt;= @DATAINICIAL AND CONVERT(DATE, QUEST_DATA_ATUALIZACAO) &lt;= @DATAFINAL
                AND (@TECNICO = 0 OR SUP_IND = @TECNICO) 
                AND (@RAPIDO = 2 OR QUEST_6 = @RAPIDO) 
                AND (@PRESTATIVO = 2 OR QUEST_5 = @PRESTATIVO) 
                AND (@GENTIL = 2 OR QUEST_4 = @GENTIL)  
                AND (
                          @STATUS = 0 OR
                          @STATUS = 4 AND QUEST_3 = @STATUS OR
                         (@STATUS = 2 AND QUEST_3 = 3 OR QUEST_3 = @STATUS) OR
			             (@STATUS = 3 AND QUEST_3 = 2 OR QUEST_3 = @STATUS) OR
                          @STATUS = 1 AND QUEST_3 = @STATUS
                )
                AND (@RESPONDERAM = 2 OR @RESPONDERAM = 0 AND CONVERT(VARCHAR, QUEST_OBS) = ' ' OR @RESPONDERAM = 1 AND CONVERT(VARCHAR, QUEST_OBS) &lt;&gt; ' ' )
                ORDER BY QUEST_DATA DESC">
        <SelectParameters>
            <asp:Parameter Name="DATAINICIAL" Type="DateTime" />
            <asp:Parameter Name="DATAFINAL" Type="DateTime" />
            <asp:Parameter Name="STATUS" Type="Int32" />
            <asp:Parameter Name="RESPONDERAM" Type="Int32" />

            <asp:Parameter Name="TECNICO" Type="Int32" />
            <asp:Parameter Name="RAPIDO" Type="Int32" />
            <asp:Parameter Name="PRESTATIVO" Type="Int32" />
            <asp:Parameter Name="GENTIL" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataTecnico" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT SUP_IND, SUP_NOME FROM AssepontoSuporte WHERE SUP_ATIVO = 1 AND SUP_SETOR &gt; 0
        ORDER BY SUP_NOME ASC"></asp:SqlDataSource>
</asp:Content>
