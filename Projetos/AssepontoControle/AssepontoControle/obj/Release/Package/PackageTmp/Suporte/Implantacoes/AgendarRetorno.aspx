<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgendarRetorno.aspx.cs" Inherits="Asseponto.Suporte.Implantacoes.AgendarRetorno" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../Styles/Site.css" rel="stylesheet" />
    <style>
           body
        {
            border: 0px !important;
        }

        #tableEmail
        {
            margin-top: 6px;
            border-collapse: collapse;
        }

            #tableEmail .tableg
            {
                padding-bottom: 6px;
                padding-top: 6px;
            }

            #tableEmail td
            {
                padding-top: 10px;
            }

        .titulo
        {
            color: steelblue;
            text-transform: uppercase;
        }
    </style>

    <script type="text/javascript">
        function openProcess() {
            GetRadWindow().close();
            top.location.href = top.location.href;
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
            <asp:FormView ID="FV_ATUALIZAR_DADOS" runat="server" DefaultMode="Insert" DataKeyNames="IM_IND" DataSourceID="sqlCadastro">
                <InsertItemTemplate>
                    <table id="tableEmail" style="width: 100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="tableg"  colspan="2"><span class="titulo">Razão Social</span><br />
                                <asp:Label ID="lbRazaoSocial" runat="server" Font-Size="12pt" OnLoad="lbRazaoSocial_Load" ></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td  colspan="2">
                                <div class="fieldviewcaption">Data do Agendamento</div>
                            </td>
                        </tr>
                        <tr>
                            <td  colspan="2">
                                <telerik:RadDateTimePicker ID="DATA_HORA" Skin="Web20" Width="200px" runat="server" DbSelectedDate='<%# Bind("DATA_HORA") %>'>
                                    <Calendar ID="Calendar2" runat="server" EnableKeyboardNavigation="true" />
                                    <DateInput DateFormat="dd/MM/yyyy HH:mm" DisplayDateFormat="dd/MM/yyyy HH:mm" ToolTip="Date input" Label="" />
                                </telerik:RadDateTimePicker>
                            </td>
                        </tr>
                        <tr>
                            <td  colspan="2">
                                <div class="fieldviewcaption">Observação</div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="txtObs" runat="server" Width="410px" Height="80px" TextMode="MultiLine" CssClass="text" Text='<%# Bind("AGE_OBSERVACAO") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:LinkButton ID="lkAgendar" runat="server" CommandArgument="Insert" CommandName="Insert" CssClass="sitebutton blue">Agendar</asp:LinkButton><br />
                            </td>
                            <td style="text-align: right;">
                                <input id="Button1" type="button" class="sitebutton Red" style="font-size: 12pt;" value="Cancelar" onclick="openProcess();" />
                            </td>
                        </tr>
                    </table>
                </InsertItemTemplate>
            </asp:FormView>



            <asp:SqlDataSource ID="SqlCadastro" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnInserted="SqlCadastro_Inserted" OnInserting="SqlCadastro_Inserting"
                SelectCommand="SELECT CAD_RAZAOSOCIAL FROM AssepontoClientes INNER JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND WHERE IM_IND = @IM_IND"
                InsertCommand="INSERT INTO AssepontoImplantacoesAgenda (AGE_DATA, AGE_AGENDADO_EM, AGE_IMPLANTACAO, AGE_AGENDADO_POR, AGE_OBSERVACAO) VALUES (@DATA_HORA, GETDATE(), @IM_IND, @USUARIO, @AGE_OBSERVACAO)
                    UPDATE AssepontoImplantacoes SET IM_DTAGENDA = @DATA_HORA, IM_AGENDADO_POR = @USUARIO WHERE IM_IND = @IM_IND ">
                <InsertParameters>
                    <asp:Parameter Name="AGE_OBSERVACAO" Type="String" />
                    <asp:Parameter Name="USUARIO" Type="Int32" />
                    <asp:Parameter Name="DATA_HORA" Type="DateTime" />
                    <asp:QueryStringParameter Name="IM_IND" QueryStringField="ind" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="IM_IND" QueryStringField="ind" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>


            <asp:Panel ID="panelSucesso" runat="server" Visible="false">
                <table style="width: 100%;">
                    <tr>
                        <td colspan="2">
                            <div style="padding: 12px 0px 0px 5px; font-size: 15px;">
                                Solicitação enviada com sucesso.<br />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 30px; text-align: center; vertical-align: middle">
                            <input id="Button1" type="button" class="sitebutton blue" style="font-size: 16pt;" value="Fechar" onclick="openProcess();" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>

            <asp:Panel ID="panelFalha" runat="server" Visible="false">
                <table style="margin-top: 20px; width: 100%;">
                    <tr>
                        <td>
                            <img src="~/Imagens/Site/Aviso.png" width="80" />

                        </td>
                        <td style="font-size: 14pt">
                            <div class="titleSubs font_red">
                                <b>Ops !</b>
                            </div>
                            Ocorreu um erro inesperado
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-top: 30px; font-size: 12pt">Por favor, tentar novamente mais tarde.
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 30px; text-align: center; vertical-align: middle">
                            <input id="Button2" type="button" class="sitebutton blue" style="font-size: 14pt;" value="Fechar" onclick="openProcess();" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
