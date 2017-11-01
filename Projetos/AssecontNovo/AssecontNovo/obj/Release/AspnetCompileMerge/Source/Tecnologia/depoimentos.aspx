<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="depoimentos.aspx.cs" Inherits="Assecont2.Tecnologia.depoimentos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <asp:FormView ID="FormViewInfo" runat="server" DefaultMode="Edit" Width="830" DataSourceID="SqlData" DataKeyNames="DEP_IND">
        <EditItemTemplate>
            <table style="width: 830px;">
                <tr>
                    <td>
                        <asp:Label ID="lbData" runat="server" Style="text-shadow: 0px 0px 0px #7C0000;" Font-Size="12pt" CssClass="font_red" Text='<%# "Escrito " + Eval("DEP_DATA", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 8px; border-top: 1px dotted #A7ABB4;">
                        <asp:Label ID="lbHTML" runat="server" Style="word-wrap: break-word;" Width="830" Text='<%# Eval("DEP_HTML") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 8px; padding-bottom: 8px; color: #1A4C83; text-shadow: 0px 0px 0px #A7ABB4;">
                        <asp:Label ID="lbTitulo" runat="server" Text='<%# Eval("DEP_AUTOR") %>'></asp:Label><br />
                        <asp:Label ID="lbcargo" runat="server" Text='<%# Eval("DEP_CARGO_AUTOR") %>'></asp:Label> na empresa 
                        <a href='<%# Eval("DEP_LINK_EMPRESA") %>' >
                                <asp:Label ID="lbAutor" runat="server" Text='<%# Eval("DEP_EMPRESA") %>'></asp:Label>
                        </a>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="SqlData" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionStringTecnologia %>"
        SelectCommand="SELECT * FROM AssepontoDepoimentos WHERE DEP_IND = @ind">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" QueryStringField="ind" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
