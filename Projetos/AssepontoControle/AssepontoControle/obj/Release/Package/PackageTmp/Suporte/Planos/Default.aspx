<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Asseponto.Suporte.Planos.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Solicitações em Aberto" NavigateUrl="~/Suporte/Planos/Default.aspx?Aberto=1" />
                <telerik:RadMenuItem runat="server" Text="Solicitações Concluidas" NavigateUrl="~/Suporte/Planos/Default.aspx?Aberto=0" />
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <%--<wr:TextSearch ID="TextSearch1" runat="server" QueryStringField="filtronome" ShowTableFilter="true"
                PostBackUrl="~/Suporte/Planos/Default.aspx" QueryStringFieldFixed1="filTipo" />--%>

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
                        <asp:HyperLink ID="hlRazaoSocial" runat="server" CssClass="sitelinkpadraoazul" Font-Bold="true" 
                            Style="text-transform: uppercase" NavigateUrl='<%# Eval("CAD_IND", "~/Suporte/Planos/Solicitacao.aspx?ind={0}") %>'>
                            <%# Eval("CAD_RAZAOSOCIAL") %>
                        </asp:HyperLink><br />

                        <asp:Label CssClass="sitelistviewfields" ID="label1" Style="text-transform: capitalize" ForeColor="#0071A2" runat="server" 
                            Visible='<%# string.IsNullOrEmpty(Eval("Fantasia").ToString()) ? false : true %>' Text='<%# Eval("Fantasia") %>' />

                        <asp:Label CssClass="sitelistviewfields" ID="label2" Style="text-transform: capitalize" runat="server" 
                            Visible='<%# string.IsNullOrEmpty(Eval("Contato").ToString()) ? false : true %>' Text='<%# Eval("Contato") %>' />

                        <asp:Label CssClass="sitelistviewfields" ID="label3" Style="text-transform: lowercase" runat="server" 
                            Visible='<%# string.IsNullOrEmpty(Eval("Email").ToString()) ? false : true %>' Text='<%# Eval("Email") %>' />

                        <asp:Label CssClass="sitelistviewfields" ID="label7" Style="text-transform: lowercase" runat="server" 
                            Visible='<%# string.IsNullOrEmpty(Eval("Email2").ToString()) ? false : true %>' Text='<%# Eval("Email2") %>' />

                        <asp:Label CssClass="sitelistviewfields" ID="label4" runat="server" 
                            Visible='<%# string.IsNullOrEmpty(Eval("CNPJ_CPF").ToString()) ? false : true %>' Text='<%# Eval("CNPJ_CPF") %>' />
                        
                        <asp:Label CssClass="sitelistviewfields" ID="label5" Style="text-transform: capitalize" ForeColor="#0071A2" runat="server" 
                            Visible='<%# string.IsNullOrEmpty(Eval("SOLPLA_SOLICITADO_POR_NOME").ToString()) ? false : true %>' Text='<%# Eval("SOLPLA_SOLICITADO_POR_NOME") %>' />
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
        SelectCommand="SELECT CAD_IND, 
	                        CAD_RAZAOSOCIAL,  
	                        CAD_EMAIL2 AS Email2, 
	                        CAD_FANTASIA AS Fantasia, 
	                        CAD_CONTATO AS Contato, 
	                        CAD_EMAIL AS Email, 
	                        CAD_CIDADE AS Cidade, 
	                        dbo.fn_cliente_cnpj_cpf(CAD_IND) AS CNPJ_CPF, 
	                        SOLPLA_SOLICITADO_POR_NOME 
                        FROM AssepontoClientes
                        inner join AssepontoSolicitacoesPlanos ON SOLPLA_CLIENTE = CAD_IND 
                        WHERE 
	                        ((@ABERTO = 0 AND solpla_concluido_em is not null) OR
	                         (@ABERTO = 1 AND solpla_concluido_em is null)) AND 
	                        (1 = 1)
                        ORDER BY SOLPLA_DATA, CAD_RAZAOSOCIAL">
        <SelectParameters>
            <asp:QueryStringParameter Name="ABERTO" QueryStringField="aberto" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
