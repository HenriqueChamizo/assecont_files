<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UltimasEmpresas.ascx.cs"
    Inherits="Asseponto.WebControls.UltimasEmpresas" %>
<div id="UltimasEmpresasWrapper" runat="server">
    <table>
        <tr>
            <td valign="top">
                <img runat="server" id="imageTitulo" alt="Últimas empresas" />
            </td>
            <td valign="top">
                <strong class="siteTituloDestaque">
                    <asp:Label ID="linkNPedidos" runat="server" ForeColor="#606160">Últimas empresas atendidas</asp:Label>
                </strong>
                <div id="divUltimasEmpresas" runat="server">
                </div>
            </td>
        </tr>
    </table>
</div>
