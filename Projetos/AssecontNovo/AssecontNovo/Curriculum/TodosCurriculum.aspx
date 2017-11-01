<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="TodosCurriculum.aspx.cs" Inherits="AssecontNovo.Curriculum.TodosCurriculum" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section id="ContentText">
        <telerik:RadGrid ID="RadGridInformativos" runat="server" DataSourceID="SqlData"
            EditItemStyle-HorizontalAlign="Justify" AllowPaging="True" CellSpacing="0" GridLines="None"
            Skin="flv" EnableEmbeddedSkins="false" AutoGenerateColumns="False" Width="920" PageSize="15"
            AllowAutomaticUpdates="true" PagerTextFormat="{4} {5}" PagerStyle-ShowPagerText="false">

            <PagerStyle Mode="NumericPages"></PagerStyle>

            <MasterTableView DataSourceID="SqlData"
                DataKeyNames="CUR_IND" ItemStyle-Height="40px" AlternatingItemStyle-Height="40px">

                <Columns>
                    <telerik:GridTemplateColumn DataField="CUR_ATIVO"
                        HeaderText="Desativar" SortExpression="CUR_ATIVO" UniqueName="CUR_ATIVO">
                        <ItemTemplate> 
                            <asp:CheckBox ID="chkAtivo" runat="server" AutoPostBack="true" Checked='<%# Bind("CUR_ATIVO") %>' OnCheckedChanged="chkTest_CheckedChanged" />
                        </ItemTemplate>
                        <HeaderStyle Width="80px" />
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="CUR_OBJETIVO"
                        HeaderText="Dados Pessoais" SortExpression="CUR_OBJETIVO" UniqueName="CUR_OBJETIVO">
                        <ItemTemplate>
                            <asp:Label ID="lbNome" runat="server" Font-Size="12pt" Style="text-shadow: 0 0 0; text-transform: uppercase;" Text='<%# Eval("CUR_NOME") %>'></asp:Label><br />
                            <asp:Label ID="lbSexo" runat="server" Text='<%# Convert.ToBoolean(Eval("CUR_SEXO")) ? "Homem" : "Mulher"  %>'></asp:Label><br />
                            Bairro:
                            <asp:Label ID="lbBairro" runat="server" Text='<%# Eval("CUR_BAIRRO")  %>'></asp:Label>
                            / 
                            <asp:Label ID="lbZona" runat="server" Text='<%# "Zona " + Eval("CUR_ZONA")  %>'></asp:Label>
                            <br />
                            Telefone:
                            <asp:Label ID="lbTelefone" runat="server" Text='<%# Eval("CUR_TELEFONE")  %>'></asp:Label>
                            <asp:Label ID="lbCelular" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("CUR_CELULAR").ToString()) %>' Text='<%# " <br />Celular: " + Eval("CUR_CELULAR") %>'></asp:Label>
                            <br />
                            E-mail:
                            <asp:Label ID="lbEmail" runat="server" Text='<%# Eval("CUR_EMAIL")  %>'></asp:Label><br />
                        </ItemTemplate>
                        <HeaderStyle Width="500px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="CUR_NOME"
                        HeaderText="Objetivo" SortExpression="CUR_NOME" UniqueName="INF_IND">
                        <ItemTemplate>
                            <asp:Label ID="lbObjetivo" Font-Size="12pt" runat="server" Text='<%# Eval("CUR_OBJETIVO")  %>'></asp:Label><br />
                            <asp:Label ID="lbSalario" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("CUR_SALARIO").ToString()) %>' Text='<%# " <br />Salário Pretendido: " + Eval("CUR_SALARIO") %>'></asp:Label><br />
                            Curriculum disponibilizado em
                            <asp:Label ID="lbDisponivel" runat="server" Text='<%# Eval("CUR_DISPONIVEL", "{0:dd/MM/yyyy HH:mm}") %>'> </asp:Label>
                            <br />
                        </ItemTemplate>
                        <HeaderStyle Width="420px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="CUR_IND"
                        HeaderText="Abrir" SortExpression="CUR_IND" UniqueName="CUR_IND">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperArquivo" runat="server" NavigateUrl='<%# Eval("CUR_IND", "~/Curriculum/ViewCurriculum.aspx?ind={0}") %>'>
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagens/24x24/Open24x24.png" />
                            </asp:HyperLink>
                        </ItemTemplate>
                        <HeaderStyle Width="80px" />
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridTemplateColumn>

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </section>
    <asp:SqlDataSource ID="SqlData" runat="server" OnLoad="SqlData_Load" 
        SelectCommand="SELECT * FROM Curriculum WHERE CUR_ATIVO = 1 ORDER BY CUR_DISPONIVEL DESC"></asp:SqlDataSource>
</asp:Content>
