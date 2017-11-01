<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/HoleriteCliente.Master" CodeBehind="defaultCli.aspx.cs" Inherits="AssecontNovo.Holerite.defaultCli" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Visualização de Relatório</title>
    <script language="javascript" type="text/jscript">
        function imprimePanel(elementId) {
            var printContent = document.getElementById(elementId);
            var windowUrl = 'about:blank';
            var uniqueName = new Date();
            var windowName = 'Print' + uniqueName.getTime();
            var printWindow = window.open(windowUrl, windowName, 'left=50000,top=50000, width=0,height=0');
            printWindow.document.write(printContent.innerHTML);
            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            printWindow.close();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <table>
        <tr>
            <td valign="top">
                <asp:TreeView ID="TreeView1" runat="server" NodeIndent="10" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged" ShowExpandCollapse="False">
                    <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                    <Nodes>
                        <asp:TreeNode Text="Janeiro" Value="1"></asp:TreeNode>
                        <asp:TreeNode Text="Fevereiro" Value="2"></asp:TreeNode>
                        <asp:TreeNode Text="Março" Value="3"></asp:TreeNode>
                        <asp:TreeNode Text="Abril" Value="4"></asp:TreeNode>
                        <asp:TreeNode Text="Maio" Value="5"></asp:TreeNode>
                        <asp:TreeNode Text="Junho" Value="6"></asp:TreeNode>
                        <asp:TreeNode Text="Julho" Value="7"></asp:TreeNode>
                        <asp:TreeNode Text="Agosto" Value="8"></asp:TreeNode>
                        <asp:TreeNode Text="Setembro" Value="9"></asp:TreeNode>
                        <asp:TreeNode Text="Outubro" Value="10"></asp:TreeNode>
                        <asp:TreeNode Text="Novembro" Value="11"></asp:TreeNode>
                        <asp:TreeNode Text="Dezembro" Value="12"></asp:TreeNode>
                        <asp:TreeNode Value="Ano"></asp:TreeNode>
                        <asp:TreeNode Value="AnoAnterior"></asp:TreeNode>
                        <asp:TreeNode Value="Funcionário" Text="Holerite Individual"></asp:TreeNode>
                    </Nodes>
                    <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="0px" NodeSpacing="0px" VerticalPadding="0px" />
                    <ParentNodeStyle Font-Bold="False" />
                    <SelectedNodeStyle CssClass="TreeViewNode" Font-Underline="True" HorizontalPadding="0px" VerticalPadding="0px" ForeColor="#5555DD"></SelectedNodeStyle>
                </asp:TreeView>
            </td>
            <td valign="top">
                <div id="sitecorpobox">
                    <table style="width: 714px; margin-left: 20px; font-family: Calibri; font-size: 14px;">
                        <tr>
                            <td><b>
                                <asp:Label ID="lbIE9" runat="server" Text="Melhor Visualizado no Internet Explore 9"></asp:Label>
                                <br />
                                <asp:Label ID="lbImpre" runat="server" Text="Impressão Ajustada para folha A4"></asp:Label>
                            </b>
                            </td>
                            <td style="text-align: right;">
                                <asp:Label ID="lbDataCriacao" runat="server"></asp:Label>
                                <br />
                                <asp:Label ID="lbVisualizado" runat="server"></asp:Label>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="button" value="Imprimir Holerites" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebutton" />
                            </td>
                        </tr>
                    </table>
                    <div id="DivImpressao">
                        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataHolerite" DataKeyNames="FUNC_IND"
                            RepeatDirection="Vertical" RepeatLayout="Flow" HorizontalAlign="Center" ShowFooter="False" ShowHeader="False">
                            <EditItemStyle BorderStyle="None" />
                            <ItemStyle BorderStyle="None" />
                            <ItemTemplate>
                                <br />
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
                                                                <asp:Label ID="Label37" runat="server" Text='<%# Eval("HOLERITE_TITULO") %>'></asp:Label></b>
                                                        </div>
                                                        <asp:Label ID="Label16" runat="server" Text='<%# Eval("CLI_NUMERO", "{0:0000}") %>'></asp:Label>&nbsp;&nbsp;
                                                                    <asp:Label ID="Label17" runat="server" Text='<%# Eval("CLI_RAZAOSOCIAL") %>'></asp:Label>
                                                        <br />
                                                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("CLI_ENDERECO") %>'></asp:Label>&nbsp;&nbsp;
                                                                     <asp:Label ID="Label4" runat="server" Text='<%# Eval("CLI_ENDERECO_NUMERO") %>'></asp:Label>
                                                        <br />
                                                        <asp:Label ID="Label18" runat="server" Text='<%# Eval("CLI_ENDERECO_MUNICIPIO") %>'></asp:Label>&nbsp;
                                                                    <asp:Label ID="Label19" runat="server" Text="- SP"></asp:Label>&nbsp;&nbsp;&nbsp;
                                                                    <asp:Label ID="Label20" runat="server" Text='<%# Eval("CLI_ENDERECO_CEP", "{0:00.000-000}") %>'></asp:Label>&nbsp;&nbsp;&nbsp;
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
                                                            <asp:Label ID="Label39" runat="server" Text='<%# Eval("SAL_COMPETENCIA", "{0:MM/yyyy}") %>'></asp:Label>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 20px">
                                                        <div>
                                                            Divisão R.H.
                                                        </div>
                                                        <div align="right">
                                                            <asp:Label ID="Label40" runat="server" Text='<%# Eval("SAL_DIVISAO") %>'></asp:Label>
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
                                                        <asp:Label ID="Label41" runat="server" Text='<%# Eval("FUNC_REG", "{0:00000}") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 380px; border-right: 1px solid Black;">
                                                        <div>
                                                            Nome
                                                        </div>
                                                        <asp:Label ID="Label42" runat="server" Text='<%# Eval("FUNC_NOME") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 195px;">
                                                        <div>
                                                            Função
                                                        </div>
                                                        <asp:Label ID="Label43" runat="server" Text='<%# Eval("SAL_FUNCAO") %>'></asp:Label>
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
                                                        <asp:Label ID="Label44" runat="server" Text='<%# String.Format(@"{0:000\.000\.000\-00}", Convert.ToDouble(Eval("FUNC_CPF")))%>'></asp:Label>
                                                    </td>
                                                    <td style="width: 150px; border-right: 1px solid Black;">
                                                        <div>
                                                            Banco/AG
                                                        </div>
                                                        <asp:Label ID="Label45" runat="server" Text='<%# Eval("FUNC_BANCO") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 150px; border-right: 1px solid Black;">
                                                        <div>
                                                            Conta Corrente
                                                        </div>
                                                        <asp:Label ID="Label46" runat="server" Text='<%# Eval("FUNC_CONTA") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            Creditado
                                                        </div>
                                                        <asp:Label ID="Label61" runat="server" Text='<%# Eval("SAL_CREDITO")%>'></asp:Label>
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
                                                        <asp:Label ID="Label47" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTOCODIGO").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                    </td>
                                                    <td valign="top" style="width: 287px; height: 250px; border-right: 1px solid Black; padding: 2px 0px 0px 5px;">
                                                        <asp:Label ID="Label48" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTODESCRICAO").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                    </td>
                                                    <td align="right" valign="top" style="width: 78px; height: 250px; border-right: 1px solid Black; padding: 2px 5px 0px 0px;">
                                                        <asp:Label ID="Label49" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTOREFERENCIA").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                    </td>
                                                    <td align="right" valign="top" style="width: 151px; height: 250px; border-right: 1px solid Black; padding: 2px 5px 0px 0px;">
                                                        <asp:Label ID="Label50" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTOVENCIMENTO").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                    </td>
                                                    <td align="right" valign="top" style="width: 166px; height: 250px; padding: 2px 5px 0px 0px;">
                                                        <asp:Label ID="Label51" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTODESCONTO").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
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
                                                        <asp:Label ID="Label52" runat="server" Text='<%# Eval("SAL_BASE") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 160px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                        <div align="center">
                                                            Salário Contribuição
                                                        </div>
                                                        <asp:Label ID="Label53" runat="server" Text='<%# Eval("SAL_CONTRIBUICAO") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 152px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                        <div align="center">
                                                            Total de vecimentos
                                                        </div>
                                                        <asp:Label ID="Label54" runat="server" Text='<%# Eval("SAL_VENCIMENTOS") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 163px; padding-right: 5px;" align="right">
                                                        <div align="center">
                                                            Total de descontos
                                                        </div>
                                                        <asp:Label ID="Label55" runat="server" Text='<%# Eval("SAL_DESCONTOS") %>'></asp:Label>
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
                                                        <asp:Label ID="Label56" runat="server" Text='<%# Eval("SAL_BASEFGTS") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 136px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                        <div align="center">
                                                            F.G.T.S do Més
                                                        </div>
                                                        <asp:Label ID="Label57" runat="server" Text='<%# Eval("SAL_MESFGTS") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 138px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                        <div align="center">
                                                            Base Cál. I.R.
                                                        </div>
                                                        <asp:Label ID="Label58" runat="server" Text='<%# Eval("SAL_BASECALIR") %>'></asp:Label>
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
                                                        <asp:Label ID="Label59" runat="server" Text='<%# Eval("SAL_LIQUIDO") %>'></asp:Label>
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
                                                            <asp:Label ID="Label60" runat="server" Text='<%# Eval("SAL_FRASE") %>'></asp:Label>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <div style="position: relative; width: 164; font-family: Tahoma; font-size: 9px; margin: 5px 0px 5px 0px; margin-left: 20px;">
                                    1º&nbsp;via/Funcionário
                        <div style="position: relative; font-size: 10; font-weight: bold; width: 820; text-align: left;">
                            ------------------------------------------------------------------------------------------------------------------------
                        </div>
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
                                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("CLI_ENDERECO") %>'></asp:Label>&nbsp;&nbsp;
                                                                     <asp:Label ID="Label6" runat="server" Text='<%# Eval("CLI_ENDERECO_NUMERO") %>'></asp:Label>
                                                        <br />
                                                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("CLI_ENDERECO_MUNICIPIO") %>'></asp:Label>&nbsp;
                                                                    <asp:Label ID="Label8" runat="server" Text="- SP"></asp:Label>&nbsp;&nbsp;&nbsp;
                                                                    <asp:Label ID="Label64" runat="server" Text='<%# Eval("CLI_ENDERECO_CEP", "{0:00.000-000}") %>'></asp:Label>&nbsp;&nbsp;&nbsp;
                                                                    <asp:Label ID="Label65" runat="server" Text='<%# Eval("CNPJ_CPF") %>'></asp:Label>
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
                                                        <asp:Label ID="Label22" runat="server" Text='<%# Eval("SAL_CREDITO")%>'></asp:Label>
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
                                                        <asp:Label ID="Label23" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTOCODIGO").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                    </td>
                                                    <td valign="top" style="width: 287px; height: 250px; border-right: 1px solid Black; padding: 2px 0px 0px 5px;">
                                                        <asp:Label ID="Label24" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTODESCRICAO").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                    </td>
                                                    <td align="right" valign="top" style="width: 78px; height: 250px; border-right: 1px solid Black; padding: 2px 5px 0px 0px;">
                                                        <asp:Label ID="Label25" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTOREFERENCIA").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                    </td>
                                                    <td align="right" valign="top" style="width: 151px; height: 250px; border-right: 1px solid Black; padding: 2px 5px 0px 0px;">
                                                        <asp:Label ID="Label26" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTOVENCIMENTO").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
                                                    </td>
                                                    <td align="right" valign="top" style="width: 166px; height: 250px; padding: 2px 5px 0px 0px;">
                                                        <asp:Label ID="Label27" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EVENTODESCONTO").ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") %>'></asp:Label>
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
                                                        <asp:Label ID="Label28" runat="server" Text='<%# Eval("SAL_BASE") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 160px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                        <div align="center">
                                                            Salário Contribuição
                                                        </div>
                                                        <asp:Label ID="Label29" runat="server" Text='<%# Eval("SAL_CONTRIBUICAO") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 152px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                        <div align="center">
                                                            Total de vecimentos
                                                        </div>
                                                        <asp:Label ID="Label30" runat="server" Text='<%# Eval("SAL_VENCIMENTOS") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 163px; padding-right: 5px;" align="right">
                                                        <div align="center">
                                                            Total de descontos
                                                        </div>
                                                        <asp:Label ID="Label31" runat="server" Text='<%# Eval("SAL_DESCONTOS") %>'></asp:Label>
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
                                                        <asp:Label ID="Label32" runat="server" Text='<%# Eval("SAL_BASEFGTS") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 136px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                        <div align="center">
                                                            F.G.T.S do Més
                                                        </div>
                                                        <asp:Label ID="Label33" runat="server" Text='<%# Eval("SAL_MESFGTS") %>'></asp:Label>
                                                    </td>
                                                    <td style="width: 138px; border-right: 1px solid Black; padding-right: 5px;" align="right">
                                                        <div align="center">
                                                            Base Cál. I.R.
                                                        </div>
                                                        <asp:Label ID="Label34" runat="server" Text='<%# Eval("SAL_BASECALIR") %>'></asp:Label>
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
                                                        <asp:Label ID="Label35" runat="server" Text='<%# Eval("SAL_LIQUIDO") %>'></asp:Label>
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
                                                            <asp:Label ID="Label62" runat="server" Text='<%# Eval("SAL_FRASE") %>'></asp:Label>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table style="width: 714px; height: 70px; font-family: Tahoma; font-size: 10px; border: 1px solid Black; border-collapse: collapse; margin-left: 20px"
                                    border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td colspan="2" align="center">DECLARO TER RECEBIDO A IMPORTÂNCIA LÍQUIDA DISCRIMINADA NESTE RECIBO
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 60px">___________________________
                                <div style="padding-left: 60px">
                                    DATA
                                </div>
                                        </td>
                                        <td style="padding-left: 100px">_______________________________________________________________
                                <div style="padding-left: 80px">
                                    ASSINATURA DO FUNCIONARIO
                                </div>
                                        </td>
                                    </tr>
                                </table>
                                <small style='page-break-after: always'></small>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataHolerite" runat="server" OnLoad="SqlData_Load"
        SelectCommand="EXEC rs_holerite_gerar @CLI_IND, @MES, @ANO, @SAL_HOLERITE_TIPO, 2">
        <SelectParameters>
            <asp:QueryStringParameter Name="CLI_IND" QueryStringField="ind" Type="Int32" />
            <asp:QueryStringParameter Name="MES" QueryStringField="mes" Type="Int32" />
            <asp:QueryStringParameter Name="ANO" QueryStringField="ano" Type="Int32" />
            <asp:QueryStringParameter Name="SAL_HOLERITE_TIPO" QueryStringField="tipo" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
