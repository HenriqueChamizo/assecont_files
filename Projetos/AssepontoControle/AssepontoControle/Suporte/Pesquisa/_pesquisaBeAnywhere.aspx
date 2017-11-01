<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="_pesquisaBeAnywhere.aspx.cs" Inherits="Asseponto.Suporte.Pesquisa.pesquisaBeAnywhere1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Asseponto" NavigateUrl="~/Suporte/Pesquisa/pesquisaAsseponto.aspx" />
                <telerik:RadMenuItem runat="server" Text="Técnico" NavigateUrl="~/Suporte/Pesquisa/default.aspx" />
                <telerik:RadMenuItem runat="server" Text="Treinamento" NavigateUrl="~/Suporte/Pesquisa/pesquisaTreinamento.aspx" />
                <telerik:RadMenuItem runat="server" Text="Questionarios" NavigateUrl="~/Suporte/Questionarios/default.aspx" />
                <telerik:RadMenuItem runat="server" Text="BeAnywhere" NavigateUrl="~/Suporte/Pesquisa/pesquisaBeAnywhere.aspx" />
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
         <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <table style="Width: 835px; border-bottom: 1px solid lightgray;">
                <tr>
                    <td style="vertical-align: top;">
                        <wr:TextSearch ID="TextSearch1" runat="server" ShowTexto="false" QueryStringField="filtro" ShowDateFilter="true" />
                    </td>
                    <td style="text-align: right;">
                        <input type="button" value="Imprimir Relatório" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebutton" />
                    </td>
                </tr>
            </table>
             <br />
            <div id="DivImpressao" style="Width: 760px; float: left;">
                <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlData" BorderStyle="None" EnableTheming="True"
                    RepeatColumns="1" RepeatDirection="Horizontal" ShowFooter="true" Width="760px">
                    <AlternatingItemStyle BorderStyle="None" />
                    <EditItemStyle BorderStyle="None" />
                    <FooterStyle BorderStyle="None" />
                    <HeaderStyle BorderStyle="None" CssClass="linha" />
                    <ItemStyle BorderStyle="None" CssClass="linha" />
                    <FooterTemplate>
                        <%# DataList1.Items.Count == 0 ? "Nenhum registro encontrado." : "" %>
                    </FooterTemplate>
                    <HeaderTemplate>
                        <style>
                            .pesquisa table
                            {
                                border: 0px;
                                border-spacing: 0px;
                                margin: 0;
                                padding: 0px;
                                width: 460px;
                                
                            }

                            .pesquisa td
                            {
                                vertical-align: top;
                            }

                            .tableDados td
                            {
                                border-spacing: 0px;
                                border: 0 !important;
                                font-size: 11pt;
                                vertical-align: top;
                                padding-top: 10px;
                                padding-left: 20px;
                            }
                        </style>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table class="pesquisa" style="width: 50%;">
                            <tr>
                                <td style="padding: 6px;">
                                    <asp:Label ID="lbTecnico" runat="server" Font-Size="14pt" ForeColor="#FF0000" Text='<%# Eval("SUP_NOME") %>'></asp:Label>
                                </td>
                                <td style="padding: 6px; text-align: right;">
                                    <asp:Label ID="Label1" runat="server"  Font-Size="14pt" Text='<%# Eval("Total") %>'></asp:Label>
                                </td>
                            </tr>
           <%--             <tr>
                                <td colspan="3" style="padding: 6px;">
                                    <asp:Label ID="Label10" runat="server" Font-Bold="true" Text='<%# Eval("Responderam") %>'></asp:Label>
                                    Clientes que responderam o questionario.                                
                                </td>
                            </tr>--%>
                        </table>
                        <div style="width: 50%; border-bottom: 1px solid lightgray">
                        </div>
                    </ItemTemplate>
                    <SelectedItemStyle BorderStyle="None" />
                    <SeparatorStyle BorderStyle="None" />
                </asp:DataList>
            </div>
        </div>
        <asp:SqlDataSource ID="SqlData" runat="server" OnSelecting="SqlData_Selecting" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT COUNT(*) AS Total,  (CASE WHEN SUP_NOME IS NULL THEN 'Total' ELSE SUP_NOME END) AS SUP_NOME
                        FROM BeAnywhereAtendimento
                        INNER JOIN AssepontoSuporte ON SUP_IND = BAA_TECNICO
                        WHERE SUP_SETOR &gt; 0 AND SUP_ATIVO = 1 AND BAA_DATAINICIO_SESSION &gt;= @DATAINICIAL AND BAA_DATAINICIO_SESSION &lt;= @DATAFINAL
                        GROUP BY GROUPING SETS (SUP_NOME, ()) ORDER BY Total">
            <SelectParameters>
                <asp:Parameter Name="DATAINICIAL" Type="DateTime" />
                <asp:Parameter Name="DATAFINAL" Type="DateTime" />
                <asp:Parameter Name="TECNICO" Type="Int32" DefaultValue="0" />
            </SelectParameters>
        </asp:SqlDataSource>
</asp:Content>
