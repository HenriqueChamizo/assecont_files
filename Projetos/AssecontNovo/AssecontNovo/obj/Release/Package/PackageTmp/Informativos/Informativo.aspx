<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Informativo.aspx.cs" Inherits="AssecontNovo.Informativos.Informativo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section style="padding-bottom: 10px;">
        <asp:FormView ID="FormViewInfo" runat="server" DefaultMode="Edit" Width="830" DataSourceID="SqlData" DataKeyNames="INF_NUMERO">
            <EditItemTemplate>
                <table style="width: 830px;">
                    <tr>
                        <td>
                            <asp:Label ID="lbNumero" runat="server" Style="text-shadow: 0px 0px 0px #7C0000;" Font-Size="12pt" CssClass="font_red" Text='<%# "Número " + Eval("INF_NUMERO") %>'></asp:Label>
                            <br />
                            <asp:Label ID="lbData" runat="server" Text='<%# Eval("INF_DATA", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 8px; padding-bottom: 8px; font-size: 12pt; color: #1A4C83; text-shadow: 0px 0px 0px #A7ABB4; letter-spacing: 1px;">
                            <asp:Label ID="lbTitulo" runat="server" Text='<%# Bind("INF_TITULO") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbHTML" runat="server" Style="word-wrap: break-word;" Width="830" Text='<%# Bind("INF_HTML") %>'></asp:Label>
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
        </asp:FormView>
    </section>

    <section style="padding: 10px 0px 10px 0px; border-top: 3px solid lightgray; font-size: 12pt;">
        <p>
            <b>Cabeçalho/Rodapé Visivel</b>
            <asp:RadioButtonList ID="ChecklistCabecalhoRodape" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="1" Selected="True" Text="Sim"></asp:ListItem>
                <asp:ListItem Value="0" Text="Não"></asp:ListItem>
            </asp:RadioButtonList>
        </p>
    </section>
    <section style="padding: 6px 0px 20px 0px; border-top: 3px solid lightgray; font-size: 12pt;">
        <table>
            <tr>
                <td style="padding-bottom: 30px;">
                    <b>Assecont Contabilidade</b>
                    <br />
                    <asp:CheckBoxList ID="ChecklistAssecont" runat="server" CssClass="checkbox" RepeatDirection="Horizontal" />
                </td>
            </tr>
            <tr>
                <td style="padding-bottom: 30px;">
                    <b>Assecont Tecnologia</b>
                    <br />
                    <asp:CheckBoxList ID="ChecklistTecnologia" runat="server" CssClass="checkbox" RepeatDirection="Horizontal" />
                    <br />
                    <br />
                    <style type="text/css">
                        .inputDias {
                            border: 1px solid #ccc;
                            width: 4em;
                            height: 1.5em;
                            border-radius: 2px;
                        }
                    </style>
                    <table style="margin-left: 630px">
                        <tr>
                            <td>
                                <b><asp:Label ID="lbDias" runat="server" Text="Dias - "></asp:Label></b>
                            </td>
                            <td>
                                <asp:Label ID="lbDiasAntes" runat="server" Text="Antes: "></asp:Label>
                                <asp:TextBox ID="txtDiasAntes" runat="server" Text="" CssClass="inputDias"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="lbDiasDepois" runat="server" Text="Depois: "></asp:Label>
                                <asp:TextBox ID="txtDiasDepois" runat="server" Text="" CssClass="inputDias"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding-bottom: 30px;">
                    <b>Interno</b>
                    <br />
                    <asp:CheckBoxList ID="ChecklistInterno" runat="server" CssClass="checkbox" RepeatDirection="Horizontal" />
                </td>
            </tr>
        </table>
    </section>

    <asp:LinkButton ID="btEnviar" CssClass="sitebutton blue" runat="server" OnClick="btEnviar_Click">Enviar Informativo por e-mail <img src="../Imagens/24x24/OpenWhite24x24.png" /></asp:LinkButton>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

       <asp:LinkButton ID="btExcluir" CssClass="sitebutton grayDark" runat="server" OnClick="btExcluir_Click">Excluir Informativo <img src="../Imagens/24x24/Garbage24x24.png" /></asp:LinkButton>

    <asp:SqlDataSource ID="SqlData" runat="server" OnLoad="SqlData_Load"
        SelectCommand="SELECT * FROM Informativos WHERE INF_NUMERO = @ind">
        <SelectParameters>
            <asp:QueryStringParameter Name="ind" QueryStringField="ind" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
