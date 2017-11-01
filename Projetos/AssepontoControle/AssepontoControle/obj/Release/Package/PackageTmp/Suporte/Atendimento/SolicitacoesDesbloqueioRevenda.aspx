<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="SolicitacoesDesbloqueioRevenda.aspx.cs" Inherits="Asseponto.Suporte.Atendimento.SolicitacoesDesbloqueioRevenda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Solicitações em Aberto" NavigateUrl="~/suporte/atendimento/solicitacoesDesbloqueioRevenda.aspx?liberado=0">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Solicitações Liberadas" NavigateUrl="~/suporte/atendimento/solicitacoesDesbloqueioRevenda.aspx?liberado=1">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="SqlAssepontoSolicitacoes"
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
                        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CADP_REV_IND", "~/suporte/atendimento/solicitacaoRevenda.aspx?ind={0}") %>'><%# Eval("CADP_REV_RAZAOSOCIAL")%></asp:HyperLink></b><br />
                        <asp:Label ID="label1" runat="server" Text='<%# Eval("CADP_REV_DATA_CADASTRO", "{0:dd/MM/yyyy HH:mm}") %>' /><br />
                        <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Text='<%# Eval("CADP_REV_CONTATO")  %>' />
                        <asp:Label ID="label3" runat="server" CssClass="sitelistviewfields" Text='<%# (Convert.ToInt32(Eval("CADP_REV_STATUS")) == 0) ? "GOLD" : "PREMIUM" %>' />
                        <div style='<%# String.IsNullOrEmpty(Eval("CADP_REV_TECNICO").ToString()) ? "visibility:hidden;position:absolute;": "" %>'>Técnico:<asp:Label ID="Label4" runat="server" Text='<%# Eval("SUP_NOME") %>' />
                        </div>
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
                                    Nenhuma solicitação
                                </td>
                            </tr>
                        </table>
                    </div>
                </EmptyDataTemplate>
            </telerik:RadListView>
            <asp:SqlDataSource ID="SqlAssepontoSolicitacoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT * FROM [AssepontoRevendasProvisorios] LEFT JOIN AssepontoSuporte ON AssepontoSuporte.SUP_IND = CADP_REV_TECNICO WHERE (@LIBERADO = 0 AND CADP_REV_LIBERADO_EM IS NULL) OR (@LIBERADO = 1 AND CADP_REV_LIBERADO_EM IS NOT NULL) ORDER BY CADP_REV_DATA_CADASTRO DESC">
                <SelectParameters>
                    <asp:QueryStringParameter Name="LIBERADO" QueryStringField="liberado" DefaultValue="0" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
