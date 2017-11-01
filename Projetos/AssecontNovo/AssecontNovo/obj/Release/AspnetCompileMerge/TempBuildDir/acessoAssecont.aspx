<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="acessoAssecont.aspx.cs" Inherits="Assecont2.acessoAssecont" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section>
        <table>
            <tr>
                <td>
                    <br />
                    Login <br />
                    <input type="text" class="textbox" name="uid" value="" style="height: 15px; width: 150px;"/> 
                </td>
            </tr>
            <tr>
                <td>
                    Senha <br />
                     <input type="password" class="textbox" name="pwd" value="" style="height: 15px; width: 150px;"/> 
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <input type="hidden" name="logintipo" value="0">
                    <asp:LinkButton ID="lkLogar" runat="server" CssClass="sitebutton blue" PostBackUrl="http://www.assecont.com.br/check_login.asp" >Acessar <img src="Imagens/24x24/OpenWhite24x24.png" /></asp:LinkButton>
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
