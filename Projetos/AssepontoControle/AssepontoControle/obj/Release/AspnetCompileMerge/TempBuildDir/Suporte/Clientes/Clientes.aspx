<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="Clientes.aspx.cs" Inherits="Asseponto.Suporte.Clientes.Clientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <style>
                #cliPontoControle {
                    display:block;
                }
                #cliAssefin {
                    display:none;
                }
            </style>
            <script>
                function PontoFin(ponto, fin) {
                    if (ponto == 1 && fin == 0) {
                        document.getElementById("cliPontoControle").style.display = "block";
                        document.getElementById("cliAssefin").style.display = "none";
                    }
                    else if (ponto == 0 && fin == 1) {
                        document.getElementById("cliPontoControle").style.display = "none";
                        document.getElementById("cliAssefin").style.display = "block";
                    }
                }
            </script>
            <%--<label>
                <input type="radio" name="clie" value="1" onclick="PontoFin(1,0)"> AssePonto
            </label>
            <label>
                <input type="radio" name="clie" value="2" onclick="PontoFin(0, 1)"> AsseFin
            </label>
            <div id="cliPontoControle">--%>
                <wr:TextSearch ID="TextSearch1" runat="server" QueryStringField="filtronome" ShowTableFilter="true" ShowTexto="true" 
                    PostBackUrl="~/Suporte/Clientes/Clientes.aspx" QueryStringFieldFixed1="filTipo" />

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
                                <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/clientes/cliente.aspx?ind={0}") %>'><%# Eval("CAD_RAZAOSOCIAL") %></asp:HyperLink></b><br />
                            <asp:Label CssClass="sitelistviewfields" ID="label1" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_TELEFONE1").ToString()) ? false : true %>'
                                Text='<%# Eval("CAD_TELEFONE1") %>' />
                            <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_CONTATO").ToString()) ? false : true %>'
                                Text='<%# Eval("CAD_CONTATO") %>' />
                            <asp:Label CssClass="sitelistviewfields" ID="label3" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_EMAIL").ToString()) ? false : true %>'
                                Text='<%# Eval("CAD_EMAIL") %>' />
                             <asp:Label CssClass="sitelistviewfields" ID="label4" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_EMAIL").ToString()) ? false : true %>'
                                Text='<%# Eval("CAD_EMAIL2") %>' />
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
            <%--</div>
            <div id="cliAssefin">  --%>  
                <wr:TextSearch2 ID="TextSearch2" runat="server" QueryStringField="filtronome" ShowTableFilter="false" ShowTexto="true" ShowAssefin="true"
                    PostBackUrl="~/Suporte/Clientes/Clientes.aspx" QueryStringFieldFixed1="filTipo" />

                <telerik:RadListView ID="RadListView2" runat="server" DataKeyNames="CAD_IND" DataSourceID="SqlClientesAssefin"
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
                                <asp:HyperLink ID="LinkNome" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/clientes/cliente.aspx?ind={0}&banco=fin") %>'><%# Eval("CAD_RAZAOSOCIAL") %></asp:HyperLink></b><br />
                                <%--<asp:Label ID="LabelNome" runat="server" CssClass="sitelinkpadraoazul"><%# Eval("CAD_RAZAOSOCIAL") %></asp:Label>--%></b><br />
                            <asp:Label CssClass="sitelistviewfields" ID="label1" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_TELEFONE1").ToString()) ? false : true %>'
                                Text='<%# Eval("CAD_TELEFONE1") %>' />
                            <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_CONTATO").ToString()) ? false : true %>'
                                Text='<%# Eval("CAD_CONTATO") %>' />
                            <asp:Label CssClass="sitelistviewfields" ID="label3" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_EMAIL").ToString()) ? false : true %>'
                                Text='<%# Eval("CAD_EMAIL") %>' />
                             <asp:Label CssClass="sitelistviewfields" ID="label4" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_EMAIL2").ToString()) ? false : true %>'
                                Text='<%# Eval("CAD_EMAIL2") %>' />
                             <asp:Label CssClass="sitelistviewfields" ID="label6" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_EMAIL3").ToString()) ? false : true %>'
                                Text='<%# Eval("CAD_EMAIL3") %>' />
                            <asp:Label CssClass="sitelistviewfields" ID="label7" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_FINANCEIRO_EMAIL").ToString()) ? false : true %>'
                                Text='<%# Eval("CAD_FINANCEIRO_EMAIL") %>' />
                             <asp:Label CssClass="sitelistviewfields" ID="label8" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_FINANCEIRO_EMAIL2").ToString()) ? false : true %>'
                                Text='<%# Eval("CAD_FINANCEIRO_EMAIL2") %>' />
                             <asp:Label CssClass="sitelistviewfields" ID="label9" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_FINANCEIRO_EMAIL3").ToString()) ? false : true %>'
                                Text='<%# Eval("CAD_FINANCEIRO_EMAIL3") %>' />
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
            <%--</div>--%>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlClientes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT DISTINCT [CAD_IND], [CAD_RAZAOSOCIAL], [CAD_TELEFONE1], [CAD_CONTATO], [CAD_EMAIL], [CAD_CIDADE], [CAD_EMAIL2], [CAD_ASSEFIN]
                       FROM [AssepontoClientes] 
                       LEFT JOIN AssepontoPendencias ON PEN_INDCADASTRO = CAD_IND
                       WHERE (@FILTRO = 1 AND CAD_RAZAOSOCIAL	LIKE '%' + @FILTRONOME + '%') OR
	                         (@FILTRO = 1 AND CAD_FANTASIA		LIKE '%' + @FILTRONOME + '%') OR
	                         (@FILTRO = 2 AND dbo.fn_trim_cnpj(CAD_CNPJ)	LIKE '%' + RTRIM(dbo.fn_trim_cnpj(@FILTRONOME)) + '%') OR
	                         (@FILTRO = 2 AND dbo.fn_trim_cnpj(CAD_CPF)	LIKE '%' + RTRIM(dbo.fn_trim_cnpj(@FILTRONOME)) + '%') OR
	                         (@FILTRO = 3 AND (CAD_EMAIL		LIKE '%' + @FILTRONOME + '%' OR CAD_EMAIL2 LIKE '%' + @FILTRONOME + '%')) OR
	                         (@FILTRO = 4 AND PEN_PROTOCOLO	LIKE '%' + @FILTRONOME + '%')
                       ORDER BY CAD_RAZAOSOCIAL ">
        <SelectParameters>
            <asp:QueryStringParameter Name="FILTRONOME" QueryStringField="filtronome" DefaultValue="*" />
            <%--<asp:QueryStringParameter Name="FILTROFANTASIA" QueryStringField="filtrofantasia" DefaultValue="*" />--%>
            <asp:QueryStringParameter Name="FILTRO" QueryStringField="filTipo" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlClientesAssefin" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionStringAssefin %>"
        SelectCommand="SELECT [CAD_IND], [CAD_RAZAOSOCIAL], [CAD_TELEFONE1], [CAD_CONTATO], [CAD_EMAIL], [CAD_CIDADE], [CAD_EMAIL2], [CAD_EMAIL3], [CAD_FINANCEIRO_EMAIL], [CAD_FINANCEIRO_EMAIL2], [CAD_FINANCEIRO_EMAIL3]
                        FROM Cadastros 
                        WHERE (@FILTRO = 1 AND CAD_RAZAOSOCIAL	LIKE '%' + @FILTRONOME + '%') OR
	                          (@FILTRO = 1 AND CAD_FANTASIA		LIKE '%' + @FILTRONOME + '%') OR
	                          (@FILTRO = 2 AND dbo.fn_trim_cnpj(CAD_CNPJ)	LIKE '%' + RTRIM(dbo.fn_trim_cnpj(@FILTRONOME)) + '%') OR
	                          (@FILTRO = 2 AND dbo.fn_trim_cnpj(CAD_CPF)	LIKE '%' + RTRIM(dbo.fn_trim_cnpj(@FILTRONOME)) + '%') OR
	                          (@FILTRO = 3 AND 
		                        ((CAD_EMAIL		LIKE '%' + @FILTRONOME + '%' OR CAD_EMAIL2 LIKE '%' + @FILTRONOME + '%' OR CAD_EMAIL3 LIKE '%' + @FILTRONOME + '%') OR
		                        (CAD_FINANCEIRO_EMAIL		LIKE '%' + @FILTRONOME + '%' OR CAD_FINANCEIRO_EMAIL2 LIKE '%' + @FILTRONOME + '%' OR CAD_FINANCEIRO_EMAIL3 LIKE '%' + @FILTRONOME + '%')))
                        ORDER BY CAD_RAZAOSOCIAL ">
        <SelectParameters>
            <asp:QueryStringParameter Name="FILTRONOME" QueryStringField="filtronome" DefaultValue="*" />
            <%--<asp:QueryStringParameter Name="FILTROFANTASIA" QueryStringField="filtrofantasia" DefaultValue="*" />--%>
            <asp:QueryStringParameter Name="FILTRO" QueryStringField="filTipo" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
