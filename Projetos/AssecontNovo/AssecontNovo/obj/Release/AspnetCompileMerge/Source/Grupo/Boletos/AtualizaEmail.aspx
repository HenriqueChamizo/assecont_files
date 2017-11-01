<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AtualizaEmail.aspx.cs" Inherits="Assecont2.Grupo.Boletos.AtualizaEmail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="http://www.assecont.com.br/assecont/Styles/Site.css" rel="stylesheet" />
    <link href="http://www.assecont.com.br/assecont/Skins/ComboBox_flv.css" rel="stylesheet" />

    <style>
        #tableEmail
        {
            margin-top: 10px;
            border-collapse: collapse;
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
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>

            <asp:FormView ID="FV_ATUALIZAR_DADOS" runat="server" DefaultMode="Edit" DataKeyNames="CAD_IND" DataSourceID="sqlCadastro"
                OnDataBound="FV_ATUALIZAR_DADOS_DataBound">
                <EditItemTemplate>
                    <asp:Panel ID="Panel1" runat="server" EnableViewState="false">
                        <table id="tableEmail" border="0" cellspacing="0" cellpadding="0">
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
                                                <telerik:RadComboBox ID="txtEstado" runat="server" taSourceID="sqlEstados" Skin="flv" EnableEmbeddedSkins="false"
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
                                <td class="tableg"><span class="titulo">Email:</span>
                                    <br />
                                    <asp:TextBox ID="txtEmail1" runat="server" notnull="true" CssClass="textbox" Width="300" Text='<%# Bind("EMAIL") %>'></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tableg"><span class="titulo">Email 2:</span>
                                    <br />
                                    <asp:TextBox ID="txtEmail2" runat="server" CssClass="textbox" Width="300" Text='<%# Bind("EMAIL2") %>'></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tableg"><span class="titulo">Email 3:</span>
                                    <br />
                                    <asp:TextBox ID="txtEmail3" runat="server" CssClass="textbox" Width="300" Text='<%# Bind("EMAIL3") %>'></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tableg"><span class="titulo">Celular:</span>
                                    <br />
                                    <asp:TextBox ID="txtxCelDDD" runat="server" CssClass="textbox" Width="50" Text='<%# Bind("CEL_DDD") %>'></asp:TextBox>
                                    <asp:TextBox ID="txtCelular" runat="server" CssClass="textbox" Width="100" Text='<%# Bind("CEL") %>'></asp:TextBox>
                                    <asp:CheckBox ID="ChckCelular" runat="server" Text='<%# Convert.ToBoolean(Eval("CEL_ACEITA")) ? "Habilitado" : "Não Habilitado" %>' Checked='<%# Convert.ToBoolean(Eval("CEL_ACEITA")) %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="tableg" style="padding-top: 20px">
                                    <asp:LinkButton ID="lbAtualizarEmail" runat="server" CssClass="sitebutton blue" CommandName="Update" OnClick="lbAtualizarEmail_Click">
                                        Salvar Atualização
                                                    <asp:Image ID="imgaa" runat="server" ImageUrl="~/Imagens/24x24/OpenWhite24x24.png" />
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </EditItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="sqlEstados" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT EST_SIGLA, EST_NOME FROM Estados"></asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlCadastro" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionStringAssefin %>"
                SelectCommand="SELECT CAD_IND, RTRIM(CAD_RAZAOSOCIAL) AS RAZAOSOCIAL, RTRIM(CAD_ENDERECO) AS ENDERECO, RTRIM(CAD_ENDERECO_NUMERO) AS NUMERO,
                               RTRIM(CAD_COMPLEMENTO) AS COMPLEMENTO, RTRIM(CAD_BAIRRO) AS BAIRRO, RTRIM(CAD_CIDADE) AS CIDADE, RTRIM(CAD_CEP) AS CEP, CAD_ESTADO,
                               RTRIM(CAD_CELULAR_DDD) AS CEL_DDD, RTRIM(CAD_CELULAR) AS CEL, RTRIM(CAD_EMAIL) AS EMAIL, RTRIM(CAD_EMAIL2) AS EMAIL2, RTRIM(CAD_EMAIL3) AS EMAIL3,
                               (CASE WHEN CAD_CELULAR_ACEITA IS NULL THEN 0 ELSE CAD_CELULAR_ACEITA END) AS CEL_ACEITA
                               FROM Cadastros WHERE CAD_IND = @ind"
                UpdateCommand="UPDATE Cadastros SET CAD_ENDERECO = @ENDERECO, CAD_ENDERECO_NUMERO = @NUMERO, CAD_COMPLEMENTO = @COMPLEMENTO, CAD_BAIRRO = @BAIRRO, CAD_CIDADE = @CIDADE, 
                               CAD_CEP = @CEP, CAD_ESTADO = @CAD_ESTADO, CAD_CELULAR_DDD = @CEL_DDD, CAD_CELULAR = @CEL, CAD_EMAIL = @EMAIL, CAD_EMAIL2 = @EMAIL2, CAD_EMAIL3 = @EMAIL3,
                               CAD_CADASTRO_ATUALIZADO_EM = GETDATE() WHERE CAD_IND = @ind">
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
                    <asp:Parameter Name="CEL" Type="String" />
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
                </table>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
