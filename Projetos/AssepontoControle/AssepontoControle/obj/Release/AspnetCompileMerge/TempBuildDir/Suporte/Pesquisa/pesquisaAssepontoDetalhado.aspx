<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="pesquisaAssepontoDetalhado.aspx.cs" Inherits="Asseponto.Suporte.Pesquisa.pesquisaAssepontoDetalhado" %>

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
                    <td>Filtro do status<br />
                        <telerik:RadComboBox ID="ComboboxStatus" runat="server" AppendDataBoundItems="true"
                            AutoPostBack="true" Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione"
                            OnSelectedIndexChanged="ComboboxStatus_SelectedIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="Ótimo" Value="4" />
                                <telerik:RadComboBoxItem Text="Regular" Value="2" />
                                <telerik:RadComboBoxItem Text="Ruim" Value="1" />
                                <telerik:RadComboBoxItem Text="Todos" Value="0" TabIndex="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="padding-left: 20px;">Responderam<br />
                        <telerik:RadComboBox ID="comboboxResponderam" runat="server" AppendDataBoundItems="true"
                            AutoPostBack="true" Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione"
                            OnSelectedIndexChanged="comboboxResponderam_SelectedIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="Sim" Value="2" />
                                <telerik:RadComboBoxItem Text="Não" Value="1" />
                                <telerik:RadComboBoxItem Text="Todos" Value="0" TabIndex="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
            <br />
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
                            HeaderText="Software" SortExpression="CAD_RAZAOSOCIAL" UniqueName="CAD_RAZAOSOCIAL">
                            <ItemTemplate>
                                <asp:Label ID="lbData" runat="server" Text='<%# Eval("QUEST_DATA_ATUALIZACAO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                -
                                <asp:HyperLink ID="lbRazaoSocial" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/Atendimento/Cliente.aspx?ind={0}") %>'><%# Eval("CAD_RAZAOSOCIAL")%></asp:HyperLink></b>
                                <asp:Label ID="lbpq" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("QUEST_1_PQ").ToString())  %>' Text='<%# "<br /><br /><b>Por que o Asseponto4 satisfaz? </b><br />" + Eval("QUEST_1_PQ") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="500px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn DataField="QUEST_2"
                            HeaderText="Avaliação" SortExpression="QUEST_2" UniqueName="QUEST_2">
                            <ItemTemplate>
                                <asp:Image ID="imgSmile" runat="server" ImageUrl='<%# "~/Images/Quest/" + (Convert.ToInt32(Eval("QUEST_2")) == 4 ? "SmileOtimo48x48.png" :  Convert.ToInt32(Eval("QUEST_2")) == 3 ? "SmileRegular48x48.png" : Convert.ToInt32(Eval("QUEST_2")) == 2 ? "SmileRegular48x48.png" : "SmilePessimo48x48.png") %>' />
                                <br />
                                <asp:Label ID="lbavaliacao" runat="server" Text='<%# Convert.ToInt32(Eval("QUEST_2")) == 4 ? "Ótimo" :  Convert.ToInt32(Eval("QUEST_2")) == 3 ? "Regular" : Convert.ToInt32(Eval("QUEST_2")) == 2 ? "Regular" : "Ruim" %>'></asp:Label>
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
        SelectCommand="SELECT QUEST_IND, CAD_IND, CAD_RAZAOSOCIAL, QUEST_1, QUEST_2, QUEST_1_PQ, QUEST_7, QUEST_DATA_ATUALIZACAO
        FROM AssepontoQuestAtendimento 
        INNER JOIN AssepontoSuporte ON QUEST_TECNICO = SUP_IND
        INNER JOIN AssepontoClientes ON QUEST_CLIENTE = CAD_IND 
        WHERE QUEST_DATA_ATUALIZACAO &gt;= @DATAINICIAL AND QUEST_DATA_ATUALIZACAO &lt;= @DATAFINAL 
        AND (
              @STATUS = 0 OR
              @STATUS = 4 AND QUEST_2 = @STATUS OR
             (@STATUS = 2 AND QUEST_2 = 3 OR QUEST_2 = @STATUS) OR
			 (@STATUS = 3 AND QUEST_2 = 2 OR QUEST_2 = @STATUS) OR
              @STATUS = 1 AND QUEST_2 = @STATUS
            )
        AND (@RESPONDERAM = 0 OR @RESPONDERAM = 1 AND CONVERT(VARCHAR, QUEST_1_PQ) = ' ' OR @RESPONDERAM = 2 AND CONVERT(VARCHAR, QUEST_1_PQ) &lt;&gt; ' ' )
        ORDER BY QUEST_DATA_ATUALIZACAO DESC">
        <SelectParameters>
            <asp:Parameter Name="DATAINICIAL" Type="DateTime" />
            <asp:Parameter Name="DATAFINAL" Type="DateTime" />
            <asp:Parameter Name="STATUS" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="RESPONDERAM" Type="Int32" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
