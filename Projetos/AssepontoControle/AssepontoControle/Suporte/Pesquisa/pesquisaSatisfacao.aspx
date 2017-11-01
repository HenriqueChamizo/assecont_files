<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="pesquisaSatisfacao.aspx.cs" Inherits="Asseponto.Suporte.Pesquisa.pesquisaSatisfacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="contentplaceMenuEsquerdo" runat="server">
    <flv:menuleftpesquisa runat="server" id="MenuLeftPesquisa" />
</asp:content>
<asp:content id="Content3" contentplaceholderid="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <table style="Width: 835px; border-bottom: 1px solid lightgray;">
                <tr>
                    <td style="width: 160px;">De<br />
                        <telerik:raddatepicker id="RadDatePicker1" runat="server" skin="Web20" autopostback="true"
                            onselecteddatechanged="RadDatePicker1_SelectedDateChanged">
                            <Calendar Skin="Web20" UseColumnHeadersAsSelectors="False"
                                UseRowHeadersAsSelectors="False" ViewSelectorText="x" />
                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="" />
                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                        </telerik:raddatepicker>

                    </td>
                    <td style="width: 420px;">Para<br />
                        <telerik:raddatepicker id="RadDatePicker2" runat="server" skin="Web20" onselecteddatechanged="RadDatePicker1_SelectedDateChanged" autopostback="true">
                            <Calendar Skin="Web20" UseColumnHeadersAsSelectors="False"
                                UseRowHeadersAsSelectors="False" ViewSelectorText="x" />
                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="" />
                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                        </telerik:raddatepicker>
                    </td>
                    <td style="text-align: right;">
                        <input type="button" value="Imprimir Relatório" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebutton" />
                    </td>
                </tr>
            </table>
            <br />
            <div id="DivImpressao" style="Width: 760px; float: left;">
                <asp:DetailsView runat="server" Width="125px" Height="50px"></asp:DetailsView>
                <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlData" BorderStyle="None" EnableTheming="True"
                    RepeatColumns="1" RepeatDirection="Horizontal" ShowFooter="true" Width="100%">
                    <AlternatingItemStyle BorderStyle="None" />
                    <EditItemStyle BorderStyle="None" />
                    <FooterStyle BorderStyle="None" />
                    <HeaderStyle BorderStyle="None" CssClass="linha" />
                    <ItemStyle BorderStyle="None" CssClass="linha" />
                    <HeaderTemplate>
                        <div id="PageTitl1_PageTitleWrapper" style="padding: 0px 0px 20px 0px;">
                            <div id="PageTitl1_PageTitleTexts">
                                <span class="descricao" style="display: block; font-size: 20pt; letter-spacing: 1px;">Pesquisa de Satisfação - Totalizado</span>
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
                        <table style="border-spacing: 0px; width: 100%">
                            <tr>
                                <td colspan="2" class="tableDados font_color">
                                    <asp:Label ID="lbPergunta" runat="server" Text='<%# Eval("QUESTAO_DESCRICAO") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="tableDados" style=" width: 150px;">
                                    <asp:Label ID="lbSim" runat="server" Visible='<%# Convert.ToInt32(Eval("QUESTAO_TIPO")) == (int)Asseponto.Classes.Types.alternativas.Bit ? true : false  %>' Text='<%# "Sim (" + Eval("BIT_SIM") + ")" %>'></asp:Label>
                                </td>
                                <td class="tableDados">
                                    <asp:Label ID="lbNao" runat="server" Visible='<%# Convert.ToInt32(Eval("QUESTAO_TIPO")) == (int)Asseponto.Classes.Types.alternativas.Bit ? true : false  %>' Text='<%# "Não (" + Eval("BIT_NAO") + ")"  %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                    <SelectedItemStyle BorderStyle="None" />
                    <SeparatorStyle BorderStyle="None" />
                </asp:DataList>

                <asp:DetailsView ID="DetailsView1" runat="server" DataSourceID="SqlData" BorderWidth="0" AutoGenerateRows="False" EmptyDataText="Nenhum Registro Encontrado">
                        <Fields>
                            <asp:TemplateField ControlStyle-BorderWidth="0" HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                                <ItemTemplate>
                                      <div class="tableDados" style="border-top: 1px solid lightgray; width: 100%;">
                                            <asp:Label ID="Label2" runat="server" Font-Size="16pt" ForeColor="#5c5c5c" Text='<%# "Total de " + Eval("TOTAL_CLIENTE") + (Convert.ToInt32(Eval("TOTAL_CLIENTE")) == 1 ? " Cliente que respondeu o questionário." : " Clientes que responderam o questionário.")  %>'></asp:Label>
                                        </div>
                               </ItemTemplate>
                            </asp:TemplateField>
                        </Fields>
                </asp:DetailsView>
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
</asp:content>
