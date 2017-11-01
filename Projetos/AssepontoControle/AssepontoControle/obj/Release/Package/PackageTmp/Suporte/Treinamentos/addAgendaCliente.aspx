<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="addAgendaCliente.aspx.cs" Inherits="Asseponto.Suporte.Treinamentos.addAgendaCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Nova Pendência" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Pendências em Aberto" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Pendências Solucionadas" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Senhas" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Ir para implantação" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Cadastro" NavigateUrl="#">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <asp:Panel ID="Panel1" runat="server">

                <h3>Agendar Treinamento</h3>

                <br />
               <%-- <asp:RadioButtonList ID="rblProdutos" runat="server" AutoPostBack="true" DataSourceID="">
                </asp:RadioButtonList>--%>
                <asp:UpdatePanel ID="upCombobox" runat="server">
                    <ContentTemplate>
                        Data:
                        <telerik:RadComboBox ID="comboboxRevenda" Width="400" EmptyMessage="Selecione uma Data - Horário" CausesValidation="false" 
                            DataTextField="DATAHORA" DataValueField="AGE_IND" runat="server" Skin="flv" DataTextFormatString="{0:dd/MM/yyyy HH:mm}" EnableEmbeddedSkins="false" AutoPostBack="true">
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td style='<%# "background-color: " + (Convert.ToBoolean(Eval("AGE_TREINAMENTO_INDIVIDUAL")) && Convert.ToInt32(Eval("Clientes")) == 0 ? "#FFC961;" : !Convert.ToBoolean(Eval("AGE_TREINAMENTO_INDIVIDUAL")) && Convert.ToInt32(Eval("Clientes")) < 15 ? "dodgerblue;" : "crimson;") + "width: 4px;" %>'></td>
                                        <td>
                                            <asp:Label ID="lbNome" runat="server" Text='<%# Eval("DATAHORA") %>'></asp:Label>
                                            <%# Convert.ToBoolean(Eval("AGE_TREINAMENTO_INDIVIDUAL")) ? " - Individual" : "" %>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </telerik:RadComboBox>
                        <asp:RequiredFieldValidator ID="RFV_comboboxRevenda" runat="server" ControlToValidate="comboboxRevenda" CssClass="sitevalidator" ErrorMessage="Obrigatório"></asp:RequiredFieldValidator>

                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:SqlDataSource ID="sqlAgenda" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                    SelectCommand="SELECT AGE_IND, AGE_REALIZADO, AGE_CANCELADO, AGE_TREINAMENTO_INDIVIDUAL, (CONVERT(NVARCHAR, AGE_DATA_HORA, 103) + ' ' + SUBSTRING(CONVERT(NVARCHAR, AGE_DATA_HORA, 108), 0, 6) + ' - ' + AGE_SEMANA) AS DATAHORA,
                         (SELECT COUNT(AGECLI_IND) FROM AssepontoAgendaClientes WHERE AGECLI_PRESENCIAL = 0 AND AGECLI_AGENDA = AGE_IND) AS Clientes 
                         FROM AssepontoAgendaTreinamentos WHERE 
                         (SELECT COUNT(*) FROM AssepontoAgendaClientes WHERE AGE_IND = AGECLI_AGENDA AND AGECLI_PRESENCIAL = 0) &lt;= 14 AND AGE_DATA_HORA &gt;= GETDATE() AND AGE_TREINAMENTO_INDIVIDUAL = 0 AND AGE_ASSEPONTO4 = 1 AND AGE_FINALIZADO_POR IS NULL ORDER BY AGE_DATA_HORA ASC"></asp:SqlDataSource>

                <asp:SqlDataSource ID="SqlAgendaAdmin" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                    SelectCommand="SELECT AGE_IND, AGE_REALIZADO, AGE_CANCELADO, AGE_TREINAMENTO_INDIVIDUAL, (CONVERT(NVARCHAR, AGE_DATA_HORA, 103) + ' ' + SUBSTRING(CONVERT(NVARCHAR, AGE_DATA_HORA, 108), 0, 6) + ' - ' + AGE_SEMANA) AS DATAHORA,
                         (SELECT COUNT(AGECLI_IND) FROM AssepontoAgendaClientes WHERE AGECLI_AGENDA = AGE_IND) AS Clientes 
                         FROM AssepontoAgendaTreinamentos WHERE AGE_DATA_HORA &gt;= GETDATE() AND AGE_ASSEPONTO4 = 1 AND AGE_FINALIZADO_POR IS NULL ORDER BY AGE_DATA_HORA ASC"></asp:SqlDataSource>
                <p>
                    Nome do participante:
                    <asp:TextBox ID="txtNome" runat="server" Width="200"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFV_NOME" runat="server" ControlToValidate="txtNome" CssClass="sitevalidator" ErrorMessage="Obrigatório"></asp:RequiredFieldValidator>
                    <asp:CheckBox ID="checkPresencial" runat="server" Text="Treinamento Presencial" />

                </p>

                <p>
                    E-mail:
                    <asp:TextBox ID="txtEmail" runat="server" Width="290"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFV_TELEFONE" runat="server" ControlToValidate="txtEmail" CssClass="sitevalidator" ErrorMessage="Obrigatório"></asp:RequiredFieldValidator>
                </p>

                <p>
                    Telefone:
                    <asp:TextBox ID="txtTelefone" runat="server" Width="100"></asp:TextBox>
                </p>

                <p>
                    <asp:Label ID="lbErro" ForeColor="Red" runat="server" Text=""></asp:Label>
                </p>

                <asp:LinkButton ID="lkSalvar" runat="server" OnClick="lkSalvar_Click" CssClass="sitebutton">Agendar</asp:LinkButton>

            </asp:Panel>
            <br />
            <br />
            <asp:Panel ID="Panel2" runat="server">
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" DataSourceID="SqlAgendaCliente"
                    CellSpacing="0" GridLines="None" PageSize="50" EditItemStyle-HorizontalAlign="Justify"
                    GroupingSettings-CaseSensitive="false" AllowSorting="true" AllowAutomaticUpdates="true"
                    SortingSettings-EnableSkinSortStyles="false" Skin="Simple">

                    <MasterTableView DataSourceID="SqlAgendaCliente" AutoGenerateColumns="false"
                        DataKeyNames="AGECLI_IND" ItemStyle-Height="30px" AlternatingItemStyle-Height="30px"
                        AllowAutomaticUpdates="true">

                        <NoRecordsTemplate>
                            <div>
                                Nenhum Agendamento encontrado.
                            </div>
                        </NoRecordsTemplate>

                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridTemplateColumn DataField="AGECLI_CONTATO"
                                HeaderText="Contato" SortExpression="AGECLI_CONTATO" UniqueName="AGECLI_CONTATO">
                                <ItemTemplate>
                                    <asp:Label ID="lbContato" runat="server" Text='<%# Eval("AGECLI_CONTATO") %>'></asp:Label>
                                    <br />
                                    E-mail:
                                    <asp:Label ID="lbEmail" runat="server" Text='<%# Eval("AGECLI_CONTATO_EMAIL") %>'></asp:Label>
                                    <br />
                                    Telefone:
                                    <asp:Label ID="lbTelefone" runat="server" Text='<%# Eval("AGECLI_CONTATO_TELEFONE") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="300px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="SUP_NOME"
                                HeaderText="Agendado Por" SortExpression="SUP_NOME" UniqueName="SUP_NOME">
                                <ItemTemplate>
                                    <asp:Label ID="lbTécnico" runat="server" Text='<%# Eval("SUP_NOME") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="AGE_DATA_HORA"
                                HeaderText="Data" SortExpression="AGE_DATA_HORA" UniqueName="AGE_DATA_HORA">
                                <ItemTemplate>
                                    <asp:Label ID="lbData" runat="server" Text='<%# Eval("AGE_DATA_HORA" , "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="120px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="AGE_REALIZADO"
                                HeaderText="Compareceu" SortExpression="AGE_REALIZADO" UniqueName="AGE_REALIZADO">
                                <ItemTemplate>
                                    <asp:Label ID="lbCompareceu" runat="server" Text='<%# !String.IsNullOrEmpty(Eval("AGE_FINALIZADO_POR").ToString()) ? Convert.ToBoolean(Eval("AGECLI_COMPARECEU")) ? "Sim" : "Não" : "-" %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="80px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="AGECLI_PRESENCIAL"
                                HeaderText="Modo" SortExpression="AGECLI_PRESENCIAL" UniqueName="AGECLI_PRESENCIAL">
                                <ItemTemplate>
                                    <asp:Label ID="lbPrensencial" runat="server" Text='<%# Convert.ToBoolean(Eval("AGECLI_PRESENCIAL")) ? "Treinamento Presencial" : "Treinamento Online" %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>

                        </Columns>

                        <EditFormSettings>
                            <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"
                                CancelImageUrl="~/Skins/Grid/Cancel.gif" CancelText="Cancelar" EditImageUrl="~/Skins/Grid/Edit.gif"
                                EditText="Editar" UpdateText="Salvar">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
                
                <asp:SqlDataSource ID="SqlAgendaCliente" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                    SelectCommand="SELECT * FROM AssepontoAgendaClientes 
                        INNER JOIN AssepontoAgendaTreinamentos ON AGE_IND = AGECLI_AGENDA
                        INNER JOIN AssepontoSuporte ON AGECLI_AGENDADO_POR = SUP_IND
                        WHERE AGECLI_CLIENTE = @CLIENTE ORDER BY AGE_DATA_HORA DESC">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="CLIENTE" Type="Int32" QueryStringField="ind" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <%--<asp:SqlDataSource ID="SqlProdutos" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                    SelectCommand="SELECT * FROM AssepontoAgendaClientes 
                        INNER JOIN AssepontoAgendaTreinamentos ON AGE_IND = AGECLI_AGENDA
                        INNER JOIN AssepontoSuporte ON AGECLI_AGENDADO_POR = SUP_IND
                        WHERE AGECLI_CLIENTE = @CLIENTE ORDER BY AGE_DATA_HORA DESC">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="CLIENTE" Type="Int32" QueryStringField="ind" />
                    </SelectParameters>
                </asp:SqlDataSource>--%>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
