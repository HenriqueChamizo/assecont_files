<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="pesquisaBeAnywhereUpload.aspx.cs" Inherits="Asseponto.Suporte.Pesquisa.pesquisaBeAnywhereUpload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
       <flv:MenuLeftPesquisa runat="server" id="MenuLeftPesquisa" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <asp:Label ID="lb" runat="server" Font-Size="16pt" Text="Planilha Atendimento"></asp:Label>
            <br />
                <asp:Label ID="ltUltimoEnvio" runat="server" CssClass="font_red" Font-Size="13pt" Text=""></asp:Label>
            <br />
            <br />
            <p>
                <asp:FileUpload ID="fupArquivo" runat="server" />
            </p>
            <p style="padding-left: 5px;">
                <asp:LinkButton ID="btnImportarPlanilha" runat="server" CssClass="sitebutton" BackColor="#808080"  OnClick="btnImportarPlanilha_Click">Importar Planilha</asp:LinkButton>
            </p>
            <div>
                <asp:Literal ID="ltError" runat="server"></asp:Literal>
            </div>
            <br />
            <p>
                Observação:
                <br />
                1) O nome dos Técnicos cadastrado no AssepontoControle tem que estar escrito igual do BeAnywhere.<br />
                2) Abra o arquivo gerado no BeAnywhere e salve novamente no formato em .xls para poder realizar a importação dos dados.<br />
            </p>
        </div>
    </div>
</asp:Content>
