<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="spedFiscal.aspx.cs" Inherits="Assecont2.spedFiscal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h3 style="color: #0094ff">Petsmart Comercial LTDA - Competência 01/09/2014</h3>
            <h3>PRINCIPAIS CLIENTES POR FATURAMENTO</h3>
            <br />
            <asp:GridView ID="GridView1" runat="server" RowStyle-HorizontalAlign="Center" DataSourceID="SqlDataSource1"></asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                SelectCommand="EXEC rst_sped_principais_produtos 9, 2014, 549, 1"></asp:SqlDataSource>

            <br />
            <br />
            <h3>PRINCIPAIS PRODUTOS</h3>
            <asp:GridView ID="GridView2" runat="server" RowStyle-HorizontalAlign="Center" DataSourceID="SqlDataSource2"></asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                SelectCommand="EXEC rst_sped_principais_produtos 9, 2014, 549"></asp:SqlDataSource>

            <br />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
