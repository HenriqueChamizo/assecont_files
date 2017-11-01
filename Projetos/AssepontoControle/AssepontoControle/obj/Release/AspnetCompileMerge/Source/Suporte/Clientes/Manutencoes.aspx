<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="Manutencoes.aspx.cs" Inherits="Asseponto.Suporte.Clientes.Manutencoes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:content id="Content2" contentplaceholderid="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%" OnItemClick="RadMenu1_ItemClick" OnPreRender="RadMenu1_PreRender">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Janeiro" Value="Janeiro" />
                <telerik:RadMenuItem runat="server" Text="Fevereiro" Value="Fevereiro" />
                <telerik:RadMenuItem runat="server" Text="Março" Value="Março" />
                <telerik:RadMenuItem runat="server" Text="Abril" Value="Abril" />
                <telerik:RadMenuItem runat="server" Text="Maio" Value="Maio" />
                <telerik:RadMenuItem runat="server" Text="Junho" Value="Junho" />
                <telerik:RadMenuItem runat="server" Text="Julho" Value="Julho" />
                <telerik:RadMenuItem runat="server" Text="Agosto" Value="Agosto" />
                <telerik:RadMenuItem runat="server" Text="Setembro" Value="Setembro" />
                <telerik:RadMenuItem runat="server" Text="Outubro" Value="Outubro" />
                <telerik:RadMenuItem runat="server" Text="Novembro" Value="Novembro" />
                <telerik:RadMenuItem runat="server" Text="Dezembro" Value="Dezembro" />
                <telerik:RadMenuItem runat="server" Value="ano" Text="" />
                <telerik:RadMenuItem runat="server" Value="anoAnterior" Text="" />
            </Items>
        </telerik:RadMenu>
    </div>
</asp:content>
<asp:content id="Content3" contentplaceholderid="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <wr:TextSearch ID="TextSearch1" runat="server" QueryStringField="filtronome" />
            <telerik:RadMenu ID="RadMenuREP" runat="server" Flow="Horizontal" Skin="Blue" EnableEmbeddedSkins="false" Width="850px">
            </telerik:RadMenu>
            <br />
            <table style="Width: 835px; margin-left: 5px">
                <tr>
                    <td>
                        <asp:FormView ID="FormViewpedidos" runat="server" DataSourceID="SqlDataManutencao" Font-Size="14px" DefaultMode="Edit" Width="100%">
                            <EditItemTemplate>
                                <table style="width: 100%">
                                    <tr>
                                        <td style="border-right: 1px solid black">
                                            <asp:Label ID="lbPedidos" Font-Bold="true"
                                                runat="server" Text='<%# "Clientes (" + Eval("QtdPedidos") + ")" %>'></asp:Label>
                                        </td>
                                        <td style="border-right: 1px solid black">
                                            <asp:Label ID="lbMes" Font-Bold="true" runat="server" Text='<%# "Mês " + Request.QueryString["ind"] + "/" + Request.QueryString["ano"] %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </EditItemTemplate>
                        </asp:FormView>
                    </td>
                    <td>
                        <asp:Label ID="lbrep" Font-Bold="true" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="sqlAssepontoManutencao"
                AllowPaging="True" ItemPlaceholderID="Holder">
                <LayoutTemplate>
                    <fieldset id="RadListView1" style="border-style: none;">
                        <asp:Panel ID="Holder" runat="server" />
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
                            <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/clientes/manutencoescliente.aspx?cliente={0}") %>'><%# Eval("CAD_RAZAOSOCIAL")%></asp:HyperLink></b>
                        <asp:Label ID="label7" runat="server" Text='<%# "<br/>" + Eval("CAD_CONTATO") %>'
                            Visible='<%# string.IsNullOrEmpty(Eval("CAD_CONTATO").ToString()) ? false : true %>' />
                        <asp:Label ID="label8" runat="server" Text='<%# "<br/>" + Eval("CAD_EMAIL") %>' Visible='<%# string.IsNullOrEmpty(Eval("CAD_EMAIL").ToString()) ? false : true %>' />
                        <asp:Label ID="label9" runat="server" Text='<%# " · " + Eval("CAD_TELEFONE1") %>'
                            Visible='<%# string.IsNullOrEmpty(Eval("CAD_TELEFONE1").ToString()) ? false : true %>' />
                        <asp:Label ID="label6" runat="server" Text='<%# "<br/>Manutenção desde: " + Eval("MNT_DATA", "{0:dd/MM/yyyy}") %>' />
                        <asp:Label ID="label10" runat="server" Text='<%# "<br/>" + Eval("VER_NOME_FANTASIA") %>' Visible='<%# string.IsNullOrEmpty(Eval("VER_NOME_FANTASIA").ToString()) ? false : true %>' ForeColor="#006699" />
                        <asp:Label ID="label11" runat="server" Text='<%# "<br/>" + Eval("MNT_VALOR", "{0:c}") %>' />
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
                                <td>Nenhuma manutenção
                                </td>
                            </tr>
                        </table>
                    </div>
                </EmptyDataTemplate>
            </telerik:RadListView>
            <asp:SqlDataSource ID="sqlAssepontoManutencao" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT CAD_IND, dbo.fn_asseponto_capital(CAD_RAZAOSOCIAL) AS CAD_RAZAOSOCIAL, CAD_TELEFONE1, CAD_CONTATO, CAD_EMAIL, 
                                MNT_DATA, VER_NOME_FANTASIA, MNT_VALOR
                                FROM AssepontoManutencao 
                                INNER JOIN AssepontoClientes ON CAD_IND = MNT_CLIENTE
                                LEFT JOIN AssepontoVersoes ON VER_COD = MNT_VERSAO_ASSEPONTO
                                WHERE ((MNT_CANCELADO = 0 AND @FILTRONOME = '*') AND (MONTH(MNT_DATA) = @ind AND YEAR(MNT_DATA) = @ano AND
                                CAD_REP_FABRICANTE = @rep) OR 
                                (MONTH(MNT_DATA) = @ind AND YEAR(MNT_DATA) = @ano AND
                                @rep = 0)) OR (CAD_RAZAOSOCIAL LIKE '%' + @FILTRONOME + '%') ORDER BY CAD_RAZAOSOCIAL">
                <SelectParameters>
                    <asp:QueryStringParameter Name="FILTRONOME" QueryStringField="filtronome" DefaultValue="*" />
                    <asp:QueryStringParameter Name="ind" Type="Int32" QueryStringField="ind" />
                    <asp:QueryStringParameter Name="ano" Type="Int32" QueryStringField="ano" />
                    <asp:QueryStringParameter Name="rep" DefaultValue="0" QueryStringField="rep" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataManutencao" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT COUNT(CAD_IND) as QtdPedidos FROM AssepontoManutencao INNER JOIN AssepontoClientes ON CAD_IND = MNT_CLIENTE 
                LEFT JOIN AssepontoVersoes ON VER_COD = MNT_VERSAO_ASSEPONTO WHERE (MONTH(MNT_DATA) = @ind 
                AND YEAR(MNT_DATA) = @ano AND CAD_REP_FABRICANTE = @rep) OR (MONTH(MNT_DATA) = @ind AND 
                YEAR(MNT_DATA) = @ano AND @rep = 0)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ind" Type="Int32" QueryStringField="ind" />
                    <asp:QueryStringParameter Name="ano" Type="Int32" QueryStringField="ano" />
                    <asp:QueryStringParameter Name="rep" DefaultValue="0" QueryStringField="rep" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:content>
