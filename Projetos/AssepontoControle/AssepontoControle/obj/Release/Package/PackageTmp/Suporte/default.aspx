<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="default.aspx.cs" Inherits="Asseponto.Suporte._default" %>

<%@ Register Src="~/WebControls/AssecontNews.ascx" TagPrefix="wr" TagName="AssecontNews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <wr:PedidosResumo runat="server" ID="PedidosResumo1" />
            <wr:SolicitacoesResumo ID="SolicitacoesResumo1" runat="server"/>
            <wr:SolicitacoesResumoRevenda runat="server" ID="SolicitacoesResumoRevenda" />
            <wr:ImplantacoesResumo runat="server" ID="ImplantacoesResumo1" />
   <%--         <wr:AssecontNews runat="server" ID="AssecontNews" />--%>
            <wr:UltimasEmpresas ID="UltimasEmpresas1" runat="server" NavigateUrl="~/suporte/Atendimento/Cliente.aspx" ImageUrl="../Images/48x48/Factory.png"   />
            <wr:PendenciasResumo ID="PendenciasResumo1" runat="server" PendenciaTipo="0"/>
            <wr:PendenciasResumo ID="PendenciasResumo2" runat="server" PendenciaTipo="2"/>
        </div>
    </div>
    <script type="text/javascript">
        var varHash = "781e37cd5245c8e858d225bedc7330aacc0bf860";
        (function() { 
        var atendV = document.createElement('script'); atendV.type = 'text/javascript'; atendV.async = true;
            atendV.src =  'http://www.atendentevirtualnoseusite.com/js/script-atendente.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(atendV, s);
        })();
    </script>
</asp:Content>
