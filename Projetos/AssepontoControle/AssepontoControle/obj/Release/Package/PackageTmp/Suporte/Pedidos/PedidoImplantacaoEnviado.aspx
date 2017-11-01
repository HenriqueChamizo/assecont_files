<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="PedidoImplantacaoEnviado.aspx.cs" Inherits="Asseponto.Suporte.Pedidos.PedidoImplantacaoEnviado" %>

<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <table>
                <tr>
                    <td>
                        <asp:Image ID="Image1" runat="server" Style="float: left; padding: 5px" ImageUrl="../../Images/48x48/Check.png" />
                    </td>
                    <td>
                        <div style="padding: 12px 0px 0px 5px">
                            Pedido enviado para implantação com sucesso<br />
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/suporte/Pedidos/default.aspx?status=1" CssClass="sitelinkpadraoazul">Ir para pedidos em aberto</asp:HyperLink><br />
                            <br />
                            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/suporte/Implantacoes/default.aspx?status=1"
                                CssClass="sitelinkpadraoazul">Ir para implantações em aberto</asp:HyperLink><br />
                            <br />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
