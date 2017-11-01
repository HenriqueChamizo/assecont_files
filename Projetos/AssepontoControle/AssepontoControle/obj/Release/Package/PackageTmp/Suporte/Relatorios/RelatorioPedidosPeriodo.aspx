<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="RelatorioPedidosPeriodo.aspx.cs" Inherits="Asseponto.Suporte.Relatorios.RelatorioPedidosPeriodo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <table style="Width: 835px; border-bottom: 1px solid lightgray;">
                <tr>
                    <td style="vertical-align: top;">
                        <wr:TextSearch ID="TextSearch1" runat="server" ShowTexto="false" QueryStringField="filtro" ShowDateFilter="true" />
                    </td>
                    <td>
                        <telerik:RadComboBox ID="comboboxRep" Width="200" EmptyMessage="Selecione um fabricante" CausesValidation="false" DataSourceID="SqlRep" AutoPostBack="true" OnDataBound="comboboxRep_DataBound"
                            OnSelectedIndexChanged="comboboxRep_SelectedIndexChanged" DataTextField="FABR_NOME" DataValueField="FABR_COD" runat="server" Skin="flv" EnableEmbeddedSkins="false">
                        </telerik:RadComboBox>

                        <asp:SqlDataSource ID="SqlRep" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                            SelectCommand="SELECT FABR_NOME, FABR_COD FROM AssepontoRepFabricantes WHERE FABR_ATIVO = 1"></asp:SqlDataSource>
                    </td>
                    <td style="text-align: right;">
                        <input type="button" value="Imprimir Relatório" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebutton" />
                    </td>
                </tr>
            </table>
            <div id="DivImpressao">
                <div style="padding-top: 10px;">
                    <asp:DetailsView ID="DetailsView1" runat="server" DataSourceID="SqlDatapedido" BorderWidth="0" AutoGenerateRows="False" EmptyDataText="Nenhum Registro Encontrado">
                        <Fields>
                            <asp:TemplateField ControlStyle-BorderWidth="0" HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                                <ItemTemplate>
                                    <asp:Label ID="lbPedidos" runat="server" Font-Size="14pt" Text='<%# Eval("QtdPedido") + " Empresas Localizadas"  %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Fields>
                    </asp:DetailsView>

                    <asp:SqlDataSource ID="SqlDatapedido" runat="server" OnSelecting="SqlDataImplantacaoes_Selecting" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                        SelectCommand="SELECT COUNT(*) AS QtdPedido FROM AssepontoClientes
                                INNER JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND
                                WHERE (CONVERT(DATE, IM_INICIO) &gt;= @datainicial AND CONVERT(DATE, IM_INICIO) &lt;= @datafinal AND CAD_REP_FABRICANTE = @rep) 
                                OR (CONVERT(DATE, IM_INICIO) &gt;= @datainicial AND CONVERT(DATE, IM_INICIO) &lt;= @datafinal AND @rep = 0)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="datainicial" Type="DateTime" QueryStringField="datainicial" />
                            <asp:QueryStringParameter Name="datafinal" Type="DateTime" QueryStringField="datafinal" />
                            <asp:QueryStringParameter Name="rep" DefaultValue="0" QueryStringField="rep" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <asp:DataList ID="DataListPedidos" runat="server" DataSourceID="SqlDataImplantacaoes" BorderStyle="None" CellSpacing="10" EnableTheming="True"
                    RepeatColumns="2" RepeatDirection="Horizontal" ShowFooter="False" ShowHeader="False" Width="835px">
                    <AlternatingItemStyle BorderStyle="None" />
                    <EditItemStyle BorderStyle="None" />
                    <FooterStyle BorderStyle="None" />
                    <HeaderStyle BorderStyle="None" />
                    <ItemStyle BorderStyle="None" />
                    <ItemTemplate>
                        <table>
                            <fieldset class="sitelistviewfieldsetitemtemplate">
                                <b>
                                    <asp:HyperLink ID="HyperLink" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/Atendimento/Cliente.aspx?ind={0}")  %>' Text='<%# Eval("CAD_RAZAOSOCIAL") %>'></asp:HyperLink></b><br />
                                <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("REV_RAZAOSOCIAL").ToString()) ? false : true %>'
                                    Text='<%# "Revenda: " + Eval("REV_RAZAOSOCIAL") %>' />
                                <asp:Label CssClass="sitelistviewfields" ID="label3" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("IM_INICIO").ToString()) ? false : true %>'
                                    Text='<%# "Data:" + Eval("IM_INICIO", "{0:dd/MM/yyyy}") %>' />
                                <asp:Label CssClass="sitelistviewfields" ID="label5" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("REP").ToString()) ? false : true %>'
                                    Text='<%# Eval("REP") %>' />
                                <asp:Label CssClass="sitelistviewfields" ID="label4" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("SUP_NOME").ToString()) ? false : true %>'
                                    Text='<%# "Liberado por: " + Eval("SUP_NOME") %>' />
                                <br />
                            </fieldset>
                        </table>
                    </ItemTemplate>
                    <SelectedItemStyle BorderStyle="None" />
                    <SeparatorStyle BorderStyle="None" />
                </asp:DataList>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataImplantacaoes" runat="server" OnSelecting="SqlDataImplantacaoes_Selecting" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT CAD_IND, REV_RAZAOSOCIAL, CAD_RAZAOSOCIAL, RTRIM(FABR_NOME) + ': ' + CAD_MODELOREP AS REP, IM_INICIO, SUP_NOME 
                FROM AssepontoClientes 
                INNER JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND
                LEFT JOIN AssepontoRepFabricantes ON FABR_COD = CAD_REP_FABRICANTE 
                LEFT JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA 
                LEFT JOIN AssepontoSuporte ON IM_PEDIDO_FINALIZADO_POR = SUP_IND 
                WHERE (CONVERT(DATE, IM_INICIO) &gt;= @datainicial AND CONVERT(DATE, IM_INICIO) &lt;= @datafinal AND CAD_REP_FABRICANTE = @rep) 
                    OR (CONVERT(DATE, IM_INICIO) &gt;= @datainicial AND CONVERT(DATE, IM_INICIO) &lt;= @datafinal AND @rep = 0)
                ORDER BY IM_INICIO DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="datainicial" Type="DateTime" QueryStringField="datainicial" />
            <asp:QueryStringParameter Name="datafinal" Type="DateTime" QueryStringField="datafinal" />
            <asp:QueryStringParameter Name="rep" DefaultValue="0" QueryStringField="rep" />
        </SelectParameters>
    </asp:SqlDataSource>
    <%--<asp:SqlDataSource ID="SqlDataImplantacaoes" runat="server" OnSelecting="SqlDataImplantacaoes_Selecting" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT A.REV_IND, A.REV_RAZAOSOCIAL, F.QTDE, 
	                           B.CAD_IND, B.CAD_RAZAOSOCIAL, RTRIM(D.FABR_NOME) + ': ' + B.CAD_MODELOREP AS REP, C.IM_INICIO, E.SUP_NOME
                        FROM AssepontoRevendas A
                        INNER JOIN AssepontoClientes B ON REV_IND = CAD_REVENDA
                        INNER JOIN AssepontoImplantacoes C ON IM_CLIENTE = CAD_IND
                        LEFT JOIN AssepontoRepFabricantes D ON FABR_COD = CAD_REP_FABRICANTE 
                        LEFT JOIN AssepontoSuporte E ON IM_PEDIDO_FINALIZADO_POR = SUP_IND 
                        OUTER APPLY(
	                        SELECT COUNT(*) AS QTDE FROM AssepontoClientes FA
	                        LEFT JOIN AssepontoRevendas FB ON FA.CAD_REVENDA = FB.REV_IND
	                        LEFT JOIN AssepontoImplantacoes FC ON FA.CAD_IND = FC.IM_CLIENTE
	                        WHERE (CONVERT(DATE, FC.IM_INICIO) &gt;= @DATAINICIAL AND CONVERT(DATE, FC.IM_INICIO) &lt;= @DATAFINAL AND FA.CAD_REP_FABRICANTE = @REP) OR 
	                              (CONVERT(DATE, FC.IM_INICIO) &gt;= @DATAINICIAL AND CONVERT(DATE, FC.IM_INICIO) &lt;= @DATAFINAL AND @REP = 0) AND
		                          FA.CAD_REVENDA = A.REV_IND
                        ) F
                        WHERE (CONVERT(DATE, IM_INICIO) &gt;= @DATAINICIAL AND CONVERT(DATE, IM_INICIO) &lt;= @DATAFINAL AND CAD_REP_FABRICANTE = @REP) OR 
	                          (CONVERT(DATE, IM_INICIO) &gt;= @DATAINICIAL AND CONVERT(DATE, IM_INICIO) &lt;= @DATAFINAL AND @REP = 0)
                        ORDER BY REV_IND DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="DATAINICIAL" Type="DateTime" QueryStringField="datainicial" />
            <asp:QueryStringParameter Name="DATAFINAL" Type="DateTime" QueryStringField="datafinal" />
            <asp:QueryStringParameter Name="REP" DefaultValue="0" QueryStringField="rep" />
        </SelectParameters>
    </asp:SqlDataSource>--%>

</asp:Content>

