<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="RevendaPedidosPeriodo.aspx.cs" 
    Inherits="Asseponto.Suporte.Relatorios.RevendaPedidosPeriodo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <table style="Width: 835px; border-bottom: 1px solid lightgray; padding-bottom: 10px">
                <tr>
                    <td style="vertical-align: top;">
                        <wr:TextSearch ID="TextSearch1" runat="server" ShowTexto="false" QueryStringField="filtro" ShowDateFilter="true" />
                    </td>
                    <td style="text-align: right;">
                        <input type="button" value="Imprimir Relatório" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebutton" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadComboBox ID="ListRevendas" Width="500" EmptyMessage="Selecione" CausesValidation="false" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ListRevendas_SelectedIndexChanged" Skin="flv" EnableEmbeddedSkins="false" DataSourceID="SqlDataSourceListRevendas"
                            DataTextField="REV_RAZAOSOCIAL" DataValueField="REV_IND">
                        </telerik:RadComboBox>
                    </td>
                    <td style="text-align: right;">
                        <telerik:RadComboBox ID="ListReps" Width="200" EmptyMessage="Selecione" CausesValidation="false" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ListReps_SelectedIndexChanged" Skin="flv" EnableEmbeddedSkins="false" DataSourceID="SqlDataSourceListReps"
                            DataTextField="FABR_NOME" DataValueField="FABR_COD">
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
            <div id="DivImpressao" style="padding-top:20px">
                <center><asp:Label ID="lbTitulo" runat="server" Text=""></asp:Label></center>
                <asp:DataList ID="dtListPedidos" runat="server" DataSourceID="SqlDataSourceListPedidos" CssClass="listExpansive" BorderStyle="None" 
                    CellSpacing="10" EnableTheming="True" RepeatColumns="2" RepeatDirection="Horizontal" ShowFooter="False" ShowHeader="False" Width="835px">
                    <AlternatingItemStyle BorderStyle="None" />
                    <EditItemStyle BorderStyle="None" />
                    <FooterStyle BorderStyle="None" />
                    <HeaderStyle BorderStyle="None" />
                    <ItemStyle BorderStyle="None" />
                    <ItemTemplate>
                        <table>
                            <%--<div class="listExpansiveItem">--%>
                            <fieldset class="sitelistviewfieldsetitemtemplate">
                                <b>
                                    <asp:HyperLink ID="HyperLink" runat="server" CssClass="listExpansiveItemComp sitelinkpadraoazul" 
                                        Text='<%# Eval("PED_CLI_RAZAO") %>' Enabled="false"></asp:HyperLink></b><br />

                                <asp:Label CssClass="listExpansiveItemDesc sitelistviewfields" ID="label2" runat="server" 
                                    Visible='<%# string.IsNullOrEmpty(Eval("PED_CLI_QTD_FUNCIONA").ToString()) ? false : true %>'
                                    Text='<%# "Funcionários: " + Eval("PED_CLI_QTD_FUNCIONA") %>' />

                                <asp:Label CssClass="listExpansiveItemDesc sitelistviewfields" ID="label3" runat="server" 
                                    Visible='<%# string.IsNullOrEmpty(Eval("PED_CLI_CNPJ").ToString()) ? false : true %>'
                                    Text='<%# "CNPJ: " + Eval("PED_CLI_CNPJ") %>' />

                                <asp:Label CssClass="listExpansiveItemDesc sitelistviewfields" ID="label5" runat="server" 
                                    Visible='<%# string.IsNullOrEmpty(Eval("PED_MODELOREP").ToString()) ? false : true %>'
                                    Text='<%# "PED_MODELOREP: " + Eval("PED_MODELOREP") %>' />
                                <br />
                            </fieldset>
                            <%--</div>--%>
                        </table>
                    </ItemTemplate>
                    <SelectedItemStyle BorderStyle="None" />
                    <SeparatorStyle BorderStyle="None" />
                </asp:DataList>
            </div>
            <asp:SqlDataSource ID="SqlDataSourceListRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" 
                SelectCommand="SELECT A.REV_IND, (A.REV_RAZAOSOCIAL + ' (' + CONVERT(VARCHAR(5), B.QTDE) + ')') AS REV_RAZAOSOCIAL 
                                FROM ASSEPONTOREVENDAS A
                                OUTER APPLY(
	                                SELECT COUNT(*) AS QTDE
	                                FROM ASSEPONTOPEDIDOSREVENDAS BA
	                                WHERE BA.PED_REV_IND = A.REV_IND AND 
		                                  (CONVERT(DATE, BA.PED_DATA) &gt;= @DATAINICIAL AND 
		                                   CONVERT(DATE, BA.PED_DATA) &lt;= @DATAFINAL) AND
		                                  (@REP = 0 OR BA.PED_REP_FABRICANTE = @REP)
                                ) B
                                WHERE B.QTDE &gt; 0">
                <SelectParameters>
                    <asp:QueryStringParameter Name="DATAINICIAL" Type="DateTime" QueryStringField="DATAINICIAL" />
                    <asp:QueryStringParameter Name="DATAFINAL" Type="DateTime" QueryStringField="DATAFINAL" />
                    <asp:QueryStringParameter Name="REP" Type="Int32" QueryStringField="REP" />
                </SelectParameters>
            </asp:SqlDataSource>
    
            <asp:SqlDataSource ID="SqlDataSourceListPedidos" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" 
                SelectCommand="SELECT A.PED_IND, A.PED_CLI_RAZAO, A.PED_CLI_CNPJ, A.PED_CLI_QTD_FUNCIONA, A.PED_MODELOREP, A.PED_ASSEPONTO4, A.PED_ASSEFIN  
                                FROM ASSEPONTOPEDIDOSREVENDAS A
                                WHERE (A.PED_REV_IND = @REVIND OR @REVIND = 0) AND 
	                                  (CONVERT(DATE, A.PED_DATA) &gt;= @DATAINICIAL AND 
		                               CONVERT(DATE, A.PED_DATA) &lt;= @DATAFINAL) AND
	                                  (@REP = 0 OR A.PED_REP_FABRICANTE = @REP)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="DATAINICIAL" Type="DateTime" QueryStringField="DATAINICIAL" />
                    <asp:QueryStringParameter Name="DATAFINAL" Type="DateTime" QueryStringField="DATAFINAL" />
                    <asp:QueryStringParameter Name="REP" Type="Int32" QueryStringField="REP" />
                    <asp:QueryStringParameter Name="REVIND" Type="Int32" QueryStringField="REVIND" DefaultValue="0" />
                </SelectParameters>
            </asp:SqlDataSource>
    
            <asp:SqlDataSource ID="SqlDataSourceListReps" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" 
                SelectCommand="SELECT DISTINCT B.FABR_NOME, B.FABR_COD  
                                FROM AssepontoPedidosRevendas A
                                INNER JOIN AssepontoRepFabricantes B ON B.FABR_COD = A.PED_REP_FABRICANTE
                                WHERE (A.PED_REV_IND = @REVIND OR @REVIND = 0) AND 
	                                  (CONVERT(DATE, A.PED_DATA) &gt;= @DATAINICIAL AND 
	                                   CONVERT(DATE, A.PED_DATA) &lt;= @DATAFINAL) AND
	                                  (@REP = 0 OR A.PED_REP_FABRICANTE = @REP)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="DATAINICIAL" Type="DateTime" QueryStringField="DATAINICIAL" />
                    <asp:QueryStringParameter Name="DATAFINAL" Type="DateTime" QueryStringField="DATAFINAL" />
                    <asp:QueryStringParameter Name="REP" Type="Int32" QueryStringField="REP" />
                    <asp:QueryStringParameter Name="REVIND" Type="Int32" QueryStringField="REVIND" DefaultValue="0" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
