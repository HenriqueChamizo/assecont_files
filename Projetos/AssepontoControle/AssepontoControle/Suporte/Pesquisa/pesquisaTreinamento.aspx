<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="pesquisaTreinamento.aspx.cs" Inherits="Asseponto.Suporte.Pesquisa.pesquisaTreinamento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="contentplaceMenuEsquerdo" runat="server">
    <flv:MenuLeftPesquisa runat="server" ID="MenuLeftPesquisa" />
</asp:content>
<asp:content id="Content3" contentplaceholderid="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <table style="Width: 835px; border-bottom: 1px solid lightgray;">
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
                    <td style="text-align: right;">
                        <input type="button" value="Imprimir Relatório" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebutton" />
                    </td>
                </tr>
            </table>
            <br />
            <div id="DivImpressao" style="Width: 760px; float: left;">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlData" BorderStyle="None" EnableTheming="True"
                            RepeatColumns="1" RepeatDirection="Horizontal" ShowFooter="true" Width="100%">
                            <AlternatingItemStyle BorderStyle="None" />
                            <EditItemStyle BorderStyle="None" />
                            <FooterStyle BorderStyle="None" />
                            <HeaderStyle BorderStyle="None" CssClass="linha" />
                            <ItemStyle BorderStyle="None" CssClass="linha" />
                            <FooterTemplate>
                                <%# DataList1.Items.Count == 0 ? "Nenhum registro encontrado." : "" %>
                            </FooterTemplate>
                            <HeaderTemplate>
                                <div id="PageTitl1_PageTitleWrapper" style="padding: 0px 0px 20px 0px;">
                                    <div id="PageTitl1_PageTitleTexts">
                                        <span class="descricao" style="display: block; font-size: 20pt; letter-spacing: 1px;">Pesquisa Treinamento - Totalizado</span>
                                        <asp:Label ID="Label13" runat="server" Font-Size="12pt" ForeColor="#5c5c5c" Text='<%# "AssepontoControle de " + RadDatePicker1.SelectedDate.Value.ToString("dd/MM/yyyy") + " até " + RadDatePicker2.SelectedDate.Value.ToString("dd/MM/yyyy")  %>'></asp:Label>
                                    </div>
                                </div>
                                <style>
                                    body
                                    {
                                        font-family: 'Segoe UI', 'Segoe UI Light';
                                        margin: 0px;
                                        padding: 0px;
                                        overflow: auto !important;
                                        background-color: white;
                                        color: #1B1B1B;
                                    }

                                    .tableDados
                                    {
                                        border-spacing: 0px;
                                        font-size: 12.5pt;
                                        vertical-align: top;
                                        padding: 10px;
                                    }

                                    .font_color
                                    {
                                        text-shadow: 0 0 0;
                                    }

                                    .font_green a
                                    {
                                        color: #378746;
                                        text-shadow: 0 0 0;
                                    }

                                    .font_blue a
                                    {
                                        color: #3F88E9;
                                        text-shadow: 0 0 0;
                                    }

                                    .font_blueDark a
                                    {
                                        color: #425269;
                                        text-shadow: 0 0 0;
                                    }

                                    .font_red a
                                    {
                                        color: #D42020 !important;
                                        text-shadow: 0 0 0;
                                    }

                                    .tecnico
                                    {
                                        background: #8C8C8C !important;
                                        color: white;
                                    }
                                </style>
                             </HeaderTemplate>
                            <ItemTemplate>
                                <table class="pesquisa" style="border-spacing: 0px; width: 100%;">
                                    <tr>
                                        <td colspan="4" class="tableDados font_color"><b>1)</b> Dificuldade de acesso ?</td>
                                    </tr>
                                    <tr>
                                        <td class="tableDados">
                                            <asp:Label ID="Label3" runat="server" Text='<%# "Sim (" + Eval("Sim") + ")" %>'></asp:Label>
                                        </td>
                                        <td colspan="2" class="tableDados">
                                            <asp:Label ID="Label4" runat="server" Text='<%# "Não (" + Eval("Nao") + ")" %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="tableDados font_color"><b>2)</b> Avaliação do Treinamento</td>
                                    </tr>
                                    <tr>
                                        <td class="tableDados font_green" style="padding-bottom: 20px;">
                                            <img src="../../Images/Quest/SmileOtimo48x48.png" width="20" />
                                            <asp:HyperLink ID="HyperOtimo" runat="server" NavigateUrl='<%# "~/Suporte/Pesquisa/pesquisaTreinamentoDetalhado.aspx?DI=" + 
                                                RadDatePicker1.SelectedDate.Value.ToString("dd/MM/yyyy") + "&DF="+ RadDatePicker2.SelectedDate.Value.ToString("dd/MM/yyyy") + "&S=4"  %>'
                                                Text='<%# "Ótimo (" + Eval("Otimo") + ")" %>'></asp:HyperLink>
                                        </td>
                                        <%--<td class="tableDados font_blue">
                                            <img src="../../Images/Quest/SmileBom48x48.png" width="20" />
                                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/Suporte/Pesquisa/pesquisaTreinamentoDetalhado.aspx?DI=" + 
                                                RadDatePicker1.SelectedDate.Value.ToString("dd/MM/yyyy") + "&DF="+ RadDatePicker2.SelectedDate.Value.ToString("dd/MM/yyyy") + "&S=3"  %>'
                                                Text='<%# "Bom (" + Eval("Bom") + ")" %>'></asp:HyperLink>
                                        </td>--%>
                                        <td class="tableDados font_blueDark">
                                            <img src="../../Images/Quest/SmileRegular48x48.png" width="20" />
                                            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "~/Suporte/Pesquisa/pesquisaTreinamentoDetalhado.aspx?DI=" + 
                                                RadDatePicker1.SelectedDate.Value.ToString("dd/MM/yyyy") + "&DF="+ RadDatePicker2.SelectedDate.Value.ToString("dd/MM/yyyy") + "&S=2"  %>'
                                                Text='<%# "Regular (" + Eval("Regular") + ")"  %>'></asp:HyperLink>
                                        </td>
                                        <td class="tableDados font_red">
                                            <img src="../../Images/Quest/SmilePessimo48x48.png" width="20" />
                                            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# "~/Suporte/Pesquisa/pesquisaTreinamentoDetalhado.aspx?DI=" + 
                                                RadDatePicker1.SelectedDate.Value.ToString("dd/MM/yyyy") + "&DF="+ RadDatePicker2.SelectedDate.Value.ToString("dd/MM/yyyy") + "&S=1"  %>'
                                                Text='<%# "Ruim (" + Eval("Pessimo") + ")"  %>'></asp:HyperLink>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="tableDados" style="border-top: 1px solid lightgray; width: 100%;">
                                            <asp:Label ID="Label10" runat="server" Font-Size="16pt" ForeColor="#5c5c5c" Text='<%# Eval("Responderam") + " Clientes que responderam o questionário." %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                            <SelectedItemStyle BorderStyle="None" />
                            <SeparatorStyle BorderStyle="None" />
                        </asp:DataList>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <asp:SqlDataSource ID="SqlData" runat="server" OnSelecting="SqlData_Selecting" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT SUM(CASE WHEN QUEST_TREI_ATUALIZACAO IS NOT NULL THEN 1 ELSE 0 END) AS Responderam, @DATAINICIAL AS DATAINICIAL, @DATAFINAL AS DATAFINAL,
                    SUM(CASE WHEN QUEST_TREI_1 = 0 THEN 1 ELSE 0 END) AS Nao,
                    SUM(CASE WHEN QUEST_TREI_1 = 1 THEN 1 ELSE 0 END) AS Sim,
                    SUM(CASE WHEN QUEST_TREI_2 = 1 THEN 1 ELSE 0 END) AS Pessimo,
                    SUM(CASE WHEN QUEST_TREI_2 = 2 or QUEST_TREI_2 = 3 THEN 1 ELSE 0 END) AS Regular,
                    --SUM(CASE WHEN QUEST_TREI_2 = 3 THEN 1 ELSE 0 END) AS Bom,
                    SUM(CASE WHEN QUEST_TREI_2 = 4 THEN 1 ELSE 0 END) AS Otimo
                    FROM AssepontoQuestTreinamento
                    INNER JOIN AssepontoClientes ON QUEST_TREI_CLIENTE = CAD_IND 
                    WHERE QUEST_TREI_ATUALIZACAO &gt;= @DATAINICIAL AND QUEST_TREI_ATUALIZACAO &lt;= @DATAFINAL">
            <SelectParameters>
                <asp:Parameter Name="DATAINICIAL" Type="DateTime" />
                <asp:Parameter Name="DATAFINAL" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:content>
