<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ForaMasterPage.Master" AutoEventWireup="true" CodeBehind="DescadastrarEmail.aspx.cs" Inherits="Asseponto.Suporte.Util.DescadastrarEmail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
     <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <table>
                <tr>
                    <td>
                        <asp:Image ID="Image1" runat="server" Style="float: left; padding: 5px" ImageUrl="~/Images/48x48/Check.png" />
                    </td>
                    <td>
                        <div style="padding: 12px 0px 0px 5px">
                            E-mail descadastrado com sucesso.
                            <br />
                            <br />
                            <br />
                            Atenciosamente,<br />
                            <br />
                            Assecont Tecnologia <br />
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
</asp:Content>
