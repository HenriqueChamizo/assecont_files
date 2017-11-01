<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="RelatorioClientesExpirados.aspx.cs" Inherits="Asseponto.Suporte.Relatorios.RelatorioClientesExpirados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%" OnItemClick="RadMenu1_ItemClick" OnPreRender="RadMenu1_PreRender">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Janeiro" Value="1" />
                <telerik:RadMenuItem runat="server" Text="Fevereiro" Value="2" />
                <telerik:RadMenuItem runat="server" Text="Março" Value="3" />
                <telerik:RadMenuItem runat="server" Text="Abril" Value="4" />
                <telerik:RadMenuItem runat="server" Text="Maio" Value="5" />
                <telerik:RadMenuItem runat="server" Text="Junho" Value="6" />
                <telerik:RadMenuItem runat="server" Text="Julho" Value="7" />
                <telerik:RadMenuItem runat="server" Text="Agosto" Value="8" />
                <telerik:RadMenuItem runat="server" Text="Setembro" Value="9" />
                <telerik:RadMenuItem runat="server" Text="Outubro" Value="10" />
                <telerik:RadMenuItem runat="server" Text="Novembro" Value="11" />
                <telerik:RadMenuItem runat="server" Text="Dezembro" Value="12" />
                <telerik:RadMenuItem runat="server" Value="ano" Text="" />
                <telerik:RadMenuItem runat="server" Value="anoAnterior" Text="" />
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">

            <telerik:RadFormDecorator ID="QsfFromDecorator" runat="server" DecoratedControls="All" EnableRoundedCorners="false" />
            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="RadGrid1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManager>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

            <table style="width: 100%">
                <tr>
                    <td>
                        <asp:FormView ID="FormViewpedidos" runat="server" DataSourceID="SqlDatapedido" DefaultMode="Edit">
                            <EditItemTemplate>
                                <table style="width: 100%; font-size: 16pt;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label1" runat="server" ForeColor="#EF461D" Style="font-weight: 600" Text='<%# Asseponto.Classes.Utils.getMesAnoFormat(Convert.ToInt32(Request.QueryString["ind"]), Convert.ToInt32(Request.QueryString["ano"]))  %>'></asp:Label>
                                            <br />
                                            <asp:Label ID="lbPeds" runat="server" Text='<%# "Total de empresas (" + Eval("QtdPedido") + ")" %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </EditItemTemplate>
                        </asp:FormView>
                    </td>
                    <td style="text-align: right;">
                        <asp:LinkButton ID="btnHabilitarComunicado" runat="server" CssClass="sitebutton" BackColor="GrayText" OnClick="btnHabilitarComunicado_Click"></asp:LinkButton><br /><br />
                        <input type="button" value="Imprimir Relatório" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebutton" />
                    </td>
                </tr>
            </table>
            <br />
            <div id="DivImpressao">
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="false" DataSourceID="SqlDataClientesExpirados"
                    CellSpacing="0" GridLines="None" EditItemStyle-HorizontalAlign="Justify"
                    GroupingSettings-CaseSensitive="false" AllowSorting="true" SortingSettings-EnableSkinSortStyles="false"
                    EnableEmbeddedSkins="false" Skin="flv" PagerStyle-ShowPagerText="true"
                    PagerTextFormat="{4} {5}">

                    <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Clientes"></PagerStyle>

                    <MasterTableView DataSourceID="SqlDataClientesExpirados" AutoGenerateColumns="false"
                        ItemStyle-Height="55px" AlternatingItemStyle-Height="55px" DataKeyNames="CAD_IND"
                        AlternatingItemStyle-BackColor="#F7F7F7">

                        <NoRecordsTemplate>Nenhum registro encontrado.</NoRecordsTemplate>

                        <Columns>
                            <telerik:GridTemplateColumn DataField="CAD_RAZAOSOCIAL"
                                HeaderText="Empresa" SortExpression="CAD_RAZAOSOCIAL" UniqueName="CAD_RAZAOSOCIAL">
                                <ItemTemplate>
                                    <asp:HyperLink ID="lbRazaoSocial" runat="server" Target="_blank" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/Atendimento/Cliente.aspx?ind={0}") %>' Text='<%# Eval("CAD_RAZAOSOCIAL")%>'> </asp:HyperLink></b>
                                    <br />
                                    <asp:Label ID="lbRevenda" runat="server" Text='<%# Eval("REV_RAZAOSOCIAL") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="lbliberadoEm" runat="server" Text='<%# "Liberado em: " + Eval("NSE_DATA", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                        <br />
                                    <asp:Label ID="lbComunicado" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("CAD_DTA_COMUNICADO").ToString()) %>' Text='<%# "Enviado " + Eval("CAD_DTA_COMUNICADO", "{0:dd/MM/yyyy}") %>'></asp:Label>
  
                                </ItemTemplate>
                                <HeaderStyle Width="500px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="CAD_TELEFONE1_DDD"
                                HeaderText="Contatos" SortExpression="CAD_TELEFONE1_DDD" UniqueName="CAD_TELEFONE1_DDD">
                                <ItemTemplate>
                                    <asp:Label ID="lbEmail" runat="server" Text='<%# Eval("CAD_EMAIL") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="lbEmail2" runat="server"  Text='<%# Eval("CAD_EMAIL2") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="lbDDD" runat="server" Text='<%# Eval("CAD_TELEFONE1_DDD") %>'></asp:Label>
                                    <asp:Label ID="lbTelefone" runat="server" Text='<%# Eval("CAD_TELEFONE1") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("CAD_TELEFONE2_DDD") %>'></asp:Label>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("CAD_TELEFONE2") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="200px" />
                                <ItemStyle VerticalAlign="Top" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="DIAS"
                                HeaderText="Dias" SortExpression="DIAS" UniqueName="DIAS">
                                <ItemTemplate>
                                    <asp:Label ID="lbDIAS" runat="server" Font-Size="14pt" ForeColor='<%# Convert.ToInt32(Eval("DIAS")) <= 60 ? System.Drawing.Color.Black : System.Drawing.Color.Red  %>' Text='<%# Eval("DIAS") %>'></asp:Label>
                                 </ItemTemplate>
                                <HeaderStyle Width="100px" />
                                <ItemStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataClientesExpirados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT CAD_IND, CAD_RAZAOSOCIAL, CAD_DTA_COMUNICADO, CAD_EMAIL, REV_RAZAOSOCIAL, CAD_EMAIL2, NSE_DATA, 
	                          DATEDIFF(DAY, NSE_DATA, GETDATE()) AS DIAS, CAD_TELEFONE1, CAD_TELEFONE2, CAD_TELEFONE1_DDD, CAD_TELEFONE2_DDD
                      FROM AssepontoClientes
                      CROSS APPLY(SELECT TOP 1 NSE_DATA
			                      FROM AssepontoNSeries 
			                      WHERE NSE_CLIENTE = CAD_IND AND 
					                    NSE_SOLICITACAO = 1 
			                      ORDER BY NSE_DATA) a
                      LEFT JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA
                      WHERE dbo.fn_asseponto_cliente_tem_manutencao_ativa(CAD_IND) = 0 AND 
	                        CAD_RAZAOSOCIAL NOT LIKE '%excluir%' AND CAD_TESTE = 0 AND 
	                        (MONTH(NSE_DATA)= @ind AND YEAR(NSE_DATA) = @ano) AND
	                        DATEDIFF(DAY, NSE_DATA, GETDATE()) &gt; 60 AND
	                        (REV_COBRAR_CLIENTES IS NOT NULL AND REV_COBRAR_CLIENTES &lt;&gt; 0)
                      ORDER BY NSE_DATA">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" Type="Int32" QueryStringField="ind" />
            <asp:QueryStringParameter Name="ano" Type="Int32" QueryStringField="ano" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDatapedido" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT COUNT(*) AS QtdPedido 
                        FROM AssepontoClientes
                        CROSS APPLY( SELECT TOP 1 * 
			                         FROM AssepontoNSeries 
			                         WHERE NSE_CLIENTE = CAD_IND AND 
				                           NSE_SOLICITACAO = 1 
			                         ORDER BY NSE_DATA ) a
                        INNER JOIN AssepontoRevendas on REV_IND = CAD_REVENDA
                        WHERE dbo.fn_asseponto_cliente_tem_manutencao_ativa(CAD_IND) = 0 AND 
	                          CAD_RAZAOSOCIAL NOT LIKE '%excluir%' AND CAD_TESTE = 0 AND 
	                          MONTH(NSE_DATA) = @ind AND YEAR(NSE_DATA) = @ano AND
	                          DATEDIFF(DAY, NSE_DATA, GETDATE()) &gt; 60 AND
	                          (REV_COBRAR_CLIENTES IS NOT NULL AND REV_COBRAR_CLIENTES &lt;&gt; 0)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" Type="Int32" QueryStringField="ind" />
            <asp:QueryStringParameter Name="ano" Type="Int32" QueryStringField="ano" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

