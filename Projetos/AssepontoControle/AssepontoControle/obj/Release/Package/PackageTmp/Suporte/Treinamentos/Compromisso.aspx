<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Compromisso.aspx.cs" Inherits="Asseponto.Suporte.Treinamentos.Compromisso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <link href="../../Skins/Window.flv.css" rel="stylesheet" />
    <script src="../../JQuery/Impressao.js"></script>
    <script type="text/javascript">
        function confirmarExcluir() { return (window.confirm('Deseja realmente excluir a Agenda ?')) }
        function confirmarCancelar() { return (window.confirm('Deseja realmente cancelar a Agenda ?')) }
        function confirmarfinalizar() { return (window.confirm('Deseja realmente finalizar a Agenda?')) }


        function OpenAddAnotacao() {
            var oWnd1 = $find("<%= RadWindowAnotacao.ClientID %>");
            oWnd1.set_initialBehaviors(Telerik.Web.UI.WindowBehaviors.Pin);
            oWnd1.set_animation(Telerik.Web.UI.WindowAnimation.Fade);
            //oWnd1.setUrl("addAnotacao.aspx?ind=" + id);
            oWnd1.show();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <table style="width: 100%" class="text">
        <tr>
            <td>
                <asp:Label ID="lbDIA" runat="server" Font-Size="16pt" Text=""></asp:Label>
            </td>
            <td style="text-align: right;">
                <telerik:RadComboBox ID="combobox" CausesValidation="false" DataSourceID="sqlAgenda" Width="280" EmptyMessage="Selecione uma Data - Horário" OnSelectedIndexChanged="comboboxRevenda_SelectedIndexChanged"
                    DataTextField="DATAHORA" DataValueField="AGE_IND" runat="server" Skin="flv" DataTextFormatString="{0:dd/MM/yyyy HH:mm}" EnableEmbeddedSkins="false" AutoPostBack="true">
                    <ItemTemplate>
                        <table>
                                <tr>
                                    <td style='<%# "background-color: " + (Convert.ToBoolean(Eval("AGE_TREINAMENTO_INDIVIDUAL")) && Convert.ToInt32(Eval("Clientes")) == 0 ? "#FFC961;": (!Convert.ToBoolean(Eval("AGE_TREINAMENTO_INDIVIDUAL")) && Convert.ToInt32(Eval("Clientes")) < 15) ? "dodgerblue;" : "crimson;") + "width: 4px;" %>'></td>
                                    <td>
                                        <asp:Label ID="lbNome" runat="server" Text='<%# Eval("DATAHORA") %>'></asp:Label>
                                        <%# Convert.ToBoolean(Eval("AGE_TREINAMENTO_INDIVIDUAL")) ? " - Individual" : "" %>
                                    </td>
                                </tr>
                        </table>
                    </ItemTemplate>
                </telerik:RadComboBox>

                <asp:SqlDataSource ID="sqlAgenda" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                    SelectCommand="SELECT AGE_IND, AGE_REALIZADO, AGE_CANCELADO, AGE_TREINAMENTO_INDIVIDUAL, (CONVERT(NVARCHAR, AGE_DATA_HORA, 103) + ' ' + SUBSTRING(CONVERT(NVARCHAR, AGE_DATA_HORA, 108), 0, 6) + ' - ' + AGE_SEMANA) AS DATAHORA,
                            (SELECT COUNT(AGECLI_IND) FROM AssepontoAgendaClientes WHERE AGECLI_AGENDA = AGE_IND) AS Clientes 
                            FROM AssepontoAgendaTreinamentos WHERE CONVERT(DATE, AGE_DATA_HORA) = CONVERT(DATE, @data) AND AGE_ASSEPONTO4 = 1 ORDER BY AGE_DATA_HORA ASC">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="DATA" Type="DateTime" QueryStringField="data" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>

    <asp:Panel ID="PanelCodigo" runat="server">
        <table style="padding-top: 30px; width: 100%">
            <tr>
                <td style="width: 250px;">CODIGO
                    <asp:TextBox ID="txtCodigo" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:LinkButton ID="lkCodigo" runat="server" OnClick="lkCodigo_Click" CssClass="sitebutton blue">Enviar E-mail </asp:LinkButton>
                </td>
                <td style="text-align: right;">
                    <input type="button" value="Imprimir" onclick="JavaScript: imprimePanel('impressao');" class="sitebutton blue" />
                </td>
            </tr>
            <tr>
                <td colspan="3" style="width: 250px; padding-top: 10px;">
                    <asp:CheckBox ID="CheckBoxHeader" runat="server" Font-Size="14pt" AutoPostBack="true" Text="Selecionar Todos" OnCheckedChanged="CheckBoxHeader_CheckedChanged" />
                </td>

            </tr>
        </table>
    </asp:Panel>
    <div id="impressao">
        <style type="text/css">
            .rgExpand, .rgCollapse
            {
                display: none;
            }
            .gold {
                color: #FFC961;
            }
        </style>
        <link href="http://www.asseponto.com.br/assepontocontrole/Skins/Grid.flv.css" rel="stylesheet" />
        <link href="http://www.asseponto.com.br/assepontocontrole/Styles/Site.css" rel="stylesheet" type="text/css" />
        <asp:Panel ID="PanelClientes" runat="server">
            <table>
                <tr>
                    <td style="padding-bottom: 10px;" colspan="2">
                        <asp:Label ID="lbErro" runat="server" Font-Size="14pt" ForeColor="Red" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
                            <AjaxSettings>
                                <telerik:AjaxSetting AjaxControlID="RadGrid1">
                                    <UpdatedControls>
                                        <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                                    </UpdatedControls>
                                </telerik:AjaxSetting>
                            </AjaxSettings>
                        </telerik:RadAjaxManager>

                        <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" DataSourceID="SqlAgendaCliente"
                            CellSpacing="0" GridLines="None" PageSize="50" EditItemStyle-HorizontalAlign="Justify" EnableEmbeddedSkins="false"
                            GroupingSettings-CaseSensitive="false" AllowSorting="true" AllowAutomaticUpdates="true"
                            SortingSettings-EnableSkinSortStyles="false" Skin="flv" ShowGroupPanel="false">

                            <MasterTableView DataSourceID="SqlAgendaCliente" AutoGenerateColumns="false" ShowGroupFooter="true"
                                DataKeyNames="AGECLI_IND" ItemStyle-Height="40px" AlternatingItemStyle-Height="40px"
                                AllowAutomaticDeletes="true">

                                <NoRecordsTemplate>
                                    <table style="min-height: 150px; border-bottom: 1px dashed gray; width: 100%; padding-bottom: 50px; font-size: 14pt;">
                                        <tr>
                                            <td>Nenhum Cliente encontrado.
                                            </td>
                                        </tr>
                                    </table>
                                </NoRecordsTemplate>

                                <GroupByExpressions>
                                    <telerik:GridGroupByExpression>
                                        <SelectFields>
                                            <telerik:GridGroupByField FieldAlias="HORA" FieldName="HORA" HeaderText="Horário" HeaderValueSeparator=" "></telerik:GridGroupByField>
                                        </SelectFields>
                                        <GroupByFields>
                                            <telerik:GridGroupByField FieldName="HORA" SortOrder="Ascending"></telerik:GridGroupByField>
                                        </GroupByFields>
                                    </telerik:GridGroupByExpression>
                                </GroupByExpressions>

                                <Columns>
                                    <telerik:GridTemplateColumn DataField="AGECLI_COMPARECEU" HeaderText="Status" SortExpression="AGECLI_COMPARECEU" UniqueName="AGECLI_COMPARECEU">
                                        <ItemTemplate>
                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/TickVerde.png" Visible='<%# !(Eval("AGE_FINALIZADO_POR") is DBNull) && Convert.ToBoolean(Eval("AGECLI_COMPARECEU")) ? true : false %>' />
                                            <asp:CheckBox ID="CheckRealizado" runat="server" AutoPostBack="true" OnCheckedChanged="CheckRealizado_CheckedChanged" Visible='<%# Eval("AGE_FINALIZADO_POR") is DBNull ? true : false %>'
                                                Checked='<%# Convert.ToBoolean(Eval("AGECLI_COMPARECEU")) %>' />
                                            <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/16x16/PremiumGolden.png" Visible='<%# Convert.ToBoolean(Eval("REV_COBRAR_CLIENTES")) ? false : true %>' />
                                        </ItemTemplate>
                                        <HeaderStyle Width="40px" />
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridTemplateColumn DataField="CAD_RAZAOSOCIAL" DataType="System.String" HeaderText="Empresa"
                                        Aggregate="Count" ItemStyle-Font-Size="9pt" FooterAggregateFormatString="Total: {0:0} Clientes">
                                        <HeaderStyle Width="350px" />
                                        <ItemTemplate>
                                            <asp:Label CssClass='<%# Convert.ToBoolean(Eval("REV_COBRAR_CLIENTES")) ? "" : "gold" %>' ID="lbRazao" Font-Bold="true" runat="server" Text='<%# Eval("CAD_RAZAOSOCIAL") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="AGECLI_CONTATO" HeaderText="Contato" SortExpression="AGECLI_CONTATO" UniqueName="AGECLI_CONTATO">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="HiddenRadwindows" runat="server" Value='<%# RadWindowAnotacao.NavigateUrl = "addAnotacao.aspx?ind=" + Eval("AGECLI_IND").ToString()  %>' />
                                            <asp:HiddenField ID="HiddenCliente" runat="server" Value='<%# Eval("AGECLI_CLIENTE") %>' />
                                            <asp:HiddenField ID="HiddenIdAgendaCliente" runat="server" Value='<%# Eval("AGECLI_IND") %>' />
                                            Nome:
                                        <asp:Label ID="lbContato" Font-Bold="true" runat="server" Text='<%# Eval("AGECLI_CONTATO") %>'></asp:Label>
                                            <br />
                                            E-mail:
                                        <asp:Label ID="lbEmail" runat="server" Text='<%# Eval("AGECLI_CONTATO_EMAIL") %>'></asp:Label>
                                            <br />
                                            Telefone:
                                        <asp:Label ID="lbTelefone" runat="server" Text='<%# Eval("AGECLI_CONTATO_TELEFONE") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Width="350px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="SUP_NOME" HeaderText="Agendado Por" SortExpression="SUP_NOME" UniqueName="SUP_NOME">
                                        <ItemTemplate>
                                            <asp:Label ID="lbTécnico" runat="server" Text='<%# Eval("SUP_NOME") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Width="150px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="AGE_LINK" HeaderText="Código" SortExpression="AGE_LINK" UniqueName="AGE_LINK">
                                        <ItemTemplate>
                                            <asp:Label ID="lbPresencial" runat="server" Text='<%# Convert.ToBoolean(Eval("AGECLI_PRESENCIAL")) ? "Presencial" : Eval("AGE_LINK") %>'> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Width="100px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridButtonColumn UniqueName="EditCommandColumn" ButtonType="ImageButton" ConfirmText="Tem certeza que deseja excluir o item selecionado ?"
                                        HeaderText="Excluir" ImageUrl="http://www.asseponto.com.br/assepontocontrole/Skins/Grid/Delete.png" CommandName="Delete"
                                        FilterControlAltText="Filter DeleteColumn column">
                                        <HeaderStyle Width="50px" />
                                    </telerik:GridButtonColumn>

                                </Columns>
                                <EditFormSettings>
                                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"
                                        CancelImageUrl="~/Skins/Grid/Cancel.gif" CancelText="Cancelar" EditImageUrl="~/Skins/Grid/Edit.gif"
                                        EditText="Editar" UpdateText="Salvar">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </td>
                </tr>
            </table>

        </asp:Panel>
    </div>
    <asp:Panel ID="PanelBotoes" runat="server">
        <table>
            <tr>
                <td style="padding-left: 20px;" colspan="2">
                    <table>
                        <tr>
                            <td style="width: 200px;">
                                <asp:LinkButton ID="lkFinalizar" OnClientClick="return confirmarfinalizar();"
                                    CausesValidation="false" runat="server" OnClick="lkFinalizar_Click" CssClass="sitebutton blue">Finalizar Treinamento</asp:LinkButton>
                            </td>
                            <td style="padding-left: 20px; width: 200px;">
                                <asp:LinkButton ID="lkCancelar" CausesValidation="false" OnClientClick="return confirmarCancelar();"
                                    runat="server" OnClick="lkCancelar_Click" BackColor="Crimson" CssClass="sitebutton">Cancelar Agenda</asp:LinkButton>
                            </td>
                            <td style="padding-left: 20px;">
                                <asp:LinkButton ID="lkExcluir" CausesValidation="false" OnClientClick="return confirmarExcluir();"
                                    runat="server" OnClick="lkExcluir_Click" BackColor="Gray" CssClass="sitebutton">Exluir Agenda</asp:LinkButton>
                            </td>
                            <%--<td style="text-align: right;">
                                <asp:LinkButton ID="lkAddAnotacao" CausesValidation="false" OnClick='<%# "OpenAddAnotacao();" %>'
                                    runat="server" BackColor="#005100" CssClass="sitebutton">Add Anotação</asp:LinkButton>
                            </td>--%>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding: 20px;" colspan="2">
                    <b style="color: red;">Obs:</b> Ao clicar no botão Finalizar Treinamento, vai automaticamente gerar uma pendencia e enviar um e-mail para o cliente dependendo do status dele:
                        <ul>
                            <li><b>Se compareceu:</b>
                                <br />
                                - Pendencia: "Treinamento realizado com sucesso. Usuário apto a administrar o sistema. Suporte a disposição."<br />
                                - Email: Envia o Questionário.
                            </li>

                            <li><b>Se Não compareceu:</b>
                                <br />
                                - Pendencia: "Encaminhamos E-mail solicitando o retorno para reagendar o treinamento operacional do software Asseponto4."<br />
                                - Email: Envia o e-mail cobrando o retorno cliente para reagendar.
                            </li>
                        </ul>
                    <p>
                        O botão Cancelar, só vai colocar o status cancelado no treinamento e não vai enviar e-mail e nem gerar pendencia automática.
                    </p>
                </td>
            </tr>
        </table>
    </asp:Panel>

    <telerik:RadWindowManager ID="RWM_AddAnotacao" runat="server" EnableShadow="true" ReloadOnShow="True" AutoSizeBehaviors="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindowAnotacao" runat="server" EnableEmbeddedSkins="false" Skin="flv" Title="Adicionar Anotação"
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="600" Width="680" Behaviors="Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <asp:SqlDataSource ID="SqlAgendaCliente" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT (CASE WHEN REV_COBRAR_CLIENTES IS NULL THEN 1 ELSE REV_COBRAR_CLIENTES END) AS REV_COBRAR_CLIENTES, AGECLI_IND, AGECLI_CLIENTE, AGECLI_COMPARECEU, AGECLI_PRESENCIAL, AGE_LINK, 
	                           AGE_REALIZADO, AGE_DATA_HORA, SUP_NOME, AGECLI_CONTATO_TELEFONE, AGECLI_CONTATO_EMAIL,
                               AGECLI_CONTATO, CAD_RAZAOSOCIAL, SUBSTRING(CONVERT(NVARCHAR, AGE_DATA_HORA, 108), 0, 6) AS HORA, AGE_FINALIZADO_POR        
                        FROM AssepontoAgendaClientes 
                        INNER JOIN AssepontoClientes ON AGECLI_CLIENTE = CAD_IND
                        INNER JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA
                        INNER JOIN AssepontoAgendaTreinamentos ON AGE_IND = AGECLI_AGENDA
                        INNER JOIN AssepontoSuporte ON AGECLI_AGENDADO_POR = SUP_IND
                        WHERE AGE_IND = @IND ORDER BY AGE_DATA_HORA, CAD_RAZAOSOCIAL ASC"
        OnSelecting="SqlAgendaCliente_Selecting"
        DeleteCommand="DELETE FROM AssepontoAgendaClientes WHERE AGECLI_IND = @AGECLI_IND AND (SELECT (CASE WHEN AGE_FINALIZADO_POR IS NULL THEN 0 ELSE 1 END) FROM AssepontoAgendaTreinamentos WHERE AGE_IND = @IND) = 0">
        <SelectParameters>
            <asp:QueryStringParameter Name="IND" Type="Int16" QueryStringField="ind" />
        </SelectParameters>
        <DeleteParameters>
            <asp:QueryStringParameter Name="IND" Type="Int16" QueryStringField="ind" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>
