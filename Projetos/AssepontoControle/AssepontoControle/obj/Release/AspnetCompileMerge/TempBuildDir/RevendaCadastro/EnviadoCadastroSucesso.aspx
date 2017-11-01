<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ForaMasterPage.Master" AutoEventWireup="true" 
CodeBehind="EnviadoCadastroSucesso.aspx.cs" Inherits="Asseponto.Revenda.Cadastro.EnviadoCadastroSucesso" %>

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
                            Pedido enviado com sucesso para o departamento comercial.<br />
                            <br />
                            A confirmação será enviada pelo E-mail informado.<br />
                            <br />
                            Obrigado,<br />
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