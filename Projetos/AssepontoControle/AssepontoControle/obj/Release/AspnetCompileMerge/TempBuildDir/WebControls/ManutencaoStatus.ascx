<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManutencaoStatus.ascx.cs"
    Inherits="Asseponto.WebControls.ManutencaoStatus" %>
<asp:FormView ID="FormView1" runat="server" DataSourceID="sqlManutencao">
    <ItemTemplate>
        <div class="sitecorpoboxcaixa">
            <table  style="width: 500px;">
                <tr>
                    <td  style='<%# Convert.ToInt32(Eval("MANUTENCAOATIVA")) == 1 ? "visibility:hidden;position:absolute;": "width: 60px; padding-left: 50px;" %>' >
                        <asp:Image ID="Image1" runat="server" src="../../Images/48x48/WarningRed.png" />
                    </td>
                    <td>
                        <div class="fieldviewcaptionfirst">

                            <asp:HiddenField ID="lbManuntencao" runat="server" Value='<%# Eval("MANUTENCAOATIVA") %>' />

                            <asp:Label ID="STATUS" runat="server" Text='<%# Eval("STATUS") %>'
                                ForeColor='<%# Convert.ToInt32(Eval("MANUTENCAOATIVA")) == 0 ? System.Drawing.Color.Red : System.Drawing.ColorTranslator.FromHtml("#004C70") %>' />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <div style='<%# Convert.ToInt32(Eval("MANUTENCAOGRATUITA")) == 0 ? "visibility:hidden;position:absolute;": "" %>'>
                            <table>
                                <tr>
                                    <td>
                                        <div class="fieldviewcaption">
                                            Versão
                                        </div>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("VERSAODESCRICAO") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="fieldviewcaption">
                                            Liberado Por
                                        </div>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("LIBERADOPOR") %>' />
                                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("LIBERADOEM", "{0:dd/MM/yyyy}") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="fieldviewcaption">
                                            Dias decorridos
                                        </div>
                                        <asp:Label ID="lbDiasCorridos" runat="server" Text='<%# Eval("DIASDECORRIDOS") %>' />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </ItemTemplate>
</asp:FormView>
<asp:SqlDataSource ID="sqlManutencao" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
    OnSelecting="sqlManutencao_Selecting"
    SelectCommand="EXEC asseponto_rs_manutencao_cliente_status @P_CLIENTE = @CLIENTE">
    <SelectParameters>
        <asp:QueryStringParameter Name="CLIENTE" QueryStringField="ind" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>