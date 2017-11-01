<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="vantagens.aspx.cs" Inherits="AssecontNovo.Tecnologia.AssepontoWeb.requisitosDeInstalacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <div style="padding-top:15px">
        <flv:MenuLeftAssepontoWeb runat="server" id="MenuLeftAsseponto4" />
        <section class="ContentText" style="width: 780px">
            <img src="../../Imagens/AssepontoWeb/vantagens-assepontoweb.png" style="width: 100%;margin: 0px 0px 15px 0px;" />
            <ul>
                <li>Utilizando o AssepontoWeb pode-se acessar o apontamento de horas dos funcionários de qualquer parte do mundo</li>
                <li>Permite acompanhar e gerenciar a frequência dos funcionários pela internet</li>
                <li>TRatamento de ponto: consultas, lançamentos, pré-justificativas, abonos, escalas, banco de horas, férias, afastamentos, horas extras, adc noturno, etc.</li>
                <li>Envia por SMS ou email da situação de ponto dos funcionários.</li>
                <li>Emite relatórios legais e gerenciais</li>
                <li>Exporta arquivo devidamente tratato para o sistema de folha de pagamento</li>
                <li>Espelho de Ponto Eletrônico</li>
            </ul>
            <h3>Senhas de acessos por níveis de usuários: </h3>
            <p>O assepontoWeb permite criar senhas de acesso de acordo com o perfil dos usuários</p>
            <ol>
                <li><b>Funcionários: </b>permite consultar o apontamento PELO CELULAR (Smartphone) ou computador, resultados 
                    banco de horas, lançar pré-justificativas, anexar atestados (foto) e outros tipos de justificativas e afastamentos.</li>
                <li><b>Usuários: </b> O pessoal a nível chefia tem acesso exclusivo para consulta, aceitar ou não as pré-justificativas
                    dos funcionários e efetuar justificativas entre outros tratamentos
                </li>
                <li><b>Supervisor ou Gerencia: </b>Efetua e avalia o fechamento do apontamento de horas, envia variáveis para 
                    a folha de pagamento, emite os relatórios gerenciais e legais.
                </li>
            </ol>
            <h3>Segurança e Backup</h3>
            <p>Como os dados ficam registrados em nosso servidor, fazemos backups diários do banco de dados, não sendo necessário se 
                preocupar com a segurança das informações. Havendo necessidade disponibilizamos a qualquer momento os apontamentos 
                anteriores para apresentação a fiscalização ou consulta.
            </p>
            <h3>Versões sempre atualizadas</h3>
            <p><b>O AssePontoWeb </b>é operado 100% via navegador (IE, Opera, Google Chrome, Firefoz, etc.) você sempre estará utilizando 
                a ultima versão, ou seja, recursos novos e melhorias, estarão á sua disposição sempre que forem disponibilizados sem nenhum custo adicional.
            </p>
            <h3>Suporte On-Line</h3>
            <p>Sistema de suporte online viabilizando e otimizando ainda mais a prest~ção de serviço, alem de Chat, Skype, telefone e/ou via internet para a 
                solução de suas dúvidas, sugestões e críticas.
            </p>
            <ul>
                <li>Desenvolvido em ASP.NET</li>
                <li>Banco de Dados SQL Server da Microsoft</li>
            </ul>
        </section>
    </div>
</asp:Content>
