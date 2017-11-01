<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Holerite.Master" AutoEventWireup="true" CodeBehind="HoleriteFuncionario.aspx.cs" Inherits="AssecontNovo.HoleriteFunc.HoleriteFuncionario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Visualização de Recibo</title>
    <script src="../Jquery/Impressao/print.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <table>
        <tr>
            <td style="vertical-align: top; padding-right: 10px;">
                <div>
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
                        </Items>
                    </telerik:RadMenu>
                </div>
                <div class="divMenuTitle">
                    Ano
                </div>
                <div>
                    <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
                        Width="100%" OnItemClick="RadMenu1_ItemClick" OnPreRender="RadMenu1_PreRender">
                        <Items>
                            <telerik:RadMenuItem runat="server" Value="ano" Text="" />
                            <telerik:RadMenuItem runat="server" Value="anoAnterior" Text="" />
                        </Items>
                    </telerik:RadMenu>
                </div>
            </td>
            <td style="vertical-align: top;">
                <div id="sitecorpobox">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table style="width: 714px; margin-left: 18px;">
                                <tr>
                                    <td colspan="2" style="padding-bottom: 15px; border-bottom: 2px solid #E4E6E7;">
                                        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataHolerite" Width="100%">
                                            <ItemTemplate>
                                                <table style="width: 100%; vertical-align: top; font-size: 12pt;">
                                                    <tr>
                                                        <td><b>
                                                            <asp:Label ID="lbMesAno" runat="server" Font-Size="16pt" Text='<%# Wr.Classes.DateUtils.getMonthName(Convert.ToInt32(Request.QueryString["month"])) %>' />/
                                                    <asp:Label ID="lbAno" runat="server" Font-Size="14pt" Text='<%# Request.QueryString["year"] %>' /></b>
                                                        </td>
                                                        <td style="text-align: right; vertical-align: top;">Disponibilizado
                                                    <asp:Label ID="lbDataCriacao2" runat="server" Text='<%# Eval("SAL_DATA_CRIACAO", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="reciboTitulo" runat="server" CssClass="font_red" Font-Size="16pt" Text='<%#  Wr.Classes.Utils.GetDescription((AssecontNovo.Classes.Types.HoleritesTipos)Convert.ToInt32(Eval("SAL_HOLERITE_TIPO"))) %>' />
                                                        </td>
                                                        <td style="text-align: right; vertical-align: top;">Visualizado
                                                    <asp:Label ID="lbVisualizado2" runat="server" Text='<%# Eval("SAL_VISUALIZADO", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:FormView>
                                    </td>
                                </tr>
                                <tr>
                                    <td><span style="padding-left: 6px; padding-top: 20px; font-size: 14pt; vertical-align: bottom;">Selecione um recibo</span>
                                        <telerik:RadComboBox ID="comboboxRecibo" EmptyMessage="Selecione um Recibo" CausesValidation="false" AutoPostBack="true" Width="200"
                                            runat="server" Skin="flv" EnableEmbeddedSkins="false" OnPreRender="comboboxRecibo_PreRender" OnSelectedIndexChanged="comboboxRecibo_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                    </td>
                                    <td style="text-align: right; padding-top: 20px;">
                                        <asp:HyperLink ID="hyperImprimir" class="sitebutton" Font-Size="12pt" BackColor="#0086E7" onClick="JavaScript: imprimePanel('DivImpressao');" runat="server">Imprimir recibo</asp:HyperLink>
                                    </td>
                                </tr>
                            </table>

                            <div id="DivImpressao">
                                <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataHolerite"
                                    RepeatDirection="Vertical" RepeatLayout="Flow" HorizontalAlign="Center" ShowFooter="true" ShowHeader="False">
                                    <FooterStyle BorderStyle="None" />
                                    <HeaderStyle BorderStyle="None" />
                                    <ItemStyle BorderStyle="None" />
                                    <FooterTemplate>
                                        <div style="width: 714px; padding-top: 30px; margin-left: 20px; font-size: 14pt;">
                                            <% if (DataList1.Items.Count == 0) hyperImprimir.Visible = comboboxRecibo.Visible = false;  %>

                                            <%= DataList1.Items.Count == 0 ? "Nenhum recibo encontrado para este periodo." : "" %>
                                        </div>
                                    </FooterTemplate>
                                    <ItemTemplate>
                                        <div style='<%# Convert.ToInt32(Eval("SAL_QUEBRA")) == 1? "visibility: hidden": "" %>'>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Label ID="lbLinha" runat="server" Text="------------------------------------------------------------------------------------"></asp:Label>
                                        </div>
                                        <table style="width: 714px; font-family: Tahoma; font-size: 9px; border: 1px solid Black; border-collapse: collapse; margin: 5px 0px 0px 20px;"
                                            cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td>
                                                    <table style="width: 510px; height: 40px; padding-left: 2px; font-family: Tahoma; font-size: 9px;"
                                                        border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td>
                                                                <div align="center">
                                                                    <b>
                                                                        <asp:Label ID="Label63" runat="server" Text='<%# Eval("HOLERITE_TITULO") %>'></asp:Label></b>
                                                                </div>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("CLI_NUMERO", "{0:0000}") %>'></asp:Label>&nbsp;&nbsp;
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CLI_RAZAOSOCIAL") %>'></asp:Label>
                                                                <br />
                                                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("CLI_ENDERECO") %>'></asp:Label>&nbsp;&nbsp;
                                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("CLI_ENDERECO_NUMERO") %>'></asp:Label>
                                                                <br />
                                                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("CLI_ENDERECO_MUNICIPIO") %>'></asp:Label>&nbsp;
                                                        <asp:Label ID="Label6" runat="server" Text="- SP"></asp:Label>&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("CLI_ENDERECO_CEP", "{0:00.000-000}") %>'></asp:Label>&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="Label36" runat="server" Text='<%# Eval("CNPJ_CPF") %>'></asp:Label>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>
                                                    <table style="width: 196px; border-left: 1px solid Black; font-family: Tahoma; font-size: 9px;"
                                                        border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td style="width: 190px; border-bottom: 1px solid Black; height: 20px;">
                                                                <div>
                                                                    Competência
                                                                </div>
                                                                <div align="right">
                                                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("SAL_COMPETENCIA", "{0:MM/yyyy}") %>'></asp:Label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="height: 20px">
                                                                <div>
                                                                    Divisão R.H.
                                                                </div>
                                                                <div align="right">
                                                                    <asp:Label ID="Label10" runat="server" Text='<%# Eval("SAL_DIVISAO") %>'></asp:Label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="border: 1px solid Black;" colspan="2">
                                                    <table border="0" cellspacing="0" cellpadding="0" style="padding-left: 2px; font-family: Tahoma; font-size: 9px;">
                                                        <tr>
                                                            <td style="width: 132px; border-right: 1px solid Black;">
                                                                <div>
                                                                    Nº Reg.
                                                                </div>
                                                                <asp:Label ID="Label11" runat="server" Text='<%# Eval("FUNC_REG", "{0:00000}") %>'></asp:Label>
                                                            </td>
                                                            <td style="width: 380px; border-right: 1px solid Black;">
                                                                <div>
                                                                    Nome
                                                                </div>
                                                                <asp:Label ID="Label12" runat="server" Text='<%# Eval("FUNC_NOME") %>'></asp:Label>
                                                            </td>
                                                            <td style="width: 195px;">
                                                                <div>
                                                                    Função
                                                                </div>
                                                                <asp:Label ID="Label13" runat="server" Text='<%# Eval("SAL_FUNCAO") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="border-bottom: 1px solid Black;" colspan="2">
                                                    <table border="0" cellspacing="0" cellpadding="0" style="padding-left: 2px; font-family: Tahoma; font-size: 9px;">
                                                        <tr>
                                                            <td style="width: 131px; border-right: 1px solid Black;">
                                                                <div>
                                                                    CPF
                                                                </div>
                                                                <asp:Label ID="Label14" runat="server" Text='<%# String.Format(@"{0:000\.000\.000\-00}", Convert.ToDouble(Eval("FUNC_CPF")))%>'></asp:Label>
                                                            </td>
                                                            <td style="width: 150px; border-right: 1px solid Black;">
                                                                <div>
                                                                    Banco/AG
                                                                </div>
                                                                <asp:Label ID="Label15" runat="server" Text='<%# Eval("FUNC_BANCO") %>'></asp:Label>
                                                            </td>
                                                            <td style="width: 150px; border-right: 1px solid Black;">
                                                                <div>
                                                                    Conta Corrente
                                                                </div>
                                                                <asp:Label ID="Label21" runat="server" Text='<%# Eval("FUNC_CONTA") %>'></asp:Label>
                                                            </td>
                                                            <td>
                                                                <div>
                                                                    Creditado
                                                                </div>
                                                                <asp:Label ID="Label16" runat="server" Text='<%# Eval("SAL_CREDITO")%>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="border-bottom: 1px solid Black;" colspan="2">
                                                    <table border="0" cellspacing="0" cellpadding="0" style="font-family: Tahoma; font-size: 9px;">
                                                        <tr>
                                                            <td align="center" style="width: 32px; border-right: 1px solid Black;">
                                                                <div>
                                                                    Cód.
                                                                </div>
                                                            </td>
                                                            <td align="center" style="width: 284px; border-right: 1px solid Black;">
                                                                <div>
                                                                    Descrição
                                                                </div>
                                                            </td>
                                                            <td align="center" style="width: 80px; border-right: 1px solid Black;">
                                                                <div>
                                                                    Referência
                                                                </div>
                                                            </td>
                                                            <td align="center" style="width: 152px; border-right: 1px solid Black;">
                                                                <div>
                                                                    Vencimentos
                                                                </div>
                                                            </td>
                                                            <td align="center" style="width: 166px;">
                                                                <div>
                                                                    Descontos
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="border-bottom: 1px solid Black;" colspan="2">
                                                    <table border="0" cellspacing="0" cellpadding="0" style="font-family: Tahoma; font-size: 9px;">
                                                        <tr>
                                                            <td align="center" valign="top" style="width: 32px; height: 250px; border-right: 1px solid Black; padding-top: 2px;">
                                                                <asp:Label ID="Label22" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTOCODIGO").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                            </td>
                                                            <td valign="top" style="width: 287px; height: 250px; border-right: 1px solid Black; padding: 2px 0px 0px 5px;">
                                                                <asp:Label ID="Label23" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTODESCRICAO").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                            </td>
                                                            <td align="right" valign="top" style="width: 78px; height: 250px; border-right: 1px solid Black; padding: 2px 5px 0px 0px;">
                                                                <asp:Label ID="Label24" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTOREFERENCIA").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                            </td>
                                                            <td align="right" valign="top" style="width: 151px; height: 250px; border-right: 1px solid Black; padding: 2px 5px 0px 0px;">
                                                                <asp:Label ID="Label25" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTOVENCIMENTO").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                            </td>
                                                            <td align="right" valign="top" style="width: 166px; height: 250px; padding: 2px 5px 0px 0px;">
                                                                <asp:Label ID="Label26" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTODESCONTO").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="border-bottom: 1px solid Black;" colspan="2">
                                                    <table border="0" cellspacing="0" cellpadding="0" style="font-family: Tahoma; font-size: 9px;">
                                                        <tr>
                                                            <td style="width: 72px; border-right: 1px solid Black; padding-left: 5px;">
                                                                <b>Resumo do Salário</b>
                                                            </td>
                                                            <td style="width: 150px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                                <div align="center">
                                                                    Salário Base
                                                                </div>
                                                                <asp:Label ID="Label27" runat="server" Text='<%# Eval("SAL_BASE") %>'></asp:Label>
                                                            </td>
                                                            <td style="width: 160px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                                <div align="center">
                                                                    Salário Contribuição
                                                                </div>
                                                                <asp:Label ID="Label28" runat="server" Text='<%# Eval("SAL_CONTRIBUICAO") %>'></asp:Label>
                                                            </td>
                                                            <td style="width: 152px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                                <div align="center">
                                                                    Total de vecimentos
                                                                </div>
                                                                <asp:Label ID="Label29" runat="server" Text='<%# Eval("SAL_VENCIMENTOS") %>'></asp:Label>
                                                            </td>
                                                            <td style="width: 163px; padding-right: 5px;" align="right">
                                                                <div align="center">
                                                                    Total de descontos
                                                                </div>
                                                                <asp:Label ID="Label30" runat="server" Text='<%# Eval("SAL_DESCONTOS") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="border-bottom: 1px solid Black;" colspan="2">
                                                    <table border="0" cellspacing="0" cellpadding="0" style="font-family: Tahoma; font-size: 9px;">
                                                        <tr>
                                                            <td style="width: 134px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                                <div align="center">
                                                                    Base Cál. F.G.T.S
                                                                </div>
                                                                <asp:Label ID="Label31" runat="server" Text='<%# Eval("SAL_BASEFGTS") %>'></asp:Label>
                                                            </td>
                                                            <td style="width: 136px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                                <div align="center">
                                                                    F.G.T.S do Més
                                                                </div>
                                                                <asp:Label ID="Label32" runat="server" Text='<%# Eval("SAL_MESFGTS") %>'></asp:Label>
                                                            </td>
                                                            <td style="width: 138px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                                <div align="center">
                                                                    Base Cál. I.R.
                                                                </div>
                                                                <asp:Label ID="Label33" runat="server" Text='<%# Eval("SAL_BASECALIR") %>'></asp:Label>
                                                            </td>
                                                            <td style="width: 140px; border-right: 1px solid Black;" align="center">
                                                                <b>LÍQUIDO
                                                <div>
                                                    A RECEBER
                                                </div>
                                                                </b>
                                                            </td>
                                                            <td style="width: 166px; padding-right: 5px;" align="right">
                                                                <br />
                                                                <asp:Label ID="Label34" runat="server" Text='<%# Eval("SAL_LIQUIDO") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table border="0" cellspacing="0" cellpadding="0" style="font-family: Tahoma; height: 10px; font-size: 9px;">
                                                        <tr>
                                                            <td>
                                                                <div style="padding-left: 5px;">
                                                                    <asp:Label ID="Label35" runat="server" Text='<%# Eval("SAL_FRASE") %>'></asp:Label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <table style="width: 714px; height: 70px; font-family: Tahoma; font-size: 10px; border: 1px solid Black; border-collapse: collapse; margin: 12px 0px 5px 20px;"
                                            border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td colspan="2" align="center">DECLARO TER RECEBIDO A IMPORTÂNCIA LÍQUIDA DISCRIMINADA NESTE RECIBO
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"></td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 50px">
                                                    <b>RECIBO DISPONIBILIZADO EM: 
                                    <asp:Label ID="lbDATA" runat="server" Text='<%# Eval("SAL_DATA_CRIACAO", "{0:dd/MM/yyyy}") %>'></asp:Label></b>
                                                </td>
                                                <td style="padding-left: 180px">
                                                    <b>HOLERITE ELETRÔNICO</b>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataHolerite" runat="server" OnLoad="SqlData_Load" OnSelecting="SqlDataHolerite_Selecting" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
        SelectCommand="EXEC rs_holerite_gerar @FUNC_IND, @MES, @ANO, @SAL_HOLERITE_TIPO, 1">
        <SelectParameters>
            <asp:Parameter Name="FUNC_IND" Type="Int32" />
            <asp:Parameter Name="MES" Type="Int32" />
            <asp:Parameter Name="ANO" Type="Int32" />
            <asp:Parameter Name="SAL_HOLERITE_TIPO" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
