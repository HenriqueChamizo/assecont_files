<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Faturamento.aspx.cs" Inherits="Asseponto.Suporte.Clientes.Faturamento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">

    <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="false" DataSourceID="SqlDataFaturamento" CellSpacing="0" GridLines="None" EditItemStyle-HorizontalAlign="Justify"
        GroupingSettings-CaseSensitive="false" AllowSorting="true" SortingSettings-EnableSkinSortStyles="false"
        EnableEmbeddedSkins="false" Skin="flv" PagerStyle-ShowPagerText="true" pagertextformat="{4} {5}">

        <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Clientes"></PagerStyle>

        <MasterTableView DataSourceID="SqlDataFaturamento" AutoGenerateColumns="false" ItemStyle-Height="55px" AlternatingItemStyle-Height="55px" DataKeyNames="CAD_IND"
            AlternatingItemStyle-BackColor="#F7F7F7">

            <NoRecordsTemplate>Nenhum contrato encontrado.</NoRecordsTemplate>

            <Columns>
                <telerik:GridTemplateColumn DataField="FCON_DATA_INICIO" HeaderText="Contrato" SortExpression="FCON_DATA_INICIO" UniqueName="FCON_DATA_INICIO">
                    <ItemTemplate>
                        <table style="width: 100%;">
                            <tr>
                                <td colspan="2" style="vertical-align: top;">
                                    <asp:Label ID="lbEmissor" runat="server" Font-Size="14pt" Text='<%# Eval("Emissor") %>'></asp:Label>
                                    <br />
                                    Inicio do Contrato
                                    <asp:Label ID="lbInicio" runat="server" Text='<%# Eval("FCON_DATA_INICIO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="border: 0px;">
                                    <asp:Label ID="lbItens" runat="server" Font-Size="12pt" Text="Itens do Contrato: " />
                                </td>
                                <td style="border: 0px;">
                                    <asp:SqlDataSource ID="SqlDataItens" runat="server" OnLoad="SqlData_Load"
                                        SelectCommand="SELECT FCONI_IND, PRO_DESCRICAO AS Produto, FCONI_VALOR AS ValorProduto
                                        FROM FaturamentoContratosItens
                                        INNER JOIN Produtos ON PRO_IND = FCONI_PRODUTO
                                        WHERE FCONI_CONTRATO = @INDICE_FATURAMENTO">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lbIndiceContrato" PropertyName="Text" Type="Int32" Name="INDICE_FATURAMENTO" />
                                        </SelectParameters>

                                    </asp:SqlDataSource>

                                    <asp:Label ID="lbIndiceContrato" Font-Bold="true" Font-Italic="true" Text='<%# Eval("FCON_IND") %>' Visible="false" runat="server" />

                                    <asp:DataList ID="DataListItens" runat="server" DataSourceID="SqlDataItens" DataKeyField="FCONI_IND" ItemStyle-BorderWidth="0">
                                        <ItemTemplate>
                                            <asp:Label ID="lbProduto" runat="server" Text='<%# Eval("Produto") %>'></asp:Label>
                                            - 
                                            <asp:Label ID="lbValorProduto" runat="server" Text='<%# Eval("ValorProduto", "{0:N2}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </td>
                            </tr>
                            <tr>
                                <td style="border: 0px;">
                                    <asp:Label ID="lbValorTotal" runat="server" Font-Size="12pt" Text="Valor Total: " />
                                </td>
                                <td style="border: 0px;">
                                    <asp:Label ID="lbValor" runat="server" Text='<%# Eval("FCON_VALOR", "{0:N2}") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                    <HeaderStyle Width="500px" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="FCON_IND" HeaderText="Arquivos" SortExpression="FCON_IND" UniqueName="FCON_IND">
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td colspan="2" style="border: 0px;">
                                    <asp:FileUpload ID="file" runat="server" />
                                    <asp:LinkButton ID="btnAnexarContrato" runat="server" OnClick="LinkButton1_Click" Font-Size="12pt" ForeColor="#0099ff">Anexar Contrato</asp:LinkButton>
                                    <asp:CustomValidator ID="CV_Planilha" runat="server" ControlToValidate="file" CssClass="sitevalidator" ErrorMessage="Formato Inválido"></asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="border: 0px;">
                                    <asp:SqlDataSource ID="SqlDataContratos" runat="server" OnLoad="SqlData_Load" OnDeleted="SqlDataContratos_Deleted"
                                        SelectCommand="SELECT FATUCONARQ_IND, FATUCONARQ_FATURAMENTO_CONTRATO, FATUCONARQ_NOME, FATUCONARQ_DATA, FATUCONARQ_POR 
                                            FROM FaturamentoContratosArquivo 
                                            WHERE FATUCONARQ_FATURAMENTO_CONTRATO = @INDICE_FATURAMENTO ORDER BY FATUCONARQ_DATA DESC"
                                        DeleteCommand="DELETE FROM FaturamentoContratosArquivo WHERE FATUCONARQ_IND = @FATUCONARQ_IND">

                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lbIndiceContrato" PropertyName="Text" Type="Int32" Name="INDICE_FATURAMENTO" />
                                        </SelectParameters>

                                        <DeleteParameters>
                                            <asp:Parameter Type="Int32" Name="FATUCONARQ_IND" />
                                        </DeleteParameters>

                                    </asp:SqlDataSource>

                                    <asp:DataList ID="DataListContratos" runat="server" DataSourceID="SqlDataContratos" DataKeyField="FATUCONARQ_IND" ItemStyle-BorderWidth="0" OnDeleteCommand="DataListContratos_DeleteCommand">
                                        <ItemTemplate>
                                            <table style="width: 100%; border: 1px solid #B5B5B5; background: rgba(234, 234, 234, 0.67);">
                                                <tr>
                                                    <td style="border: 0px;">
                                                        <asp:Label ID="lbDataDoArquivo" runat="server" Text='<%# "Anexado em " + Eval("FATUCONARQ_DATA", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                                        <asp:Label ID="lbAnexadoPor" runat="server" Text='<%# " por " + Eval("FATUCONARQ_POR") %>'></asp:Label>
                                                        <br />
                                                        <asp:HyperLink ID="btAbrir" runat="server" Target="_blank" NavigateUrl='<%# "~/ViewFile.aspx?contrato=" + Eval("FATUCONARQ_IND") %>' Text='<%# Eval("FATUCONARQ_NOME") %>'></asp:HyperLink>
                                                    </td>
                                                    <td style="border: 0px;">
                                                        <asp:LinkButton ID="btnExcluir" runat="server" CommandArgument="delete" CommandName="delete">
                                                        <img src="../../Images/Site/Error.png" width="48" /> </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                    <HeaderStyle Width="500px" />
                    <ItemStyle HorizontalAlign="Center" />
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="SqlDataFaturamento" runat="server" OnLoad="SqlData_Load" OnSelecting="SqlDataFaturamento_Selecting"
        SelectCommand="SELECT CAD_IND, FCON_IND, FCON_DATA_INICIO, FCON_VALOR, 
                    (SELECT GRU_RAZAOSOCIAL FROM Grupos WHERE FCON_GRUPO = GRU_IND ) AS Emissor
                    FROM FaturamentoContratos 
                    INNER JOIN Cadastros ON CAD_IND = FCON_CADASTRO 
                    WHERE CAD_IND = @INDICE_CADASTRO">
        <SelectParameters>
            <asp:Parameter Name="INDICE_CADASTRO" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
