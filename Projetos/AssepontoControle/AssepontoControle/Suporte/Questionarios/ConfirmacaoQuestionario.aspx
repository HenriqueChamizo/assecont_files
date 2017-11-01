<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ForaMasterPage.Master" AutoEventWireup="true" CodeBehind="ConfirmacaoQuestionario.aspx.cs" Inherits="Asseponto.Suporte.Questionarios.ConfirmacaoQuestionario" %>

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
                        <asp:Image ID="Image1" runat="server" Style="float: left; padding: 5px" ImageUrl="../../Images/48x48/Check.png" />
                    </td>
                    <td>
                        <div style="padding: 12px 0px 0px 5px;  font-size: 14pt;" >
                            Questionário enviado com sucesso<br />
                            <br />

                            Obrigado pela participação.
                            <br />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
