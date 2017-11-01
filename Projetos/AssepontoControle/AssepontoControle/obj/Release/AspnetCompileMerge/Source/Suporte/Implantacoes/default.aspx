<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="default.aspx.cs" Inherits="Asseponto.Suporte.Implantacoes.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script type="text/javascript">
        function confirmarfinalizar() { return (window.confirm('Confirma a exclusão?')) }
    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <div>
            <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
                Width="200px">
                <Items>
                    <telerik:RadMenuItem runat="server" Text="Exibir em Aberto" NavigateUrl="~/suporte/implantacoes/default.aspx?status=1&filtronome=*" />
                    <telerik:RadMenuItem runat="server" Text="Exibir Não Iniciadas" NavigateUrl="~/suporte/implantacoes/default.aspx?status=1&filtronome=*&iniciadas=0" />
                    <telerik:RadMenuItem runat="server" Text="Exibir Finalizadas" NavigateUrl="~/suporte/implantacoes/default.aspx?status=2&filtronome=*&iniciadas=1" />
                    <telerik:RadMenuItem runat="server" Text="Exibir Assefin" NavigateUrl="~/suporte/implantacoes/default.aspx?status=1&filtronome=*&assef=1" />
                </Items>
            </telerik:RadMenu>
        </div>
        <div class="divMenuTitle">
            Controles
        </div>
        <div>
            <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
                Width="200px">
                <Items>
                    <telerik:RadMenuItem runat="server" Text="Primeiro Contato" NavigateUrl="~/suporte/implantacoes/default.aspx?status=1&andam=6&filtronome=*&iniciadas=2" />
                    <telerik:RadMenuItem runat="server" Value="planilha" Text="Aguardando Planilha" NavigateUrl="~/suporte/implantacoes/default.aspx?status=1&andam=1&filtronome=*&iniciadas=2" />
                    <telerik:RadMenuItem runat="server" Text="Aguardando Treinamento" NavigateUrl="~/suporte/implantacoes/default.aspx?status=1&andam=2&filtronome=*&iniciadas=2" />
                    <telerik:RadMenuItem runat="server" Text="REP Manutenção" NavigateUrl="~/suporte/implantacoes/default.aspx?status=1&andam=4&filtronome=*&iniciadas=2" />
                    <telerik:RadMenuItem runat="server" Text="Retorno do Cliente" NavigateUrl="~/suporte/implantacoes/default.aspx?status=1&andam=5&filtronome=*&iniciadas=2" />
                    <telerik:RadMenuItem runat="server" Text="Repassado para revenda <br /> (Finalizado)" NavigateUrl="~/suporte/implantacoes/default.aspx?status=100&andam=8&filtronome=*&iniciadas=2" />   
                    <telerik:RadMenuItem runat="server" Text="Agendamento" NavigateUrl="~/suporte/implantacoes/default.aspx?status=1&andam=9&filtronome=*&iniciadas=2&tip=0" />                     
                </Items>
            </telerik:RadMenu>
        </div>
        <div class="divMenuTitle">
            Agenda
        </div>
        <div>
            <telerik:RadMenu ID="RadMenu3" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
                Width="200px">
                <%--<Items>
                    <telerik:RadMenuItem runat="server" Text="Agendamentos hoje" NavigateUrl="~/suporte/implantacoes/Agenda.aspx?tipo=1" />
                    <telerik:RadMenuItem runat="server" Text="Todos Agendamentos" NavigateUrl="~/suporte/implantacoes/Agenda.aspx?tipo=2" />
                </Items>--%>
            </telerik:RadMenu>
        </div>
    </div>
</asp:content>
<asp:content id="Content3" contentplaceholderid="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <wr:TextSearch ID="TextSearch1" runat="server" QueryStringField="filtronome" QueryStringFieldFixed1="status" QueryStringValueFixed1="100" QueryStringFieldFixed2="iniciadas" QueryStringValueFixed2="3" />

            <telerik:RadListView ID="RadListView1" runat="server" DataKeyNames="IM_IND" DataSourceID="SqlImplantacoes"
                AllowPaging="True" ItemPlaceholderID="PendenciasHolder">
                <LayoutTemplate>
                    <fieldset id="RadListView1" style="border-style: none;">
                        <asp:Panel ID="PendenciasHolder" runat="server" />
                        <telerik:RadDataPager ID="RadDataPager1" runat="server" Width="100%" PagedControlID="RadListView1"
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
                    <fieldset class="sitelistviewfieldsetitemtemplate1coluna" style="<%# Container.DisplayIndex % 2 == 0 ? "background:#EBEBEB": "" %>">
                        <table>
                            <tr>
                                <td>
                                    <%--<asp:Image ID="Image1" runat="server" ImageUrl='<%# Convert.ToInt32(Eval("IM_STATUS")) == Convert.ToInt32(Asseponto.Classes.Types.ImplantacaoStatus.EmAberto) ? Eval("IM_INICIO_IMPLANTACAO") is DBNull ? Convert.ToInt32(Eval("IM_ANDAMENTO")) == 6 ? "~/Images/48x48/FlagRed.png" : "~/Images/48x48/FlagBlue.png" : "~/Images/48x48/Check.png" %>'--%>
                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Convert.ToInt32(Eval("IM_STATUS")) == Convert.ToInt32(Asseponto.Classes.Types.ImplantacaoStatus.EmAberto) ? Convert.ToInt32(Eval("IM_ANDAMENTO")) == 6 ? Eval("IM_INICIO_IMPLANTACAO") is DBNull ? "~/Images/48x48/FlagRed.png" : "~/Images/48x48/FlagYellow.png" : "~/Images/48x48/FlagBlue.png" : "~/Images/48x48/Check.png" %>'
                                        ToolTip='<%# Convert.ToInt32(Eval("IM_STATUS")) == Convert.ToInt32(Asseponto.Classes.Types.ImplantacaoStatus.EmAberto) ? Eval("IM_INICIO_IMPLANTACAO") is DBNull ? "Implantação Não Iniciada" : "Implantação Iniciada" : "Implantação Finalizada" %>' />
                                </td>
                                <td style="padding-right: 8px;">
                                    <b>
                                        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# !(bool)Eval("IM_ASSEFIN") ? Eval("IM_IND", "~/suporte/implantacoes/implantacao.aspx?ind={0}") : Eval("IM_IND", "~/suporte/implantacoes/implantacaoAssefin.aspx?ind={0}") %>'><%# !(bool)Eval("IM_ASSEFIN") ? Eval("CAD_RAZAOSOCIAL") : Eval("CAD_RAZAOSOCIAL") + " - Assefin" %></asp:HyperLink></b><br />
                                    <asp:Label CssClass="siteSubTitulo" ID="label7" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("CAD_FANTASIA").ToString()) ? false : true %>' Text='<%# Eval("CAD_FANTASIA") %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label4" runat="server" Text='<%# "Revenda: " + Eval("REV_RAZAOSOCIAL") %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label1" runat="server" Text='<%# "Pedido fechado em: " + Eval("IM_INICIO", "{0: dd/MM/yyyy HH:mm}")  %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label5" runat="server" Text='<%# "Iniciado em: " + Eval("IM_INICIO_IMPLANTACAO", "{0: dd/MM/yyyy HH:mm}")  %>'
                                        Visible='<%# string.IsNullOrEmpty(Eval("IM_INICIO_IMPLANTACAO").ToString()) ? false : true %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label3" runat="server" Text='<%# "Finalizado em: " + Eval("IM_TERMINO", "{0: dd/MM/yyyy HH:mm}")  %>'
                                        Visible='<%# string.IsNullOrEmpty(Eval("IM_TERMINO").ToString()) ? false : true %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Text='<%# "Status: " + Eval("STAT_NOME") %>'
                                        Visible='<%# Convert.ToInt16(Eval("IM_ANDAMENTO")) == 7 ? false : true %>' ForeColor='<%# Convert.ToInt16(Eval("IM_ANDAMENTO")) == 6 ? System.Drawing.Color.Red : System.Drawing.Color.FromName("#333333") %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label9" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("SUP_NOME").ToString()) ? false : true %>'
                                        Text='<%# "Finalizado por: " + Eval("SUP_NOME") %>' />
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
        SelectCommand="SELECT IM_IND, REV_RAZAOSOCIAL, IM_INICIO, IM_ANDAMENTO, STAT_NOME, TIPO_STAT_NOME, IM_TERMINO, CAD_FANTASIA, 
        CAD_RAZAOSOCIAL, SUP_NOME, IM_STATUS, IM_INICIO_IMPLANTACAO, IM_DTAGENDA, IM_ASSEFIN, IM_ASSEPONTO4,
        (' por ' + (SELECT SUP_NOME FROM AssepontoSuporte WHERE SUP_IND = IM_AGENDA_CONCLUIDO_POR)) AS CONCLUIDO 
        FROM AssepontoImplantacoes
        LEFT JOIN AssepontoSuporte ON SUP_IND = IM_FINALIZADO_POR
        LEFT JOIN AssepontoImplantacoesStatus ON IM_ANDAMENTO = STAT_IND
        LEFT JOIN AssepontoImplantacoesStatusTipo ON IM_ANDAMENTO_TIPO = TIPO_STAT_IND
        INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE
        LEFT JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA
        WHERE (@STATUS = 100 OR IM_STATUS = @STATUS) 
        AND (
            (@FILTRONOME = '*') OR 
            (REV_RAZAOSOCIAL LIKE '%' + @FILTRONOME + '%') OR 
            (CAD_RAZAOSOCIAL LIKE '%' + @FILTRONOME + '%') OR
            (CAD_FANTASIA LIKE '%' + @FILTRONOME + '%') OR
            (dbo.fn_trim_cnpj(CAD_CPF) LIKE '%' + RTRIM(dbo.fn_trim_cnpj(@FILTRONOME)) + '%') OR
            (dbo.fn_trim_cnpj(CAD_CNPJ) LIKE '%' + RTRIM(dbo.fn_trim_cnpj(@FILTRONOME)) + '%') OR
            (CAD_EMAIL LIKE '%' + @FILTRONOME + '%') OR
            (CAD_EMAIL2 LIKE '%' + @FILTRONOME + '%')
        ) 
        AND (@INICIADAS = 3 OR
            (@INICIADAS = 1 AND IM_INICIO_IMPLANTACAO IS NOT NULL AND @andam = 101) OR 
            (@INICIADAS = 0 AND IM_INICIO_IMPLANTACAO IS NULL AND @andam = 101) OR 
            (@INICIADAS = 1 AND IM_INICIO_IMPLANTACAO IS NOT NULL AND IM_ANDAMENTO = 5 AND @andam = 5 AND IM_ANDAMENTO_TIPO = @tip) OR
            (@INICIADAS = 2 AND IM_ANDAMENTO = @andam AND (@tip = IM_ANDAMENTO_TIPO OR @tip = 0))
            )
        AND (@assef = 2 OR IM_ASSEFIN = @assef)
         ORDER BY IM_STATUS, IM_INICIO DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="STATUS" DefaultValue="100" QueryStringField="status" />
            <asp:QueryStringParameter Name="FILTRONOME" DefaultValue="*" QueryStringField="filtronome" />
            <asp:QueryStringParameter Name="INICIADAS" DefaultValue="3" QueryStringField="iniciadas" />
            <asp:QueryStringParameter Name="andam" QueryStringField="andam" DefaultValue="101" />
            <asp:QueryStringParameter Name="assef" QueryStringField="assef" DefaultValue="2" />
            <asp:QueryStringParameter Name="tip" QueryStringField="tip" DefaultValue="0" />            
        </SelectParameters>
    </asp:SqlDataSource>
</asp:content>
