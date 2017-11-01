<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="QuestionarioObrigacao.aspx.cs" Inherits="AssecontNovo.Pesquisas.QuestionarioObrigacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">

    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>

            <table style="width: 835px; padding-bottom: 20px;">
                <tr>
                    <td>Setor
                        <br />
                        <telerik:RadComboBox ID="comboboxSetor" CausesValidation="false" Width="280" EmptyMessage="Selecione" OnSelectedIndexChanged="combobox_SelectedIndexChanged"
                            runat="server" Skin="flv" EnableEmbeddedSkins="false" AutoPostBack="true" OnLoad="comboboxDatas_Load">
                        </telerik:RadComboBox>
                    </td>
          <%--          <td style="text-align: right">
                        <a id="btTotalizado" runat="server" href="QuestionarioSociosTotalizado.aspx" target="_blank" class="sitebutton blue">Relatório Questionário Totalizado</a>
                    </td>--%>
                </tr>
            </table>
            <telerik:RadGrid ID="RadGridQuestionarioDepartamento" runat="server" DataSourceID="SqlData" Width="780"
                CellSpacing="0" GridLines="None" AllowPaging="True" PageSize="30" SortingSettings-SortToolTip="Classificar de A-Z ou Z-A"
                GroupingSettings-CaseSensitive="false" AllowSorting="true" SortingSettings-EnableSkinSortStyles="false"
                EnableEmbeddedSkins="false" Skin="flv" PagerStyle-ShowPagerText="true" pagertextformat="{4} {5}">

                <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Registros encontrados"></PagerStyle>

                <MasterTableView DataSourceID="SqlData" AllowPaging="true" AutoGenerateColumns="false"
                    ItemStyle-Height="40px" AlternatingItemStyle-Height="40px" DataKeyNames="QUERESDADOS_IND"
                    AlternatingItemStyle-BackColor="#F7F7F7" AllowAutomaticUpdates="true" NoMasterRecordsText="Nenhum registro encontrado">

                    <Columns>
                        <telerik:GridTemplateColumn DataField="LOGE_NOME" ShowSortIcon="true" HeaderText="Empresa" SortExpression="LOGE_NOME" UniqueName="LOGE_NOME">
                            <ItemTemplate>
                                <asp:Label ID="lbRazaoSocial" runat="server" Font-Size="14pt" Text='<%# Eval("CLI_RAZAOSOCIAL")  %>'></asp:Label><br />
                                <asp:Label ID="lbData" runat="server" Text='<%# "Respodindo em " + Eval("QUERESDADOS_DATA", "{0:dd/MM/yyyy}")  %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="350px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="Nota" ShowSortIcon="true" HeaderText="Nota" SortExpression="Nota" UniqueName="Nota">
                            <ItemTemplate>
                                <asp:Label ID="lbNota" runat="server" Font-Bold="true" Font-Size="20pt" ForeColor='<%# Convert.ToInt32(Eval("Nota")) >= 75 ? System.Drawing.ColorTranslator.FromHtml("#009EFF") : Convert.ToInt32(Eval("Nota")) >= 25 ? System.Drawing.Color.Orange : System.Drawing.Color.Red %>' Text='<%# Eval("Nota") + " %" %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="QUERESDADOS_IND" HeaderText="Abrir" UniqueName="QUERESDADOS_IND" ShowSortIcon="false">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperArquivo" runat="server" Target="_blank" NavigateUrl='<%# string.Format("~/pesquisas/pesquisaDepto.aspx?v=Fu04k4eCM+vLX2Wb5GXUejTdtH/0142cWYoHJ2iizOw=&I={0}", (new Wr.Classes.Crypto()).Encrypt(Eval("QUERESDADOS_IND").ToString()) ) %>'>
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagens/24x24/Open24x24.png" />
                                </asp:HyperLink>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="80px" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>

        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="SqlData" runat="server" OnLoad="SqlData_Load" OnSelecting="SqlData_Selecting"
        SelectCommand="SET DATEFORMAT DMY EXEC dbo.rs_questionario_obrigacoes @P_DATA_INICIAL = '01/08/2015', @P_DATA_FINAL = '01/10/2017', @P_SETOR = @SETOR">
        <SelectParameters>
            <asp:Parameter Name="SETOR" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

