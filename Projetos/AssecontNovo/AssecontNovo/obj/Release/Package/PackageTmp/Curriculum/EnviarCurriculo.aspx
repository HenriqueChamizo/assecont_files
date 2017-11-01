<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="EnviarCurriculo.aspx.cs" Inherits="AssecontNovo.Curriculum.EnviarCurriculo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <style>
        #RadComboxZona .rcbInputCell .rcbInput
        {
            height: 28px;
        }

       
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <table id="boxLogin" style="padding-left: 30px; width: 450px">
        <tr>
            <td colspan="2">
                <p><span style="font-size: 16pt; text-shadow: 0 0 0;">Faça parte da equipe da Assecont !</span></p>
                <p><span style="font-size: 12pt; text-shadow: 0 0 0;">Envie o seu curriculo em breve entraremos em contato.</span></p>
            </td>
        </tr>
        <tr>
            <td colspan="2">Cargo Pretendido<br />
                <asp:RequiredFieldValidator ID="RequiredFieldCargo" CssClass="sitevalidator" Style="margin-left: 320px;" runat="server" ErrorMessage="Obrigatório" ControlToValidate="txtObjetivo"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtObjetivo" CssClass="textbox" runat="server" Height="25" Font-Size="12pt" Width="350px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2">Salário Pretendido<br />
                <asp:TextBox ID="txtSalario" CssClass="textbox" runat="server" Height="25" Width="350"></asp:TextBox>
            </td>
        </tr>
        
        <tr>
            <td colspan="2">
                <p><span style="font-size: 16pt; text-shadow: 0 0 0;">Dados Pessoais</span></p>
            </td>
        </tr>
        <tr>
            <td colspan="2">Nome<br />
                <asp:RequiredFieldValidator ID="RequiredFieldNome" CssClass="sitevalidator" runat="server" Style="margin-left: 320px;" ErrorMessage="Obrigatório" ControlToValidate="txtNome"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtNome" CssClass="textbox" runat="server" Height="25" Width="350"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2">E-mail<br />
                <asp:RequiredFieldValidator ID="RequiredFieldEmail" Display="Dynamic" CssClass="sitevalidator" Style="margin-left: 320px;" runat="server" ErrorMessage="Obrigatório" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionEMAIL" runat="server" CssClass="sitevalidator" Style="margin-left: 320px;"
                    Display="Dynamic" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                <asp:TextBox ID="txtEmail" CssClass="textbox" Height="25" Width="350" runat="server"></asp:TextBox>

            </td>
        </tr>
        <tr>
            <td colspan="2">Sexo
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldSexo" CssClass="sitevalidator" runat="server" Style="margin-left: 150px;" ErrorMessage="Obrigatório" ControlToValidate="RblSexo"></asp:RequiredFieldValidator>
                <asp:RadioButtonList ID="RblSexo" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Feminino" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Masculino" Value="1"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td colspan="2">Bairro<br />
                <asp:RequiredFieldValidator ID="RequiredFieldBairro" CssClass="sitevalidator" runat="server" Style="margin-left: 320px;" ErrorMessage="Obrigatório" ControlToValidate="txtBairro"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtBairro" CssClass="textbox" runat="server" Height="25" Width="350"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2">Zona<br />
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <telerik:RadComboBox ID="RadComboxZona" runat="server" notnull="true" OnLoad="RadComboxZona_Load"
                            AutoPostBack="true" Width="350" Skin="flv" EnableEmbeddedSkins="false" CausesValidation="false">
                        </telerik:RadComboBox>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr colspan="2">
            <td>Telefone<br />
                <asp:RequiredFieldValidator ID="RequiredFieldTelefone" CssClass="sitevalidator" runat="server" Style="margin-left: 320px;" ErrorMessage="Obrigatório" ControlToValidate="txtTelefone"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtTelefone" CssClass="textbox" runat="server" Height="25" MaxLength="20" Width="350"></asp:TextBox>
            </td>
        </tr>
        <tr colspan="2">
            <td>Celular<br />
                <asp:TextBox ID="txtCelular" CssClass="textbox" runat="server" Height="25" MaxLength="20" Width="350"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table>
                    <tr>
                        <td  class="Upload">
                            <p><span style="font-size: 14pt; text-shadow: 0 0 0;">Curriculum</span></p>
                            <asp:FileUpload ID="FUCurriculum" runat="server" Font-Size="12pt"  />
                            <br />
                            <p><span style="font-size: 10pt; text-shadow: 0 0 0;">*Apenas arquivos .PDF / Tamanho máximo 4 MB</span></p>
                        </td>
                        <td>
                            <asp:CustomValidator ID="CustomValidatorCurriculo" runat="server" ErrorMessage="Anexo Invalido" CssClass="sitevalidator2" OnServerValidate="CustomValidatorCurriculo_ServerValidate"></asp:CustomValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="padding-top: 20px;">
                <asp:LinkButton ID="lkEnviar" runat="server" CssClass="sitebutton blue" Font-Size="16pt" OnClick="lkEnviar_Click">Enviar os dados
                    <img src="../Imagens/24x24/OpenWhite24x24.png" />
                </asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
