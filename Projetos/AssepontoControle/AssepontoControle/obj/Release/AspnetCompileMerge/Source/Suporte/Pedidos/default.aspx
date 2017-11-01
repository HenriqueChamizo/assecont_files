<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Asseponto.Suporte.Pedidos._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Novo Pedido Asseponto4" NavigateUrl="~/suporte/pedidos/pedido.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Novo Pedido Assefin" NavigateUrl="~/suporte/pedidos/pedidoAssefin.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Pedidos em Aberto" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Pedidos Fechados" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Pedidos Fechados Assefin" NavigateUrl="#">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <wr:TextSearch ID="TextSearch1" runat="server" QueryStringField="filtronome" />
            <telerik:RadListView ID="RadListView1" runat="server" DataKeyNames="PED_IND" DataSourceID="sqlAssepontoPedidosRevendas"
                AllowPaging="True" ItemPlaceholderID="ClientesHolder">
                <LayoutTemplate>
                    <fieldset id="RadListView1" style="border-style: none;">
                        <asp:Panel ID="ClientesHolder" runat="server" />
                        <telerik:RadDataPager ID="RadDataPager1" runat="server" PagedControlID="RadListView1"
                            PageSize="30" Skin="Wr" EnableEmbeddedSkins="false" Visible='<%# Container.PageCount != 1%>'>
                            <Fields>
                                <telerik:RadDataPagerButtonField FieldType="FirstPrev" />
                                <telerik:RadDataPagerButtonField FieldType="Numeric" />
                                <telerik:RadDataPagerButtonField FieldType="NextLast" />
                                <telerik:RadDataPagerTemplatePageField>
                                    <PagerTemplate>
                                        <div style="float: right">
                                            Registros
                                            <asp:Label runat="server" ID="CurrentPageLabel" Text="<%# Container.Owner.StartRowIndex+1%>" />
                                            até
                                            <asp:Label runat="server" ID="TotalPagesLabel" Text="<%# Container.Owner.StartRowIndex+Container.Owner.PageSize %>" />
                                            de
                                            <asp:Label runat="server" ID="TotalItemsLabel" Text="<%# Container.Owner.TotalRowCount%>" />
                                            <br />
                                        </div>
                                    </PagerTemplate>
                                </telerik:RadDataPagerTemplatePageField>
                            </Fields>
                        </telerik:RadDataPager>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                    <fieldset class="sitelistviewfieldsetitemtemplate">
                        <b>
                            <asp:HyperLink ID="HyperLink" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# !(bool)Eval("PED_ASSEFIN") ? Eval("PED_IND", "~/suporte/pedidos/pedido.aspx?ind={0}") : Eval("PED_IND", "~/suporte/pedidos/pedidoAssefin.aspx?ind={0}")  %>' Text='<%# !(bool)Eval("PED_ASSEFIN") ? Eval("PED_CLI_RAZAO") : Eval("PED_CLI_RAZAO") + " - Assefin" %>'></asp:HyperLink></b><br />
                        <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("REV_RAZAOSOCIAL").ToString()) ? false : true %>'
                            Text='<%# "Revenda: " + Eval("REV_RAZAOSOCIAL") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label3" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("PED_DATA").ToString()) ? false : true %>'
                            Text='<%# Eval("PED_DATA", "{0:dd/MM/yyyy}") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label5" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("REP").ToString()) ? false : true %>'
                            Text='<%# Eval("REP") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label1" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("VERS4_DESCRICAO").ToString()) ? false : true %>'
                            Text='<%# (bool)Eval("PED_ASSEPONTO4") ? Eval("VERS4_DESCRICAO") : ""  %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label4" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("SUP_NOME").ToString()) ? false : true %>'
                            Text='<%# "Liberado por: " + Eval("SUP_NOME") %>' />
                        <br />
                    </fieldset>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <div class="sitelistviewfieldsetitemtemplate1coluna">
                        <table>
                            <tr>
                                <td>
                                    <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/48x48/info.png" />
                                </td>
                                <td>Nenhum Pedido
                                </td>
                            </tr>
                        </table>
                    </div>
                </EmptyDataTemplate>
            </telerik:RadListView>
        </div>
    </div>
    <asp:SqlDataSource ID="sqlAssepontoPedidosRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT TOP 100 [PED_IND], [REV_RAZAOSOCIAL], [PED_CLI_RAZAO], RTRIM(FABR_NOME) + ': ' + PED_MODELOREP AS REP, [PED_DATA], 
                [PED_FANTASIA], [PED_ASSEFIN], [VERS4_DESCRICAO], [PED_ASSEPONTO4], [SUP_NOME] FROM [AssepontoPedidosRevendas] 
                LEFT JOIN AssepontoRepFabricantes ON FABR_COD = PED_REP_FABRICANTE 
                LEFT JOIN AssepontoRevendas ON REV_IND = PED_REV_IND 
                LEFT JOIN Asseponto4Versoes ON VERS4_COD = PED_VERSAO_AQUISICAO 
                LEFT JOIN AssepontoImplantacoes ON IM_PEDIDO = PED_IND
                LEFT JOIN AssepontoSuporte ON IM_PEDIDO_FINALIZADO_POR = SUP_IND 
                WHERE PED_STATUS = @STATUS AND (PED_ASSEFIN = @assef OR @assef = 2)
                AND (@FILTRONOME = '*' OR PED_CLI_RAZAO LIKE '%' + @FILTRONOME + '%') 
                ORDER BY PED_DATA DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="STATUS" QueryStringField="status" Type="Int32" DefaultValue="1" />
            <asp:QueryStringParameter Name="assef" QueryStringField="assef" Type="Int32" DefaultValue="2" />
            <asp:QueryStringParameter Name="FILTRONOME" QueryStringField="filtronome"
                DefaultValue="*" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
