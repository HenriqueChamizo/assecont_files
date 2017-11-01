<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AssecontNovo.Grupo.ImpostoIbit._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section id="SectiontWebsit" runat="server" style="margin: 0px auto; width: 1030px; min-height: 330px; padding-bottom: 50px;">
        <section>
            <h3>Lista de Mercadorias Sujeitas à Substituição Tributária</h3>
        </section>

        <section>
            <asp:Panel ID="Panel1" runat="server" DefaultButton="lkBuscar">
                <table>
                    <tr>
                        <td valign="top" style="width: 90px;">Código NCM:
                        </td>
                        <td valign="top">
                            <asp:TextBox ID="txtNCM" runat="server" MaxLength="4"></asp:TextBox>
                            <br />
                            Fonte : <a href="http://deolhonoimposto.ibpt.org.br/">IBPT</a>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">ATENÇÃO: Digite somente os 4 primeiros dígitos da NCM da mercadoria.
                            <br />
                            Por exemplo, se a classificação fiscal do seu produto é 6506.10.00, digite 6506.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <br />
                            <asp:LinkButton ID="lkBuscar" runat="server" OnClick="lkBuscar_Click" CssClass="sitebutton blue">Localizar
                            <img src="../../Imagens/24x24/OpenWhite24x24.png" />
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <br />
            <telerik:RadGrid ID="RadGridMensal" DataSourceID="SqlDataTabelaNCM" runat="server" Skin="flv" PagerStyle-AlwaysVisible="true"
                EnableEmbeddedSkins="false" AllowSorting="false" Width="860" AllowMultiRowSelection="False" AllowPaging="false" PagerStyle-ShowPagerText="true"
                ShowGroupPanel="false" AutoGenerateColumns="False" GridLines="none" PagerTextFormat="{4} {5}" ItemStyle-Height="32px" AlternatingItemStyle-Height="32px">

                <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Registros encontrados"></PagerStyle>

                <MasterTableView Width="800" ExpandCollapseColumn-Visible="false" NoMasterRecordsText="Nenhum Registro" DataSourceID="SqlDataTabelaNCM" DataKeyNames="NCM_IND">
                    <Columns>
                        <telerik:GridTemplateColumn DataField="NCM_NUMERO" HeaderText="NCM">
                            <ItemTemplate>
                                <asp:Label ID="lbNcmNUmero" runat="server" Font-Bold='<%# Eval("NCM_NUMERO").ToString().Trim().Length == 5 ? true : false %>' Text='<%# Eval("NCM_NUMERO") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="NCM_DESCRICAO" HeaderText="DESCRICAO">
                            <ItemTemplate>
                                <asp:Label ID="lbNcmDescricao" runat="server" Font-Bold='<%# Eval("NCM_NUMERO").ToString().Trim().Length == 5 ? true : false %>' Text='<%# Eval("NCM_DESCRICAO") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="NCM_ALIQUOTA_IMP" HeaderText="ALIQUOTA IBPT">
                            <ItemTemplate>
                                <asp:Label ID="lbNcmAliqImp" runat="server" Text='<%# Eval("NCM_ALIQUOTA_IMP") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>

            <asp:SqlDataSource ID="SqlDataTabelaNCM" runat="server" OnLoad="SqlData_Load"
                SelectCommand="SELECT * FROM TabelaNCM WHERE cast(SUBSTRING(REPLACE(NCM_NUMERO, '.', ''),0,5) as int) = cast(@NCM_NUMERO as int) ORDER BY NCM_IND ">
                <SelectParameters>
                    <asp:QueryStringParameter Name="NCM_NUMERO" Type="String" QueryStringField="NCM" />
                </SelectParameters>
            </asp:SqlDataSource>
        </section>
    </section>
</asp:Content>
