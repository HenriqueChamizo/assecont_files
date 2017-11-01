<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="RelatorioImplantacoesFinalizadasIncompleta.aspx.cs" Inherits="Asseponto.Suporte.Relatorios.RelatorioImplantacoesFinalizadasIncompleta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%" OnItemClick="RadMenu1_ItemClick" OnPreRender="RadMenu1_PreRender">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Janeiro" Value="Janeiro">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Fevereiro" Value="Fevereiro">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Março" Value="Março">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Abril" Value="Abril">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Maio" Value="Maio">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Junho" Value="Junho">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Julho" Value="Julho">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Agosto" Value="Agosto">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Setembro" Value="Setembro">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Outubro" Value="Outubro">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Novembro" Value="Novembro">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Dezembro" Value="Dezembro">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Value="ano" Text="">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Value="anoAnterior" Text="">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">

            <p>
                <asp:FormView ID="FormViewQtdFinalizadas" runat="server" DataSourceID="SqlDataQtdFinalizadas" Font-Size="12pt" DefaultMode="Edit">
                    <EditItemTemplate>
                        <asp:Label ID="lbMes" runat="server" ForeColor="#EF461D"  Text='<%# Asseponto.Classes.Utils.getMesAnoFormat(Convert.ToInt32(Request.QueryString["ind"]), Convert.ToInt32(Request.QueryString["ano"]))  %>'></asp:Label>
                        <br />
                        <asp:Label ID="lbqtdevidada" runat="server"  Text='<%# Eval("QtdFinalizadas") + " Implantações finalizadas Incompletas" %>'></asp:Label>
                    </EditItemTemplate>
                </asp:FormView>
            </p>

            <asp:DataList ID="DataListQtdFinalizadas" runat="server" DataSourceID="SqlDataImplantacaoesFinalizadas" BorderStyle="None" CellSpacing="20" EnableTheming="True"
                RepeatColumns="2" RepeatDirection="Horizontal" ShowFooter="False" ShowHeader="False" Width="835px">
                <AlternatingItemStyle BorderStyle="None" />
                <EditItemStyle BorderStyle="None" />
                <FooterStyle BorderStyle="None" />
                <HeaderStyle BorderStyle="None" />
                <ItemStyle BorderStyle="None" />
                <ItemTemplate>
                    <table>
                        <tr>
                            <td>
                                <asp:HyperLink ID="lbNome" runat="server" CssClass="sitelinkpadraoazul" NavigateUrl='<%# Eval("CAD_IND", "~/suporte/Atendimento/Cliente.aspx?ind={0}") %>'><%# Eval("CAD_RAZAOSOCIAL")%></asp:HyperLink></b>
                            </td>
                        </tr>
                        <tr>
                            <td>Data do Cadastro: 
                                <asp:Label ID="lbDataCadastro" runat="server" Text='<%# Eval("IM_INICIO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                <br />
                                Data da finalização: 
                                <asp:Label ID="lbDataFinalizado" runat="server" Text='<%# Eval("IM_TERMINO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                <br />
                                Faltou: 
                                <asp:Label ID="Label1" ForeColor="Red" runat="server" Text='<%# Eval("STAT_NOME") %>'></asp:Label>
                                <br />
                                Relogio
                                <asp:Label ID="lbRelogio" runat="server" Text='<%# Eval("FABR_NOME") %>'></asp:Label>
                                <br />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
                <SelectedItemStyle BorderStyle="None" />
                <SeparatorStyle BorderStyle="None" />
            </asp:DataList>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataImplantacaoesFinalizadas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT * FROM AssepontoClientes
                       INNER JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND
                       INNER JOIN AssepontoImplantacoesStatus ON IM_ANDAMENTO = STAT_IND
                       INNER JOIN AssepontoRepFabricantes ON IM_REP_FABRICANTE = FABR_COD
                       WHERE IM_STATUS = 2 AND MONTH(IM_TERMINO) = @ind AND IM_ANDAMENTO != 7
                       AND YEAR(IM_TERMINO) = @ano
                       ORDER BY CAD_RAZAOSOCIAL">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" Type="Int32" QueryStringField="ind" />
            <asp:QueryStringParameter Name="ano" Type="Int32" QueryStringField="ano" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataQtdFinalizadas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT COUNT(CAD_RAZAOSOCIAL) AS QtdFinalizadas FROM AssepontoClientes
                       INNER JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND
                       WHERE IM_STATUS = 2 AND MONTH(IM_TERMINO) = @ind AND IM_ANDAMENTO != 7
                       AND YEAR(IM_TERMINO) = @ano">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" Type="Int32" QueryStringField="ind" />
            <asp:QueryStringParameter Name="ano" Type="Int32" QueryStringField="ano" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
