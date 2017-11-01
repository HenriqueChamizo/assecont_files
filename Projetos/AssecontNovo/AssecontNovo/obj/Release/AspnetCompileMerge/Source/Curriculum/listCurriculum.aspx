<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="listCurriculum.aspx.cs" Inherits="Assecont2.Curriculum.listCurriculum" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <asp:DataList ID="DlCurriulum" runat="server">
        <ItemTemplate>
            <table>
                <tr>
                    <td>
                        <asp:TextBox ID="txt" runat="server" Text='<%# Eval("CUR_NOME") %>'>' ></asp:TextBox>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataCurriculum" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT * FROM Curriculum" >
    </asp:SqlDataSource>
</asp:Content>
