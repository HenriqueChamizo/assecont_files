<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/HoleriteCliente.Master" AutoEventWireup="true" CodeBehind="HoleriteNovaSenha.aspx.cs" Inherits="AssecontNovo.HoleriteFunc.HoleriteNovaSenha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <table class="sitetable">
        <tr>
            <td valign="top" class="text">
                <p><span style="font-size: 16pt; text-shadow: 0 0 0;">Redefinir sua senha</span></p>
                <p>
                    Para redefinir sua senha, informe seu CPF e Registro Funcional no campo Número do Registro com 5 dígitos para
                        encaminhar um nova senha no e-mail informado no cadastro.
                </p>
            </td>
        </tr>
        <tr>
            <td>CPF (Somente Números)
            </td>
        </tr>
        <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" SetFocusOnError="true"
                    ErrorMessage="Obrigatório" CssClass="sitevalidator" ControlToValidate="txtCPF" />
                <asp:TextBox ID="txtCPF" runat="server" MaxLength="12" Width="280px" Font-Size="12pt" />
            </td>
        </tr>
        <tr>
            <td>Número do Registro</td>
        </tr>
        <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" SetFocusOnError="true"
                    ErrorMessage="Obrigatório" CssClass="sitevalidator" ControlToValidate="txtRegistro"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtRegistro" runat="server" TextMode="Password" Width="280px" Font-Size="12pt" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbErro" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="sitebutton lightBlue" OnClick="LinkButton1_Click">Enviar</asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
