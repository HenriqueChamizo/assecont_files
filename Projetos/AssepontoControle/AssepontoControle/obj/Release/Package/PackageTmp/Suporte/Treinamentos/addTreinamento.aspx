<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addTreinamento.aspx.cs" Inherits="Asseponto.Suporte.Treinamentos.addTreinamento" %>

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
                padding-bottom: 8px;
                padding-top: 8px;
            }

                #tableEmail .tableg .descricao
                {
                    color: steelblue;
                    float: left;
                }

            #tableEmail td
            {
                padding-top: 10px;
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
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <table id="tableEmail" width="420px" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="tableg"><span class="titulo">Data/Horário</span><br />
                        <telerik:RadDateTimePicker ID="RDTP_Horario" Skin="Web20" Width="250px" runat="server">
                            <Calendar ID="Calendar2" runat="server" EnableKeyboardNavigation="true" />
                            <DateInput DateFormat="dd/MM/yyyy HH:mm" DisplayDateFormat="dd/MM/yyyy HH:mm" ToolTip="Date input" Label="" />
                        </telerik:RadDateTimePicker>
                        <asp:RequiredFieldValidator ID="RFV_treinamento" runat="server" ErrorMessage="Obrigatório" CssClass="sitevalidator" ControlToValidate="RDTP_Horario"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:RadioButton ID="rbtnTreinamento" runat="server" Text="Treinamento" AutoPostBack="true" Checked="true" GroupName="treinamento" OnCheckedChanged="CheckTreinamento_CheckedChanged" /><br />
                        <asp:RadioButton ID="rbtnTreinamentoIndividual" runat="server" AutoPostBack="true" Text="Treinamento Individual" GroupName="treinamento" OnCheckedChanged="CheckTreinamentoIndividual_CheckedChanged" /><br />
                        <asp:RadioButton ID="rbtnFeriado" runat="server" Text="Feriado" AutoPostBack="true" OnCheckedChanged="CheckFeriado_CheckedChanged" GroupName="treinamento" />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="tableg">
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <div id="DivDescricao" runat="server">
                                        Título
                                        <asp:TextBox ID="txtDescricao" runat="server" Width="250"></asp:TextBox>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="tableg">
                        <asp:LinkButton ID="RbSalvar" runat="server" OnClick="RbSalvar_Click" CssClass="sitebutton blue">Agendar</asp:LinkButton>
                    </td>
                    <td style="text-align: right">
                        <input id="Button1" type="button" class="sitebutton Red" style="font-size: 12pt;" value="Cancelar" onclick="openProcess();" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
