<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="Senhas.aspx.cs" Inherits="Asseponto.Suporte.Atendimento.Senhas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <wr:SenhaControl runat="server" ID="SenhaControl1" />
            <div class="siteseparador"></div>
            <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="sqlNSeries" AllowPaging="True" ItemPlaceholderID="Holder">
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
                        <strong>
                            <asp:Label ID="label2" runat="server" Text='<%# Eval("VER_NOME") %>' /></strong><br />
                        <asp:Label ID="label1" runat="server" Text='<%# Eval("NSE_NUMEROSERIE") + ">" + Eval("NSE_SENHA") %>' /><br />
                        <asp:Label ID="label3" runat="server" Text='<%# Eval("SUP_NOME") %>' />·&nbsp;<asp:Label ID="label5" runat="server" Text='<%# Eval("NSE_DATA", "{0:dd/MM/yyyy HH:mm}") %>' /><br />
                        <asp:Label ID="label4" runat="server" Visible='<%# Convert.ToBoolean(Eval("NSE_SOLICITACAO")) ? true : false %>' Text='Solicitação Online' ForeColor="#009933" />
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
                                    Nenhuma senha liberada
                                </td>
                            </tr>
                        </table>
                    </div>
                </EmptyDataTemplate>
            </telerik:RadListView>
        </div>
    </div>
    <asp:SqlDataSource ID="sqlNSeries" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT NSE_DATA, NSE_NUMEROSERIE, NSE_SENHA, VER_NOME, SUP_NOME, NSE_SOLICITACAO
            FROM AssepontoNSeries
            INNER JOIN AssepontoVersoes ON VER_COD = NSE_TIPO
            LEFT JOIN AssepontoSuporte ON SUP_IND = NSE_SUPORTE
            WHERE NSE_CLIENTE = @NSE_CLIENTE
            ORDER BY NSE_DATA DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="NSE_CLIENTE" QueryStringField="cliente" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
