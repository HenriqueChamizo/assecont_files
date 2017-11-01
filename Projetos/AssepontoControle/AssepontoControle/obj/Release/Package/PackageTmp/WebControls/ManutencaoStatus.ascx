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
<div class="sitecorpoboxcaixa">
    <table  style="width: 500px;">
        <tr>
            <h3 style="margin:0px"><strong>Status Financeiro</strong></h3>
        </tr>
        <tr>
            <td>
                <asp:FormView ID="FormView2" runat="server" DataSourceID="sqlManutencaoAsseponto">
                    <ItemTemplate>
                        <%# (Eval("STATUSCLIENTE").ToString() == "00-Manutenção em Dia") ? "<div style='width:150px' class='alert alert-success text-center'><strong>AssePonto</strong></div>" : (Eval("STATUSCLIENTE").ToString() == "04-Manutenção Ativa com Valores em Aberto") ? "<div style='width:150px' class='alert alert-warning text-center'><strong>AssePonto</strong></div>" : "<div style='width:150px' class='alert alert-danger text-center'><strong>AssePonto</strong></div>" %>
                    </ItemTemplate>
                </asp:FormView>
            </td>
            <td>
                <asp:FormView ID="FormView3" runat="server" DataSourceID="sqlManutencaoAssefin">
                    <ItemTemplate>
                        <%# (Eval("STATUSCLIENTE").ToString() == "00-Manutenção em Dia") ? "<div style='width:150px' class='alert alert-success text-center'><strong>AsseFin</strong></div>" : (Eval("STATUSCLIENTE").ToString() == "04-Manutenção Ativa com Valores em Aberto") ? "<div style='width:150px' class='alert alert-warning text-center'><strong>AsseFin</strong></div>" : "<div style='width:150px' class='alert alert-danger text-center'><strong>AsseFin</strong></div>" %>
                    </ItemTemplate>
                </asp:FormView>
            </td>
            <td>
                <asp:FormView ID="FormView4" runat="server" DataSourceID="sqlManutencaoAssepontoWeb">
                    <ItemTemplate>
                        <%# (Eval("STATUSCLIENTE").ToString() == "00-Manutenção em Dia") ? "<div style='width:150px' class='alert alert-success text-center'><strong>AssePontoWeb</strong></div>" : (Eval("STATUSCLIENTE").ToString() == "04-Manutenção Ativa com Valores em Aberto") ? "<div style='width:150px' class='alert alert-warning text-center'><strong>AssePontoWeb</strong></div>" : "<div style='width:150px' class='alert alert-danger text-center'><strong>AssePontoWeb</strong></div>" %>
                    </ItemTemplate>
                </asp:FormView>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <strong>Legenda</strong>
                <div style='width:300px;padding:5px;margin:5px 0px' class='alert alert-success'><strong>Manutenção Ativa com Valores em Dia</strong></div>
                <div style='width:300px;padding:5px;margin:5px 0px' class='alert alert-warning'><strong>Manutenção Ativa com Valores em Aberto</strong></div>
                <div style='width:300px;padding:5px;margin:5px 0px' class='alert alert-danger'><strong>Manutenção Cancelada ou Sem Manutenção</strong></div>
            </td>
        </tr>
    </table>
    <style>
        .text-center {
            text-align: center;
        }
        .alert-success {
            background-image: -webkit-linear-gradient(top,#dff0d8 0,#c8e5bc 100%);
            background-image: -o-linear-gradient(top,#dff0d8 0,#c8e5bc 100%);
            background-image: -webkit-gradient(linear,left top,left bottom,from(#dff0d8),to(#c8e5bc));
            background-image: linear-gradient(to bottom,#dff0d8 0,#c8e5bc 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffdff0d8', endColorstr='#ffc8e5bc', GradientType=0);
            background-repeat: repeat-x;
            border-color: #b2dba1;
        }.alert {
            text-shadow: 0 1px 0 rgba(255,255,255,.2);
            -webkit-box-shadow: inset 0 1px 0 rgba(255,255,255,.25), 0 1px 2px rgba(0,0,0,.05);
            box-shadow: inset 0 1px 0 rgba(255,255,255,.25), 0 1px 2px rgba(0,0,0,.05);
        }.alert-success {
            color: #3c763d;
            background-color: #dff0d8;
            border-color: #d6e9c6;
        }.alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }.alert-warning {
            background-image: -webkit-linear-gradient(top,#fcf8e3 0,#f8efc0 100%);
            background-image: -o-linear-gradient(top,#fcf8e3 0,#f8efc0 100%);
            background-image: -webkit-gradient(linear,left top,left bottom,from(#fcf8e3),to(#f8efc0));
            background-image: linear-gradient(to bottom,#fcf8e3 0,#f8efc0 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#fffcf8e3', endColorstr='#fff8efc0', GradientType=0);
            background-repeat: repeat-x;
            border-color: #f5e79e;
        }.alert-warning {
            color: #8a6d3b;
            background-color: #fcf8e3;
            border-color: #faebcc;
        }.alert-danger {
            background-image: -webkit-linear-gradient(top,#f2dede 0,#e7c3c3 100%);
            background-image: -o-linear-gradient(top,#f2dede 0,#e7c3c3 100%);
            background-image: -webkit-gradient(linear,left top,left bottom,from(#f2dede),to(#e7c3c3));
            background-image: linear-gradient(to bottom,#f2dede 0,#e7c3c3 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#fff2dede', endColorstr='#ffe7c3c3', GradientType=0);
            background-repeat: repeat-x;
            border-color: #dca7a7;
        }.alert-danger {
            color: #a94442;
            background-color: #f2dede;
            border-color: #ebccd1;
        }
    </style>
</div>
<asp:SqlDataSource ID="sqlManutencao" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
    OnSelecting="sqlManutencao_Selecting"
    SelectCommand="EXEC asseponto_rs_manutencao_cliente_status @P_CLIENTE = @CLIENTE">
    <SelectParameters>
        <asp:QueryStringParameter Name="CLIENTE" QueryStringField="ind" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sqlManutencaoAsseponto" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionStringAssefin %>"
    OnSelecting="sqlManutencaoAssefin_Selecting" 
    SelectCommand="select dbo.fn_status_cliente(convert(nvarchar(max), @CNPJ), 3) as 'STATUSCLIENTE'">
    <SelectParameters>
        <asp:QueryStringParameter Name="CNPJ" DefaultValue="" QueryStringField="CNPJ" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sqlManutencaoAssefin" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionStringAssefin %>"
    OnSelecting="sqlManutencaoAssefin_Selecting" 
    SelectCommand="select dbo.fn_status_cliente(convert(nvarchar(max), @CNPJ), 13) as 'STATUSCLIENTE'">
    <SelectParameters>
        <asp:QueryStringParameter Name="CNPJ" DefaultValue="" QueryStringField="CNPJ" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sqlManutencaoAssepontoWeb" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionStringAssefin %>"
    OnSelecting="sqlManutencaoAssefin_Selecting" 
    SelectCommand="select dbo.fn_status_cliente(convert(nvarchar(max), @CNPJ), 47) as 'STATUSCLIENTE'">
    <SelectParameters>
        <asp:QueryStringParameter Name="CNPJ" DefaultValue="" QueryStringField="CNPJ" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>