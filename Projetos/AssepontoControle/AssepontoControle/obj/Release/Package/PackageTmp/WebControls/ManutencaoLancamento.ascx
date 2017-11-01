<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManutencaoLancamento.ascx.cs"
    Inherits="Asseponto.WebControls.ManutencaoLancamento" %>


<link href="../Styles/Site.css" rel="stylesheet" />
<link href="../Styles/FormView.css" rel="stylesheet" />

<asp:FormView ID="FormViewManutencaoLancamento" runat="server" DataKeyNames="MNT_IND"
    DataSourceID="sqlAssepontoManutencaoLancamento" DefaultMode="Insert">
    <EditItemTemplate>
        <div class="sitecorpoboxcaixa">
            <table class="formviewtable" style="padding-top: 10px;">
                <tr>
                    <td>
                        <div class="fieldviewcaptionnormal">
                            Valor
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="sitevalidator" ErrorMessage="Obrigatório" ControlToValidate="MNT_VALOR"></asp:RequiredFieldValidator>
                        <telerik:RadNumericTextBox ID="MNT_VALOR" runat="server" Value='<%# Bind("MNT_VALOR") %>'
                            Skin="Wr" EnableEmbeddedSkins="false">
                        </telerik:RadNumericTextBox>
                    </td>
                    <td>
                        <div class="fieldviewcaptionnormal">
                            Versão
                        </div>
                        <telerik:RadComboBox ID="MNT_VERSAO_ASSEPONTO" runat="server" DataSourceID="sqlAssepontoVersoes"
                            DataTextField="VER_NOME" DataValueField="VER_COD" SelectedValue='<%# Bind("MNT_VERSAO_ASSEPONTO") %>'
                            Skin="flv" Width="200px" EnableEmbeddedSkins="false" EmptyMessage="Selecione a Versão">
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <div class="fieldviewcaptionnormal">
                            Contrato Enviado Em
                        </div>
                        <telerik:RadDatePicker ID="RadDate" runat="server" Skin="Web20"
                            DbSelectedDate='<%# Bind("MNT_CONTRATO_ENVIADOEM") %>'>
                            <Calendar Skin="Web20" UseColumnHeadersAsSelectors="False"
                                UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                            </Calendar>
                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="">
                            </DateInput>
                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                        </telerik:RadDatePicker>
                    </td>
                </tr>
                <%--<tr>
                    <td style="padding-top: 15px;">
                        <div class="fieldviewcaptionnormal">
                            Contrato (PDF)
                        </div>
                        <asp:FileUpload ID="FileContrato" runat="server" />
                        <br />
                        <asp:CustomValidator ID="CV_Contrato" runat="server" OnServerValidate="CV_Contrato_ServerValidate" ControlToValidate="FileContrato" CssClass="sitevalidator" ErrorMessage="Formato Inválido"></asp:CustomValidator>
                    </td>
                </tr>--%>
                <tr>
                    <td colspan="3" style="padding-top: 15px;">
                        <div class="fieldviewcaptionnormal">
                            &nbsp;
                        </div>
                        <asp:Button ID="Salvar" runat="server" Text="Salvar Manutenção" CssClass="sitebutton blue" CommandName="Insert" />
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
    </EditItemTemplate>
</asp:FormView>
<asp:SqlDataSource ID="sqlAssepontoManutencaoLancamento" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
    InsertCommand="INSERT INTO AssepontoManutencao (MNT_CLIENTE, MNT_DATA, MNT_VALOR, MNT_VERSAO_ASSEPONTO, MNT_DATA_LANCAMENTO, MNT_CONTRATO_ENVIADOEM, MNT_REALIZADO_POR) VALUES (@MNT_CLIENTE, GETDATE(), @MNT_VALOR, @MNT_VERSAO_ASSEPONTO, GETDATE(), @MNT_CONTRATO_ENVIADOEM, @MNT_REALIZADO_POR)"
    OnInserting="sqlAssepontoManutencao_Inserting" OnInserted="sqlAssepontoManutencao_Inserted">
    <InsertParameters>
        <asp:Parameter Name="MNT_DATA" Type="DateTime" />
        <asp:Parameter Name="MNT_CLIENTE" Type="Int32" />
        <asp:Parameter Name="MNT_VALOR" Type="Decimal" />
        <asp:Parameter Name="MNT_VERSAO_ASSEPONTO" Type="Int32" />
        <asp:Parameter Name="MNT_CONTRATO_ENVIADOEM" Type="DateTime" />
        <asp:Parameter Name="MNT_REALIZADO_POR" Type="Int32" />
    </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sqlAssepontoVersoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
    SelectCommand="SELECT [VER_COD], [VER_NOME] FROM [AssepontoVersoes] WHERE VER_ATIVO = 1 AND VER_MANUTENCAO = 1 ORDER BY [VER_COD]"></asp:SqlDataSource>
