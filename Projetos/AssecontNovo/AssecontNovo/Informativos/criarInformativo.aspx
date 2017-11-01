<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="criarInformativo.aspx.cs" Inherits="AssecontNovo.Informativos.criarInformativo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <style type="text/css">
        #TextArea1
        {
            width: 829px;
            height: 176px;
        }

        reTool .InsertSpecialLink
        {
            background-image: url(Custom.gif) !important;
        }

        .reTool .PrintPreview
        {
            background-image: url(CustomDialog.gif) !important;
        }

        .reTool .InsertEmoticon
        {
            background-image: url(Emoticons/1.gif) !important;
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

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <%--<asp:TextBox ID="txtHtml" CssClass="textbox" runat="server" ValidateRequestMode="Inherit" TextMode="MultiLine" Height="400px" Width="830px"></asp:TextBox>--%>
            <telerik:RadEditor runat="server" ID="RadEditor1" Width="860px" Height="1030px">
                <Tools>
                    <telerik:EditorToolGroup>
                        <telerik:EditorTool Name="Bold" Text="Negrito"></telerik:EditorTool>
                        <telerik:EditorTool Name="Italic" Text="Itálico"></telerik:EditorTool>
                        <telerik:EditorTool Name="Underline" Text="Sublinhado"></telerik:EditorTool>
                        <telerik:EditorTool Name="RealFontSize"></telerik:EditorTool>
                        <telerik:EditorTool Name="BackColor"></telerik:EditorTool>
                        <telerik:EditorTool Name="ForeColor"></telerik:EditorTool>
                        <telerik:EditorTool Name="InsertTable"></telerik:EditorTool>
                        <telerik:EditorTool Name="InsertOrderedList"></telerik:EditorTool>
                        <telerik:EditorTool Name="InsertUnorderedList"></telerik:EditorTool>
                        <telerik:EditorTool Name="JustifyLeft" Text="Esquerda"></telerik:EditorTool>
                        <telerik:EditorTool Name="JustifyCenter" Text="Centro"></telerik:EditorTool>
                        <telerik:EditorTool Name="JustifyRight" Text="Direita"></telerik:EditorTool>
                        <telerik:EditorTool Name="ToggleTableBorder" Text="Habilitar/Desabilitar redimensionar"></telerik:EditorTool>
                        <telerik:EditorTool Name="ToggleScreenMode" Text="Tela Inteira"></telerik:EditorTool>
                    </telerik:EditorToolGroup>
                </Tools>
            </telerik:RadEditor>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Obrigatório" CssClass="sitevalidator" ControlToValidate="RadEditor1"></asp:RequiredFieldValidator>
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
    <asp:LinkButton ID="lkPublicar" CssClass="sitebutton blue" runat="server" OnClick="lkPublicar_Click">Salvar</asp:LinkButton>
    &nbsp;&nbsp;&nbsp;
    <asp:LinkButton ID="lkCancelar" CssClass="sitebutton grayDark" CausesValidation="false" runat="server" OnClick="lkCancelar_Click">Cancelar</asp:LinkButton>
</asp:Content>
