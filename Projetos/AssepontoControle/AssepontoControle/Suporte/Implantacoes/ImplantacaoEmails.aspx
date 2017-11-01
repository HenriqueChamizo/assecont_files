<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="ImplantacaoEmails.aspx.cs" Inherits="Asseponto.Suporte.Implantacoes.ImplantacaoEmails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%" OnItemClick="RadMenu1_ItemClick">
            <Items>
                <telerik:RadMenuItem runat="server" Value="Email" Text="Enviar E-mail p/ selecionados" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Value="Empresas" Text="Empresas 10 E-mails " NavigateUrl="#">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:Label ID="lbImplatacao" runat="server" CssClass="formviewsubtitle" Font-Bold="true">
            </asp:Label>
            <br />
            <br />
            <telerik:RadListView ID="RadListView1" runat="server" DataKeyNames="IM_IND" DataSourceID="SqlImplantacoes"
                AllowPaging="True" ItemPlaceholderID="PendenciasHolder">
                <LayoutTemplate>
                    <asp:CheckBox ID="CheckBoxHeader" runat="server" AutoPostBack="true" OnCheckedChanged="CheckBoxHeader_CheckedChanged" />
                    Selecionar todos<br />
                    <fieldset id="RadListView1" style="border-style: none;">
                        <asp:Panel ID="PendenciasHolder" runat="server" />
                        <telerik:RadDataPager ID="RadDataPager1" runat="server" PagedControlID="RadListView1"
                            PageSize="100" Skin="Wr" EnableEmbeddedSkins="false" Visible='<%# Container.PageCount != 1%>'>
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
                                    <asp:CheckBox ID="CheckBox1" runat="server" ForeColor="White" Text='<%# Eval("IM_IND")  %>' />
                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Convert.ToInt32(Eval("IM_STATUS")) == Convert.ToInt32(Asseponto.Classes.Types.ImplantacaoStatus.EmAberto) ? Eval("IM_INICIO_IMPLANTACAO") is DBNull ? "~/Images/48x48/FlagRed.png" : "~/Images/48x48/FlagBlue.png" : "~/Images/48x48/Check.png" %>'
                                        ToolTip='<%# Convert.ToInt32(Eval("IM_STATUS")) == Convert.ToInt32(Asseponto.Classes.Types.ImplantacaoStatus.EmAberto) ? Eval("IM_INICIO_IMPLANTACAO") is DBNull ? "Implantação Não Iniciada" : "Implantação Iniciada" : "Implantação Finalizada" %>' />
                                </td>
                                <td>
                                    <b>
                                        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("IM_IND", "~/suporte/implantacoes/implantacao.aspx?ind={0}") %>'><%# Eval("CAD_RAZAOSOCIAL")%></asp:HyperLink></b><br />
                                    <asp:Label CssClass="sitelistviewfields" ID="label4" runat="server" Text='<%# "Revenda: " + Eval("REV_RAZAOSOCIAL") %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Text='<%# Eval("SUP_NOME") %>'
                                        Visible='<%# string.IsNullOrEmpty(Eval("SUP_NOME").ToString()) ? false : true  %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label1" runat="server" ForeColor="Red" Text='<%# "Enviados: " + Eval("QtdEmails") + " de cobrança " %>'
                                        Visible='<%# Convert.ToInt16(Eval("QtdEmails")) <= 0 ? false : true %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label6" runat="server" Text='<%# "Ultimo E-mail Enviado: " + Eval("DATAENVIO", "{0: dd/MM/yyyy HH:mm}") %>'
                                        Visible='<%# Convert.ToInt16(Eval("QtdEmails")) <= 0 ? false : true %>' />
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
    <asp:SqlDataSource ID="SqlImplantacoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT IM_IND, REV_RAZAOSOCIAL, IM_ANDAMENTO, STAT_NOME, IM_TERMINO, CAD_RAZAOSOCIAL, SUP_NOME, IM_STATUS, IM_INICIO_IMPLANTACAO, 
        (SELECT COUNT(*) FROM AssepontoPendencias WHERE PEN_IMPLANTACAO = IM_IND AND PEN_ANDAM = @andam AND PEN_EMAIL_FINALIZAR &lt;&gt; 1) AS QtdEmails, 
        (SELECT TOP 1 PEN_ANDAM_DATA FROM AssepontoPendencias WHERE PEN_IMPLANTACAO = IM_IND AND PEN_ANDAM = @andam ORDER BY PEN_ANDAM_DATA DESC) AS DATAENVIO
        
        FROM AssepontoImplantacoes
        LEFT JOIN AssepontoSuporte ON SUP_IND = IM_FINALIZADO_POR
        LEFT JOIN AssepontoImplantacoesStatus ON IM_ANDAMENTO = STAT_IND
        INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE
        LEFT JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA
        WHERE IM_STATUS &lt;&gt; 2 AND IM_ASSEPONTO4 = 1 AND IM_ANDAMENTO = @andam AND IM_INICIO_IMPLANTACAO IS NOT NULL AND 
        (
            (SELECT COUNT(*) FROM AssepontoPendencias WHERE PEN_IMPLANTACAO = IM_IND AND PEN_ANDAM = @andam AND PEN_EMAIL_FINALIZAR &lt;&gt; 1) &lt; 10 AND @env = 1 OR 
            (SELECT COUNT(*) FROM AssepontoPendencias WHERE PEN_IMPLANTACAO = IM_IND AND PEN_ANDAM = @andam AND PEN_EMAIL_FINALIZAR &lt;&gt; 1) &gt;= 10 AND @env = 0
        ) 
        AND CONVERT(DATE, IM_INICIO_IMPLANTACAO) &lt;&gt; CONVERT(DATE, GETDATE())
        ORDER BY QtdEmails, CAD_RAZAOSOCIAL DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="andam" QueryStringField="andam" DefaultValue="101" />
            <asp:QueryStringParameter Name="assef" QueryStringField="assef" DefaultValue="2" />
            <asp:QueryStringParameter Name="env" QueryStringField="env" DefaultValue="1" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
