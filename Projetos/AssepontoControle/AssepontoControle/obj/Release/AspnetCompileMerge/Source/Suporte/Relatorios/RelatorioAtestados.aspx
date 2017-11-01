<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="RelatorioAtestados.aspx.cs" Inherits="Asseponto.Suporte.Relatorios.RelatorioAtestados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%" OnItemClick="RadMenu1_ItemClick" OnPreRender="RadMenu1_PreRender">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Janeiro" Value="1" />
                <telerik:RadMenuItem runat="server" Text="Fevereiro" Value="2" />
                <telerik:RadMenuItem runat="server" Text="Março" Value="3" />
                <telerik:RadMenuItem runat="server" Text="Abril" Value="4" />
                <telerik:RadMenuItem runat="server" Text="Maio" Value="5" />
                <telerik:RadMenuItem runat="server" Text="Junho" Value="6" />
                <telerik:RadMenuItem runat="server" Text="Julho" Value="7" />
                <telerik:RadMenuItem runat="server" Text="Agosto" Value="8" />
                <telerik:RadMenuItem runat="server" Text="Setembro" Value="9" />
                <telerik:RadMenuItem runat="server" Text="Outubro" Value="10" />
                <telerik:RadMenuItem runat="server" Text="Novembro" Value="11" />
                <telerik:RadMenuItem runat="server" Text="Dezembro" Value="12" />
                <telerik:RadMenuItem runat="server" Value="ano" Text="" />
                <telerik:RadMenuItem runat="server" Value="anoAnterior" Text="" />
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <table>
                <tr>
                    <td>
                        <wr:TextSearch ID="TextSearch1" runat="server" QueryStringField="filtronome"
                            QueryStringFieldFixed2="ind=1&ano" QueryStringValueFixed2="0" PostBackUrl="~/Suporte/Relatorios/RelatorioAtestados.aspx" />
                    </td>
                    <td style="text-align: right;">
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/48x48/Excel_ExcelML.png"
                            AlternateText="Exportar Assefin" OnClick="ImageButton_Click" />
                    </td>
                    <td style="text-align: right;">
                        <asp:ImageButton ID="ImageWorld" runat="server" ImageUrl="~/Images/48x48/Word.PNG"
                            AlternateText="Exportar" OnClick="ImageWorld_Click" />
                    </td>
                </tr>
            </table>

            <telerik:RadFormDecorator ID="QsfFromDecorator" runat="server" DecoratedControls="All" EnableRoundedCorners="false" />
            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="RadGrid1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManager>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

            <p>
                <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" Font-Size="12pt" DefaultMode="Edit">
                    <EditItemTemplate>
                        <asp:Label ID="lbMes" runat="server" ForeColor="#EF461D" Style="font-weight: 600" Text='<%# Asseponto.Classes.Utils.getMesAnoFormat(Convert.ToInt32(Request.QueryString["ind"]), Convert.ToInt32(Request.QueryString["ano"]))  %>'></asp:Label>
                        - 
                                    <asp:Label ID="lbqtdevidada" runat="server" Text='<%# "Enviados (" + Eval("QtdEnviada") + ")" %>'></asp:Label>
                    </EditItemTemplate>
                </asp:FormView>
            </p>

            <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataClientesAtestados"
                CellSpacing="0" GridLines="None" AllowPaging="True" PageSize="30" EditItemStyle-HorizontalAlign="Justify"
                GroupingSettings-CaseSensitive="false" AllowSorting="true" SortingSettings-EnableSkinSortStyles="false"
                EnableEmbeddedSkins="false" Skin="flv" PagerStyle-ShowPagerText="true" PagerTextFormat="{4} {5}">

                <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Clientes"></PagerStyle>

                <MasterTableView DataSourceID="SqlDataClientesAtestados" AllowPaging="true" AutoGenerateColumns="false"
                    ItemStyle-Height="50px" AlternatingItemStyle-Height="50px" DataKeyNames="CAD_IND"
                    AlternatingItemStyle-BackColor="#F7F7F7" AllowAutomaticUpdates="true">

                    <NoRecordsTemplate>Nenhum registro encontrado.</NoRecordsTemplate>
                    <Columns>

                        <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="Editar" EditImageUrl="~/Skins/Grid/Edit.gif">
                            <HeaderStyle Width="50px" />
                        </telerik:GridEditCommandColumn>

                        <telerik:GridTemplateColumn DataField="CAD_IND"
                            HeaderText="Empresa" SortExpression="CAD_IND" UniqueName="CAD_RAZAOSOCIAL">
                            <ItemTemplate>
                                <asp:HyperLink ID="lbRazaoSocial" runat="server" Target="_blank" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/Atendimento/Cliente.aspx?ind={0}") %>'><%# Eval("CAD_RAZAOSOCIAL")%></asp:HyperLink></b>
                                 <br />
                                <asp:Label ID="lbCNPJ" runat="server" Visible='<%# Eval("CAD_CNPJ") is DBNull ? false : true %>' Text='<%# "CNPJ: " + (Eval("CAD_CNPJ") is DBNull ? "" : String.Format(@"{0:00\.000\.000\/0000\-00}", Convert.ToDouble(Eval("CAD_CNPJ")))) %>'></asp:Label>
                                <asp:Label ID="lbCPF" runat="server" Visible='<%# Eval("CAD_CPF") is DBNull ? false : true  %>' Text='<%# "CPF: " + (Eval("CAD_CPF") is DBNull ? "" : String.Format(@"{0:000\.000\.000\-00}", Convert.ToDouble(Eval("CAD_CPF")))) %>'></asp:Label>
                                <br />
                                <asp:Label ID="lbRevenda" runat="server" Text='<%# "Revenda: " + Eval("REV_RAZAOSOCIAL") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="400px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="CAD_IMPRESSAO_CERTIFICADO" ItemStyle-Font-Size="11px" AllowFiltering="false"
                            HeaderText="Impressão" SortExpression="CAD_IMPRESSAO_CERTIFICADO" UniqueName="CAD_IMPRESSAO_CERTIFICADO">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkTest" runat="server" AutoPostBack="true" Checked='<%# Bind("CAD_IMPRESSAO_CERTIFICADO") %>' OnCheckedChanged="chkTest_CheckedChanged" />
                            </ItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="IM_INICIO" ItemStyle-Font-Size="11px" AllowFiltering="false"
                            HeaderText="Data do Pedido" SortExpression="IM_INICIO" UniqueName="IM_INICIO">
                            <ItemTemplate>
                                <asp:Label ID="lbPedido" runat="server" Text='<%# Eval("IM_INICIO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="CAD_DTA_CERTIFICADO" AllowFiltering="false"
                            HeaderText="Enviado" SortExpression="CAD_DTA_CERTIFICADO" UniqueName="CAD_DTA_CERTIFICADO">
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="RadPickerAtestado" runat="server" Culture="pt-BR"
                                    DbSelectedDate='<%# Bind("CAD_DTA_CERTIFICADO") %>' Skin="Wr" EnableEmbeddedSkins="false">
                                    <Calendar ID="Calendar1" runat="server" Skin="Wr" EnableEmbeddedSkins="false" UseColumnHeadersAsSelectors="False"
                                        UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                    </Calendar>
                                    <DateInput ID="DateInput1" runat="server" DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="">
                                    </DateInput>
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbAtestado" runat="server" ForeColor='<%# Eval("CAD_DTA_CERTIFICADO") is DBNull ? System.Drawing.Color.Red : System.Drawing.Color.Black %>' Text='<%# Eval("CAD_DTA_CERTIFICADO") is DBNull? "Não" : Eval("CAD_DTA_CERTIFICADO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="CAD_RAZAOSOCIAL" AllowFiltering="false"
                            HeaderText="Atestado" SortExpression="CAD_RAZAOSOCIAL" UniqueName="CAD_RAZAOSOCIAL">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperAtestado" runat="server" Target="_blank" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/Relatorios/Atestado.aspx?ind={0}") %>'><img src="../../Images/48x48/Agreement.png" width="35" /></asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                    </Columns>
                    <EditFormSettings>
                        <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"
                            CancelImageUrl="~/Skins/Grid/Cancel.gif" CancelText="Cancelar" EditImageUrl="~/Skins/Grid/Edit.gif"
                            EditText="Editar" UpdateText="Salvar">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataClientesAtestados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT IM_INICIO, CAD_CNPJ, CAD_CPF, CAD_RAZAOSOCIAL, CAD_REVENDA, CAD_IMPRESSAO_CERTIFICADO, REV_RAZAOSOCIAL, CAD_DTA_CERTIFICADO, CAD_IND  FROM AssepontoClientes
                       LEFT JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA
                       INNER JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND
                       WHERE (
                                ((@FILTRONOME = '*') AND MONTH(IM_INICIO) = @IND AND YEAR(IM_INICIO) = @ANO) OR
                                ((CAD_RAZAOSOCIAL LIKE '%' + @FILTRONOME + '%') AND @ANO = 0)
                             ) 
                             AND IM_ASSEPONTO4 = 1
                       ORDER BY IM_INICIO DESC"
        UpdateCommand="UPDATE AssepontoClientes SET [CAD_DTA_CERTIFICADO] = @CAD_DTA_CERTIFICADO WHERE [CAD_IND] = @CAD_IND">

        <SelectParameters>
            <asp:QueryStringParameter Name="IND" Type="Int32" QueryStringField="ind" />
            <asp:QueryStringParameter Name="ANO" Type="Int32" QueryStringField="ano" DefaultValue="0" />
            <asp:QueryStringParameter Name="FILTRONOME" DefaultValue="*" QueryStringField="filtronome" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CAD_RAZAOSOCIAL" Type="String" />
            <asp:Parameter Name="REV_RAZAOSOCIAL" Type="String" />
            <asp:Parameter Name="CAD_IND" Type="Int32" />
            <asp:Parameter Name="CAD_DTA_CERTIFICADO" Type="DateTime" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDatapedido" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT COUNT(CAD_IND) AS QtdPedido FROM AssepontoClientes
                       INNER JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND 
                       WHERE MONTH(IM_INICIO) = @ind AND YEAR(IM_INICIO) = @ano AND IM_ASSEPONTO4 = 1">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" Type="Int32" QueryStringField="ind" />
            <asp:QueryStringParameter Name="ano" Type="Int32" QueryStringField="ano" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT COUNT(CAD_IND) AS QtdEnviada FROM AssepontoClientes
                       INNER JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND AND IM_ASSEPONTO4 = 1
                       WHERE MONTH(IM_INICIO) = @ind AND YEAR(IM_INICIO) = @ano 
                        AND CAD_DTA_CERTIFICADO IS NOT NULL">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" Type="Int32" QueryStringField="ind" />
            <asp:QueryStringParameter Name="ano" Type="Int32" QueryStringField="ano" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
