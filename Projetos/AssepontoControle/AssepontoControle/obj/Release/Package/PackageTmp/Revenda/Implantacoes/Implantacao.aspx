<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true"
    CodeBehind="Implantacao.aspx.cs" Inherits="Asseponto.Revenda.Implantacoes.Implantacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Pendências" NavigateUrl="#">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="IM_IND" DataSourceID="sqlImplantacoes" DefaultMode="Edit">
                <EditItemTemplate>
                    <table class="formviewtable">
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Cliente</div>
                                <asp:Label ID="CAD_NOMELabel" runat="server" Text='<%# Eval("CAD_RAZAOSOCIAL") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">
                                                E-mail</div>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("CAD_EMAIL") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Contato</div>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("CAD_CONTATO") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Telefone</div>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("CAD_TELEFONE1") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">
                                                SKYPE/MSN</div>
                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("CAD_SKYPE") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Revenda</div>
                                <asp:Label ID="REV_RAZAOSOCIALLabel" runat="server" Text='<%# Eval("REV_RAZAOSOCIAL") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Data do Pedido</div>
                                <asp:Label ID="PED_DATALabel" runat="server" Text='<%# Eval("PED_DATA", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Data de Agendamento</div>
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("IM_DTAGENDA", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Versão</div>
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("VERS4_DESCRICAO") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Fabricante REP</div>
                                            <asp:Label ID="TextBox1" runat="server" Text='<%# Eval("FABR_NOME") %>' />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Modelo do REP</div>
                                            <asp:Label ID="IM_MODELOREPTextBox" runat="server" Text='<%# Eval("IM_MODELOREP") %>' />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Inicio</div>
                                            <asp:Label ID="IM_INICIOTextBox" runat="server" Text='<%# Eval("IM_INICIO", "{0:dd/MM/yyyy}") %>' />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Término</div>
                                            <asp:Label ID="TextBox2" runat="server" Text='<%# string.IsNullOrEmpty(Eval("IM_TERMINO").ToString()) ? "-" : Eval("IM_TERMINO")  %>' />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style='<%# String.IsNullOrEmpty(Eval("IM_OBS_PEDIDO").ToString()) ? "visibility: hidden": "" %>'>
                                    <div class="fieldviewcaption">
                                        Observações do Pedido</div>
                                    <asp:Label ID="IM_OBS_PEDIDOLabel" runat="server" Text='<%# Eval("IM_OBS_PEDIDO") %>'></asp:Label>
                                </div>
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
            </asp:FormView>
        </div>
    </div>
    <asp:SqlDataSource ID="sqlImplantacoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [REV_RAZAOSOCIAL], PED_DATA, IM_DTAGENDA, 
            [IM_TECNICO], VERS4_DESCRICAO, IM_INICIO, [IM_TERMINO], 
            dbo.fn_texttohtmltext(IM_OBS_PEDIDO) AS IM_OBS_PEDIDO, [IM_OBS], 
            [CAD_RAZAOSOCIAL], [CAD_EMAIL], [CAD_SKYPE], [CAD_TELEFONE1], [CAD_CONTATO], [FABR_NOME], [IM_MODELOREP], [IM_IND] 
            FROM [AssepontoImplantacoes]
            INNER JOIN AssepontoPedidosRevendas ON PED_IND = IM_PEDIDO 
            INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE 
            INNER JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA 
            LEFT JOIN Asseponto4Versoes ON VERS4_COD = IM_VERSAO
            INNER JOIN AssepontoRepFabricantes ON FABR_COD = IM_REP_FABRICANTE
            WHERE IM_IND = @IM_IND">
        <SelectParameters>
            <asp:QueryStringParameter Name="IM_IND" Type="Int32" QueryStringField="ind" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
