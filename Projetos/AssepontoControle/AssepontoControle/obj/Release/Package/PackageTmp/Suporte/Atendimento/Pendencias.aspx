<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="Pendencias.aspx.cs" Inherits="Asseponto.Suporte.Atendimento.Pendencias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <div style="clear: both; padding: 10px 0px 3px 7px">
            <strong>Suporte</strong>
        </div>
        <div style="clear: both">
            <telerik:RadMenu ID="RadMenu3" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="False">
            </telerik:RadMenu>
        </div>
        <div style="clear: both; padding: 10px 0px 3px 7px">
            <strong>Implantações</strong>
        </div>
        <div style="clear: both">
            <telerik:RadMenu ID="RadMenuImplantacoes" runat="server" Flow="Vertical" Skin="Wr"
                EnableEmbeddedSkins="False">
            </telerik:RadMenu>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <wr:TextSearch ID="TextSearch1" runat="server" QueryStringField="filtro" ShowDateFilter="true" />
            <telerik:RadListView ID="RadListView1" runat="server" DataKeyNames="PEN_IND" DataSourceID="SqlPendencias"
                AllowPaging="True" ItemPlaceholderID="PendenciasHolder" PageSize="30">
                <LayoutTemplate>
                    <fieldset id="RadListView1" style="border-style: none;">
                        <asp:Panel ID="PendenciasHolder" runat="server" />
                        <telerik:RadDataPager ID="RadDataPager1" runat="server" PagedControlID="RadListView1"
                            PageSize="20" Skin="Wr" EnableEmbeddedSkins="false" Visible='<%# Container.PageCount != 1%>'>
                            <Fields>
                                <telerik:RadDataPagerButtonField FieldType="FirstPrev" />
                                <telerik:RadDataPagerButtonField FieldType="Numeric" />
                                <telerik:RadDataPagerButtonField FieldType="NextLast" />
                                <telerik:RadDataPagerPageSizeField PageSizeComboWidth="60" PageSizeText="Page size: " />
                                <telerik:RadDataPagerTemplatePageField>
                                    <PagerTemplate>
                                        <div style="float: right">
                                            Registros
                                            <asp:Label runat="server" ID="CurrentPageLabel" Text="<%# Container.Owner.StartRowIndex+1%>" />
                                            até
                                            <asp:Label runat="server" ID="TotalPagesLabel" Text="<%# Container.Owner.TotalRowCount > (Container.Owner.StartRowIndex+Container.Owner.PageSize) ? Container.Owner.StartRowIndex+Container.Owner.PageSize : Container.Owner.TotalRowCount %>" />
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
                                    <strong>
                                        <asp:Label CssClass="sitelistviewfields" ID="label5" runat="server" Text='<%# Eval("CAD_RAZAOSOCIAL") %>'
                                            ForeColor="#003366" /></strong>
                                    <asp:HyperLink ID="HyperLink1" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("PEN_IND", "~/Suporte/atendimento/pendencia.aspx?ind={0}") %>'><%# Eval("PEN_PROBLEMA")%></asp:HyperLink><br />
                                    <asp:Label CssClass="sitelistviewfields" ID="label1" runat="server" Text='<%# Eval("PEN_DATAHORA", "{0: dd/MM/yyyy HH:mm}")  %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label2" runat="server" Text='<%# string.IsNullOrEmpty(Eval("SUP_NOME").ToString()) ? "Desconhecido" : Eval("SUP_NOME")  %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label6" runat="server" Text='<%# string.IsNullOrEmpty(Eval("PEN_PROTOCOLO").ToString()) ? "" : "Protocolo: " + Eval("PEN_PROTOCOLO") %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label3" runat="server" Visible='<%# Eval("PEN_DATAHORASOLUCAO") is DBNull ? false : true %>'
                                        Text='<%# Eval("PEN_DATAHORASOLUCAO") is DBNull ? "" : "Solucionado em: " + Eval("PEN_DATAHORASOLUCAO", "{0:dd/MM/yyyy HH:mm}") + (Eval("SUP_NOME_SOLUCAO").ToString().Trim() == "" ? "" : " por " + Eval("SUP_NOME_SOLUCAO")) %>' />
                                    <asp:Label CssClass="sitelistviewfields" ID="label4" runat="server" Text='<%# string.IsNullOrEmpty(Eval("PEN_TIPO").ToString()) ? "" : Eval("PEN_TIPO")  %>'
                                        Visible='<%# string.IsNullOrEmpty(Eval("PEN_TIPO").ToString()) ? false : true%>' ForeColor="Red" />
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
        SelectCommand="EXEC asseponto_rs_pendencias @P_SITUACAO = @SITUACAO, @P_SUPORTE = @SUPORTE, @P_FILTRO = @FILTRO, @P_TIPO = @TIPO, @P_DATAINICIAL = @DATAINICIAL, @P_DATAFINAL = @DATAFINAL">
        <SelectParameters>
            <asp:QueryStringParameter Name="SITUACAO" DefaultValue="0" QueryStringField="situacao" />
            <asp:QueryStringParameter Name="SUPORTE" DefaultValue="0" QueryStringField="suporte" />
            <asp:QueryStringParameter Name="FILTRO" DefaultValue="*" QueryStringField="filtro" />
            <asp:QueryStringParameter Name="TIPO" DefaultValue="100" QueryStringField="tipo" />
            <asp:QueryStringParameter Name="DATAINICIAL" QueryStringField="datainicial"
                Type="DateTime" />
            <asp:QueryStringParameter Name="DATAFINAL" QueryStringField="datafinal"
                Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
