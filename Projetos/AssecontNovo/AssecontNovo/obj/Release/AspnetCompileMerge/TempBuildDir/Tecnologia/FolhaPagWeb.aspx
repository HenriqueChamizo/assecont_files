<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="FolhaPagWeb.aspx.cs" Inherits="Assecont2.Tecnologia.FolhaPagWeb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <img src="../Imagens/Tecnologia/Pagina-Folha-de-Pagamento-Final.png" width="760" />

    <section class="ContentText">
        <table style="width: 400px">
            <tr>
                <td>
                    <br /><br />
                    <asp:HyperLink ID="lkCliqueAquiGratis" runat="server" CssClass="sitebutton blue" NavigateUrl="~/Tecnologia/Formularios/FormularioSolicitacao.aspx?orc=2">Solicite um més gratis
                        <img src="../Imagens/24x24/OpenWhite24x24.png" />
                    </asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td><br />
                    <asp:HyperLink ID="lkCliqueAquiOrcamento" runat="server" CssClass="sitebutton blue" NavigateUrl="~/Tecnologia/Formularios/FormularioSolicitacao.aspx?orc=1">Solicite um orçamento
                      <img src="../Imagens/24x24/OpenWhite24x24.png" />
                    </asp:HyperLink>
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
