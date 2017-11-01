<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="EnviarCurriculo.aspx.cs" Inherits="Assecont2.Curriculum.EnviarCurriculo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <table>
        <tr>
            <td colspan="2">Faça parte da equipe da Assecont !
                <br />
                Envie o seu curriculum em breve entraremos em contato.
            </td>
        </tr>
        <tr>
            <td>Nome<br />
                <asp:TextBox ID="txtNome" CssClass="textbox" runat="server" Height="25" Width="350"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldNome" CssClass="sitevalidator" runat="server" ErrorMessage="Obrigatório" ControlToValidate="txtNome"></asp:RequiredFieldValidator>
            </td>
            <td>Telefone<br />
                <asp:TextBox ID="txtTel" CssClass="textbox" placeholder="DDD XXXX - XXXX" Height="25" Width="180" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldTelefone" CssClass="sitevalidator" runat="server" ErrorMessage="Obrigatório" ControlToValidate="txtTel"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td colspan="2">E-mail<br />
                <asp:TextBox ID="txtEmail" CssClass="textbox" Height="25" Width="350" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldEmail" Display="Dynamic" CssClass="sitevalidator" runat="server" ErrorMessage="Obrigatório" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionEMAIL" runat="server" CssClass="sitevalidator"
                    Display="Dynamic" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
            </td>
        </tr>

        <tr>
            <td colspan="2">Objetivo<br />
                <asp:TextBox ID="txtObjetivo" placeholder="Objetivo" CssClass="textbox" Height="25" Width="350" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorObjetivo" CssClass="sitevalidator" runat="server" ErrorMessage="Obrigatório" ControlToValidate="txtObjetivo"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td colspan="2">Curriculum:
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <asp:FileUpload ID="FUCurriculum" runat="server"   />
                <br />
                *Apenas arquivos .PDF / Tamanho máximo 4 MB
            </td>
            <td>
                <asp:CustomValidator ID="CustomValidatorCurriculo" runat="server" ErrorMessage="Anexo Invalido" CssClass="sitevalidator2" OnServerValidate="CustomValidatorCurriculo_ServerValidate"></asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:LinkButton ID="lkEnviar" runat="server" CssClass="sitebutton blue" OnClick="lkEnviar_Click">Enviar</asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
