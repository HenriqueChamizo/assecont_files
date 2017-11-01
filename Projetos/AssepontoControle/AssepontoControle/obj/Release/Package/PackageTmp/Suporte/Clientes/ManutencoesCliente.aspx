<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="ManutencoesCliente.aspx.cs" Inherits="Asseponto.Suporte.Clientes.ManutencoesCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%" OnItemClick="RadMenu2_ItemClick" CausesValidation="false">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Lançar Manutenção" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Cancelamento" NavigateUrl="#">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">

            <telerik:RadGrid ID="RadGrid1" runat="server" Skin="Wr" EnableEmbeddedSkins="False" AllowAutomaticUpdates="true"
                DataSourceID="sqlAssepontoManutencao" DataKeyNames="MNT_IND" AutoGenerateColumns="False" CellSpacing="0"
                GridLines="None" Width="820px">

                <MasterTableView DataSourceID="sqlAssepontoManutencao" DataKeyNames="MNT_IND"
                    AllowAutomaticUpdates="true">

                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>

                    <Columns>

                        <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="Editar" EditImageUrl="~/Skins/Grid/Edit.gif">
                            <HeaderStyle Width="50px" />
                        </telerik:GridEditCommandColumn>

                        <telerik:GridBoundColumn DataField="MNT_DATA" DataType="System.DateTime" ReadOnly="True"
                            HeaderText="Data" SortExpression="MNT_DATA" UniqueName="MNT_DATA" DataFormatString="{0:dd/MM/yyyy}">
                            <HeaderStyle Width="100px" />
                            <ItemStyle Width="100px" />
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="VER_NOME_FANTASIA"
                            HeaderText="Versão" ReadOnly="True" SortExpression="VER_NOME_FANTASIA" UniqueName="VER_NOME_FANTASIA">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="MNT_VALOR" DataType="System.Decimal" ReadOnly="True"
                            HeaderText="Valor" SortExpression="MNT_VALOR" UniqueName="MNT_VALOR" DataFormatString="{0:c}">
                            <HeaderStyle Width="100px" />
                            <ItemStyle Width="100px" />
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn DataField="MNT_CONTRATO_ENVIADOEM" ItemStyle-Font-Size="11px"
                            HeaderText="Contrato Envio" SortExpression="MNT_CONTRATO_ENVIADOEM" UniqueName="MNT_CONTRATO_ENVIADOEM">
                            <ItemTemplate>
                                <asp:Label ID="lbContratoE" runat="server" Text='<%# Eval("MNT_CONTRATO_ENVIADOEM", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>

                                <telerik:RadDatePicker ID="RP_ContratoEnviado" runat="server" Culture="pt-BR"
                                    DateInput-ReadOnly='<%# Eval("MNT_CANCELADO").ToString() == "1" ? true : false %>'
                                    DbSelectedDate='<%# Bind("MNT_CONTRATO_ENVIADOEM") %>' Skin="Wr" EnableEmbeddedSkins="false">
                                    <Calendar ID="Calendar1" runat="server" Skin="Wr" EnableEmbeddedSkins="false" UseColumnHeadersAsSelectors="False"
                                        UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                    </Calendar>
                                    <DateInput ID="DateInput1" runat="server" DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="">
                                    </DateInput>
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>

                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="MNT_CONTRATO_RECEBIDOEM" ItemStyle-Font-Size="11px"
                            HeaderText="Contrato Retorno" SortExpression="MNT_CONTRATO_RECEBIDOEM" UniqueName="MNT_CONTRATO_RECEBIDOEM">
                            <ItemTemplate>
                                <asp:Label ID="lbContratoR" runat="server" Text='<%# Eval("MNT_CONTRATO_RECEBIDOEM", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>

                                <telerik:RadDatePicker ID="RP_ContratoReceber" runat="server" Culture="pt-BR"
                                    DateInput-ReadOnly='<%# Eval("MNT_CANCELADO").ToString() == "1" ? true : false %>'
                                    DbSelectedDate='<%# Bind("MNT_CONTRATO_RECEBIDOEM") %>' Skin="Wr" EnableEmbeddedSkins="false">
                                    <Calendar ID="Calendar1" runat="server" Skin="Wr" EnableEmbeddedSkins="false" UseColumnHeadersAsSelectors="False"
                                        UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                    </Calendar>
                                    <DateInput ID="DateInput1" runat="server" DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="">
                                    </DateInput>
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>

                            </EditItemTemplate>
                            <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="MNT_EMAILCOBRANCACONTRATOEM" DataType="System.Decimal" ReadOnly="True" DataFormatString="{0:dd/MM/yyyy HH:mm}"
                            HeaderText="Solicitado em" SortExpression="MNT_EMAILCOBRANCACONTRATOEM" UniqueName="MNT_EMAILCOBRANCACONTRATOEM">
                            <HeaderStyle Width="130px" />
                        </telerik:GridBoundColumn>

                    </Columns>

                    <EditFormSettings>
                        <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"
                            CancelImageUrl="~/Skins/Grid/Cancel.gif" CancelText="Cancelar" EditImageUrl="~/Skins/Grid/Edit.gif"
                            EditText="Editar" UpdateText="Salvar">
                        </EditColumn>
                    </EditFormSettings>

                </MasterTableView>

            </telerik:RadGrid>
            <br />
            <wr:ManutencaoLancamento ID="ManutencaoLancamento1" runat="server" Visible="false" />
            <wr:ManutencaoCancelamento ID="ManutencaoCancelamento1" runat="server" Visible="false" />

            <asp:SqlDataSource ID="sqlAssepontoManutencao" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT MNT_IND, MNT_DATA, MNT_CANCELADO, 
      
                                    (CASE WHEN MNT_CANCELADO = 1 THEN 'CANCELADO: ' + MNT_MOTIVO_CANCELAMENTO ELSE 
                                        (CASE WHEN MNT_REVENDA IS NULL THEN ISNULL(VER_NOME_FANTASIA, '') 
                                         ELSE 'REVENDA' END) END ) AS VER_NOME_FANTASIA,
                                
                                (CASE WHEN MNT_REVENDA IS NULL THEN MNT_VALOR ELSE NULL END) AS MNT_VALOR,

                                MNT_CONTRATO_ENVIADOEM, MNT_CONTRATO_RECEBIDOEM, MNT_EMAILCOBRANCACONTRATOEM FROM AssepontoManutencao 
                                LEFT JOIN AssepontoVersoes ON VER_COD = MNT_VERSAO_ASSEPONTO
                                WHERE MNT_CLIENTE = @CLIENTE ORDER BY MNT_DATA DESC, MNT_IND DESC"

                UpdateCommand="UPDATE AssepontoManutencao SET MNT_CONTRATO_ENVIADOEM = @MNT_CONTRATO_ENVIADOEM, MNT_CONTRATO_RECEBIDOEM = @MNT_CONTRATO_RECEBIDOEM, MNT_DATA = GETDATE() WHERE MNT_IND = @MNT_IND">
                
                <SelectParameters>
                    <asp:QueryStringParameter Name="CLIENTE" QueryStringField="cliente" />
                </SelectParameters>

                <UpdateParameters>
                    <asp:Parameter Name="MNT_CONTRATO_ENVIADOEM" Type="DateTime" />
                    <asp:Parameter Name="MNT_CONTRATO_RECEBIDOEM" Type="DateTime" />
                    <asp:Parameter Name="MNT_IND" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
