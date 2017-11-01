<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManutencaoRevendaCancelamento.ascx.cs"
    Inherits="Asseponto.WebControls.ManutencaoRevendaCancelamento" %>

<link href="../Styles/Site.css" rel="stylesheet" />
<link href="../Styles/FormView.css" rel="stylesheet" />

<%--<div class="sitecorpoboxcaixa">
    <table class="formviewtable">
        <tr>
            <td>
                <asp:Label ID="lbErro" runat="server" ForeColor="Red" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <div class="fieldviewcaptionnormal">
                    Motivo do Cancelamento
                </div>
                <asp:TextBox ID="txtMotivo" runat="server" Width="300"></asp:TextBox>
            </td>
            <td>
                <div class="fieldviewcaptionnormal">
                    &nbsp;
                </div>
                <asp:Button ID="Salvar" runat="server" Text="Cancelar Manutenção"  CssClass="sitebutton blue" OnClick="Salvar_Click" />
            </td>
        </tr>
    </table>
</div>--%>

<telerik:RadInputManager ID="RadInputManager1" runat="server" Skin="Wr" EnableEmbeddedSkins="false">
    <telerik:TextBoxSetting Validation-IsRequired="true" ClearValueOnError="False" ErrorMessage="Obrigatório">
        <TargetControls>
            <telerik:TargetInput ControlID="txtMotivo" />
        </TargetControls>
    </telerik:TextBoxSetting>
</telerik:RadInputManager>

<div class="sitecorpoboxcaixa">
    <table class="formviewtable" style="padding-top: 10px;">
        <tr>
            <td>
                <div class="fieldviewcaptionnormal">
                    Motivo do Cancelamento
                </div>
                <asp:TextBox ID="txtMotivo" runat="server" Width="300"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbError" ForeColor="Red" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <br />
                <b>
                    <div class="fieldviewcaptionnormal">
                        Clientes
                    </div>
                </b>
            </td>
        </tr>
        <tr>
            <td>
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
                                    <asp:HyperLink ID="hyperRazao" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/Atendimento/Cliente.aspx?ind={0}")  %>'><%# Eval("CAD_RAZAOSOCIAL")  %></asp:HyperLink>
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
                    <asp:LinkButton ID="Cancelar" runat="server" Text="Cancelar Manutenção" CssClass="sitebutton" OnClick="Cancelar_Click"></asp:LinkButton>
                </div>
            </td>
        </tr>
    </table>
</div>

<asp:SqlDataSource ID="SqlCliente" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"

    SelectCommand="SELECT dbo.fn_cliente_cnpj_cpf(CAD_IND) AS CNPJ_CPF, CAD_EMAIL, CAD_IND, REV_IND, CAD_RAZAOSOCIAL FROM AssepontoClientes 
                    INNER JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA WHERE REV_IND = @Revenda">
    <SelectParameters>
        <asp:QueryStringParameter Type="Int32" Name="Revenda" QueryStringField="Revenda" />
    </SelectParameters>
</asp:SqlDataSource>
