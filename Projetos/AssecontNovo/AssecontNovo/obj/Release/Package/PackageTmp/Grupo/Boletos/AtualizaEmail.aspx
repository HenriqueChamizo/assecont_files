<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AtualizaEmail.aspx.cs" Inherits="AssecontNovo.Grupo.Boletos.AtualizaEmail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="overflow: hidden !important;">
<head runat="server">
    <title></title>

    <link href="http://www.assecont.com.br/Styles/Site.css" rel="stylesheet" />
    <link href="/Skins/ComboBox_flv.css" rel="stylesheet" />

    <style>
        #tableEmail
        {
            margin-top: 6px;
            margin-left: 15px;
            border-collapse: collapse;
            width: 720px;
        }

            #tableEmail .tableg
            {
                padding-bottom: 5px;
                padding-top: 5px;
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
        <asp:FormView ID="FV_ATUALIZAR_DADOS" runat="server" DefaultMode="Edit" DataKeyNames="CAD_IND" DataSourceID="sqlCadastro" OnDataBound="FV_ATUALIZAR_DADOS_DataBound">
            <EditItemTemplate>
                <asp:Panel ID="Panel1" runat="server" EnableViewState="false">
                    <table id="tableEmail" border="0" cellspacing="0" cellpadding="0" style="width: 620px;">
                        <tr>
                            <td style="padding-bottom: 8px; font-size: 10pt;">Mantenha o seu cadastro atualizado.
                                    <br />
                                Dessa forma, você não vai ficar sem receber nenhuma informação importante !
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
                                        <td style="padding-right: 8px;"><span class="titulo">Endereço</span><br />
                                            <asp:TextBox ID="txtEndereco" runat="server" CssClass="textbox" Text='<%# Bind("ENDERECO") %>'
                                                Width="300px" MaxLength="70" notnull="true" />
                                        </td>
                                        <td><span class="titulo">Número</span><br />
                                            <asp:TextBox ID="txtEnderecoNumero" runat="server" CssClass="textbox" Text='<%# Bind("NUMERO") %>'
                                                Width="80px" MaxLength="7" notnull="true" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tableg">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="padding-right: 8px;"><span class="titulo">Complemento</span><br />
                                            <asp:TextBox ID="txtComplemento" runat="server" CssClass="textbox" Text='<%# Bind("COMPLEMENTO") %>'
                                                Width="300px" MaxLength="60" />
                                        </td>
                                        <td><span class="titulo">Bairro</span><br />
                                            <asp:TextBox ID="txtBairro" runat="server" CssClass="textbox" Text='<%# Bind("BAIRRO") %>'
                                                Width="180px" MaxLength="25" notnull="true" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tableg">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="padding-right: 8px;"><span class="titulo">Cidade</span><br />
                                            <asp:TextBox ID="txtCidade" runat="server" CssClass="textbox" Text='<%# Bind("CIDADE") %>'
                                                Width="180px" MaxLength="30" notnull="true" />
                                        </td>
                                        <td style="padding-right: 8px;"><span class="titulo">UF</span><br />
                                            <telerik:RadComboBox ID="txtEstado" runat="server" tasourceid="sqlEstados" Skin="flv" EnableEmbeddedSkins="false"
                                                OnDataBinding="CAD_ESTADO_DataBinding" EmptyMessage="Selecione o Estado" Width="200"
                                                SelectedValue='<%# Bind("CAD_ESTADO") %>' notnull="true">
                                                <ItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lbUF" runat="server" Text='<%# "(" + Eval("EST_SIGLA") + ") " + Eval("EST_NOME") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </td>
                                        <td><span class="titulo">CEP</span><br />
                                            <asp:TextBox ID="txtCEP" runat="server" CssClass="textbox" Text='<%# Bind("CEP") %>' Width="80px"
                                                MaxLength="9" notnull="true" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tableg"><span class="titulo">Email Financeiro</span>
                                <br />
                                <asp:TextBox ID="txtEmail1" runat="server" notnull="true" CssClass="textbox" Width="300" Text='<%# Bind("EMAIL") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="tableg"><span class="titulo">Email Financeiro 2</span>
                                <br />
                                <asp:TextBox ID="txtEmail2" runat="server" CssClass="textbox" Width="300" Text='<%# Bind("EMAIL2") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="tableg"><span class="titulo">Email Financeiro 3</span>
                                <br />
                                <asp:TextBox ID="txtEmail3" runat="server" CssClass="textbox" Width="300" Text='<%# Bind("EMAIL3") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="tableg">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td><span class="titulo">Telefone Financeiro 1</span>
                                            <br />
                                            <asp:TextBox ID="TextBox1" runat="server" CssClass="textbox" Width="50" MaxLength="2" Text='<%# Bind("TEL1_DDD") %>'></asp:TextBox>
                                            <asp:TextBox ID="TextBox2" runat="server" CssClass="textbox" Width="100" Text='<%# Bind("TEL1") %>'></asp:TextBox>
                                        </td>
                                        <td style="padding-left: 50px;"><span class="titulo">Telefone Financeiro 2</span>
                                            <br />
                                            <asp:TextBox ID="TextBox3" runat="server" CssClass="textbox" Width="50" MaxLength="2" Text='<%# Bind("TEL2_DDD") %>'></asp:TextBox>
                                            <asp:TextBox ID="TextBox4" runat="server" CssClass="textbox" Width="100" Text='<%# Bind("TEL2") %>'></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <tr>
                                <td class="tableg">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td><span class="titulo">Celular:</span>
                                                <br />
                                                <asp:TextBox ID="txtxCelDDD" runat="server" CssClass="textbox" Width="50" MaxLength="2" Text='<%# Bind("CEL_DDD") %>'></asp:TextBox>
                                                <asp:TextBox ID="txtCelular" runat="server" CssClass="textbox" Width="100" MaxLength="9" Text='<%# Bind("CEL") %>'></asp:TextBox>
                                            </td>
                                            <td style="padding-left: 50px;"><span class="titulo">Aceita receber avisos por SMS ?</span>
                                                <br />
                                                <asp:RadioButtonList ID="CAD_CELULAR_ACEITA" runat="server" RepeatDirection="Horizontal"
                                                    RepeatLayout="Flow" SelectedValue='<%# Bind("CAD_CELULAR_ACEITA") %>' notnull="true">
                                                    <asp:ListItem Value="True">Sim</asp:ListItem>
                                                    <asp:ListItem Value="False">Não</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="tableg" style="padding-top: 20px">
                                    <asp:LinkButton ID="lbAtualizarEmail" runat="server" CssClass="sitebutton blue" CommandName="Update" OnClick="lbAtualizarEmail_Click">
                                        Confirmar Dados
                                                    <asp:Image ID="imgaa" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" />
                                    </asp:LinkButton>
                                </td>
                            </tr>
                    </table>
                </asp:Panel>
            </EditItemTemplate>
        </asp:FormView>

        <asp:SqlDataSource ID="sqlEstados" runat="server" OnLoad="SqlData_Load"
            SelectCommand="SELECT EST_SIGLA, EST_NOME FROM Estados"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlCadastro" runat="server" OnLoad="SqlDataAssefin_Load" OnUpdated="SqlCadastro_Updated"
            SelectCommand="SELECT CAD_IND, RTRIM(CAD_RAZAOSOCIAL) AS RAZAOSOCIAL, RTRIM(CAD_ENDERECO) AS ENDERECO, RTRIM(CAD_ENDERECO_NUMERO) AS NUMERO,
                               RTRIM(CAD_COMPLEMENTO) AS COMPLEMENTO, RTRIM(CAD_BAIRRO) AS BAIRRO, RTRIM(CAD_CIDADE) AS CIDADE, RTRIM(CAD_CEP) AS CEP, CAD_ESTADO,
                               RTRIM(CAD_FINANCEIRO_TELEFONE1_DDD) AS TEL1_DDD, RTRIM(CAD_FINANCEIRO_TELEFONE1) AS TEL1, RTRIM(CAD_FINANCEIRO_TELEFONE2_DDD) AS TEL2_DDD, RTRIM(CAD_FINANCEIRO_TELEFONE2) AS TEL2, 
                               RTRIM(CAD_FINANCEIRO_CELULAR1_DDD) AS CEL_DDD, RTRIM(CAD_FINANCEIRO_CELULAR1) AS CEL, RTRIM(CAD_FINANCEIRO_EMAIL) AS EMAIL, RTRIM(CAD_FINANCEIRO_EMAIL2) AS EMAIL2, RTRIM(CAD_FINANCEIRO_EMAIL3) AS EMAIL3,
                               CAD_CELULAR_ACEITA
                               FROM Cadastros WHERE CAD_IND = @ind"
            UpdateCommand="UPDATE Cadastros SET CAD_ENDERECO = @ENDERECO, CAD_ENDERECO_NUMERO = @NUMERO, CAD_COMPLEMENTO = @COMPLEMENTO, CAD_BAIRRO = @BAIRRO, CAD_CIDADE = @CIDADE, 
                               CAD_CEP = @CEP, CAD_ESTADO = @CAD_ESTADO, CAD_FINANCEIRO_CELULAR1_DDD = @CEL_DDD, CAD_FINANCEIRO_CELULAR1 = @CEL, CAD_FINANCEIRO_EMAIL = @EMAIL, CAD_FINANCEIRO_EMAIL2 = @EMAIL2, CAD_FINANCEIRO_EMAIL3 = @EMAIL3,
                               CAD_FINANCEIRO_TELEFONE1_DDD = @TEL1_DDD, CAD_FINANCEIRO_TELEFONE1 = @TEL1, CAD_FINANCEIRO_TELEFONE2_DDD = @TEL2_DDD, CAD_FINANCEIRO_TELEFONE2 = @TEL2, CAD_CELULAR_ACEITA = @CAD_CELULAR_ACEITA, CAD_CADASTRO_ATUALIZADO_EM = GETDATE() WHERE CAD_IND = @ind">
            <UpdateParameters>
                <asp:QueryStringParameter Name="ind" QueryStringField="ind" Type="Int32" />
                <asp:Parameter Name="ENDERECO" Type="String" />
                <asp:Parameter Name="NUMERO" Type="String" />
                <asp:Parameter Name="COMPLEMENTO" Type="String" />
                <asp:Parameter Name="BAIRRO" Type="String" />
                <asp:Parameter Name="CIDADE" Type="String" />
                <asp:Parameter Name="CEP" Type="String" />
                <asp:Parameter Name="CAD_ESTADO" Type="String" />
                <asp:Parameter Name="CEL_DDD" Type="String" />
                <asp:Parameter Name="CAD_CELULAR_ACEITA" Type="Boolean" />
                <asp:Parameter Name="CEL" Type="String" />
                <asp:Parameter Name="TEL1_DDD" Type="String" />
                <asp:Parameter Name="TEL1" Type="String" />
                <asp:Parameter Name="TEL2_DDD" Type="String" />
                <asp:Parameter Name="TEL2" Type="String" />
                <asp:Parameter Name="EMAIL" Type="String" />
                <asp:Parameter Name="EMAIL2" Type="String" />
                <asp:Parameter Name="EMAIL3" Type="String" />
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
                <tr>
                    <td colspan="2" style="text-align: right;">
                        <asp:LinkButton ID="btnFechar" runat="server" CssClass="sitebutton blue" OnClientClick="openProcess();">Fechar</asp:LinkButton>
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
                    <td colspan="2" style="text-align: right;">
                        <asp:LinkButton ID="btnFechar2" runat="server" CssClass="sitebutton blue" OnClientClick="openProcess();">Fechar</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </form>
</body>
</html>
