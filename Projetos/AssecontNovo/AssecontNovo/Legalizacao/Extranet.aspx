<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Extranet.aspx.cs" Inherits="AssecontNovo.Legalizacao.Extranet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <style>
        .topo
        {
            padding-top: 40px;
        }

            .topo td
            {
                vertical-align: top;
            }

        .botoes a, botoes
        {
            width: 120px;
            color: gray;
            text-align: center;
            float: left;
        }

            .botoes:hover, .botoes a:hover
            {
                opacity: 0.6;
                text-decoration: none;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <div class="AjaxLoadCenter">
                <asp:Image ID="ImgAjaxLoad" runat="server" ImageUrl="~/Imagens/Site/ajaxLoader.gif" /><br />
                <br />
                <asp:Label ID="lbAjaxLoad" runat="server" Font-Size="20pt">                
                    processando...
                </asp:Label>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table style="margin-top: 10px;">
        <tr>
            <td>
                <asp:FormView ID="FormViewCadastro" runat="server" DefaultMode="Edit" DataSourceID="SDS_Cadastro" DataKeyNames="LEGCLI_IND">
                    <EditItemTemplate>
                        <table class="topo" style="border-collapse: collapse; border-spacing: 0px;">
                            <tr>
                                <td colspan="2" style="padding-bottom: 30px;">
                                    <span style="font-size: 20pt; text-shadow: 0 0 0;">
                                        <asp:Label ID="lbPedido" runat="server" Text='<%# "Pedido de " + Wr.Classes.Utils.GetDescription((AssecontNovo.Classes.Types.LegalizacaoServicoTipo)Convert.ToInt32(Eval("LEGPED_SERVICO"))) %>' /></span>
                                    <br />
                                    <span style="font-size: 16pt; color: gray; text-shadow: 0 0 0;">
                                        <asp:Label ID="lbProtocolo" runat="server" Text='<%# "Protocolo: " + Request.QueryString["ind"] %>' /></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 200px; width: 700px;">
                                    <table style="width: 100%; border-bottom: 1px solid #C5C5C5; height: 100%; border-spacing: 0px">
                                        <tr>
                                            <td style="background: #336CAB; height: 75%; padding: 10px;">
                                                <span style="font-size: 14pt; color: white;"><%# Eval("ULTIMO_STATUS") %></span>
                                                <br />
                                                <span style="color: white;">Entrada do pedido em <%# Eval("LEGPED_DATA_ENTRADA", "{0:dd/MM/yyyy HH:mm}") %> </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 10px; border-right: 1px solid #C5C5C5; border-left: 1px solid #C5C5C5;">
                                                <span>Prazo para terminar o processo de <%# Wr.Classes.Utils.GetDescription((AssecontNovo.Classes.Types.LegalizacaoServicoTipo)Convert.ToInt32(Eval("LEGPED_SERVICO"))) %>
                                                    de 30 dias</span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table style="float: right; padding: 0px 10px 10px 10px; width: 300px; height: 200px; border: 1px solid #C5C5C5;">
                                        <tr>
                                            <td class="text">
                                                <asp:Label ID="lbBoletoSacado" runat="server" Font-Size="14pt" ForeColor="Orange" Text='<%# "Empresa " + Wr.Classes.Strings.capitalizeWords(Eval("LEGCLI_RAZAOSOCIAL").ToString()) %>'></asp:Label>
                                                <br />
                                                <br />
                                                <asp:Label ID="Label1" Font-Bold="true" runat="server" Text='<%# Eval("LEGCLI_CONTATO") %>'></asp:Label><br />
                                                <asp:Label ID="lbTelefone_ddd" runat="server" Text='<%# Eval("LEGCLI_TELEFONE_DDD") %>'></asp:Label>
                                                <asp:Label ID="lbTelefone" runat="server" Text='<%# Eval("LEGCLI_TELEFONE") %>'></asp:Label>
                                                <br />
                                                <asp:Label ID="lbCelular_ddd" runat="server" Text='<%# Eval("LEGCLI_CELULAR_DDD") %>'></asp:Label>
                                                <asp:Label ID="lbCelular" runat="server" Text='<%# Eval("LEGCLI_CELULAR") %>'></asp:Label>
                                                <br />
                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("LEGCLI_EMAIL") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <%--<tr>
                                            <td colspan="2" class="center">-----
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div style='<%# !string.IsNullOrEmpty(Eval("LEGCLI_ENDERECO").ToString()) ? "display: none": "" %>'>
                                                    Nenhum Endereço Cadastrado.
                                                </div>
                                                <div style='<%# string.IsNullOrEmpty(Eval("LEGCLI_ENDERECO").ToString()) ? "display: none": "" %>'>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("LEGCLI_ENDERECO") %>'></asp:Label>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("LEGCLI_ENDERECO_NUMERO") %>'></asp:Label>
                                                    <br />
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("LEGCLI_ENDERECO_COMPLEMENTO") %>'></asp:Label>
                                                    <br />
                                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("LEGCLI_BAIRRO") %>'></asp:Label>
                                                    <br />
                                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("LEGCLI_CIDADE") %>'></asp:Label>
                                                    -
                                                    <asp:Label ID="Label8" runat="server" Text='<%# Eval("LEGCLI_UF") %>'></asp:Label>
                                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("LEGCLI_CEP") %>'></asp:Label>
                                                </div>
                                            </td>
                                        </tr>--%>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table class="topo">
                            <tr>
                                <td style="padding: 0px;">
                                    <asp:Label ID="lbServico" runat="server" Visible="false" Text='<%# Eval("LEGPED_SERVICO") %>'></asp:Label>

                                    <asp:Label ID="lbIndicePedido" runat="server" Visible="false" Text='<%# Eval("LEGPED_IND") %>'></asp:Label>

                                    <asp:SqlDataSource ID="SqlDataItens" runat="server" OnLoad="SqlData_Load"
                                        SelectCommand="SELECT *, @SERVICO AS SERVICO FROM LegalizacaoEtapas
                                            LEFT JOIN LegalizacaoPedidosEtapas ON LPETA_ETAPA = LEGETA_IND AND LPETA_PEDIDO = @PEDIDO 
                                            WHERE  LEGETA_VISUALIZA_CLIENTE = 1 ORDER BY LEGETA_ORDEM ">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lbServico" PropertyName="Text" Type="Int32" Name="SERVICO" />
                                            <asp:ControlParameter ControlID="lbIndicePedido" PropertyName="Text" Type="Int32" Name="PEDIDO" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                    <asp:DataList ID="DataListItens" runat="server" CellPadding="0" CellSpacing="0" RepeatDirection="Horizontal" DataSourceID="SqlDataItens" DataKeyField="LEGETA_IND" ItemStyle-BorderWidth="0">
                                        <ItemTemplate>
                                            <div class="botoes">
                                                <asp:LinkButton ID="lbProduto" runat="server">
                                                    <div style='<%# "position: absolute; margin-top: 20px; z-index: 0; position: absolute; border-bottom: 3px solid; border-color: " + System.Drawing.ColorTranslator.ToHtml(AssecontNovo.Classes.UtilLegalizacao.getColorEtapaStatus(Eval("LPETA_STATUS"))) + ";" + ((Convert.ToBoolean(Eval("LEGETA_RISCO_LEFT"))) ? (Convert.ToBoolean(Eval("LEGETA_RISCO_RIGHT"))) ?  "width: 120px;": "width: 60px;" : "margin-left: 60px; width: 60px;") %>'>
                                                    </div>
                                                    <asp:Image ID="imgIcon" runat="server" CssClass="imgEtapas" BackColor='<%# AssecontNovo.Classes.UtilLegalizacao.getColorEtapaStatus(Eval("LPETA_STATUS")) %>' ImageUrl='<%#  "~/Imagens/24x24/" + Eval("LEGETA_IMAGEM") %>' />
                                                    <br />
                                                    <asp:Label ID="lbIndicePedido" runat="server" ForeColor='<%# AssecontNovo.Classes.UtilLegalizacao.getColorEtapaStatus(Eval("LPETA_STATUS")) %>'
                                                        Text='<%# string.Format(Eval("LEGETA_NOME").ToString(),  Wr.Classes.Utils.GetDescription((AssecontNovo.Classes.Types.LegalizacaoServicoTipo)Convert.ToInt32(Eval("SERVICO")))) + 
                                                     (string.IsNullOrEmpty(Eval("LPETA_CONCLUIDO_EM").ToString()) ? "" : " - Concluido em " + Eval("LPETA_CONCLUIDO_EM", "{0:dd/MM/yyyy}")) %>'></asp:Label>
                                                </asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </td>
                            </tr>
                        </table>
                    </EditItemTemplate>
                </asp:FormView>

                <asp:SqlDataSource ID="SDS_Cadastro" runat="server" OnLoad="SqlData_Load"
                    SelectCommand="SELECT *, (SELECT TOP 1 LEGETA_NOME FROM LegalizacaoPedidosEtapas INNER JOIN 
                        LegalizacaoEtapas ON LEGETA_IND = LPETA_ETAPA
                        WHERE LPETA_PEDIDO = LEGPED_IND AND LEGETA_VISUALIZA_CLIENTE = 1 AND LPETA_STATUS &lt; 2  ORDER BY LEGETA_ORDEM ASC) AS ULTIMO_STATUS
                        FROM legalizacaoPedidos INNER JOIN LegalizacaoClientes ON LEGPED_CADASTRO = LEGCLI_IND
                        WHERE LEGPED_PROTOCOLO = @LEGPED_PROTOCOLO">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="LEGPED_PROTOCOLO" QueryStringField="ind" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>

</asp:Content>
