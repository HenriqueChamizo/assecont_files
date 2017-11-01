<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManutencaoRevendaLancamento.ascx.cs" Inherits="Asseponto.WebControls.ManutencaoRevendaLancamento" %>

<link href="../Styles/Site.css" rel="stylesheet" />
<link href="../Styles/FormView.css" rel="stylesheet" />

<div class="sitecorpoboxcaixa">
    <table class="formviewtable" style="padding-top: 10px;">
        <tr>
            <td style="float: left; padding-right: 6px; width: 150px;">
                <div class="fieldviewcaptionnormal">
                    Valor
                </div>
                <telerik:RadNumericTextBox ID="txtValor" runat="server" Skin="Wr" EnableEmbeddedSkins="false"></telerik:RadNumericTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="sitevalidator" ErrorMessage="Obrigatório" ControlToValidate="txtValor"></asp:RequiredFieldValidator>
            </td>
            <td style="float: left; padding-right: 6px; width: 250px;">
                <div class="fieldviewcaptionnormal">
                    Versão
                </div>
                <telerik:RadComboBox ID="comboVersao" runat="server" DataSourceID="sqlAssepontoVersoes"
                    DataTextField="VER_NOME" DataValueField="VER_COD"
                    Skin="flv" Width="200px" EnableEmbeddedSkins="false" EmptyMessage="Selecione a Versão">
                </telerik:RadComboBox>
            </td>

            <td style="float: left; padding-right: 6px;">
                <div class="fieldviewcaptionnormal">
                    Contrato Enviado Em
                </div>
                <telerik:RadDatePicker ID="RadDateEnviado" runat="server" Skin="Web20">
                    <Calendar Skin="Web20" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                    </Calendar>
                    <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="">
                    </DateInput>
                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                </telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Label ID="lbError" ForeColor="Red" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <br />
                <b><div class="fieldviewcaptionnormal">
                    Clientes
                </div></b>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
                    <AjaxSettings>
                        <telerik:AjaxSetting AjaxControlID="RadGrid1">
                            <UpdatedControls>
                                <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                            </UpdatedControls>
                        </telerik:AjaxSetting>
                    </AjaxSettings>
                </telerik:RadAjaxManager>

                <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" DataSourceID="SqlCliente" Width="860"
                    CellSpacing="0" GridLines="None" PageSize="50" EditItemStyle-HorizontalAlign="Justify" EnableEmbeddedSkins="false"
                    GroupingSettings-CaseSensitive="false" AllowSorting="true" AllowAutomaticUpdates="true"
                    SortingSettings-EnableSkinSortStyles="false" Skin="flv" ShowGroupPanel="false">

                    <MasterTableView DataSourceID="SqlCliente" AutoGenerateColumns="false"
                        DataKeyNames="CAD_IND" ItemStyle-Height="40px" AlternatingItemStyle-Height="40px">

                        <NoRecordsTemplate>
                            <div>
                                Nenhum Cliente Encontrado.
                            </div>
                        </NoRecordsTemplate>

                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

                        <Columns>
                            <telerik:GridTemplateColumn DataField="REV_IND"
                                HeaderText="Selecionar" SortExpression="REV_IND" UniqueName="selecionar">
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckRealizado" runat="server" Width="20" />
                                </ItemTemplate>
                                <HeaderStyle Width="40px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="CAD_RAZAOSOCIAL"
                                HeaderText="Empresa" SortExpression="CAD_RAZAOSOCIAL" UniqueName="CAD_RAZAOSOCIAL">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hyperRazao" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/Atendimento/Cliente.aspx?ind={0}")  %>' ><%# Eval("CAD_RAZAOSOCIAL")  %></asp:HyperLink>
                                </ItemTemplate>
                                <HeaderStyle Width="350px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="CNPJ_CPF"
                                HeaderText="CNPJ/CPF" SortExpression="CNPJ_CPF" UniqueName="CNPJ_CPF">
                                <ItemTemplate>
                                    <asp:Label ID="lbCnpjCpf" runat="server" Text='<%# Eval("CNPJ_CPF")  %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="CAD_EMAIL"
                                HeaderText="E-mail" SortExpression="CAD_EMAIL" UniqueName="CAD_EMAIL">
                                <ItemTemplate>
                                    <asp:Label ID="lbEmail" Font-Size="9pt" runat="server" Text='<%# Eval("CAD_EMAIL")  %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="padding-top: 20px;">
                <div class="formviewbuttons">
                    <asp:LinkButton ID="Salvar" runat="server" Text="Salvar Manutenção" CssClass="sitebutton" OnClick="Salvar_Click" ></asp:LinkButton>
                </div>
            </td>
        </tr>
    </table>
</div>

<telerik:RadInputManager ID="RadInputManager1" runat="server" Skin="Wr" EnableEmbeddedSkins="false">
    <telerik:TextBoxSetting Validation-IsRequired="true" ClearValueOnError="False" ErrorMessage="Obrigatório">
        <TargetControls>
            <telerik:TargetInput ControlID="MNT_VALOR" />
            <telerik:TargetInput ControlID="MNT_VERSAO_ASSEPONTO" />
        </TargetControls>
    </telerik:TextBoxSetting>
</telerik:RadInputManager>

<asp:SqlDataSource ID="SqlCliente" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
    OnSelecting="SqlCliente_Selecting"
    SelectCommand="SELECT dbo.fn_cliente_cnpj_cpf(CAD_IND) AS CNPJ_CPF, CAD_EMAIL, CAD_IND, REV_IND, CAD_RAZAOSOCIAL FROM AssepontoClientes 
                    INNER JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA WHERE REV_IND = @Revenda">
    <SelectParameters>
        <asp:QueryStringParameter Type="Int32" Name="Revenda" QueryStringField="Revenda" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sqlAssepontoVersoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
    SelectCommand="SELECT VER_COD, VER_NOME FROM AssepontoVersoes WHERE VER_ATIVO = 1 AND VER_MANUTENCAO = 1 ORDER BY VER_COD"></asp:SqlDataSource>
