<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="criarInformativo.aspx.cs" Inherits="Assecont2.Informativos.criarInformativo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <style type="text/css">
        #TextArea1
        {
            width: 829px;
            height: 176px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    Titulo<br />
    <asp:TextBox ID="txtTitulo" CssClass="textbox" runat="server" Width="830px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldTitulo" runat="server" ErrorMessage="Obrigatório" CssClass="sitevalidator" ControlToValidate="txtTitulo"></asp:RequiredFieldValidator>
    <br />
    <br />
    <%--    Capa *(apenas arquivos .jpeg, .png)  Tamanho: 560px;
    <br />
    <asp:FileUpload ID="FileUploadCapa" runat="server" />
    <asp:CustomValidator ID="CustomValidatorCapa" runat="server" OnServerValidate="CustomValidatorCapa_ServerValidate" CssClass="sitevalidator" ErrorMessage="Formato invalido"></asp:CustomValidator>
    <br />
    <br />--%>
    Texto
    <br />
    <asp:Timer ID="Timer1" runat="server"></asp:Timer>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="Timer1" />
        </Triggers>
        <ContentTemplate>
            <asp:TextBox ID="txtHtml" CssClass="textbox" runat="server" TextMode="MultiLine" Height="400px" Width="830px"></asp:TextBox>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Obrigatório" CssClass="sitevalidator" ControlToValidate="txtHtml"></asp:RequiredFieldValidator>
    <br />
    <br />
    <%--  Imagem *(apenas arquivos .jpeg, .png) Tamanho: 560px;
    <br />
    <asp:FileUpload ID="FileUploadImagem" runat="server" />
    <asp:CustomValidator ID="CustomValidatorImagem" OnServerValidate="CustomValidatorImagem_ServerValidate" CssClass="sitevalidator" runat="server" ErrorMessage="Formato invalido"></asp:CustomValidator>
    <br />
    <br />
    Rodapé
    <br />
    <asp:TextBox ID="txtRodape" CssClass="textbox" runat="server" Width="370px" TextMode="MultiLine" height="30px"></asp:TextBox>
    <br />
    <br />--%>
    <%--    Selecione o grupo:
    <br />
    <asp:CheckBox ID="ckAssecont" runat="server" Text="Assecont Contabilidade" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:CheckBox ID="ckTecnologia" runat="server" Text="Assecont Tecnologia" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:CustomValidator ID="CustomValidatorGrupo" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator" OnServerValidate="CustomValidatorGrupo_ServerValidate"></asp:CustomValidator>
    <br />
    <br />--%>
    <asp:LinkButton ID="lkPublicar" CssClass="sitebutton blue" runat="server" OnClick="lkPublicar_Click">Salvar</asp:LinkButton>
    &nbsp;&nbsp;&nbsp;
    <asp:LinkButton ID="lkCancelar" CssClass="sitebutton grayDark" runat="server" OnClick="lkCancelar_Click">Cancelar</asp:LinkButton>
</asp:Content>
