<%@ Page Title="Questionario Treinamento" Language="C#" MasterPageFile="~/MasterPages/ForaMasterPage.Master" AutoEventWireup="true" CodeBehind="QuestTreinamento.aspx.cs" Inherits="Asseponto.Suporte.Questionarios.QuestTreinamento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <table class="formviewtable" style="font-size: 10pt">
        <tr>
            <td style="padding: 8px;">
                <asp:Label ID="Label1" runat="server" CssClass="formviewsubtitle">Pesquisa de Satisfação do Treinamento Asseponto4</asp:Label>
                <br />
            </td>
        </tr>
        <tr>
            <td class="formviewtableinner" style="padding: 8px;">Prezado Sr. / Sra. Cliente, obrigado pela sua atenção. O objetivo deste questionário é nos ajudar a obter os melhores resultados. 
            </td>
        </tr>
        <tr>
            <td style="padding: 8px;"><b>Voce encontrou dificuldades em realizar o acesso para nossa sala de treinamento virtual?</b>
                <asp:RequiredFieldValidator ID="validator1" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator2" ControlToValidate="dbDificuldatdes"></asp:RequiredFieldValidator><br /><br />
                <asp:RadioButtonList ID="dbDificuldatdes" runat="server" CssClass="Radiolist" RepeatLayout="Flow" RepeatDirection="Vertical"
                    notnull="true">
                    <asp:ListItem Value="True">Sim</asp:ListItem>
                    <asp:ListItem Value="False">Não</asp:ListItem>
                </asp:RadioButtonList>

            </td>
        </tr>
        <tr>
            <td style="padding: 8px;">
                <b>Com base em sua experiência, por favor, avalie a sua satisfação com nosso treinamento on-line.</b>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator2" ControlToValidate="dbExperiencia"></asp:RequiredFieldValidator><br /><br />
                <asp:RadioButtonList ID="dbExperiencia" runat="server" CssClass="Radiolist"
                    notnull="true" RepeatLayout="Flow">
                    <asp:ListItem Value="4"> Ótimo&nbsp;&nbsp;<img src="../../Images/Quest/smyle_mto_satisfeito.png" width="25px" alt="" /></asp:ListItem>
                    <%--<asp:ListItem Value="3"> Bom&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../Images/Quest/smyle_satisfeito.png" width="25px" alt="" /></asp:ListItem>--%>
                    <asp:ListItem Value="2"> Regular&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../Images/Quest/smyle_insatisfeito.png" width="25px" alt="" /></asp:ListItem>
                    <asp:ListItem Value="1"> Péssimo&nbsp;&nbsp;<img src="../../Images/Quest/smyle_mtoInsatisfeito.png" width="25px" alt="" /></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td style="padding: 8px;"><b>Para que possamos melhorar, você tem algum comentário/ alguma sugestão?</b>
                <br /><br />
                <asp:TextBox ID="txtSugestao" runat="server" notnull="true" TextMode="MultiLine" Rows="8" Width="700px" Text='<%# Bind("QUEST_TREI_OBS") %>'></asp:TextBox>
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
