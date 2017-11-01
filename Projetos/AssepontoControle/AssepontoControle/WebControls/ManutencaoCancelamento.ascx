<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManutencaoCancelamento.ascx.cs"
    Inherits="Asseponto.WebControls.ManutencaoCancelamento" %>

<link href="../Styles/Site.css" rel="stylesheet" />
<link href="../Styles/FormView.css" rel="stylesheet" />

<asp:FormView ID="FormViewManutencaoCancelamento" runat="server" DataKeyNames="MNT_IND"
    DataSourceID="sqlAssepontoManutencaoCancelamento" DefaultMode="Insert">
    <EditItemTemplate>
        <div class="sitecorpoboxcaixa">
            <table class="formviewtable">
                <tr>
                    <td>
                        <div class="fieldviewcaptionnormal">
                            Motivo do Cancelamento</div>
                        <asp:TextBox ID="MNT_MOTIVO_CANCELAMENTO" runat="server" Text='<%# Bind("MNT_MOTIVO_CANCELAMENTO") %>'
                            Width="300"></asp:TextBox>
                    </td>
                    <td>
                        <div class="fieldviewcaptionnormal">
                            &nbsp;
                        </div>
                        <asp:Button ID="Salvar" runat="server" Text="Cancelar Manutenção"  CssClass="sitebutton blue" CommandName="Insert" />
                    </td>
                </tr>
            </table>
        </div>
        <telerik:RadInputManager ID="RadInputManager1" runat="server" Skin="Wr" EnableEmbeddedSkins="false">
            <telerik:TextBoxSetting Validation-IsRequired="true" ClearValueOnError="False" ErrorMessage="Obrigatório">
                <TargetControls>
                    <telerik:TargetInput ControlID="MNT_MOTIVO_CANCELAMENTO" />
                </TargetControls>
            </telerik:TextBoxSetting>
        </telerik:RadInputManager>
    </EditItemTemplate>
</asp:FormView>
<asp:SqlDataSource ID="sqlAssepontoManutencaoCancelamento" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
    InsertCommand="INSERT INTO [AssepontoManutencao] ([MNT_CLIENTE], [MNT_DATA], [MNT_MOTIVO_CANCELAMENTO], [MNT_CANCELADO], MNT_REALIZADO_POR) VALUES (@MNT_CLIENTE, GETDATE(), @MNT_MOTIVO_CANCELAMENTO, 1, @MNT_REALIZADO_POR)"
    OnInserting="sqlAssepontoManutencao_Inserting" OnInserted="sqlAssepontoManutencao_Inserted">
    <InsertParameters>
        <asp:Parameter Name="MNT_CLIENTE" Type="Int32" />
        <asp:Parameter Name="MNT_MOTIVO_CANCELAMENTO" Type="String" />
        <asp:Parameter Name="MNT_REALIZADO_POR" Type="Int32" />
    </InsertParameters>
</asp:SqlDataSource>
