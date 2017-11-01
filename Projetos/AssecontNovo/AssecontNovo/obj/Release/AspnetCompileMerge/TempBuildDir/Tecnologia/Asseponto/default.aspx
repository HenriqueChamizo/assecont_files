<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Assecont2.Tecnologia.asseponto4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="http://www.assecont.com.br/assecont/Jquery/Arccodion/arccodion.js"></script>
    <link href="http://www.assecont.com.br/assecont/Styles/arccodion.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#buttons').akordeon({ buttons: true, toggle: true });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <center>
        <img src="../../Imagens/logos/logoAsseponto.png" />
    </center>
    <section>
        <flv:MenuLeftAsseponto4 runat="server" ID="MenuLeftAsseponto4" />
        <table style="width: 650px; float: left;">
            <tr>
                <td style="letter-spacing: 0.5px; padding-top: 15px;">
                    <b>SOFTWARE PARA APONTAMENTO DE HORAS E CONTROLE DE FREQUÊNCIA DE FUNCIONÁRIOS</b>
                </td>
            </tr>
            <tr>
                <td valign="top" style="text-align: right; color: gray">Atende as normas da <a target="_blank" href="http://portal.mte.gov.br/data/files/8A7C816A350AC8820135685CC74E1DCE/Portaria%201510%202009%20consolidada.pdf">Portaria 1.510/09
                    <br />
                    do Ministério do Trabalho e Emprego - MTE</a>.
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <b>Funcionalidades:</b>
                    <ul>
                        <li>Interface, totalmente amigável e parametrizável. </li>
                        <li>Gera AFDT (arquivo de Fonte de Dados Tratados, de acordo com anexo II da Portaria).</li>
                        <li>Gera ACJEF (arquivo de Controle de Jornada para efeitos fiscais), de acordo com anexo II da Portaria.</li>
                        <li>Atestado Técnico e Termo de Responsabilidade.</li>
                        <li>Total compatibilidade com os sistemas de Folha de pagamento existentes no mercado. Importa e exporta dados em arquivo configurável.</li>
                        <li>Possibilita descentralizar o apontamento através do organograma da empresa, via rede.</li>
                        <li>Senhas para usuários e funcionários com níveis de acesso, gerenciando pelo supervisor do sistema.</li>
                        <li>Horário de trabalho fixo, variável e móvel.</li>
                        <li>Controle de intervalo flexível.</li>
                        <li>Escala de revezamento automático.</li>
                        <li>Banco de horas flexível com lançamentos totais, parciais ou automáticos, opcionais de horas acrescidas, com limites mínimos, máximos e com lançamento configurável para a folha.</li>
                        <li>Histórico de fechamento mês a mês.</li>
                        <li>Compensação de extras e atrasos.</li>
                        <li>Cálculo de hora noturna (53'30), de acordo com o art.74 CLT.</li>
                        <li>Parametrização de cálculo, de acordo com sindicato ou acordo coletivo.</li>
                        <li>Registro de empregados e demais dados relativos ao acordo de trabalho.</li>
                    </ul>

                    <b>Relatórios</b>
                    <ul>
                        <li>Diversos relatórios gerenciais de horas tais como: horas trabalhadas, faltas atrasos, extras, banco de horas, variáveis de folha, abonos, etc.</li>
                        <li>Relatórios específicos e personalizados, com assistente em SQL exportáveis para Word, Excel, etc.</li>
                        <li>Espelho de Ponto.</li>
                        <li>Relatórios totalizados por data, departamento ou funcionários.</li>
                        <li>Relatório de Ocorrências ou Divergência.</li>
                    </ul>
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
