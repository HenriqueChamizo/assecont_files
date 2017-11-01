<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Accounting.Master" AutoEventWireup="true" CodeBehind="form.aspx.cs" Inherits="AssecontNovo.Contabilidade.Cotacao.form" %>

<%@ Register Src="~/WebControl/MenuTopCotacao.ascx" TagPrefix="flv" TagName="MenuTopCotacao" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <style>
        .tableg td
        {
            padding-bottom: 10px;
            padding-right: 5px;
            float: left;
            margin-right: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <flv:MenuTopCotacao runat="server" ID="MenuTopCotacao" />
    <asp:FormView ID="FormViewSAC" runat="server" DefaultMode="Insert" OnDataBound="FormView1_DataBound" DataSourceID="SqlDataFormulario">
        <InsertItemTemplate>
            <table class="tableg">
                <tr>
                    <td colspan="2">
                        <p class="font_red">Preencha o formulário abaixo que entraremos em contato.</p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><b>Nome:</b>
                        <br />
                        <asp:TextBox ID="txtNome" runat="server" notnull="true" CssClass="textbox" Width="350"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><b>Email:</b>
                        <br />
                        <asp:TextBox ID="txtEmail" runat="server" notnull="true" CssClass="textbox" Width="350"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RExpressionEMAIL" runat="server" CssClass="sitevalidator"
                            Display="Dynamic" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td style="width: 190px;">
                        <b>Telefone:</b>
                        <br />
                        <asp:TextBox ID="txtTelefone" runat="server" notnull="true" CssClass="textbox" Width="150"></asp:TextBox>
                    </td>
                    <td><b>Celular:</b>
                        <br />
                        <asp:TextBox ID="txtCelular" runat="server" CssClass="textbox" Width="150"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><b>Sua Empresa já esta Constituída / Aberta ?</b>
                        <asp:RequiredFieldValidator ID="RFieldsConstituida" runat="server" ControlToValidate="rbConstituida" CssClass="sitevalidator2" ErrorMessage="Obrigatório"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:RadioButtonList ID="rbConstituida" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Sim" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Não" Value="0"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><b>Qual o ramo de Atividade de sua empresa ?</b>
                        <asp:RequiredFieldValidator ID="RfieldsRamoAtividade" runat="server" ControlToValidate="rbRamoAtividade" CssClass="sitevalidator2" ErrorMessage="Obrigatório"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:RadioButtonList ID="rbRamoAtividade" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Industria" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Comércio" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Serviços" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Autônomo" Value="4"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><b>Qual o Ramo de Exploração?</b>
                        <br />
                        <asp:TextBox ID="txtRamoExploracao" runat="server" notnull="true" CssClass="textbox" Width="350"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><b>Em qual Cidade Está ou Será Localizada Sua Empresa?</b><br />
                        <asp:TextBox ID="txtLocalizacao" runat="server" notnull="true" CssClass="textbox" Width="350"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><b>Qual o seu de Regime de Apuração?</b>
                        <asp:RequiredFieldValidator ID="RFieldsRegime" runat="server" ControlToValidate="rbRegime" CssClass="sitevalidator2" ErrorMessage="Obrigatório"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:RadioButtonList ID="rbRegime" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Simples Nacional" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Lucro Presumido" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Lucro Real" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Não Sei" Value="4"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><b>Qual seu Volume de Documentos ? Estimado:</b><br />
                    </td>
                </tr>
                <tr>
                    <td>• NF de Entrada N.º 
                        <asp:TextBox ID="txtNfEntrada" runat="server" CssClass="textbox" Width="150"></asp:TextBox>
                    </td>
                    <td>• NF de Saída  N.º 
                        <asp:TextBox ID="txtNfSaida" runat="server" CssClass="textbox" Width="150"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table>
                            <tr>
                                <td><b>Quantos Funcionários Registrados: </b>
                                    <asp:TextBox ID="txtFuncRegistrados" runat="server" notnull="true" MaxLength="3" CssClass="textbox" Width="150"></asp:TextBox>
                                </td>
                                <td>- <b>Pró-labore:</b>&nbsp;
                                    <asp:TextBox ID="txtProLabore" runat="server" notnull="true" MaxLength="3" CssClass="textbox" Width="150"></asp:TextBox>
                                </td>

                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><b>Como chegou até nós: </b>
                        <asp:RadioButtonList ID="rbChegou" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Revista" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Internet" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Sescon" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Indicação" Value="4"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><b>Indicação, Qual?</b><br />
                        <asp:TextBox ID="txtIndicacao" runat="server" CssClass="textbox" Width="350"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:LinkButton ID="lkEnviar" runat="server" OnClick="lkEnviar_Click" CssClass="sitebutton blue">Enviar</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDataFormulario" runat="server"></asp:SqlDataSource>
</asp:Content>
