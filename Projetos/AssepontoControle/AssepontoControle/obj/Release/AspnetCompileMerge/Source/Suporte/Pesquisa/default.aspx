<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Asseponto.Suporte.Pesquisa._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <flv:MenuLeftPesquisa runat="server" ID="MenuLeftPesquisa" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <table style="Width: 835px; border-bottom: 1px solid #B8CBDE; padding-bottom: 15px;">
                <tr>
                    <td style="width: 160px;">De<br />
                        <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Skin="Web20" AutoPostBack="true" OnSelectedDateChanged="RadDatePicker1_SelectedDateChanged">
                            <Calendar Skin="Web20" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x" />
                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="" />
                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                        </telerik:RadDatePicker>

                    </td>
                    <td style="width: 420px;">Para<br />
                        <telerik:RadDatePicker ID="RadDatePicker2" runat="server" Skin="Web20" OnSelectedDateChanged="RadDatePicker1_SelectedDateChanged" AutoPostBack="true">
                            <Calendar Skin="Web20" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x" />
                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="" />
                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                        </telerik:RadDatePicker>
                    </td>
                    <td>Visualizar Setor 
                        <telerik:RadComboBox ID="comboboxSetor" runat="server" AppendDataBoundItems="true" AutoPostBack="true" Skin="flv"
                            EnableEmbeddedSkins="false" EmptyMessage="Selecione" OnSelectedIndexChanged="comboboxSetor_SelectedIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="Suporte" Value="0" TabIndex="0" />
                                <telerik:RadComboBoxItem Text="Implantação" Value="1" TabIndex="1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="text-align: right;">
                        <br />
                        <input type="button" value="Imprimir Relatório" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebutton" />
                    </td>
                </tr>
            </table>
            <br />
            <div id="DivImpressao">
                <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlData" BorderStyle="None" EnableTheming="True"
                    RepeatColumns="1" RepeatDirection="Horizontal" ShowFooter="true" Width="100%">
                    <AlternatingItemStyle BorderStyle="None" />
                    <EditItemStyle BorderStyle="None" />
                    <FooterStyle BorderStyle="None" />
                    <HeaderStyle BorderStyle="None" CssClass="linha" />
                    <ItemStyle BorderStyle="None" CssClass="linha" />
                    <FooterTemplate>
                        <%# DataList1.Items.Count == 0 ? "Nenhum questionário encontrado." : "" %>
                    </FooterTemplate>
                    <HeaderTemplate>
                        <div id="PageTitl1_PageTitleWrapper" style="padding: 0px 0px 20px 0px;">
                            <div id="PageTitl1_PageTitleTexts">
                                <span class="descricao" style="display: block; font-size: 20pt; letter-spacing: 1px;">Pesquisa Atendimento - Totalizado</span>
                                <asp:Label ID="Label13" runat="server" Font-Size="12pt" ForeColor="#5c5c5c" Text='<%# "AssepontoControle de " + RadDatePicker1.SelectedDate.Value.ToString("dd/MM/yyyy") + " até " + RadDatePicker2.SelectedDate.Value.ToString("dd/MM/yyyy")  %>'></asp:Label>
                            </div>
                        </div>
                        <style>
                            body
                            {
                                font: 10pt 'Segoe UI', 'Segoe UI Light';
                                margin: 0px;
                                padding: 0px;
                                overflow: auto !important;
                                background-color: white;
                                color: #1B1B1B;
                            }

                            .pesquisa table
                            {
                                border: 0px;
                                border-spacing: 0px;
                                margin: 0;
                                padding: 0px;
                                width: 100%;
                            }

                            .pesquisa td
                            {
                                vertical-align: top;
                            }

                            .tableDados
                            {
                                border-spacing: 0px;
                                font-size: 10.8pt;
                                vertical-align: top;
                                padding: 5px;
                            }

                            .font_color
                            {
                                text-shadow: 0 0 0;
                                font-size: 12pt;
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
                        <table class="pesquisa" style="width: 100%;">
                            <tr>
                                <td colspan="2" class="tableDados tecnico">
                                    <asp:Label ID="lbTecnico" runat="server" Font-Size="14pt" Text='<%# Eval("NOME") %>'></asp:Label>
                                    <asp:Label ID="Label2" runat="server" Font-Size="14pt" Visible='<%# !String.IsNullOrEmpty(Eval("PERIODO").ToString()) %>' Text='<%# " - Data do cadastro " + Eval("PERIODO", "{0:dd/MM/yyyy}") %>'></asp:Label>

                                </td>
                            </tr>
                            <tr>
                                <td style="width: 480px;">
                                    <table>
                                        <tr>
                                            <td colspan="4" class="tableDados font_color">O atendente foi Gentil ?</td>
                                        </tr>
                                        <tr>
                                            <td class="tableDados">
                                                <asp:Label ID="lbGentilSIM" runat="server" Text='<%# "Sim (" + Eval("GENTIL_SIM") + ")"   %>'></asp:Label></td>
                                            <td class="tableDados" colspan="3">
                                                <asp:Label ID="lbGentilNAO" runat="server" Text='<%# "Não (" + Eval("GENTIL_NAO")+ ")"  %>'></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="tableDados font_color">O atendente foi Prestativo ?</td>
                                        </tr>
                                        <tr>
                                            <td class="tableDados">
                                                <asp:Label ID="Label12" runat="server" Text='<%# "Sim (" +  Eval("PRESTATIVO_SIM") + ")" %>'></asp:Label></td>
                                            <td class="tableDados" colspan="3">
                                                <asp:Label ID="Label1" runat="server" Text='<%# "Não (" + Eval("PRESTATIVO_NAO") + ")" %>'></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="tableDados font_color">O atendente foi Rápido ?</td>
                                        </tr>
                                        <tr>
                                            <td class="tableDados">
                                                <asp:Label ID="Label5" runat="server" Text='<%# "Sim (" +  Eval("RAPIDO_SIM") + ")" %>'></asp:Label></td>
                                            <td class="tableDados" colspan="3">
                                                <asp:Label ID="Label6" runat="server" Text='<%# "Não (" + Eval("RAPIDO_NAO") + ")" %>'></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="tableDados font_color">Avaliação</td>
                                        </tr>
                                        <tr>
                                            <td class="tableDados font_green" style="padding-bottom: 20px;">
                                                <img src="../../Images/Quest/SmileOtimo48x48.png" width="20" />
                                                <asp:HyperLink ID="HyperOtimo" runat="server" NavigateUrl='<%# "~/Suporte/Pesquisa/pesquisaTecnicoDetalhado.aspx?DI=" + 
                                                RadDatePicker1.SelectedDate.Value.ToString("dd/MM/yyyy") + "&DF="+ RadDatePicker2.SelectedDate.Value.ToString("dd/MM/yyyy") + "&S=4&T=" + Eval("INDICE")  %>'
                                                    Text='<%# "Ótimo (" + Eval("OTIMO") + ")" %>'></asp:HyperLink>
                                            </td>
                                            <%--<td class="tableDados font_blue">
                                                <img src="../../Images/Quest/SmileBom48x48.png" width="20" />
                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/Suporte/Pesquisa/pesquisaTecnicoDetalhado.aspx?DI=" + 
                                                RadDatePicker1.SelectedDate.Value.ToString("dd/MM/yyyy") + "&DF="+ RadDatePicker2.SelectedDate.Value.ToString("dd/MM/yyyy") + "&S=3&T=" + Eval("INDICE")   %>'
                                                    Text='<%# "Bom (" + Eval("BOM") + ")" %>'></asp:HyperLink>
                                            </td>--%>
                                            <td class="tableDados font_blueDark">
                                                <img src="../../Images/Quest/SmileRegular48x48.png" width="20" />
                                                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "~/Suporte/Pesquisa/pesquisaTecnicoDetalhado.aspx?DI=" + 
                                                RadDatePicker1.SelectedDate.Value.ToString("dd/MM/yyyy") + "&DF="+ RadDatePicker2.SelectedDate.Value.ToString("dd/MM/yyyy") + "&S=2&T=" + Eval("INDICE")   %>'
                                                    Text='<%# "Regular (" + Eval("REGULAR") + ")"  %>'></asp:HyperLink>
                                            </td>
                                            <td class="tableDados font_red">
                                                <img src="../../Images/Quest/SmilePessimo48x48.png" width="20" />
                                                <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# "~/Suporte/Pesquisa/pesquisaTecnicoDetalhado.aspx?DI=" + 
                                                RadDatePicker1.SelectedDate.Value.ToString("dd/MM/yyyy") + "&DF="+ RadDatePicker2.SelectedDate.Value.ToString("dd/MM/yyyy") + "&S=1&T=" + Eval("INDICE")   %>'
                                                    Text='<%# "Ruim (" + Eval("PESSIMO") + ")"  %>'></asp:HyperLink>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="padding-top: 30px;">
                                    <table style="text-align: center; background-color: #FEFFCA; padding: 15px;">
                                        <tr>
                                            <td class="tableDados font_color">
                                                <asp:Label ID="Label3" runat="server" Font-Size="14pt" Text='<%# "Total de " + Eval("Responderam") + " questionarios" %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tableDados">
                                                <asp:Label ID="Label8" runat="server" Text='<%# "SUPORTE (" +  Eval("ATENDIMENTO") + ")" %>'></asp:Label>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="tableDados">
                                                <asp:Label ID="Label9" runat="server" Visible='<%# Convert.ToInt32(Eval("IMPLANTACAO")) > 0 %>' Text='<%# "IMPLANTAÇÃO (" +  Eval("IMPLANTACAO") + ")" %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tableDados font_color">
                                                <asp:Label ID="Label14" runat="server" Font-Size="14pt" Text='<%# "Total de " + (Convert.ToInt32(Eval("ATENDIMENTO")) + Convert.ToInt32(Eval("IMPLANTACAO"))) + " atendimentos" %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tableDados">
                                                <asp:Label ID="Label4" runat="server" Visible='<%# Convert.ToInt32(Eval("BA")) > 0 %>' Text='<%# "BeAnywhere (" + Eval("BA") + ")" %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                    <SelectedItemStyle BorderStyle="None" />
                    <SeparatorStyle BorderStyle="None" />
                </asp:DataList>
            </div>
        </div>
        <asp:SqlDataSource ID="SqlData" runat="server" OnSelecting="SqlData_Selecting" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="EXEC rs_pesquisa_tecnica @P_DATAINICIAL = @DATAINICIAL, @P_DATAFINAL= @DATAFINAL, @P_IMPLANTACAO = @IMPLANTACAO">
            <SelectParameters>
                <asp:Parameter Name="DATAINICIAL" Type="DateTime" />
                <asp:Parameter Name="DATAFINAL" Type="DateTime" />
                <asp:Parameter Name="IMPLANTACAO" Type="Byte" />
            </SelectParameters>
        </asp:SqlDataSource>
</asp:Content>
