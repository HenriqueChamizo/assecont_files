<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Boleto.aspx.cs" Inherits="AssecontNovo.Grupo.Boletos.Boleto" %>


<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>Assecont Contabilidade</title>
    <link href="../../Styles/Site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Panel ID="PanelAvisoItau" runat="server">
                <table style='width: 720px; background: #FCF9ED; margin-bottom: 10px; border: 5px solid rgb(244, 75, 75);'>
                    <tr>
                        <td style='text-align: center; font-weight: bold; font-size: 25pt; color: rgb(244, 75, 75);'>
                            <img src='../../Imagens/Email/aviso/Aviso.png' width='60' />AVISO </td>
                    </tr>
                    <tr>
                        <td style="padding: 0px 20px 20px 20px; font-size: 12pt;" >
                            <p>Caros clientes,</p>

                            <p>Acesse o site do Itaú para atualizar a data de vencimento de seu boleto, já com o cálculo de juros e multas.</p>
                               <p style="text-align: center; width: 100%;"> <a target="_blank" class="sitebutton red" href="https://www.itau.com.br/servicos/boletos/atualizar/">Clique aqui para atualizar </a></p>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
        </div>
    </form>
</body>
</html>
