<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CadastroAssefin.ascx.cs" Inherits="Asseponto.WebControls.CadastroAssefin" %>


<div>
    <table style="width: 600px; text-transform: uppercase; color: white; text-align: center; font-size: 11pt;">
        <tr>
            <td id="TdAssefin" runat="server" style="background-color: cadetblue; padding: 6px;">
                <asp:Label ID="lbMsgCadastroAssefin" runat="server" Text="" />
            </td>
        </tr>
        <tr>
            <td id="TdAtualizacao" runat="server" style="padding: 6px; background-color: #32648A;" >
                <asp:Label ID="lbMsgAtualizacao" runat="server" Text="" />
            </td>
        </tr>
    </table>
</div>
