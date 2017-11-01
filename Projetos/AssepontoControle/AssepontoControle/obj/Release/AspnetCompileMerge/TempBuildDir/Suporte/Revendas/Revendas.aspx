<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="Revendas.aspx.cs" Inherits="Asseponto.Suporte.Revendas.Revendas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <wr:TextSearch runat="server" QueryStringField="filtrorazaosocial" />
            <telerik:RadListView ID="RadListView1" runat="server" DataKeyNames="REV_IND" DataSourceID="SqlRevendas"
                AllowPaging="True" ItemPlaceholderID="RevendasHolder">
                <LayoutTemplate>
                    <fieldset id="RadListView1" style="border-style: none;">
                        <asp:Panel ID="RevendasHolder" runat="server" />
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
                            <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("REV_IND", "~/suporte/revendas/revenda.aspx?ind={0}") %>'><%# Eval("REV_RAZAOSOCIAL")%></asp:HyperLink></b><br />
                        <asp:Label CssClass="sitelistviewfields" ID="label4" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("REV_FANTASIA").ToString()) ? false : true %>'
                            Text='<%# Eval("REV_FANTASIA")  %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label1" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("REV_TELEFONE").ToString()) ? false : true %>'
                            Text='<%# Eval("REV_TELEFONE")  %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("REV_CONTATO").ToString()) ? false : true %>'
                            Text='<%# Eval("REV_CONTATO")  %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label3" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("REV_EMAIL").ToString()) ? false : true %>'
                            Text='<%# Eval("REV_EMAIL")  %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label5" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("REV_DATA_CADASTRO").ToString()) ? false : true %>'
                            Text='<%# "Data de Cadastro: " + Eval("REV_DATA_CADASTRO", "{0:dd/MM/yyyy}")  %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label6" runat="server" Visible='<%# Convert.ToInt32(Eval("NCLIENTES")) == 0 ? false : true %>'
                            Text='<%# "Clientes: " + Eval("NCLIENTES")  %>' ForeColor="Red" />
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
                                <td>
                                    Nenhuma Revenda
                                </td>
                            </tr>
                        </table>
                    </div>
                </EmptyDataTemplate>
            </telerik:RadListView>
        </div>
    </div>
    <asp:SqlDataSource ID="sqlRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [REV_IND], [REV_CNPJ], REV_FANTASIA, dbo.fn_asseponto_capital(REV_RAZAOSOCIAL) AS REV_RAZAOSOCIAL, [REV_TELEFONE], [REV_CONTATO], [REV_EMAIL], [FABR_NOME], 
        [REV_DATA_CADASTRO], [REV_CPF], dbo.fn_asseponto_n_clientes_revenda(REV_IND) AS NCLIENTES 
        FROM [AssepontoRevendas] 
        LEFT JOIN AssepontoRepFabricantes ON FABR_COD = REV_REP_FABRICANTE
        WHERE 
         (@FILTRORAZAOSOCIAL = '*' OR REV_RAZAOSOCIAL LIKE '%' + @FILTRORAZAOSOCIAL + '%') OR
         (@FILTRORAZAOSOCIAL = '*' OR REV_FANTASIA LIKE '%' + @FILTRORAZAOSOCIAL + '%') OR
        (@FILTRORAZAOSOCIAL = '*' OR REV_CONTATO LIKE '%' + @FILTRORAZAOSOCIAL + '%') OR
        (@FILTRORAZAOSOCIAL = '*' OR dbo.fn_trim_cnpj(REV_CNPJ) LIKE '%' + dbo.fn_trim_cnpj(@FILTRORAZAOSOCIAL) + '%') OR
        (@FILTRORAZAOSOCIAL = '*' OR dbo.fn_trim_cnpj(REV_CPF) LIKE '%' + dbo.fn_trim_cnpj(@FILTRORAZAOSOCIAL) + '%')
        ORDER BY REV_RAZAOSOCIAL">
        <SelectParameters>
            <asp:QueryStringParameter Name="FILTRORAZAOSOCIAL" QueryStringField="filtrorazaosocial" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
