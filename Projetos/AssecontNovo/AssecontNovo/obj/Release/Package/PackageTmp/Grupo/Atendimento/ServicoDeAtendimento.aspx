<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="ServicoDeAtendimento.aspx.cs" Inherits="AssecontNovo.Grupo.Atendimento.ServicoDeAtendimento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <flv:MenuLeftAtendimento runat="server" ID="MenuLeftAtendimento" />
    <asp:FormView ID="FormViewSAC" runat="server" OnDataBound="FormView1_DataBound" DefaultMode="Insert" DataSourceID="SqlDataFormulario">
        <InsertItemTemplate>
            <table style="float: left; margin-right: 20px;">
                <tr>
                    <td>
                        <p style="color: red; font-weight: bold;">Entre em Contato</p>
                    </td>
                </tr>
                <tr>
                    <td>A Assecont interagindo com você.<br />
                        Gostaríamos de esclarecer suas dúvidas e deixá-lo sempre bem informado.
                    </td>
                </tr>
                <tr>
                    <td>1.	<b>Você é cliente Assecont ?</b>
                        <asp:RequiredFieldValidator ID="RFieldsCliente" runat="server" ControlToValidate="RadioButtonCliente" CssClass="sitevalidator2" ErrorMessage="Obrigatório"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:RadioButtonList ID="RadioButtonCliente" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Sim" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Não" Value="0"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td>2.	<b>Tipo da mensagem</b>
                        <asp:RequiredFieldValidator ID="RFieldsMensagem" runat="server" ControlToValidate="RadioButtonMensagem" CssClass="sitevalidator2" ErrorMessage="Obrigatório"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:RadioButtonList ID="RadioButtonMensagem" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Consulta" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Elogio" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Reclamação" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Sugestão" Value="4"></asp:ListItem>
                            <asp:ListItem Text="Outro" Value="5"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td>3.	<b>Produtos / Serviços </b>
                        <br />
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <telerik:RadComboBox ID="RadComboxProduto" runat="server" notnull="true" AutoPostBack="true" Width="400" Skin="flv" EnableEmbeddedSkins="false">
                                </telerik:RadComboBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>4.	<b>Assunto  </b>
                        <br />
                        <asp:TextBox ID="txtAssunto" runat="server" TextMode="MultiLine" notnull="true" Height="100" CssClass="textbox" Width="390"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:LinkButton ID="lkEnviar" runat="server" OnClick="lkEnviar_Click" CssClass="sitebutton blue">Enviar</asp:LinkButton>
                    </td>
                </tr>
            </table>
            <div valign="top" style="padding: 6px; float: left; border: 1px solid #ccc">
                Se preferir, entre em contato com:<br />
                <b>SAC (Serviço de Atendimento ao Consumidor)</b>
                <br />
                Atendimento horário comercial:
                    <br />
                <b>011 2173 8855</b><br />
                <br />
                Direitos do Consumidor:
                    <br />
                <a href="../../Arquivos/codigo-de-defesa.pdf" class="liksRapidos">Clique aqui e saiba mais...</a>
            </div>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDataFormulario" runat="server"></asp:SqlDataSource>
</asp:Content>
