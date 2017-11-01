<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="listarInformativos.aspx.cs" Inherits="Assecont2.Informativos.listarInformativos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section id="ContentText">

        <p>
            <asp:HyperLink ID="HyperNovo" runat="server" NavigateUrl="http://www.assecont.com.br/assecont/informativos/criarInformativo.aspx" CssClass="sitebutton blue">
            Novo Informativo <img src="../Imagens/24x24/manual24x24.png" /></asp:HyperLink>
        </p>
        <telerik:RadGrid ID="RadGridInformativos" runat="server" DataSourceID="SqlData"
            EditItemStyle-HorizontalAlign="Justify" AllowPaging="True" CellSpacing="0" GridLines="None"
            Skin="flv" EnableEmbeddedSkins="false" AutoGenerateColumns="False" Width="780"
            AllowAutomaticUpdates="true">

            <MasterTableView DataSourceID="SqlData"
                DataKeyNames="INF_IND" ItemStyle-Height="40px" AlternatingItemStyle-Height="40px">

                <Columns>
                    <telerik:GridTemplateColumn DataField="INF_IND"
                        HeaderText="Informativo" SortExpression="INF_IND" UniqueName="INF_IND">
                        <ItemTemplate>
                            <asp:Label ID="lbNumero" runat="server" Text='<%# "Nº: " + Eval("INF_NUMERO") + "<br />Data " + Eval("INF_DATA", "{0:dd/MM/yyyy}") %>'></asp:Label><br />
                        </ItemTemplate>
                        <HeaderStyle Width="200px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="INF_TITULO"
                        HeaderText="Titulo" SortExpression="INF_TITULO" UniqueName="INF_TITULO">
                        <ItemTemplate>
                            <asp:Label ID="lbTitulo" runat="server" Text='<%# Eval("INF_TITULO")  %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="450px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="INF_NUMERO"
                        HeaderText="Abrir" SortExpression="INF_NUMERO" UniqueName="INF_NUMERO">
                        <ItemTemplate>
                            <asp:HyperLink ID="hyperUrl" runat="server" NavigateUrl='<%# Eval("INF_NUMERO", "~/Informativos/Informativo.aspx?ind={0}") %>'>  <img src="../Imagens/24x24/Open24x24.png" /></asp:LinkButton> </asp:HyperLink>
                        </ItemTemplate>
                        <HeaderStyle Width="80px" />
                    </telerik:GridTemplateColumn>

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </section>
    <asp:SqlDataSource ID="SqlData" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT * FROM Informativos WHERE INF_ATIVO = 1 ORDER BY INF_NUMERO DESC"></asp:SqlDataSource>

</asp:Content>
