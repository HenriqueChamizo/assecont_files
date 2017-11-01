<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="SolicitacoesDesbloqueio.aspx.cs" Inherits="Asseponto.Suporte.Atendimento.SolicitacoesDesbloqueio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Solicitações em Aberto" NavigateUrl="~/suporte/atendimento/solicitacoesdesbloqueio.aspx?liberado=0">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Solicitações Liberadas" NavigateUrl="~/suporte/atendimento/solicitacoesdesbloqueio.aspx?liberado=1">
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
                        <telerik:RadDataPager ID="RadDataPager1" runat="server" PagedControlID="RadListView1" Width="810"
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
                            <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("ASOL_IND", "~/suporte/atendimento/solicitacaodesbloqueio.aspx?ind={0}") %>'><%# Eval("NOME")%></asp:HyperLink></b><br />
                        <asp:Label ID="label1" runat="server" Text='<%# Eval("ASOL_DATA_SOLICITACAO", "{0:dd/MM/yyyy HH:mm}") %>' /><br />
                        <asp:Label ID="label2" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("ASOL_LIBERADOEM").ToString()) ? false : true %>'
                            Text='<%# "Liberado em: " + Eval("ASOL_LIBERADOEM", "{0:dd/MM/yyyy HH:mm}") + "<br>" %>' />
                        <asp:Label ID="label4" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("LIBERADOMANUALPOR").ToString()) ? false : true %>'
                            Text='<%# Eval("LIBERADOMANUALPOR") + "<br>" %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label3" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("SUP_NOME").ToString()) ? false : true %>'
                            Text='<%# Eval("SUP_NOME") + "<br>" %>' />
                        Origem:
                        <asp:Label ID="label5" runat="server" Text='<%# string.IsNullOrEmpty(Eval("ASOL_ORIGEM").ToString()) ? "-" : Eval("ASOL_ORIGEM") %>' />
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
                SelectCommand="SELECT ASOL_IND, ASOL_DATA_SOLICITACAO, (CASE WHEN CAD_RAZAOSOCIAL IS NOT NULL 	  THEN CAD_RAZAOSOCIAL 	  ELSE CADP_RAZAOSOCIAL END) AS NOME,
                                ASOL_LIBERADOEM, SUP_NOME, ASOL_ORIGEM, ASOL_LIBERADO_MANUAL, (SELECT SUP_NOME FROM AssepontoSuporte WHERE SUP_IND = ASOL_LIBERADO_MANUAL_SUPORTE_POR) AS LIBERADOMANUALPOR,
                                (CASE WHEN ASOL_CLIENTE IS NULL THEN 1 ELSE 0 END) AS CLIENTEPROVISORIO FROM AssepontoSolicitacoes 
                                OUTER APPLY(	SELECT CAD_RAZAOSOCIAL FROM AssepontoClientes WHERE CAD_IND = ASOL_CLIENTE) A 
                                OUTER APPLY(	SELECT CADP_RAZAOSOCIAL FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) B
                                LEFT JOIN AssepontoSuporte ON SUP_IND = ASOL_LIBERADO_SUPORTE_POR
                                WHERE ((@LIBERADO = 0 AND  ASOL_LIBERADO_MANUAL = 0 AND ASOL_LIBERADOEM IS NULL) OR (@LIBERADO = 1 AND (ASOL_LIBERADO_MANUAL = 1 OR ASOL_LIBERADOEM IS NOT NULL))) AND 
                                (ASOL_CLIENTE IS NOT NULL OR ASOL_CLIENTE_PROVISORIO IS NOT NULL) AND (CAD_RAZAOSOCIAL IS NOT NULL OR CADP_RAZAOSOCIAL IS NOT NULL) ORDER BY ASOL_DATA_SOLICITACAO DESC">
                <SelectParameters>
                    <asp:QueryStringParameter Name="LIBERADO" QueryStringField="Liberado" DefaultValue="0" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
