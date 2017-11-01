<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AssecontNovo.AssepontoWeb._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="http://www.assecont.com.br/Jquery/Arccodion/arccodion.js"></script>
    <link href="http://www.assecont.com.br/Styles/arccodion.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#buttons').akordeon({ buttons: true, toggle: true });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <center>
        <img src="../../Imagens/logos/logoAssepontoWeb.png" style="width: 60%;margin: 40px auto" />
    </center>
    <section>
        <flv:MenuLeftAssepontoWeb runat="server" ID="MenuLeftAssepontoWeb" />
        <table style="width: 650px; float: left;">
            <tr>
                <td style="letter-spacing: 0.5px; padding-top: 15px;">
                    <b>SOFTWARE PARA APONTAMENTO DE HORAS E CONTROLE DE FREQUÊNCIA DE FUNCIONÁRIOS ONLINE</b>
                </td>
            </tr>
            <tr>
                <td valign="top" style="text-align: right; color: gray">Apontamento de Horas e Controle de Frequência de Funcionários pela Internet 
                    <a target="_blank" href="http://portal.mte.gov.br/data/files/8A7C816A350AC8820135685CC74E1DCE/Portaria%201510%202009%20consolidada.pdf">Portaria 1.510/09 <br /> Ministério do Trabalho e Emprego</a>.
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <p>A Assecont aplicou sua larga experiência nas rotinas trabalhistas e desenvolveu o software <b>AssePonto Web – Programa para Apontamento de Horas e Controle de Frequência de Funcionários pela Internet.</b>
                        Desenvolvido por programadores e contadores com larga experiência, foi concebido dentro das especificações e exigências da Portaria 1.510 publicada pelo Ministério do Trabalho e Emprego em 21/08/2009. 
                        Há 20 anos no mercado de controle de ponto, o software <b>AssePonto</b>, possui cerca de 15.000 usuários em todo Brasil!! Empresas de diversos segmentos, como; industrias, comércio, agroindustria, 
                        prestadores de serviços, hotéis, restaurantes, clubes, escolas, etc, empresas de  pequeno, médio e grande porte.
                    </p>

                    <b>Funcionalidades:</b>
                    <ul>
                        <li>Adequado à Portaria 1.510 25/08/2009 MTE</li>
                        <li>Interface! Totalmente amigável e parametrizável!!</li>
                        <li>Gera AFDT (Arquivo de Fonte de Dados Tratados) de acordo com anexo II da Portaria</li>
                        <li>Gera ACJEF (Arquivo de Controle de Jornada para Efeitos Fiscais de acordo com anexo II da Portaria</li>
                        <li>Atestado Técnico e Termo de Responsabilidade</li>
                        <li>Total compatibilidade com os sistemas de Folha de pagamento existentes no mercado (importa e exporta dados em arquivo configurável )</li>
                        <li>Possibilita descentralizar o apontamento através do organograma da empresa </li>
                        <li>Senhas para usuários e funcionários, com níveis de acesso gerenciado pelo  Adm do sistema </li>
                        <li>Horário de trabalho fixo, variável e móvel</li>
                        <li>Controle de intervalo flexível</li>
                        <li>Escala de revezamento automático</li>
                        <li>Banco de horas flexível com lançamentos totais, parciais ou automáticos com opcionais de horas acrescidas, com limites mínimos, máximos e com lançamento configurável para a folha</li>
                        <li>Histórico de fechamento mês a mês</li>
                        <li>Compensação de extras/ atrasos </li>
                        <li>Cálculo de hora noturna (52'30) de acordo com o art. 74 CLT</li>
                        <li>Parametrização de cálculo de acordo com sindicato ou acordo coletivo</li>
                        <li>Registro de empregados e demais dados relativos ao contrato de trabalho – portaria n. 1121 de 08/11/95 do Ministério do Trabalho do Estado de São Paulo DOU de 09/11/95 e certificada no de 13/11/95.</li>
                        <li>SMS para os funcionários  informando a situação de ponto </li>
                    </ul>

                    <%--<b>Relatórios</b>
                    <ul>
                        <li>Diversos relatórios gerenciais de horas tais como: horas trabalhadas, faltas atrasos, extras, banco de horas, variáveis de folha, abonos, etc.</li>
                        <li>Relatórios específicos e personalizados, com assistente em SQL exportáveis para Word, Excel, etc.</li>
                        <li>Espelho de Ponto.</li>
                        <li>Relatórios totalizados por data, departamento ou funcionários.</li>
                        <li>Relatório de Ocorrências ou Divergência.</li>
                    </ul>--%>
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
