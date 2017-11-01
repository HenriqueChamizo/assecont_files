<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="Pendencias.aspx.cs" Inherits="Asseponto.Suporte.Clientes.Pendencias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <telerik:RadListView ID="RadListView1" runat="server" DataKeyNames="PEN_IND" DataSourceID="SqlPendencias"
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
                    <fieldset class="sitelistviewfieldsetitemtemplate1coluna" style="<%# Container.DisplayIndex % 2 == 0 ? "background:#F5F5F5": "" %>">
                        <table>
                            <tr>
                                <td>
                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# (Convert.ToInt32(Eval("PEN_SITUACAO")) == Convert.ToInt32(Asseponto.Classes.Types.PendenciaSituacao.EmAberto)) ? "~/Images/48x48/warning.png" : "~/Images/48x48/check.png" %>' />
                                </td>
                                <td>
                                    <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("PEN_IND", "~/suporte/clientes/pendencia.aspx?ind={0}") %>'><%# Eval("PEN_PROBLEMA")%></asp:HyperLink><br />
                                    <asp:Label CssClass="sitelistviewfields" ID="label1" runat="server" Text='<%# Eval("PEN_DATAHORA", "{0: dd/MM/yyyy HH:mm}")  %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Text='<%# string.IsNullOrEmpty(Eval("SUP_NOME").ToString()) ? "Desconhecido" : Eval("SUP_NOME")  %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label5" runat="server" Text='<%# "Protocolo: " + Eval("PEN_PROTOCOLO") %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label3" runat="server" Visible='<%# Eval("PEN_DATAHORASOLUCAO") is DBNull ? false : true %>'
                                        Text='<%# Eval("PEN_DATAHORASOLUCAO") is DBNull ? "" : "Solucionado em: " + Eval("PEN_DATAHORASOLUCAO", "{0:dd/MM/yyyy HH:mm}") + (Eval("SUP_NOME_SOLUCAO").ToString().Trim() == "" ? "" : " por " + Eval("SUP_NOME_SOLUCAO")) %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label4" runat="server" Text='<%# string.IsNullOrEmpty(Eval("PEN_TIPO").ToString()) ? "" : Eval("PEN_TIPO")  %>' Visible='<%# string.IsNullOrEmpty(Eval("PEN_TIPO").ToString()) ? false : true%>' ForeColor="Red" />
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
                                <td>Nenhum Registro
                                </td>
                            </tr>
                        </table>
                    </div>
                </EmptyDataTemplate>
            </telerik:RadListView>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlPendencias" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [PEN_IND], [PEN_DATAHORA], PEN_SITUACAO, dbo.fn_texttohtmltext(PEN_PROBLEMA) AS PEN_PROBLEMA, PEN_RESPONSAVEL2, 
        (SELECT SUP_NOME FROM AssepontoSuporte WHERE SUP_IND = PEN_RESPONSAVEL2) AS SUP_NOME_SOLUCAO,
        [SUP_NOME], [PEN_PROTOCOLO], [PEN_DATAHORASOLUCAO], (CASE PEN_TIPO WHEN 0 THEN 'Suporte' WHEN 2 THEN 'Implantação' END) AS PEN_TIPO
        FROM [AssepontoPendencias] 
        LEFT JOIN AssepontoSuporte ON SUP_IND = PEN_RESPONSAVEL1
        WHERE PEN_INDCADASTRO = @CLIENTE
        ORDER BY PEN_SITUACAO, PEN_DATAHORASOLUCAO DESC, PEN_DATAHORA DESC">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="cliente" Name="CLIENTE" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
