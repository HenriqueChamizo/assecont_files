<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="Asseponto.Suporte.Atendimento.Clientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <wr:TextSearch ID="TextSearch1" runat="server" QueryStringField="filtronome" ShowTableFilter="true"
                PostBackUrl="~/Suporte/Atendimento/Clientes.aspx" QueryStringFieldFixed1="filTipo" />

            <span class="font_red" style="font-size: 16px; text-shadow: 0 0 0;">Cliente</span>
            <telerik:RadListView ID="RadListView1" runat="server" DataKeyNames="CAD_IND" DataSourceID="SqlClientes" AllowPaging="false" ItemPlaceholderID="ClientesHolder">
                <LayoutTemplate>
                    <fieldset id="RadListView1" style="border-style: none;">
                        <asp:Panel ID="ClientesHolder" runat="server" />
                        <telerik:RadDataPager ID="RadDataPager1" Width="1000" runat="server" PagedControlID="RadListView1"
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
                        <asp:HyperLink ID="hlRazaoSocial" runat="server" CssClass="sitelinkpadraoazul" Font-Bold="true" Style="text-transform: uppercase" NavigateUrl='<%# Eval("CAD_IND", "~/Suporte/atendimento/cliente.aspx?ind={0}") %>'><%# Eval("CAD_RAZAOSOCIAL")%></asp:HyperLink><br />
                        <asp:Label CssClass="sitelistviewfields" ID="label1" Style="text-transform: capitalize" ForeColor="#0071A2" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("Fantasia").ToString()) ? false : true %>' Text='<%# Eval("Fantasia") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label2" Style="text-transform: capitalize" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("Contato").ToString()) ? false : true %>' Text='<%# Eval("Contato") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label3" Style="text-transform: lowercase" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("Email").ToString()) ? false : true %>' Text='<%# Eval("Email") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label7" Style="text-transform: lowercase" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("Email2").ToString()) ? false : true %>' Text='<%# Eval("Email2") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label4" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CNPJ_CPF").ToString()) ? false : true %>' Text='<%# Eval("CNPJ_CPF") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label6" runat="server" Visible='<%# Convert.ToInt32(Request.QueryString["tipo"]) == 4 ? true : false %>' Text='<%# "Protocolo : " + Eval("Protocolo") %>' />
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

            <span class="font_red" style="font-size: 16px; text-shadow: 0 0 0;">Revenda</span>
            <telerik:RadListView ID="RadListView2" runat="server" DataKeyNames="REV_IND" DataSourceID="SqlRevenda"
                AllowPaging="false" ItemPlaceholderID="ClientesHolder">
                <LayoutTemplate>
                    <fieldset id="RadListView1" style="border-style: none;">
                        <asp:Panel ID="ClientesHolder" runat="server" />
                        <telerik:RadDataPager ID="RadDataPager1" Width="1000" runat="server" PagedControlID="RadListView1"
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
                        <asp:HyperLink ID="hlRazaoSocial" runat="server" CssClass="sitelinkpadraoazul" Font-Bold="true" Style="text-transform: uppercase" NavigateUrl='<%# Eval("REV_IND", "~/Suporte/Revendas/revenda.aspx?ind={0}") %>'><%# Eval("REV_RAZAOSOCIAL")%></asp:HyperLink><br />
                        <asp:Label CssClass="sitelistviewfields" ID="label1" Style="text-transform: capitalize" ForeColor="#0071A2" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("Fantasia").ToString()) ? false : true %>' Text='<%# Eval("Fantasia") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label2" Style="text-transform: capitalize" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("Contato").ToString()) ? false : true %>' Text='<%# Eval("Contato") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label3" Style="text-transform: lowercase" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("Email").ToString()) ? false : true %>' Text='<%# Eval("Email") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label7" Style="text-transform: lowercase" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("Email2").ToString()) ? false : true %>' Text='<%# Eval("Email2") %>' />
                        <asp:Label CssClass="sitelistviewfields" ID="label4" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CNPJ_CPF").ToString()) ? false : true %>' Text='<%# Eval("CNPJ_CPF") %>' />
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
    <asp:SqlDataSource ID="SqlClientes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT DISTINCT CAD_IND, dbo.fn_asseponto_capital(CAD_RAZAOSOCIAL) AS CAD_RAZAOSOCIAL, CAD_EMAIL2 AS Email2, CAD_FANTASIA AS Fantasia, CAD_CONTATO AS Contato, 
				                       CAD_EMAIL AS Email, CAD_CIDADE AS Cidade, dbo.fn_cliente_cnpj_cpf(CAD_IND) AS CNPJ_CPF,
				                       (SELECT TOP 1 PEN_PROTOCOLO 
				                        FROM AssepontoPendencias 
				                        WHERE PEN_INDCADASTRO = CAD_IND AND 
					                          @FILTRO = 4 AND 
					                          PEN_PROTOCOLO LIKE '%' + @FILTRONOME + '%') AS Protocolo
                       FROM AssepontoClientes
                       LEFT JOIN AssepontoPendencias ON PEN_INDCADASTRO = CAD_IND
                       WHERE 
	                       (@FILTRO = 1 AND CAD_RAZAOSOCIAL LIKE '%' + @FILTRONOME + '%') OR
	                       (@FILTRO = 1 AND CAD_FANTASIA LIKE '%' + @FILTRONOME + '%') OR
	                       (@FILTRO = 2 AND dbo.fn_trim_cnpj(CAD_CNPJ) LIKE '%' + RTRIM(dbo.fn_trim_cnpj(@FILTRONOME)) + '%') OR
	                       (@FILTRO = 2 AND dbo.fn_trim_cnpj(CAD_CPF) LIKE '%' + RTRIM(dbo.fn_trim_cnpj(@FILTRONOME)) + '%') OR
	                       (@FILTRO = 3 AND (CAD_EMAIL LIKE '%' + @FILTRONOME + '%' OR 
					                         CAD_EMAIL2 LIKE '%' + @FILTRONOME + '%' OR 
					                         CAD_EMAIL3 LIKE '%' + @FILTRONOME + '%')) OR
	                       (@FILTRO = 4 AND PEN_PROTOCOLO LIKE '%' + @FILTRONOME + '%')
                       ORDER BY CAD_RAZAOSOCIAL ">
        <SelectParameters>
            <asp:QueryStringParameter Name="FILTRONOME" QueryStringField="filtronome" DefaultValue="*" />
            <asp:QueryStringParameter Name="FILTRO" QueryStringField="filTipo" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlRevenda" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT REV_IND, dbo.fn_asseponto_capital(REV_RAZAOSOCIAL) AS REV_RAZAOSOCIAL, REV_EMAIL2 AS Email2, REV_FANTASIA AS Fantasia, REV_CONTATO AS Contato, 
	                          REV_EMAIL AS Email, REV_CIDADE AS Cidade, dbo.fn_cliente_cnpj_cpf(REV_IND) AS CNPJ_CPF
                       FROM AssepontoRevendas
                       WHERE 
	                       (@FILTRO = 1 AND REV_RAZAOSOCIAL LIKE '%' + @FILTRONOME + '%') OR
                           (@FILTRO = 1 AND REV_FANTASIA LIKE '%' + @FILTRONOME + '%') OR
                           (@FILTRO = 2 AND dbo.fn_trim_cnpj(REV_CNPJ) LIKE '%' + RTRIM(dbo.fn_trim_cnpj(@FILTRONOME)) + '%') OR
                           (@FILTRO = 2 AND dbo.fn_trim_cnpj(REV_CPF) LIKE '%' + RTRIM(dbo.fn_trim_cnpj(@FILTRONOME)) + '%') OR
                           (@FILTRO = 3 AND (REV_EMAIL LIKE '%' + @FILTRONOME + '%' OR 
					                         REV_EMAIL2 LIKE '%' + @FILTRONOME + '%' OR
					                         REV_EMAIL3 LIKE '%' + @FILTRONOME + '%'))
                       ORDER BY REV_RAZAOSOCIAL">
        <SelectParameters>
            <asp:QueryStringParameter Name="FILTRONOME" QueryStringField="filtronome" DefaultValue="*" />
            <asp:QueryStringParameter Name="FILTRO" QueryStringField="filTipo" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
