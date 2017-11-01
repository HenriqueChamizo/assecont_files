<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="AssecontNovo.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server" ></asp:ScriptManager>
<%--            <flv:ServerSpedFiscal id="serverViews" runat="server" Mes="6" Ano="2015" Cliente="51" />--%>
            <img class=""
            
         <flv:ServerControlePesquisa id="serverViews" runat="server" />
        </div>
    </form>
</body>
</html>
