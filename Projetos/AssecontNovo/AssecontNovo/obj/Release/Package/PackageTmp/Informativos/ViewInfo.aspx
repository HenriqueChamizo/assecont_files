<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="ViewInfo.aspx.cs" Inherits="AssecontNovo.Informativos.ViewInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <asp:FormView ID="FormViewInfo" runat="server" DefaultMode="Edit" Width="830" DataSourceID="SqlData" DataKeyNames="INF_NUMERO">
        <EditItemTemplate>
            <table style="width: 830px;">
                <tr>
                    <td>
                        <asp:Label ID="lbNumero" runat="server" style="text-shadow: 0px 0px 0px #7C0000;" Font-Size="12pt" CssClass="font_red" Text='<%# "Número " + Eval("INF_NUMERO") %>'></asp:Label>
                        <br />
                        <asp:Label ID="lbData" runat="server" Text='<%# Eval("INF_DATA", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 8px; padding-bottom: 8px; font-size: 12pt; color: #1A4C83; text-shadow: 0px 0px 0px #A7ABB4; letter-spacing: 2px;">
                        <asp:Label ID="lbTitulo" runat="server" Text='<%# Eval("INF_TITULO") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 8px; border-top: 1px dotted #A7ABB4;">
                        <asp:Label ID="lbHTML" runat="server" Style="word-wrap: break-word;" Width="830" Text='<%# Eval("INF_HTML") %>'></asp:Label>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="SqlData" runat="server" OnLoad="SqlData_Load"
        SelectCommand="SELECT * FROM Informativos WHERE INF_IND = @ind">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" QueryStringField="ind" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
