<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Accounting.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AssecontNovo.Contabilidade.Cotacao._default" %>

<%@ Register Src="~/WebControl/MenuTopCotacao.ascx" TagPrefix="flv" TagName="MenuTopCotacao" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <flv:MenuTopCotacao runat="server" ID="MenuTopCotacao" />
    <section class="ContentText">
        <p>
            <div class="titleSubs font_red">
                Por que Mudar?
            </div>
        </p>
        <p>
            Conte com a solidez e segurança de um parceiro que, desde 1978 esta lado a lado com seus clientes e investe fortemente em novos produtos e serviços
                     e no capital humano, visando garantir a qualidade no atendimento e fornecendo elementos para facilitar o gerenciamento do seu negócio;
                    
        </p>
        <p>
            Empresa Certificada com ISO 9001 e PQEC - Programa de Qualidade de Empresas Contábeis do Sescon/SP  desde 2006;
        </p>
        <p>
            <a target="_blank" href="http://www.assecont.com.br/grupo/NbrIso.aspx" class="sitebutton blue">SISTEMA DE GESTÃO DA QUALIDADE ABNT NBR ISO 9001
                        <img src="http://www.assecont.com.br/Imagens/24x24/OpenWhite24x24.png" /></a><br />
        </p>
        <p>
            <a target="_blank" href="http://www.assecont.com.br/grupo/contabeisPqec.aspx" class="sitebutton blue">PROGRAMA DE QUALIDADE DE EMPRESAS CONTÁBEIS - PQEC
            <img src="http://www.assecont.com.br/Imagens/24x24/OpenWhite24x24.png" /></a><br />

        </p>
    </section>
</asp:Content>
