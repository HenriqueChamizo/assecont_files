<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="AssecontNovo.Holerite.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link href="~/Imagens/iconAssecontHolerite.ico" rel="icon" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:TextBox ID="txtID" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:LinkButton ID="lkFuncionario" runat="server" OnClick="LinkButton1_Click">Holerite Funcionario</asp:LinkButton>
        <br />
        <br />
        <asp:LinkButton ID="lkClientes" runat="server" OnClick="lkClientes_Click">Holerite Clientes</asp:LinkButton>
    </div>
    </form>
</body>
</html>
