<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ForaMasterPage.Master" AutoEventWireup="true" CodeBehind="Proposta.aspx.cs" Inherits="Asseponto.Suporte.Formulario.Proposta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <table style="width: 100%; border-collapse: collapse" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td style="padding: 0px 20px 20px 20px;">
                <p>
                    <b>Prezado(a) Usuário(a),</b>
                </p>
                <p>
                    Lembramos que oferecemos gratuitamente por 60 dias os serviços de implantação, instalação, treinamento operacional (online), e suporte técnico para operação do Software AssePonto, e também, assessoria e consultoria legal, visando orientar os usuários sobre as práticas e rotinas trabalhistas, tais como, jurisprudências e portarias que regulamentam o controle de ponto.
                </p>
                <p>
                    A Assecont oferece 3 (três) opções para adesão aos serviços de suporte técnico do Software AssePonto.
                </p>
                <p style="padding: 0px 20px 20px 20px;">
                    <span class="font_red"><b>IMPORTANTE&nbsp;</b></span>As atualizações do Software AssePonto são disponibilizadas apenas mediante adesão ao Contrato de Prestação de Serviços de Suporte Tecnico, 
                        cliente poderá preencher os campos e enviar assianda digitalizada para o email <a class="font_Red" href="mailto:comercial@assecont.com.br">comercial@assecont.com.br </a>
                </p>
                <p>
                    <b>1) Adesão Contrato de Prestação de Serviços de Suporte Técnico Mensal</b><br />
                    <span style="color: #0094ff">(Vigências por 3, 6 ou 12 meses)</span>
                    <ul class="itens">
                        <li>a)&nbsp;&nbsp;Suporte técnico operacional por: Acessos remotos, Skypes, Voips, telefones, E-mails, Chats.</li>
                        <li>b)&nbsp;&nbsp;Atualizações up-grandes do software AssePonto.</li>
                        <li>c)&nbsp;Assessoria e Consultoria legal sobre os dispostos na CLT, jurisprudências e Portarias sobre interjornada de trabalho (horas extras tolerâncias mínimas, acordos coletivos, etc).</li>
                        <li>d)&nbsp;&nbsp;Acompanhamento para fechamento de ponto mês a mês.</li>
                        <li>e)&nbsp;&nbsp;Senhas ilimitadas para reinstalações e novas instalações.</li>
                        <li>f)&nbsp;&nbsp;Treinamentos Online, Skypes, Voips, Telefone.</li>
                        <li>g)&nbsp;&nbsp;Orientação para operação do REP.</li>
                        <li>h)&nbsp;&nbsp;Informativos, e-mails e revistas.</li>
                    </ul>
                </p>
                <p style="padding: 20px; -webkit-margin-after: 0;">
                    <a style="font-size: 13pt; color: white; padding: 4px 14px 6px 10px; background-color: #0094ff" href="http://www.asseponto.com.br/assepontocontrole/suporte/formulario/FormContratoManut.aspx" class="sitebutton">Clique aqui para consultar o valor</a>
                </p>
                <p style="-webkit-margin-after: 0;">
                    <b>2) Contratação Avulso (30 dias) dos serviços de Suporte Técnico Mensal</b>
                    <ul class="itens">
                        <li>b)&nbsp;&nbsp;Não inclui atualizações up-grandes do software AssePonto.</li>
                        <li>a)&nbsp;&nbsp;Serviços disponíveis por 30 dias a contar da data do pagamento.</li>
                        <li>c)&nbsp;&nbsp;Liberação mediante comprovação do pagamento.</li>
                    </ul>
                </p>
                <p style="padding-left: 20px; -webkit-margin-after: 0;">
                    <b style="font-size: 14pt;"><span style="font-size: 25pt; vertical-align: sub;">&gt; </span>
                        <asp:Label ID="lbContratacaoAvulso30dias" runat="server"></asp:Label>
                    </b>
                    <br />
                    Para adesão do serviço clique em "aderir Serviço".                     
                </p>
                <p style="padding: 20px; -webkit-margin-after: 0;">
                    <asp:LinkButton ID="btnbContratacaoAvulso30dias" runat="server" Style="font-size: 13pt; color: white; padding: 4px 14px 6px 10px; background-color: #0094ff" OnClick="btnbContratacaoAvulso30dias_Click" class="sitebutton">Aderir Serviço </asp:LinkButton>
                </p>
                <p style="-webkit-margin-after: 0; padding-top: 15px;">
                    <b>3) Contratação Avulso (por atendimento) de suporte Técnico </b>
                    <ul class="itens">
                        <li>a)&nbsp;&nbsp;Não inclui atualizações up-grandes do Software AssePonto.</li>
                        <li>b)&nbsp;&nbsp;Liberação do serviço mediante comprovação do pagamento.</li>
                    </ul>
                </p>
                <p style="padding-left: 20px; -webkit-margin-after: 0;">
                    <b style="font-size: 14pt;"><span style="font-size: 25pt; vertical-align: sub;">&gt; </span>
                        <asp:Label ID="lbContratacaoAvulso" runat="server"></asp:Label>
                    </b>
                    <br />
                    Para adesão do serviço clique em "aderir Serviço". 
                </p>
                <p style="padding: 20px; -webkit-margin-after: 0;">
                    <asp:LinkButton ID="btnContratacaoAvulso" runat="server" Style="font-size: 13pt; color: white; padding: 4px 14px 6px 10px; background-color: #0094ff" OnClick="btnContratacaoAvulso_Click" class="sitebutton">Aderir Serviço </asp:LinkButton>
                </p>
            </td>
        </tr>
        <tr>
            <td style="padding-left: 30px;">
                <p>Qualquer dúvida estamos a disposição.</p>
            </td>
        </tr>
    </table>
</asp:Content>
