<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PendenciasControl.ascx.cs"
    Inherits="Asseponto.WebControls.PendenciasControl" %>
<asp:Label ID="labelTitulo" runat="server" CssClass="formviewsubtitle"></asp:Label>
<telerik:RadListView ID="RadListView1" runat="server" DataKeyNames="PEN_IND" AllowPaging="True"
    ItemPlaceholderID="PendenciasHolder">
    <LayoutTemplate>
        <fieldset id="RadListView1" style="border-style: none; padding-left: 0px;">
            <asp:Panel ID="PendenciasHolder" runat="server" />
            <telerik:RadDataPager ID="RadDataPager1" runat="server" PagedControlID="RadListView1"
                PageSize="30" Skin="Metro" EnableEmbeddedSkins="true" Visible='<%# Container.PageCount != 1%>' AllowSEOPaging="True">
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
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("PEN_DATAHORASOLUCAO") is DBNull ? "~/Images/48x48/warning.png" : "~/Images/48x48/check.png" %>' />
                    </td>
                    <td>
                        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("PEN_IND", LinkUrl + "?ind={0}") %>'><%# Eval("PEN_PROBLEMA")%></asp:HyperLink><br />
                        <asp:Label CssClass="sitelistviewfields" ID="label1" runat="server" Text='<%# Eval("PEN_DATAHORA", "{0: dd/MM/yyyy HH:mm}")  %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Text='<%# string.IsNullOrEmpty(Eval("SUP_NOME").ToString()) ? "Desconhecido" : Eval("SUP_NOME")  %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label6" runat="server" Text='<%# "Protocolo: " + Eval("PEN_PROTOCOLO") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label3" runat="server" Visible='<%# Eval("PEN_DATAHORASOLUCAO") is DBNull ? false : true %>'
                            Text='<%# Eval("PEN_DATAHORASOLUCAO") is DBNull ? "" : "Solucionado em: " + Eval("PEN_DATAHORASOLUCAO", "{0:dd/MM/yyyy HH:mm}") + (Eval("SUP_NOME_SOLUCAO").ToString().Trim() == "" ? "" : " por " + Eval("SUP_NOME_SOLUCAO")) %>' />
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
                    <td>Nenhuma Pendência em Aberto
                    </td>
                </tr>
            </table>
        </div>
    </EmptyDataTemplate>
</telerik:RadListView>
<asp:SqlDataSource ID="SqlPendencias" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
    SelectCommand="SELECT [PEN_IND], [PEN_DATAHORA], dbo.fn_texttohtmltext(PEN_PROBLEMA) AS PEN_PROBLEMA, 
    PEN_RESPONSAVEL2, [SUP_NOME], PEN_PROTOCOLO, [PEN_DATAHORASOLUCAO], (SELECT SUP_NOME FROM AssepontoSuporte WHERE SUP_IND = PEN_RESPONSAVEL2) AS SUP_NOME_SOLUCAO 
        FROM [AssepontoPendencias] 
        LEFT JOIN AssepontoSuporte ON SUP_IND = PEN_RESPONSAVEL1
        WHERE PEN_INDCADASTRO = @CLIENTE AND PEN_SITUACAO = @SITUACAO
        ORDER BY PEN_DATAHORA DESC">
    <SelectParameters>
        <asp:Parameter Name="CLIENTE" DbType="Int32" />
        <asp:Parameter Name="SITUACAO" DbType="Byte" />
    </SelectParameters>
</asp:SqlDataSource>
