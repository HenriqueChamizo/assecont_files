<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MenuLeftPesquisa.ascx.cs" Inherits="Asseponto.WebControls.MenuLeftPesquisa" %>

<div id="sitemenuesquerdo">
    <div class="divMenuTitle">
        Totalizado
    </div>
    <telerik:radmenu id="RadMenu1" runat="server" flow="Vertical" skin="Wr" enableembeddedskins="false"
        width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Atendimento" NavigateUrl="~/Suporte/Pesquisa/default.aspx" />
                <telerik:RadMenuItem runat="server" Text="Satisfação" NavigateUrl="~/Suporte/Pesquisa/pesquisaSatisfacao.aspx" />
                <telerik:RadMenuItem runat="server" Text="Software" NavigateUrl="~/Suporte/Pesquisa/pesquisaAsseponto.aspx" />
                <telerik:RadMenuItem runat="server" Text="Treinamento" NavigateUrl="~/Suporte/Pesquisa/pesquisaTreinamento.aspx" />
             </Items>
        </telerik:radmenu>
    <div class="divMenuTitle">
        Detalhado
    </div>
    <telerik:radmenu id="RadMenu2" runat="server" flow="Vertical" skin="Wr" enableembeddedskins="false"
        width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Atendimento" NavigateUrl="~/Suporte/Pesquisa/pesquisaTecnicoDetalhado.aspx" />
                <telerik:RadMenuItem runat="server" Text="Satisfação" NavigateUrl="~/Suporte/Pesquisa/pesquisaSatisfacao.aspx" />
                <telerik:RadMenuItem runat="server" Text="Software" NavigateUrl="~/Suporte/Pesquisa/pesquisaAssepontoDetalhado.aspx" />
                <telerik:RadMenuItem runat="server" Text="Treinamento" NavigateUrl="~/Suporte/Pesquisa/pesquisaTreinamentoDetalhado.aspx" />
            </Items>
        </telerik:radmenu>
    <div class="divMenuTitle">
        Importação
    </div>
    <telerik:radmenu id="RadMenu3" runat="server" flow="Vertical" skin="Wr" enableembeddedskins="false"
        width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="BeAnywhere" NavigateUrl="~/Suporte/Pesquisa/pesquisaBeAnywhereUpload.aspx" />
            </Items>
        </telerik:radmenu>
</div>
