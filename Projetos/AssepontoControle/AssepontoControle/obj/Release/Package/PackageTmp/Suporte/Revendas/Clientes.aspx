<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="Asseponto.Suporte.Revendas.Clientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <wr:TextSearch ID="TextSearch1" runat="server" QueryStringField="filtronome" />
            <telerik:RadListView ID="RadListView1" runat="server" DataKeyNames="CAD_IND" DataSourceID="SqlClientes"
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
                            <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/clientes/cliente.aspx?ind={0}") %>'><%# Eval("CAD_RAZAOSOCIAL")%></asp:HyperLink></b><br />
                        <asp:Label CssClass="sitelistviewfields" ID="label1" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_TELEFONE1").ToString()) ? false : true %>'
                            Text='<%# Eval("CAD_TELEFONE1") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_CONTATO").ToString()) ? false : true %>'
                            Text='<%# Eval("CAD_CONTATO") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label3" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_EMAIL").ToString()) ? false : true %>'
                            Text='<%# Eval("CAD_EMAIL") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label5" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_CIDADE").ToString()) ? false : true %>'
                            Text='<%# Eval("CAD_CIDADE") %>' />
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
                                    Nenhum Registro
                                </td>
                            </tr>
                        </table>
                    </div>
                </EmptyDataTemplate>
            </telerik:RadListView>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlClientes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [CAD_IND], dbo.fn_asseponto_capital(CAD_RAZAOSOCIAL) AS CAD_RAZAOSOCIAL, [CAD_TELEFONE1], [CAD_CONTATO], [CAD_EMAIL], [CAD_CIDADE] 
        FROM [AssepontoClientes] 
        WHERE CAD_REVENDA = @REVENDA AND (@FILTRONOME = '*' OR CAD_RAZAOSOCIAL LIKE '%' + @FILTRONOME + '%' OR CAD_FANTASIA LIKE '%' + @FILTRONOME + '%') 
        ORDER BY [CAD_RAZAOSOCIAL]">
        <SelectParameters>
            <asp:QueryStringParameter Name="REVENDA" QueryStringField="Revenda"/>
            <asp:QueryStringParameter Name="FILTRONOME" QueryStringField="filtronome" DefaultValue="*" />
            <asp:QueryStringParameter Name="FILTROFANTASIA" QueryStringField="filtrofantasia"
                DefaultValue="*" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
