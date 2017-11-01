<%@ Page Title="Questionario Atendimento" Language="C#" MasterPageFile="~/MasterPages/ForaMasterPage.Master" AutoEventWireup="true" CodeBehind="QuestAtendimento.aspx.cs" Inherits="Asseponto.Suporte.Questionarios.QuestAtendimento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <table class="formviewtable" style="font-size: 10pt">
        <tr>
            <td style="padding: 8px;">
                <asp:Label ID="Label1" runat="server" CssClass="formviewsubtitle">Pesquisa de satisfação do atendimento técnico do software Asseponto4</asp:Label>
                <br />
            </td>
        </tr>
        <tr>
            <td class="formviewtableinner" style="padding: 8px;">Prezado Sr. / Sra. Cliente, obrigado pela sua atenção. O objetivo deste questionário é nos ajudar a obter os melhores resultados. 
            </td>
        </tr>
        <tr>
            <td style="padding: 8px;"><b>Avalie a qualidade do atendimento.</b>
                <asp:RequiredFieldValidator ID="RequiredFieldAvalieSuporte" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator2" ControlToValidate="RbAvalieSuporte"></asp:RequiredFieldValidator><br />
                <br />
                <asp:RadioButtonList ID="RbAvalieSuporte" runat="server" CssClass="Radiolist" RepeatLayout="Flow" RepeatDirection="Vertical">
                    <asp:ListItem Value="4"> Ótimo&nbsp;&nbsp;<img src="../../Images/Quest/smyle_mto_satisfeito.png" width="25px" alt="" /></asp:ListItem>
                    <%--<asp:ListItem Value="3"> Bom&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../Images/Quest/smyle_satisfeito.png" width="25px" alt="" /></asp:ListItem>--%>
                    <asp:ListItem Value="2"> Regular&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../Images/Quest/smyle_insatisfeito.png" width="25px" alt="" /></asp:ListItem>
                    <asp:ListItem Value="1"> Ruim&nbsp;&nbsp;<img src="../../Images/Quest/smyle_mtoInsatisfeito.png" width="25px" alt="" /></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td style="padding: 8px;"><b>O atendente foi Gentil?</b>
                <asp:RequiredFieldValidator ID="RequiredFieldAtendenteGentil" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator2" ControlToValidate="RbAtendenteGentil"></asp:RequiredFieldValidator><br />
                <br />
                <asp:RadioButtonList ID="RbAtendenteGentil" runat="server" CssClass="Radiolist" RepeatLayout="Flow" RepeatDirection="Vertical">
                    <asp:ListItem Value="True">Sim</asp:ListItem>
                    <asp:ListItem Value="False">Não</asp:ListItem>
                </asp:RadioButtonList>

            </td>
        </tr>
        <tr>
            <td style="padding: 8px;"><b>O atendente foi Prestativo?</b>
                <asp:RequiredFieldValidator ID="RequiredFieldAtendentePrestativ" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator2" ControlToValidate="RbAtendentePrestativo"></asp:RequiredFieldValidator><br />
                <br />
                <asp:RadioButtonList ID="RbAtendentePrestativo" runat="server" CssClass="Radiolist" RepeatLayout="Flow" RepeatDirection="Vertical">
                    <asp:ListItem Value="True">Sim</asp:ListItem>
                    <asp:ListItem Value="False">Não</asp:ListItem>
                </asp:RadioButtonList>

            </td>
        </tr>
        <tr>
            <td style="padding: 8px;"><b>O atendente foi Rápido?</b>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator2" ControlToValidate="RbAtendentePrestativo"></asp:RequiredFieldValidator><br />
                <br />
                <asp:RadioButtonList ID="RbAtendenteRapido" runat="server" CssClass="Radiolist" RepeatLayout="Flow" RepeatDirection="Vertical">
                    <asp:ListItem Value="True">Sim</asp:ListItem>
                    <asp:ListItem Value="False">Não</asp:ListItem>
                </asp:RadioButtonList>

            </td>
        </tr>
        <tr>
            <td style="padding: 8px;"><b>O software Asseponto4 satisfaz as necessidades da empresa ?</b>
                <asp:RequiredFieldValidator ID="RequiredFieldSatisfazPonto4" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator2" ControlToValidate="RbSatisfazPonto4"></asp:RequiredFieldValidator><br />
                <br />
                <asp:RadioButtonList ID="RbSatisfazPonto4" runat="server" CssClass="Radiolist" RepeatLayout="Flow" RepeatDirection="Vertical">
                    <asp:ListItem Value="True">Sim</asp:ListItem>
                    <asp:ListItem Value="False">Não</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td style="padding: 8px;"><b>Por que?</b>
                <br />
                <br />
                <asp:TextBox ID="txtPqPonto4" runat="server" notnull="true" TextMode="MultiLine" Rows="4" Width="700px"></asp:TextBox>
                <br />
            </td>
        </tr>
        <tr>
            <td style="padding: 8px;"><b>Avalie o software Asseponto4.</b>
                <asp:RequiredFieldValidator ID="RequiredFieldAvaliePonto4" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator2" ControlToValidate="RbAvaliePonto4"></asp:RequiredFieldValidator><br />
                <br />
                <asp:RadioButtonList ID="RbAvaliePonto4" runat="server" CssClass="Radiolist" RepeatLayout="Flow" RepeatDirection="Vertical">
                    <asp:ListItem Value="4"> Ótimo&nbsp;&nbsp;<img src="../../Images/Quest/smyle_mto_satisfeito.png" width="25px" alt="" /></asp:ListItem>
                    <%--<asp:ListItem Value="3"> Bom&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../Images/Quest/smyle_satisfeito.png" width="25px" alt="" /></asp:ListItem>--%>
                    <asp:ListItem Value="2"> Regular&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../Images/Quest/smyle_insatisfeito.png" width="25px" alt="" /></asp:ListItem>
                    <asp:ListItem Value="1"> Ruim&nbsp;&nbsp;<img src="../../Images/Quest/smyle_mtoInsatisfeito.png" width="25px" alt="" /></asp:ListItem>
                </asp:RadioButtonList>

                <br />
            </td>
        </tr>
        <tr>
            <td style="padding: 8px;"><b>Indicaria o software AssePonto4 a outras empresas ?</b>
                <asp:RequiredFieldValidator ID="RequiredFieldIndicarPonto4" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator2" ControlToValidate="RbIndicarPonto4"></asp:RequiredFieldValidator><br />
                <br />
                <asp:RadioButtonList ID="RbIndicarPonto4" runat="server" CssClass="Radiolist" RepeatLayout="Flow" RepeatDirection="Vertical">
                    <asp:ListItem Value="True">Sim</asp:ListItem>
                    <asp:ListItem Value="False">Não</asp:ListItem>
                </asp:RadioButtonList>

            </td>
        </tr>
        <tr>
            <td style="padding: 8px;"><b>Para que possamos melhorar, você tem algum comentário/ alguma sugestão?</b>
                <br />
                <br />
                <asp:TextBox ID="txtSugestao" runat="server" TextMode="MultiLine" Rows="8" Width="700px"></asp:TextBox>
                <br />
            </td>
        </tr>
        <tr>
            <td style="padding: 8px;" colspan="2">
                <asp:LinkButton ID="lkEnviar" CssClass="sitebutton" runat="server" OnClick="lkEnviar_Click">Enviar</asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
