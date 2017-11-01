<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addAnotacao.aspx.cs" Inherits="Asseponto.Suporte.Treinamentos.addAnotacao" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../Styles/Site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="txtTexto" runat="server" TextMode="MultiLine" Height="300px" Width="700px"></asp:TextBox>
            <p>
                <asp:LinkButton ID="lkAddAnotacao" CausesValidation="false"
                    runat="server" CssClass="sitebutton">Adicionar</asp:LinkButton>
            </p>
        </div>
    </form>
</body>
</html>
