<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="QuestionarioSocios.aspx.cs" Inherits="AssecontNovo.Questionarios.QuestionarioSocios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table style="width: 835px;">
                <tr id="lbResponderam" runat="server">
                    <td style="padding-bottom: 10px;">Responderam<br />
                        <telerik:RadComboBox ID="comboboxRespondidos" CausesValidation="false" Width="280" EmptyMessage="Selecione"
                            runat="server" Skin="flv" EnableEmbeddedSkins="false" AutoPostBack="true" OnSelectedIndexChanged="comboboxRespondidos_SelectedIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="Não" Value="0" />
                                <telerik:RadComboBoxItem Text="Sim" Value="1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="text-align: right">
                        <a id="btTotalizado" runat="server" href="QuestionarioSociosTotalizado.aspx" target="_blank" class="sitebutton blue">Relatório Questionário Totalizado</a>
                    </td>
                </tr>
                <tr id="lbDataCombo" runat="server">
                    <td colspan="2">Data<br />
                        <telerik:RadComboBox ID="comboboxDatas" CausesValidation="false" Width="280" EmptyMessage="Selecione" OnSelectedIndexChanged="comboboxDatas_SelectedIndexChanged"
                            runat="server" Skin="flv" EnableEmbeddedSkins="false" AutoPostBack="true">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="padding-bottom: 10px;">
                        <asp:Label ID="lbUltimoEnvio" Font-Size="16pt" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>

            <telerik:RadGrid ID="RadGridQuestionarioSocios" runat="server" DataSourceID="SqlData" Width="835" PagerStyle-AlwaysVisible="true"
                CellSpacing="0" GridLines="None" AllowPaging="True" PageSize="50" SortingSettings-SortToolTip="Classificar de A-Z ou Z-A"
                GroupingSettings-CaseSensitive="false" AllowSorting="true" SortingSettings-EnableSkinSortStyles="false"
                EnableEmbeddedSkins="false" Skin="flv" PagerStyle-ShowPagerText="true" pagertextformat="{4} {5}">

                <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Registros encontrados"></PagerStyle>

                <MasterTableView DataSourceID="SqlData" AllowPaging="true" AutoGenerateColumns="false"
                    ItemStyle-Height="40px" AlternatingItemStyle-Height="40px" DataKeyNames="CLISOC_IND"
                    AlternatingItemStyle-BackColor="#F7F7F7" AllowAutomaticUpdates="true" NoMasterRecordsText="Nenhum registro encontrado">

                    <NoRecordsTemplate>
                        Nenhum questionário encontrado.
                    </NoRecordsTemplate>

                    <Columns>
                        <telerik:GridTemplateColumn DataField="CLISOC_NOME" ShowSortIcon="true" HeaderText="Socio" SortExpression="CLISOC_NOME" UniqueName="CLISOC_NOME">
                            <ItemTemplate>
                                <asp:HyperLink ID="hyperSocio" runat="server" CssClass="font_lightBlue" Target="_blank" NavigateUrl='<%# string.Format("http://www.assecont.com.br/Assecontwebnovo/app/empresas/clientesocio.aspx?socio={0}&ind={1}",  Eval("CLISOC_IND"), Eval("CLISOC_CLIENTE")) %>' Text='<%# Eval("CLISOC_NOME")%>'> </asp:HyperLink>
                                <br />
                                <asp:Label ID="lbRazaoSocial" runat="server" Text='<%# Eval("CLI_RAZAOSOCIAL") %>'></asp:Label>
                                <br />
                                <asp:Label ID="lbCnpjCpf" runat="server" ForeColor="#5E5E5E" Text='<%# Eval("CNPJ_CPF") %>'></asp:Label>
                                <br />
                            </ItemTemplate>
                            <HeaderStyle Width="350px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="DATARESPOSTA" ShowSortIcon="true" HeaderText="Respondido em" SortExpression="DATARESPOSTA" UniqueName="DATARESPOSTA">
                            <ItemTemplate>
                                <asp:Label ID="lbData" runat="server" Text='<%# Eval("DATARESPOSTA", "{0:dd/MM/yyyy}")  %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="CLISOC_IND" HeaderText="Abrir" UniqueName="CLISOC_IND" ShowSortIcon="false">
                            <ItemTemplate>
                                <%--<asp:HyperLink ID="HyperArquivo1" runat="server" Target="_blank" NavigateUrl='<%# string.Format("~/pesquisas/pesquisaSatisfacao.aspx?I={0}", (new Wr.Classes.Crypto()).Encrypt(Eval("QUERESDADOS_IND").ToString())) %>'>
                                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Imagens/24x24/Open24x24.png" />
                                </asp:HyperLink>--%>
                                <asp:HyperLink ID="HyperArquivo2" runat="server" Target="_blank" NavigateUrl='<%# string.Format("~/pesquisas/pesquisaSatisfacao.aspx?v=Fu04k4eCM+vLX2Wb5GXUejTdtH/0142cWYoHJ2iizOw=&I={0}&D={1}", (new Wr.Classes.Crypto()).Encrypt(Eval("CLISOC_IND").ToString()), Eval("DATARESPOSTA",  "{0:dd/MM/yyyy}")) %>'>
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagens/24x24/Open24x24.png" />
                                </asp:HyperLink>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>

            <telerik:RadGrid ID="RadGridNaoResponderam" runat="server" DataSourceID="SqlData" Width="860" PagerStyle-AlwaysVisible="true"
                CellSpacing="0" GridLines="None" AllowPaging="True" PageSize="50" SortingSettings-SortToolTip="Classificar de A-Z ou Z-A"
                GroupingSettings-CaseSensitive="false" AllowSorting="true" SortingSettings-EnableSkinSortStyles="false"
                EnableEmbeddedSkins="false" Skin="flv" PagerStyle-ShowPagerText="true" pagertextformat="{4} {5}" nomasterrecordstext="Nenhum registro encontrado">

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
                                <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="true" CssClass="font_lightBlue" Target="_blank" NavigateUrl='<%# string.Format("http://www.assecont.com.br/Assecontwebnovo/app/empresas/clientesocio.aspx?socio={0}&ind={1}",  Eval("CLISOC_IND"), Eval("CLISOC_CLIENTE")) %>' Text='<%# Eval("CLISOC_NOME")%>'> </asp:HyperLink>
                                <br />
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("CLI_RAZAOSOCIAL") %>'></asp:Label>
                                <br />
                                <asp:Label ID="Label2" runat="server" ForeColor="#5E5E5E" Text='<%# Eval("CNPJ_CPF") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle VerticalAlign="Top" />
                            <HeaderStyle Width="420px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="CLISOC_EMAIL" ShowSortIcon="true" HeaderText="Dados" SortExpression="CLISOC_EMAIL" UniqueName="CLISOC_EMAIL">
                            <ItemTemplate>
                                <asp:Label ID="lbTelefone" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("CLISOC_TELEFONE").ToString())  %>' Text='<%# "TELEFONE " + Eval("CLISOC_TELEFONE")  %>'></asp:Label><br />
                                <asp:Label ID="lbEmail" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("CLISOC_EMAIL").ToString())  %>' Text='<%# Eval("CLISOC_EMAIL")  %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle VerticalAlign="Bottom" HorizontalAlign="Left" />
                            <HeaderStyle Width="300px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="DATAEMAIL" ShowSortIcon="true" HeaderText="2º Envio Em" SortExpression="DATAEMAIL" UniqueName="DATAEMAIL">
                            <ItemTemplate>
                                <asp:Image ID="imgEnvio_OK" runat="server" ImageUrl="~/Imagens/16x16/TickVerde.png" Visible='<%#  string.IsNullOrEmpty(Eval("DATAEMAIL").ToString()) ? false : true %>' />
                                <asp:Label ID="lbDataEnvio" runat="server" Text='<%# Eval("DATAEMAIL", "{0:dd/MM/yyyy HH:mm}")  %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <HeaderStyle Width="200px" />
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

            <asp:SqlDataSource ID="SqlData" runat="server" OnLoad="SqlData_Load" OnSelecting="SqlData_Selecting"
                SelectCommand="SELECT CLISOC_NOME, CLI_RAZAOSOCIAL, CLISOC_EMAIL, CLISOC_TELEFONE, dbo.fn_cliente_cnpj_cpf(CLI_IND) AS CNPJ_CPF, 
                        CLISOC_EMAIL_QUESTIONARIO_ENVIADOEM AS DATAEMAIL, QUERESDADOS_IND, QUERESDADOS_DATA AS DATARESPOSTA, CLISOC_IND, CLISOC_CLIENTE 
                        FROM ClientesSocios 
                        INNER JOIN Clientes ON CLI_IND = CLISOC_CLIENTE
                        LEFT JOIN QuestionariosRespostasDados ON CLISOC_IND = QUERESDADOS_SOCIO 
                        WHERE CLISOC_QUESTIONARIO_ENVIADOEM IS NOT NULL  AND CLI_TESTE = 0 AND
                        ( (@RESPONDERAM = 0 AND QUERESDADOS_DATA IS NULL AND CLI_DESLIGAMENTO IS NULL) OR (@RESPONDERAM = 1 
                        AND CONVERT(DATE, QUERESDADOS_DATA) &gt;= @DATAINICIAL AND CONVERT(DATE, QUERESDADOS_DATA) &lt;= @DATAFINAL))
                       
                        ORDER BY CLISOC_NOME ">
                <SelectParameters>
                    <asp:Parameter Name="RESPONDERAM" Type="Int32" DefaultValue="0" />
                    <asp:Parameter Name="DATAINICIAL" Type="DateTime" />
                    <asp:Parameter Name="DATAFINAL" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
