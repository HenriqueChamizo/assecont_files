<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Legalizacao.Master" AutoEventWireup="true" CodeBehind="IntranetPedido.aspx.cs" Inherits="AssecontNovo.Legalizacao.IntranetPedido" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <style>
        .itens
        {
            font-size: 12pt;
            text-transform: uppercase;
        }

            .itens img
            {
                _padding-bottom: 10px;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
   <table style="margin-top: 10px; width: 100%;">
        <tr>
            <td>
                <asp:FormView ID="FormViewCadastro" runat="server" Width="100%" DefaultMode="Edit" DataSourceID="SDS_Cadastro" DataKeyNames="LEGCLI_IND">
                    <EditItemTemplate>
                        <table class="topo" style="width: 100%; border-collapse: collapse; border-spacing: 0px;">
                            <tr>
                                <td style="vertical-align: top; width: 700px;">
                                    <span style="font-size: 20pt; text-shadow: 0 0 0;">
                                        <asp:Label ID="lbPedido" runat="server" Text='<%# "Pedido de " + AssecontNovo.Classes.UtilLegalizacao.getNomeServico(Convert.ToInt32(Eval("LEGPED_SERVICO"))) %>' /></span>
                                    <br />
                                    <span style="font-size: 16pt; color: gray; text-shadow: 0 0 0;">
                                        <asp:Label ID="lbProtocolo" runat="server" Text='<%# "Protocolo " + Eval("LEGPED_PROTOCOLO") %>' /></span>
                                    <br />
                                    <asp:Label ID="lbPedidoIniciado" runat="server" Text='<%# "Iniciado em " + Eval("LEGPED_DATA_ENTRADA", "{0:dd/MM/yyyy HH:mm}") %>' />
                                    <br />
                                    <asp:Label ID="lbPedidoEncerrado" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("LEGPED_DATA_ENCERRAMENTO").ToString()) %>' Text='<%# "Encerrado em " + Eval("LEGPED_DATA_ENCERRAMENTO", "dd/MM/yyyy HH:mm") %>' />
                                    <asp:Label ID="lbPedidoEncerradoPor" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("LEGPED_ENCERRADO_POR").ToString()) %>' Text='<%# "por " + Eval("LEGPED_ENCERRADO_POR") %>' />
                                    <br />
                                    <asp:Label ID="Label5" runat="server" Text='<%# "Status do Pedido: " + Wr.Classes.Utils.GetDescription((AssecontNovo.Classes.Types.LegalizacaoPedidosStatus)Convert.ToInt32(Eval("LEGPED_STATUS"))) %>' /></span>
                                </td>
                                <td style="vertical-align: top;">
                                    <table style="padding: 0px 10px 10px 10px; width: 300px; height: 170px; border: 1px solid #C5C5C5;">
                                        <tr>
                                            <td class="text">
                                                <asp:Label ID="lbBoletoSacado" runat="server" Font-Size="14pt" ForeColor="Orange" Text='<%# "Empresa " + Wr.Classes.Strings.capitalizeWords(Eval("LEGCLI_RAZAOSOCIAL").ToString()) %>'></asp:Label>
                                                <br />
                                                <br />
                                                <asp:Label ID="lbContato" Font-Bold="true" runat="server" Text='<%# Eval("LEGCLI_CONTATO") %>'></asp:Label><br />
                                                <asp:Label ID="lbTelefone_ddd" runat="server" Text='<%# Eval("LEGCLI_TELEFONE_DDD") %>'></asp:Label>
                                                <asp:Label ID="lbTelefone" runat="server" Text='<%# Eval("LEGCLI_TELEFONE") %>'></asp:Label>
                                                <br />
                                                <asp:Label ID="lbCelular_ddd" runat="server" Text='<%# Eval("LEGCLI_CELULAR_DDD") %>'></asp:Label>
                                                <asp:Label ID="lbCelular" runat="server" Text='<%# Eval("LEGCLI_CELULAR") %>'></asp:Label>
                                                <br />
                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("LEGCLI_EMAIL") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="vertical-align: top;">
                                    <telerik:RadGrid ID="RadGridBoletos" runat="server" DataSourceID="SDS_Cadastro" DataKeyNames="LEGCLI_IND"
                                        CellSpacing="0" GridLines="None" PagerStyle-AlwaysVisible="false"
                                        EnableEmbeddedSkins="false" Skin="flv" PagerTextFormat="{4} {5}">

                                        <MasterTableView DataSourceID="SDS_Cadastro" AllowPaging="false" AutoGenerateColumns="false"
                                            DataKeyNames="LEGCLI_IND" ItemStyle-Height="50px" AlternatingItemStyle-Height="50px">

                                            <Columns>
                                                <telerik:GridTemplateColumn DataField="LEGETA_NOME" HeaderText="Processo">
                                                    <ItemTemplate>
                                                        <asp:Image ID="imgIcon" runat="server" CssClass="imgEtapas" BackColor='<%# AssecontNovo.Classes.UtilLegalizacao.getColorEtapaStatus(Eval("LPETA_STATUS")) %>' ImageUrl='<%#  "~/Imagens/24x24/" + Eval("LEGETA_IMAGEM") %>' />
                                                        <asp:HyperLink ID="HyperProcesso" runat="server" CssClass="itens" ForeColor='<%# AssecontNovo.Classes.UtilLegalizacao.getColorEtapaStatus(Eval("LPETA_STATUS"))  %>'
                                                            Visible='<%# !string.IsNullOrEmpty(Eval("LPETA_IND").ToString()) %>' NavigateUrl='<%# "~/Legalizacao/IntranetProcesso.aspx?P=" + Eval("LEGPED_IND") + "&S=" + Eval("LPETA_IND") %>' Text='<%# Eval("LEGETA_NOME") %>' />
                                                        <asp:Label ID="lbIndicePedido" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("LPETA_IND").ToString()) %>' Text='<%# Eval("LEGETA_NOME") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <HeaderStyle Width="420" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn DataField="LEGETA_NOME" HeaderText="Concluido Em">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbEmail" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("LPETA_EMAIL_ENVIADO_EM").ToString()) %>'
                                                            Text='<%# Eval("LPETA_CONCLUIDO_EM", "{0:dd/MM/yyyy}") %>' />                                    
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn DataField="LPETA_STATUS" HeaderText="Arquivos">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbArquivos" runat="server" Font-Size="20pt" Visible='<%# Convert.ToInt32(Eval("Arquivos")) > 0 %>' Text='<%# Eval("ARQUIVOS") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>

                                            <NoRecordsTemplate>
                                                <div>
                                                    <table style="margin: 20px;">
                                                        <tr>
                                                            <td>
                                                                <img src="http://www.assecont.com.br/Imagens/Site/Error.png" width="50" />

                                                            </td>
                                                            <td>
                                                                <div class="tituloSecundario font_gray">
                                                                    <b>Nenhum registro encontrado.</b>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </NoRecordsTemplate>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </EditItemTemplate>
                </asp:FormView>
            </td>
        </tr>

    </table>



    <asp:SqlDataSource ID="SDS_Cadastro" runat="server" OnLoad="SqlData_Load"
        SelectCommand="SELECT *,
                    (SELECT TOP 1 COUNT(*) FROM LegalizacaoArquivos WHERE LEGARQ_STATUS = 0 AND LEQARQ_PEDIDO_ETAPA = LPETA_IND) AS ARQUIVOS
                    FROM LegalizacaoEtapas
                    OUTER APPLY
                    (
	                    SELECT * FROM legalizacaoPedidos
	                    INNER JOIN LegalizacaoPedidosEtapas ON LPETA_PEDIDO = LEGPED_IND
	                    INNER JOIN LegalizacaoClientes ON LEGPED_CADASTRO = LEGCLI_IND
	                    WHERE LPETA_ETAPA = LEGETA_IND AND LEGPED_IND = @PEDIDO
                    ) a
                    ORDER BY LEGETA_ORDEM ">
        <SelectParameters>
            <asp:QueryStringParameter Name="PEDIDO" QueryStringField="p" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SDS_ETAPAS" runat="server" OnLoad="SqlData_Load"
        SelectCommand="SELECT LEGETA_IND, LEGETA_NOME FROM LegalizacaoEtapas ORDER BY LEGETA_ORDEM"></asp:SqlDataSource>
</asp:Content>
