<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="vantagensManutencao.aspx.cs" Inherits="Assecont2.Tecnologia.vantagensManutencao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section class="ContentText">
        <p>
            1) Adesão Contrato de Prestação de Serviços de Suporte Técnico
            <ul class="lista">
                <li>Suporte técnico operacional por; Acessos remotos, Skypes, Voips, telefones, E-mails, Chats.
                </li>
                <li>Atualizações up-grandes do software AssePonto.
                </li>
                <li>Acessoria e Consuloria leal sobre os dispostos na CLT, jurisprudências e Portarias sobre
                interjornada de trabalho (horas extras, tolerãncias minimas, acordos coletivos, etc).</li>
                <li>Acompanhamento para fechamento de ponto mês a mês.</li>
                <li>Senhas ilimitadas para reinstalações e novas instalações.</li>
                <li>Treinamentos Online, Skypes, Voips, Telefone.</li>
                <li>Orientação para operação do REP.</li>
                <li>Informativos, e-mails e revistas.</li>
            </ul>
            2) Contratação Avulso (30 dias) dos serviços de Suporte Técnico 
            <ul class="lista">

                <li>Não inclui atualizações up-grandes do software AssePonto.</li>
                <li>Serviços disponiveis por 30 dias a contar da data de pagamento.</li>
                <li>Liberação mediante comprovação do pagamento.</li>
            </ul>
            3) Contratação Avulso (por atendimento) de suporte Técnico 
            <ul class="lista">
                <li>Não inclui atualizações up-grandes do Software AssePonto.</li>
                <li>Liberação do serviço mediante comprovação do pagamento.</li>
            </ul>

            <br />
            <asp:HyperLink ID="hlinkOrcamento" runat="server" CssClass="sitebutton blue" NavigateUrl="~/Tecnologia/Formularios/FormularioSolicitacao.aspx?orc=3">Solicite um Orçamento  <img src="../../Imagens/24x24/OpenWhite24x24.png" /></asp:HyperLink>
            <br />
            <br />
            <br />
            Qualquer duvida estamos à disposição.
        </p>
    </section>
</asp:Content>
