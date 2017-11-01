<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Legalizacao.Master" AutoEventWireup="true" CodeBehind="IntranetProcesso.aspx.cs" Inherits="AssecontNovo.Legalizacao.IntranetProcesso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <table style="margin-top: 10px; width: 100%;">
        <tr>
            <td>
                <asp:FormView ID="FormViewCadastro" runat="server" Width="100%" DefaultMode="Edit" DataSourceID="SDS_Cadastro" DataKeyNames="LEGCLI_IND">
                    <EditItemTemplate>
                        <table class="topo" style="vertical-align: top; width: 100%; border-collapse: collapse; border-spacing: 0px;">
                            <tr>
                                <td style="vertical-align: top;">
                                    <span style="font-size: 16pt; color: gray; text-shadow: 0 0 0;">
                                        <asp:Label ID="lbProtocolo" runat="server" Text='<%# "Protocolo " + Eval("LEGPED_PROTOCOLO") %>' /></span>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #C5C5C5;">
                                    <asp:Label ID="lb" runat="server" Font-Size="14pt" ForeColor="Orange" Text='<%# "Empresa " + Wr.Classes.Strings.capitalizeWords(Eval("LEGCLI_RAZAOSOCIAL").ToString()) %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="text">
                                    <asp:Image ID="imgIcon" runat="server" CssClass="imgEtapas" BackColor='<%# AssecontNovo.Classes.UtilLegalizacao.getColorEtapaStatus(Eval("LPETA_STATUS")) %>' ImageUrl='<%#  "~/Imagens/24x24/" + Eval("LEGETA_IMAGEM") %>' />
                                    <asp:Label ID="lbIndicePedido" runat="server" ForeColor='<%# AssecontNovo.Classes.UtilLegalizacao.getColorEtapaStatus(Eval("LPETA_STATUS"))  %>'
                                        Text='<%# Eval("LEGETA_NOME") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style='<%# Convert.ToInt16(Eval("LPETA_STATUS")) != 1 ? "display:none;": "margin-top: 50x;" %>'>
                                    <asp:LinkButton ID="btnConcluido" runat="server" CssClass="sitebutton" BackColor="Green" OnClick="btnConcluido_Click">Finalizar Processo</asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td style='<%# Convert.ToInt16(Eval("LPETA_STATUS")) == 0 ?  "margin-top: 50x;": "display:none;" %>'>
                                    <asp:LinkButton ID="btnIniciarProcesso" runat="server" CssClass="sitebutton LightBlue" OnClick="btnConcluido_Click">Iniciar Processo</asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 20px;">
                                    <asp:Label ID="lbEmail" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("LPETA_EMAIL_ENVIADO_EM").ToString()) %>'>
                                       <img src="../Imagens/16x16/email16x16.png" /> Email enviado em <%# Eval("LPETA_EMAIL_ENVIADO_EM", "{0:dd/MM/yyyy HH:mm}") %>
                                    </asp:Label>
                                    <br />
                                    <asp:Label ID="lbSms" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("LPETA_SMS_ENVIADO_EM").ToString()) %>'>
                                       <img src="../Imagens/16x16/sms16x16.png" /> SMS enviado em <%# Eval("LPETA_SMS_ENVIADO_EM", "{0:dd/MM/yyyy HH:mm}") %>
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style='<%# Convert.ToBoolean(Eval("LEGETA_CONTEM_ARQUIVO")) ? "padding-top: 20px;": "display: none;" %>'>
                                    <p><span style="font-size: 14pt; text-shadow: 0 0 0;">Arquivo</span></p>
                 <%--                   <%# Eval("LEGARQ_NOME") is DBNull? "Nenhum Arquivo Anexado" : "" %>--%>
                                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/Legalizacao/View.aspx?ind=" + Eval("LEGARQ_IND") %>'><%# Eval("LEGARQ_NOME") %></asp:HyperLink>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table style='<%# Convert.ToBoolean(Eval("LEGETA_CONTEM_ARQUIVO")) ? "padding-top: 8px;": "display: none;" %>'>
                                        <tr>
                                            <td class="Upload">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="sitevalidator" ControlToValidate="FUArquivo" ErrorMessage="Nenhum Arquivo Selecionado"></asp:RequiredFieldValidator>
                                                <asp:FileUpload ID="FUArquivo" runat="server" />
                                                <br />
                                                <br />
                                                <asp:LinkButton ID="lkEnviar" runat="server" CssClass="sitebutton blue" OnClick="lkEnviar_Click">Enviar Arquivo
                                                    <img src="../Imagens/24x24/OpenWhite24x24.png" />
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:CustomValidator ID="CustomValidatorArquivo" runat="server" ErrorMessage="Anexo Invalido" CssClass="sitevalidator2" OnServerValidate="CustomValidatorArquivo_ServerValidate" ></asp:CustomValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr>
                                <td style='<%# Convert.ToBoolean(Eval("LEGETA_CONTEM_ARQUIVO")) ? "padding-top: 20px;": "display: none;" %>'>
                                    <br />
                                    <asp:SqlDataSource ID="SqlDataArquivos" runat="server" OnLoad="SqlData_Load"
                                        SelectCommand="SELECT * FROM LegalizacaoArquivos WHERE LEGARQ_STATUS = 1 AND LEQARQ_PEDIDO_ETAPA = @STATUS ORDER BY LEGARQ_ADICIONADO_EM DESC">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="STATUS" QueryStringField="S" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                    <asp:DataList ID="DataListArquivos" runat="server" CellPadding="0" CellSpacing="0" RepeatDirection="Horizontal"
                                        DataSourceID="SqlDataArquivos" DataKeyField="LEGARQ_IND" ItemStyle-BorderWidth="0">
                                        <HeaderTemplate>
                                            Arquivos Rejeitados
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <div style="display: block;">
                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/Legalizacao/View.aspx?ind=" + Eval("LEGARQ_IND") %>'><%# Eval("LEGARQ_NOME") %></asp:HyperLink>
                                            </div>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </td>
                            </tr>
                        </table>
                    </EditItemTemplate>
                </asp:FormView>
            </td>
        </tr>

    </table>



    <asp:SqlDataSource ID="SDS_Cadastro" runat="server" OnLoad="SqlData_Load"
        SelectCommand="SELECT * FROM  LegalizacaoPedidosEtapas  
                INNER JOIN legalizacaoPedidos ON LPETA_PEDIDO = LEGPED_IND
                INNER JOIN LegalizacaoClientes ON LEGPED_CADASTRO = LEGCLI_IND
                INNER JOIN LegalizacaoEtapas ON LEGETA_IND = LPETA_ETAPA
                 OUTER APPLY
                 (
                    SELECT TOP 1 * FROM LegalizacaoArquivos WHERE LEGARQ_STATUS = 0 AND LEQARQ_PEDIDO_ETAPA = LPETA_IND ORDER BY LEGARQ_ADICIONADO_EM DESC
                 ) a
                 WHERE LPETA_IND = @STATUS">
        <SelectParameters>
            <asp:QueryStringParameter Name="STATUS" QueryStringField="S" Type="Int32" />
            <asp:QueryStringParameter Name="PEDIDO" QueryStringField="P" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
