<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true"
    CodeBehind="CadasatroRep.aspx.cs" Inherits="Asseponto.Revenda.Cadastro.CadasatroRep" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
 <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="False"
            Width="100%" OnItemClick="RadMenu2_ItemClick">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Dados da Empresa" NavigateUrl="#">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpoboxinner">
        <asp:Panel ID="Panel2" runat="server">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="REV_IND" DataSourceID="SqlREP"
                Width="500px" OnDataBound="FormView1_DataBound" DefaultMode="Edit">
                <EditItemTemplate>
                    <asp:Panel ID="Panel1" runat="server" EnableViewState="false">
                        <table class="formviewtable">
                            <tr>
                                <td>
                                    <asp:Label ID="lbFabricante" CssClass="formviewsubtitle" runat="server" Text="Fabricante do Rep Comercializado"></asp:Label>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>
                                                <telerik:RadComboBox ID="RadComboBox1" runat="server" DataSourceID="SqlRepFabricante"
                                                    DataTextField="FABR_NOME" DataValueField="FABR_COD" Skin="flv" EnableEmbeddedSkins="false" >
                                                </telerik:RadComboBox>
                                            </td>
                                            <td class="formviewtableinner">
                                                <asp:LinkButton ID="lbAdd" runat="server" CssClass="sitebutton" OnClick="lbAdd_Click1"
                                                    CommandName="Update"> Adicionar</asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Pelo menos um REP Cadastrado"
                                                    OnServerValidate="CustomValidator1_ServerValidate1" CssClass="sitevalidator2"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 5px;">
                                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlREP" CellSpacing="0"
                                        GridLines="None" Width="200px" Skin="Wr" EnableEmbeddedSkins="false">
                                        <ClientSettings>
                                        </ClientSettings>
                                        <MasterTableView DataSourceID="SqlREP" AllowAutomaticDeletes="true" AutoGenerateColumns="false"
                                            DataKeyNames="REVREP_IND">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="REVREP_IND" Display="false" HeaderText="ID" UniqueName="REVREP_IND"
                                                    SortExpression="REVREP_IND">
                                                    <HeaderStyle Width="150px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="FABR_NOME" HeaderText="Nome" UniqueName="FABR_NOME"
                                                    SortExpression="FABR_NOME">
                                                    <HeaderStyle Width="150px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="Remover">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" Text="Remover" OnClick="LinkButton1_Click"
                                                            CommandArgument='<%# Eval("REVREP_IND") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </EditItemTemplate>
            </asp:FormView>
        </asp:Panel>
        <asp:SqlDataSource ID="SqlRepFabricante" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT * FROM [AssepontoRepFabricantes] WHERE NOT EXISTS (SELECT * FROM AssepontoRevendasReps WHERE REVREP_REVENDA = @REVREP_REVENDA AND REVREP_REP = FABR_COD ) ORDER BY [FABR_NOME]">
            <SelectParameters>
                <asp:QueryStringParameter Name="REVREP_REVENDA" Type="Int32" QueryStringField="ind" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlREP" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="Select * FROM [assecont1].[dbo].[AssepontoRevendasReps]
                                        INNER JOIN [assecont1].[dbo].[AssepontoRevendas] ON AssepontoRevendas.REV_IND = AssepontoRevendasReps.REVREP_REVENDA
                                        INNER JOIN [assecont1].[dbo].[AssepontoRepFabricantes] ON AssepontoRevendasReps.REVREP_REP = AssepontoRepFabricantes.FABR_COD
                                        WHERE REVREP_REVENDA = @REV_IND ">
            <DeleteParameters>
                <asp:Parameter Name="REVREP_IND" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="REV_IND" QueryStringField="ind" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
