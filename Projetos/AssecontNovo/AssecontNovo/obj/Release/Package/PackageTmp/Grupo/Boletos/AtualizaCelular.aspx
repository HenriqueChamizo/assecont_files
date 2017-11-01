<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AtualizaCelular.aspx.cs" Inherits="AssecontNovo.Grupo.Boletos.AtualizaCelular" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="http://www.assecont.com.br/Styles/Site.css" rel="stylesheet" />
    <style>
        #tableEmail
        {
            margin-top: 10px;
            border-collapse: collapse;
        }

            #tableEmail .tableg
            {
                padding-bottom: 10px;
                padding-top: 10px;
            }

        .titulo
        {
            color: steelblue;
            text-transform: uppercase;
        }
    </style>
    <script src="../../Jquery/RadWindow.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <asp:FormView ID="FV_ATUALIZAR_DADOS" runat="server" DefaultMode="Edit" DataKeyNames="CAD_IND" DataSourceID="sqlCadastro"
            OnDataBound="FV_ATUALIZAR_DADOS_DataBound">
            <EditItemTemplate>
                <asp:Panel ID="Panel1" runat="server" EnableViewState="false">
                    <table id="tableEmail" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td style="padding-bottom: 10px; font-size: 11pt;">Receba seus boletos por SMS !
                            </td>
                        </tr>
                        <tr>
                            <td class="tableg"><span class="titulo">Razão Social</span><br />
                                <asp:Label ID="lbRazaoSocial" runat="server" Font-Size="12pt" Text='<%# Eval("RAZAOSOCIAL") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tableg">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td><span class="titulo">Celular:</span>
                                            <br />
                                            <asp:TextBox ID="txtxCelDDD" runat="server" CssClass="textbox" notnull="true" Width="50" MaxLength="2" Text='<%# Bind("CEL_DDD") %>'></asp:TextBox>
                                            <asp:TextBox ID="txtCelular" runat="server" CssClass="textbox" notnull="true" Width="100" Text='<%# Bind("CEL") %>'></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tableg" style="padding-top: 20px">
                                <asp:LinkButton ID="lbAtualizarEmail" runat="server" CssClass="sitebutton blue" CommandName="Update" OnClick="lbAtualizarEmail_Click">
                                    Confirmar
                                    <asp:Image ID="imgaa" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" />
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </EditItemTemplate>
        </asp:FormView>

        <asp:SqlDataSource ID="sqlEstados" runat="server" OnLoad="SqlData_Load" SelectCommand="SELECT EST_SIGLA, EST_NOME FROM Estados"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlCadastro" runat="server" OnLoad="SqlDataAssefin_Load"
            SelectCommand="SELECT CAD_IND, RTRIM(CAD_RAZAOSOCIAL) AS RAZAOSOCIAL, 
                               RTRIM(CAD_FINANCEIRO_CELULAR1_DDD) AS CEL_DDD, RTRIM(CAD_FINANCEIRO_CELULAR1) AS CEL
                               FROM Cadastros WHERE CAD_IND = @ind"
            UpdateCommand="UPDATE Cadastros SET CAD_FINANCEIRO_CELULAR1_DDD = @CEL_DDD, CAD_FINANCEIRO_CELULAR1 = @CEL,
                               CAD_CELULAR_ACEITA = 1, CAD_CADASTRO_ATUALIZADO_EM = GETDATE() WHERE CAD_IND = @ind">
            <UpdateParameters>
                <asp:QueryStringParameter Name="ind" QueryStringField="ind" Type="Int32" />
                <asp:Parameter Name="CEL_DDD" Type="String" />
                <asp:Parameter Name="CEL" Type="String" />
            </UpdateParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="ind" QueryStringField="ind" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:Panel ID="panelSucesso" runat="server" Visible="false">
            <table class="sectionSucessoTable">
                <tr>
                    <td style="width: 100px;">
                        <asp:Image ID="ImageCheck" runat="server" CssClass="green" Width="80" ImageUrl="~/Imagens/Site/Sucess.png" />
                    </td>
                    <td style="color: #00ac59; padding-top: 30px;" class="titleSubs">Sucesso !
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div style="padding: 12px 0px 0px 5px; font-size: 15px;">
                            Solicitação enviada com sucesso.<br />
                        </div>
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="panelFalha" runat="server" Visible="false">
            <table style="margin-top: 50px;">
                <tr>
                    <td>
                        <img src="~/Imagens/Site/Error.png" width="80" />

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
                   <td style="text-align: right;">
                        <asp:LinkButton ID="btnFechar" runat="server" CssClass="sitebutton Red" OnClientClick="openProcess();">Fechar</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

       <%-- <asp:Panel ID="panelChamadaAssecontCelular" runat="server">
            <table>
                <tr>
                    <td colspan="2">
                        <img src="../../Imagens/Assecont/AssecontCelular.jpg" width="680" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:LinkButton ID="btnCadastrar" runat="server" CssClass="sitebutton blue" OnClick="btnCadastrar_Click">Cadastrar</asp:LinkButton>
                    </td>
                    <td style="text-align: right;">
                        <asp:LinkButton ID="btnNaoCadastrar" runat="server" CssClass="sitebutton Red" OnClick="btnNaoCadastrar_Click" OnClientClick="openProcess();">Não tenho interesse.</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>--%>
    </form>
</body>
</html>
