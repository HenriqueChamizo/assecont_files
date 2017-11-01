<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="QuestionarioSocioEmail.aspx.cs" Inherits="AssecontNovo.Questionarios.QuestionarioSocioEmail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section>
        <table>
            <tr>
                <td style="padding-bottom: 10px; padding-top: 10px; ">
                    <asp:Label ID="lbUltimoEnvio" Font-Size="16pt" runat="server" Text=""></asp:Label>
                </td>
            </tr>
        </table>
                <telerik:RadGrid ID="RadGridQuestionarioSocios" runat="server" DataSourceID="SqlData" Width="835" PagerStyle-AlwaysVisible="true"
                    CellSpacing="0" GridLines="None" AllowPaging="True" PageSize="50" SortingSettings-SortToolTip="Classificar de A-Z ou Z-A"
                    GroupingSettings-CaseSensitive="false" AllowSorting="true" SortingSettings-EnableSkinSortStyles="false"
                    EnableEmbeddedSkins="false" Skin="flv" PagerStyle-ShowPagerText="true" PagerTextFormat="{4} {5}">

                    <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Registros encontrados"></PagerStyle>

                    <MasterTableView DataSourceID="SqlData" AllowPaging="true" AutoGenerateColumns="false"
                        ItemStyle-Height="60px" AlternatingItemStyle-Height="60px" DataKeyNames="CLISOC_IND"
                        AlternatingItemStyle-BackColor="#F7F7F7" AllowAutomaticUpdates="true">

                        <NoRecordsTemplate>
                            Nenhum questionário encontrado.
                        </NoRecordsTemplate>

                        <Columns>
                            <telerik:GridTemplateColumn DataField="CLISOC_NOME" ShowSortIcon="true" HeaderText="Socio" SortExpression="CLISOC_NOME" UniqueName="CLISOC_NOME">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnSocioId" runat="server" Value='<%# Eval("CLISOC_IND") %>' />
                                    <asp:HyperLink ID="hyperSocio" runat="server" CssClass="font_lightBlue" Target="_blank" NavigateUrl='<%# string.Format("http://www.assecont.com.br/Assecontwebnovo/app/empresas/clientesocio.aspx?socio={0}&ind={1}",  Eval("CLISOC_IND"), Eval("CLISOC_CLIENTE")) %>' Text='<%# Eval("CLISOC_NOME")%>'> </asp:HyperLink>
                                    <br />
                                    <asp:Label ID="lbRazaoSocial" runat="server" Text='<%# Eval("CLI_RAZAOSOCIAL") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="lbCnpjCpf" runat="server" ForeColor="#5E5E5E" Text='<%# Eval("CNPJ_CPF") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle VerticalAlign="Top" />
                                <HeaderStyle Width="400px" />
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="CLISOC_EMAIL" ShowSortIcon="true" HeaderText="E-mail" SortExpression="CLISOC_EMAIL" UniqueName="CLISOC_EMAIL">
                                <ItemTemplate>
                                    <asp:Label ID="lbEmail" runat="server" Text='<%# Eval("CLISOC_EMAIL")  %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"  />
                                <HeaderStyle Width="200px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="DATAEMAIL" ShowSortIcon="true" HeaderText="2º Envio Em" SortExpression="DATAEMAIL" UniqueName="DATAEMAIL">
                                <ItemTemplate>
                                    <asp:Label ID="lbDataEnvio" runat="server" Text='<%# Eval("DATAEMAIL", "{0:dd/MM/yyyy}")  %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"  />
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="CLISOC_IND" HeaderText="Enviar" UniqueName="EMAIL" ShowSortIcon="false">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEnviarPesquisa" runat="server" OnClick="btnEnviarPesquisa_Click" CssClass="sitebuttonwhite">
                                        <asp:Image ID="Image2" runat="server" ImageUrl="~/Imagens/24x24/send_e-mail24x24.png" /> 
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <HeaderStyle Width="80px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>

  
    </section>

    <asp:SqlDataSource ID="SqlData" runat="server" OnLoad="SqlData_Load" OnSelecting="SqlData_Selecting"
        SelectCommand="SELECT CLISOC_NOME, CLI_RAZAOSOCIAL, CLISOC_EMAIL, CLISOC_TELEFONE, dbo.fn_cliente_cnpj_cpf(CLI_IND) AS CNPJ_CPF, CLISOC_QUESTIONARIO_ENVIADOEM AS DATAENVIO, CLISOC_EMAIL_QUESTIONARIO_ENVIADOEM AS DATAEMAIL, CLISOC_IND, CLISOC_CLIENTE 
                From ClientesSocios 
                INNER JOIN Clientes ON CLI_IND = CLISOC_CLIENTE
                WHERE CLISOC_QUESTIONARIO_RESPONDIDOEM IS NULL AND CLISOC_QUESTIONARIO_ENVIADOEM IS NOT NULL 
                ORDER BY CLISOC_NOME">
    </asp:SqlDataSource>
</asp:Content>
