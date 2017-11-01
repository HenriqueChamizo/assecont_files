<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Accounting.Master" AutoEventWireup="true" 
    CodeBehind="gestaoTrabalhista.aspx.cs" Inherits="AssecontNovo.Contabilidade.gestaoTrabalhista" %>

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
    <section class="ContentText">
        <p>
            A burocracia estatal na área trabalhista e previdenciária são enormes. Quase todas as empresas brasileiras, 94%, 
            enfrentam ou já enfrentaram reclamações trabalhistas. São ações que geram custos altos e desgastes, 
            podendo comprometer a continuidade dos negócios.
        </p>
        <p>
            Por outro lado, as empresas, ainda, deverão observar todas as normas previstas na legislação em vigor
             e todos os procedimentos objeto de fiscalização por parte do Ministério do Trabalho.
        </p>
        <p>
            A Assecont Contabilidade possui profissionais com muitos anos de experiência área trabalhista e previdenciária, 
            com formação superior em Recursos Humanos, sempre atualizados com diversos cursos e palestras,
             que gerenciarão toda rotina de folha de pagamento de sua empresa com eficiência, minimizando, ao máximo,
             os riscos de autuações, e reduzindo o impacto e desgastes de uma Reclamação Trabalhista.
        </p>
        <div id="demo-wrapper">
            <div class="akordeon" id="buttons">
                <div class="akordeon-item expanded">
                    <div class="akordeon-item-head">
                        <div class="akordeon-item-head-container">
                            <div class="akordeon-heading">
                                1)	ASSEPONTO4
                            </div>
                        </div>
                    </div>
                    <div class="akordeon-item-body">
                        <div class="akordeon-item-content">
                            <ul>
                                <li>A Assecont Contabilidade disponibiliza aos seus clientes, seu software ASSEPONTO4 – 
                                    Apontamento de Horas e Controle de Frequência de Funcionários, que fará todo o gerenciamento
                                     de ponto da sua empresa e enviará um arquivo devidamente tratado para o nosso sistema de folha.
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="akordeon-item">
                    <div class="akordeon-item-head">
                        <div class="akordeon-item-head-container">
                            <div class="akordeon-heading">
                                2)	Folha de Pagamento - Rotinas Mensais
                            </div>
                        </div>
                    </div>
                    <div class="akordeon-item-body">
                        <div class="akordeon-item-content">
                            <ul>
                                <li>Processo de admissão e registro eletrônico de funcionários;
                                </li>
                                <li>Controle de Férias vencidas e emissão do recibo;
                                </li>
                                <li>Cálculo, Emissão e Homologações de Rescisões Trabalhistas.
                                </li>
                                <li>Emissão da Folha de Pagamento, com os descontos legais permitidos e diversos relatórios;
                                </li>
                                <li>Emissão da Folha de Pró-Labore com os descontos legais permitidos;
                                </li>
                                <li>Emissão de Tributos e Encargos Sociais: GFIP – GPS – IRRF – GRCS;
                                </li>
                                <li>Contribuições Assistenciais, confederativas e associativas;
                                </li>
                                <li>Emissão e entrega do Cadastro Geral de Empregados e Desempregados - CAGED
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="akordeon-item">
                    <div class="akordeon-item-head">
                        <div class="akordeon-item-head-container">
                            <div class="akordeon-heading">
                                3)	Obrigações Acessórias
                            </div>
                        </div>
                    </div>
                    <div class="akordeon-item-body">
                        <div class="akordeon-item-content">
                            <ul>
                                <li>Comprovante Anual de Rendimentos Pagos e de Retenção de Imposto de Renda na Fonte - Pessoa Física;
                                </li>
                                <li>RAIS - Relação Anual de Informações Sociais;
                                </li>
                                <li>Acompanhamento e aplicação de Dissídios Coletivos;
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="akordeon-item">
                    <div class="akordeon-item-head">
                        <div class="akordeon-item-head-container">
                            <div class="akordeon-heading">
                                4)	Orientação e Consultoria
                            </div>
                        </div>
                    </div>
                    <div class="akordeon-item-body">
                        <div class="akordeon-item-content">
                            <ul>
                                <li>Suporte sobre jornada de trabalho e controle de ponto ( horas extras, banco de horas, etc.);
                                </li>
                                <li>Orientação sobre implantação da Comissão Interna de Prevenção de Acidentes – CIPA;
                                </li>
                                <li>Orientação para implantação do PCMSO, o PPRA e o PCA;
                                </li>
                                <li>Orientação sobre rotinas e Legislação Trabalhista e Previdenciária;
                                </li>
                                <li>Orientação para arquivo dos documentos necessários para atendimento à fiscalização trabalhista e previdenciária.
                                </li>
                                <li>Todos os encargos, relatórios e obrigações anuais são disponibilizados e arquivados na ASSECONTWEB. 
                                    Avisamos por e-mail e SMS dos responsáveis às respectivas datas de vencimentos. 
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
