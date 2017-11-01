<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Asseponto.Revenda.Implantacoes.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Exibir em Aberto" NavigateUrl="~/revenda/implantacoes/default.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Exibir Finalizadas" NavigateUrl="~/revenda/implantacoes/default.aspx?status=2">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <telerik:RadListView ID="RadListView1" runat="server" DataKeyNames="IM_IND" DataSourceID="SqlImplantacoes"
                AllowPaging="True" ItemPlaceholderID="PendenciasHolder">
                <LayoutTemplate>
                    <fieldset id="RadListView1" style="border-style: none;">
                        <asp:Panel ID="PendenciasHolder" runat="server" />
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
                    <fieldset class="sitelistviewfieldsetitemtemplate1coluna" style="<%# Container.DisplayIndex % 2 != 0 ? "background:#F5F5F5": "" %>">
                        <table>
                            <tr>
                                <td>
                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# (Eval("IM_STATUS").ToString() == Asseponto.Classes.Types.ImplantacaoStatus.EmAberto.ToString()) ? "~/Images/48x48/warning.png" : "~/Images/48x48/FlagBlue.png" %>' />
                                </td>
                                <td>
                                    <b>
                                        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("IM_IND", "~/revenda/implantacoes/implantacao.aspx?ind={0}") %>'><%# Eval("CAD_RAZAOSOCIAL")%></asp:HyperLink></b><br />
                                    <asp:Label CssClass="sitelistviewfields" ID="label1" runat="server" Text='<%# "Implantação iniciada em: " + Eval("IM_INICIO", "{0: dd/MM/yyyy HH:mm}")  %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("SUP_NOME").ToString()) ? false : true  %>' Text='<%# Eval("SUP_NOME")  %>' />
                                </td>
                            </tr>
                        </table>
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
    <asp:SqlDataSource ID="SqlImplantacoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT IM_IND, REV_RAZAOSOCIAL, IM_INICIO, CAD_RAZAOSOCIAL, SUP_NOME, IM_STATUS
        FROM AssepontoImplantacoes
        LEFT JOIN AssepontoSuporte ON SUP_IND = IM_TECNICO
        INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE
        INNER JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA
        WHERE (IM_STATUS = @STATUS) 
        AND (REV_IND = @REVENDA)
        AND (@INICIADAS = 3 OR (@INICIADAS = 1 AND IM_INICIO_IMPLANTACAO IS NOT NULL) OR (@INICIADAS = 0 AND IM_INICIO_IMPLANTACAO IS NULL)) 
        ORDER BY IM_STATUS, IM_INICIO">
        <SelectParameters>
            <asp:QueryStringParameter Name="STATUS" DefaultValue="1" QueryStringField="status"/>
            <asp:SessionParameter Name="REVENDA" SessionField="Revenda"/>
            <asp:QueryStringParameter Name="INICIADAS" QueryStringField="iniciadas" DefaultValue="3" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
