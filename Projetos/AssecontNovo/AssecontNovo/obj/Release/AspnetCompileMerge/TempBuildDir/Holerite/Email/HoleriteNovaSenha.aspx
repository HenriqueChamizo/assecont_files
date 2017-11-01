<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HoleriteNovaSenha.aspx.cs" Inherits="Assecont2.Holerite.Email.HoleriteNovaSenha" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="~/holerite/Site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div id="bodywrapper">
            <div id="siteheaderwrapper">
                <div>
                    <asp:Image ID="sitetopologotipo" runat="server" ImageUrl="~/holerite/Imagens/Logo.png" />
                </div>
            </div>
            <div id="siteconteudowrapper">
                <div id="siteconteudo">
                    <div id="sitecorpo">
                        <br />
                        <br />
                        <b>
                            <asp:Label ID="lbTitulo" runat="server" Text="Redefinir sua senha" Font-Size="18px"></asp:Label></b>
                        <br />
                        <br />
                        Para redefinir sua senha, informar seu CPF e número do registro para<br />
                        encaminhar um nova senha no e-mail informado no cadastro.
                        <br />
                        <br />
                        CPF (Somente Números)&nbsp;
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Obrigatorio" ControlToValidate="txtCPF" ForeColor="Red"></asp:RequiredFieldValidator><br />
                        <asp:TextBox ID="txtCPF" runat="server" MaxLength="12"></asp:TextBox><br />
                        Nº REGISTRO&nbsp;
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Obrigatorio" ControlToValidate="txtRegistro" ForeColor="Red"></asp:RequiredFieldValidator><br />
                        <asp:TextBox ID="txtRegistro" runat="server" TextMode="Password"></asp:TextBox><br />
                        <asp:Label ID="lbErro" runat="server" ForeColor="Red"></asp:Label><br />
                        <br />
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="sitebutton" OnClick="LinkButton1_Click">Enviar</asp:LinkButton>
                        <br />
                        <br />
                    </div>
                </div>
            </div>
            <div id="siteRodape" style="text-align: center">
                <asp:Label ID="Label1" runat="server" Text=" End.: Rua Mario, 194 - Vila Romana – São Paulo/SP – CEP.: 05048-010 - Tel.: (11)
            2173-8888"></asp:Label>
                <br />
                <asp:Label ID="Label2" runat="server" Text="©2013 Assecont Contabilidade LTDA - Todos os direitos reservados."></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
