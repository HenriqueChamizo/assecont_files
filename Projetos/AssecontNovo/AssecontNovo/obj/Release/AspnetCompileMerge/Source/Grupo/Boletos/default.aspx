<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Assecont2.App.Boletos._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="../../Jquery/ControlVisible/Visible.js"></script>

    <script type="text/javascript">
        function OpenAtualizaEmail(id) {
            var oWnd1 = $find("<%= RadWindowAtulizaEmail.ClientID %>");
            oWnd1.set_initialBehaviors(Telerik.Web.UI.WindowBehaviors.Pin);
            oWnd1.set_animation(Telerik.Web.UI.WindowAnimation.Fade);
            oWnd1.setUrl("AtualizaEmail.aspx?cnpj=" + id);
            oWnd1.show();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataBoletos" DataKeyNames="BOLETO_ID">
        <ItemTemplate>
            <div style="font-size: 16pt;">
                Boa tarde,
                <asp:Label ID="lbBoletoSacado" runat="server" Text='<%# Eval("BOLETO_SACADO") %>'></asp:Label>
            </div>
            <br />
            Para imprimir o boleto, clique no link "Em aberto".<br />
            <br />
            Última atualização no sistema: 
            <asp:Label ID="lbDataprocessa" runat="server" Text='<%# Eval("ultimaData", "{0:dd/MM/yyyy}") %>'></asp:Label>
            <br />
            Pagamentos efetuados após esta data e hora irão constar como abertos. Neste caso, aguarde a próxima atualização.<br />
            <br />
            Endereços cadastrados para envio do email:
            <br />
            <asp:Label ID="lbEmail" runat="server" Font-Bold="true" Text='<%# Eval("BOLETO_EMAIL") %>'></asp:Label>
            <asp:Label ID="lbEmail2" runat="server" Font-Bold="true" Visible='<%# Eval("BOLETO_EMAIL2") is DBNull ? false : true %>' Text='<%# ", " + Eval("BOLETO_EMAIL2") %>'></asp:Label>
            <asp:Label ID="lbEmail3" runat="server" Font-Bold="true" Visible='<%# Eval("BOLETO_EMAIL3") is DBNull ? false : true %>' Text='<%# ", " + Eval("BOLETO_EMAIL3") %>'></asp:Label>
            <br />
            <br />
            Certifique-se que os e-mails acima estejam corretos para que seus boletos sejam sempre recebidos. 
            <br />
            <br />
            <a id="lkAtualizaEmail" runat="server" class="sitebutton blue" onclick='<%# "OpenAtualizaEmail(" + Request.QueryString["cnpj"] + ")"%>'>Atualizar Emails
                <asp:Image ID="imgAtualiza" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" /></a>
            <br />
            <br />
        </ItemTemplate>
    </asp:FormView>

    <telerik:RadWindowManager ID="RWM_AtulizaEmail" runat="server" EnableShadow="true" ReloadOnShow="True" AutoSizeBehaviors="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindowAtulizaEmail" runat="server" EnableEmbeddedSkins="false" Skin="flv" Title="Atualização de E-mails" 
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="400" Width="480" Behaviors="Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <telerik:RadGrid ID="RadGridBoletos" runat="server" AllowPaging="True" DataSourceID="SqlDataBoletos"
        CellSpacing="0" GridLines="None" PageSize="12" EditItemStyle-HorizontalAlign="Justify"
        EnableEmbeddedSkins="false" Skin="flv" OnItemDataBound="RadGridBoletos_ItemDataBound">

        <MasterTableView DataSourceID="SqlDataBoletos" AllowPaging="true" AutoGenerateColumns="false"
            DataKeyNames="BOLETO_ID" ItemStyle-Height="40px" AlternatingItemStyle-Height="40px"
            AlternatingItemStyle-BackColor="#F7F7F7">

            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
            </RowIndicatorColumn>
            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
            </ExpandCollapseColumn>
            <Columns>

                <telerik:GridTemplateColumn DataField="BOLETO_NN"
                    HeaderText="Boleto" SortExpression="BOLETO_NN" UniqueName="BOLETO_NN">
                    <ItemTemplate>
                        <asp:Label ID="lbBoletoNN" runat="server" Text='<%# Eval("BOLETO_NN") %>'></asp:Label>
                        <asp:Image ID="imgRegistrado" runat="server" ImageUrl="~/Imagens/16x16/Registrado16x16.png" Visible='<%# Eval("BOLETO_REGISTRO_DATA") is DBNull ? false : true %>' />
                    </ItemTemplate>
                    <HeaderStyle Width="30px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="BOLETO_NOTAFISCAL_LINK"
                    HeaderText="Nota" SortExpression="BOLETO_NOTAFISCAL_LINK" UniqueName="BOLETO_NOTAFISCAL_LINK">
                    <ItemTemplate>
                        <asp:Label ID="lbRisco" Visible='<%# Eval("BOLETO_NOTAFISCAL_LINK") is DBNull ? true : false %>'  runat="server" Text=" - "></asp:Label>
                        <asp:HyperLink ID="HyNotaFiscal" Class="sitebutton blue" Visible='<%# Eval("BOLETO_NOTAFISCAL_LINK") is DBNull ? false : true %>' runat="server" NavigateUrl='<%# Eval("BOLETO_NOTAFISCAL_LINK") %>'>
                            Nota Fiscal
                            <asp:Image ID="imgNotaFiscal" runat="server" ImageUrl="~/Imagens/24x24/Payment24x24.png" />
                        </asp:HyperLink>
                    </ItemTemplate>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="BOLETO_VENCIMENTO"
                    HeaderText="Vencimento" SortExpression="BOLETO_VENCIMENTO" UniqueName="BOLETO_VENCIMENTO">
                    <ItemTemplate>
                        <asp:Label ID="lbVencimento" runat="server" Text='<%# Eval("BOLETO_VENCIMENTO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="60px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="BOLETO_VALOR"
                    HeaderText="Valor Original" SortExpression="BOLETO_VALOR" UniqueName="BOLETO_VALOR">
                    <ItemTemplate>
                        <asp:Label ID="lbOriginal" runat="server" Text='<%# "R$ " + Eval("BOLETO_VALOR", "{0:n2}") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="65px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="BOLETO_DT_PROCESSA"
                    HeaderText="Envio do aviso" SortExpression="BOLETO_DT_PROCESSA" UniqueName="BOLETO_DT_PROCESSA">
                    <ItemTemplate>
                        <asp:Label ID="lbEnvioAviso" runat="server" Font-Size="9pt" Text='<%# Eval("BOLETO_DT_PROCESSA") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="100px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="BOLETO_DATA_VISUALIZACAO"
                    HeaderText="Visualizado em" SortExpression="BOLETO_DATA_VISUALIZACAO" UniqueName="BOLETO_DATA_VISUALIZACAO">
                    <ItemTemplate>
                        <asp:Label ID="lbVisualizado" runat="server" Font-Size="9pt" Text='<%# Eval("BOLETO_DATA_VISUALIZACAO") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="100px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="BOLETO_PAGO_SN"
                    HeaderText="" SortExpression="BOLETO_PAGO_SN" UniqueName="BOLETO_PAGO_SN">
                    <ItemTemplate>
                        <asp:Label ID="lbDescricao" runat="server" Visible='<%# Convert.ToBoolean(Eval("BOLETO_PAGO_SN")) ? true :  false %>'>PAGO
                            <asp:Image ID="imgCheck" runat="server" ImageUrl="~/Imagens/24x24/check24x24.png" /></asp:Label>

                        <asp:LinkButton ID="lbBoletoPago" runat="server" CssClass="sitebutton blue" OnClick="lbBoletoPago_Click" Visible='<%# !Convert.ToBoolean(Eval("BOLETO_PAGO_SN")) && Convert.ToBoolean(Eval("PRAZO")) %>'>
                            Gerar Boleto
                            <asp:Image ID="imgGerar1" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" />
                        </asp:LinkButton>

                        <asp:LinkButton ID="lkGerarBoleto2" runat="server" CssClass="sitebutton red" Visible='<%# !Convert.ToBoolean(Eval("BOLETO_PAGO_SN")) && !Convert.ToBoolean(Eval("PRAZO")) %>'>
                            Em aberto
                            <asp:Image ID="imgAberto" runat="server" ImageUrl="~/Imagens/24x24/Warning24x24.png" />
                        </asp:LinkButton>
                        <asp:Panel ID="PanelVencimento" runat="server" CssClass="sitepadroesinvisible">
                            <table style="background-color: bisque">
                                <tr>
                                    <td>Data do pagamento >
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="RadComboBoxVencimentos" Height="200" Skin="flv" EnableEmbeddedSkins="false" runat="server" Width="120px"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:HiddenField ID="hidden_ind" runat="server" Value='<%# Eval("BOLETO_ID") %>' />
                                        <asp:LinkButton ID="lkBoletos" runat="server" CssClass="sitebutton blue" OnClick="lkBoletos_Click">
                                            Gerar Boleto
                                            <asp:Image ID="imgGerar2" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" />
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </ItemTemplate>
                    <HeaderStyle Width="300px" />
                </telerik:GridTemplateColumn>
            </Columns>
            <NoRecordsTemplate>
                <div>
                    <table style="margin-top: 50px; width: 450px;">
                        <tr>
                            <td>
                                <img src="http://www.assecont.com.br/assecont/Imagens/Site/Error.png" width="80" />

                            </td>
                            <td style="font-size: 14pt">
                                <div class="titleSubs font_red">
                                    <b>Cnpj ou Cpf Inválido.</b>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 20px;" colspan="2">
                                <i>Voltar a página inicial: <a href="http://www.assecont.com.br/assecont">Clique aqui</a></i>
                            </td>
                        </tr>
                    </table>
                </div>
            </NoRecordsTemplate>
        </MasterTableView>

    </telerik:RadGrid>
    <asp:SqlDataSource ID="SqlDataBoletos" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionStringAntigo %>"
        SelectCommand="SELECT *,  (CASE WHEN CONVERT(DATE, BOLETO_VENCIMENTO) &gt;= CONVERT(DATE, GETDATE()) THEN 1 ELSE 0 END) AS PRAZO,
                    (SELECT CFG_ULTIMA_BAIXA_BOLETOS FROM dbConfiguracao) as 'ultimaData' FROM dbBoletos Where dbo.fn_trim_cnpj(RTRIM(BOLETO_CNPJ_CPF)) = dbo.fn_trim_cnpj(RTRIM(@CNPJ))
                    ORDER BY BOLETO_VENCIMENTO DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="CNPJ" Type="String" QueryStringField="cnpj" />
            <asp:QueryStringParameter Name="ANO" Type="Int32" QueryStringField="ano" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
