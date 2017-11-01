<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Clientes.Master" AutoEventWireup="true" CodeBehind="_Login.aspx.cs" Inherits="Asseponto.Clientes.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpoboxinner">
        <div id="sitePanelDireito">
            <table style="background-color: #E9E9E9;">
                <tr>
                    <td style="height: 40px;">
                        <asp:Label ID="lbLogin" runat="server" CssClass="formviewsubtitle">Login</asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 10px;"><b>Informe o CNPJ ou CPF da empresa.</b>
                    </td>
                </tr>
                <tr>
                    <td style="height: 40px;">
                        <asp:TextBox ID="txtCnpjCpf" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbPrazo" ForeColor="Red" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 40px;">
                        <asp:LinkButton ID="lkEnviar" runat="server" CssClass="sitebutton" OnClick="lkEnviar_Click">Entrar</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <table style="font-family: Calibri; font-size: 13px;">
        <tr>
            <td style="padding-bottom: 20px;">
                    Cerca de 400 revendedores e 7000 usuários em
                    todo Brasil. Estamos integrados com alguns dos melhores fabricantes de REP do país,
                    atendendo empresas de todos os portes e segmentos: Indústria, Serviços, Varejo,
                    Educacional, Saúde, Manufatura, Logística, Construção, Agroindústria, entre outros.
            </td>
        </tr>
        <tr>
            <td>Clique nas imagens abaixo para maiores informações:<br />
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" ImageUrl="~/Images/Revenda/logoAsseponto.png"
                                OnClick="ImageButton2_Click" Width="350px" />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 20px;">
                            <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" ImageUrl="~/Images/Revenda/logoAssefin.png"
                                OnClick="ImageButton1_Click" Width="350px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
