<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConfirmarPedidoSenhaNova.aspx.cs" Inherits="Assecont2.Holerite.Email.ConfirmarPedidoSenhaNova" %>

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
                        <table>
                            <tr>
                                <td>
                                    <asp:Image ID="Image1" runat="server" Style="float: left; padding: 5px" ImageUrl="~/holerite/Imagens/Check.png" />
                                </td>
                                <td>
                                    <div style="padding: 12px 0px 0px 5px">
                                        Pedido enviado com sucesso.<br />
                                        <br />
                                        Dentro de alguns minutos receberá a nova senha no E-mail do seu cadastro.<br />
                                        <br />
                                        Atenciosamente,<br />
                                        <br />
                                        Assecont Contabilidade LTDA
                    <br />
                                        <br />
                                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="http://www.assecont.com.br"
                                            CssClass="sitelinkpadraoazul">Ir para Home</asp:HyperLink><br />
                                        <br />
                                    </div>
                                </td>
                            </tr>
                        </table>
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
