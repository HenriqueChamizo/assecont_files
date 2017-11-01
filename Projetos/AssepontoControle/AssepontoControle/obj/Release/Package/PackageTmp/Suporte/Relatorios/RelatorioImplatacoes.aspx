<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="RelatorioImplatacoes.aspx.cs" Inherits="Asseponto.Suporte.Relatorios.RelatorioImplatacoes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%" OnItemClick="RadMenu1_ItemClick" OnPreRender="RadMenu1_PreRender">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Janeiro" Value="Janeiro">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Fevereiro" Value="Fevereiro">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Março" Value="Março">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Abril" Value="Abril">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Maio" Value="Maio">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Junho" Value="Junho">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Julho" Value="Julho">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Agosto" Value="Agosto">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Setembro" Value="Setembro">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Outubro" Value="Outubro">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Novembro" Value="Novembro">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Dezembro" Value="Dezembro">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Value="ano" Text="">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Value="anoAnterior" Text="">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <table style="Width: 835px">
                <tr>
                    <td style="vertical-align: top;">
                        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDatapedido" DefaultMode="Edit" Width="100%">
                            <EditItemTemplate>
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbMes" runat="server" ForeColor="#EF461D" Style="font-weight: 600" Text='<%# Asseponto.Classes.Utils.getMesAnoFormat(Convert.ToInt32(Request.QueryString["ind"]), Convert.ToInt32(Request.QueryString["ano"]))  %>'></asp:Label>
                                            -
                                            <asp:Label ID="lbPedidos" Font-Bold="true" runat="server" Text='<%# "Pedidos (" + Eval("QtdPedido") + ")" %>'></asp:Label>
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
                </tr>
            </table>
            <br />
            <br />
            <div id="DivImpressao">
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
                                    <asp:HyperLink ID="HyperLink" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("IM_IND", "~/suporte/Implantacoes/Implantacao.aspx?ind={0}")  %>' Text='<%# Eval("CAD_RAZAOSOCIAL") %>'></asp:HyperLink></b><br />
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
    <asp:SqlDataSource ID="SqlDataImplantacaoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelecting="SqlData_Selecting"
        SelectCommand="SELECT [CAD_IND], [REV_RAZAOSOCIAL], [CAD_RAZAOSOCIAL], RTRIM(FABR_NOME) + ': ' + CAD_MODELOREP AS REP, [IM_INICIO], IM_IND,
                [SUP_NOME] FROM [AssepontoClientes] 
                LEFT JOIN AssepontoRepFabricantes ON FABR_COD = CAD_REP_FABRICANTE 
                LEFT JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA 
                LEFT JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND
                LEFT JOIN AssepontoSuporte ON IM_PEDIDO_FINALIZADO_POR = SUP_IND 
                WHERE (MONTH(IM_INICIO) = @ind AND YEAR(IM_INICIO) = @ano AND
                CAD_REP_FABRICANTE = @rep) OR 
                (MONTH(IM_INICIO) = @ind AND YEAR(IM_INICIO) = @ano AND
                 @rep = 0)
                ORDER BY IM_INICIO DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" Type="Int32" QueryStringField="ind" />
            <asp:QueryStringParameter Name="ano" Type="Int32" QueryStringField="ano" />
            <asp:QueryStringParameter Name="rep" DefaultValue="0" QueryStringField="rep" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDatapedido" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelecting="SqlData_Selecting"
        SelectCommand="SELECT COUNT(CAD_RAZAOSOCIAL) AS QtdPedido, dbo.fn_mes_ano_extenso(MONTH(IM_INICIO), YEAR(IM_INICIO)) AS DATA FROM AssepontoClientes
                       INNER JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND
                       WHERE (MONTH(IM_INICIO) = @ind AND YEAR(IM_INICIO) = @ano AND CAD_REP_FABRICANTE = @rep) OR 
                       (MONTH(IM_INICIO) = @ind AND YEAR(IM_INICIO) = @ano AND @rep = 0)
                        GROUP BY MONTH(IM_INICIO), YEAR(IM_INICIO)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" Type="Int32" QueryStringField="ind" />
            <asp:QueryStringParameter Name="ano" Type="Int32" QueryStringField="ano" />
            <asp:QueryStringParameter Name="rep" DefaultValue="0" QueryStringField="rep" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

