<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Accounting.Master" AutoEventWireup="true" CodeBehind="auditoria.aspx.cs" Inherits="Assecont2.Contabilidade.auditoria" %>

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
    <section class="ContentText">
        <p>
            A Auditoria pode ser realizada em qualquer empresa, de qualquer tamanho ou ramo de atuação, 
            com ou sem fins lucrativos. A validação externa é considerada oportuna em várias situações. 
            O relatório de auditoria possibilitará a identificação dos problemas ou vulnerabilidades e 
            recomendações para melhorias.
        </p>
        <div class="akordeon" id="buttons">
            <div class="akordeon-item expanded">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            Auditoria Contábil e Auditoria Financeira
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <p>
                            Auditoria Contábil: tem a função de verificar a precisão dos registros contábeis. O objetivo da Auditoria Contábil é de emitir uma opinião sobre 
                          as Demonstrações Contábeis de uma entidade, envolvendo os critérios adotados para sua elaboração, bem como todos os processos de registros e 
                          controles desenvolvidos internamente.
                        A Auditoria Financeira tem como foco a operação financeira como um todo, mesmo que a empresa não tenha interesse específico na publicação das demonstrações.
                        Estas auditorias são muito úteis para conferir segurança aos dirigentes, conselheiros, empresas coligadas, parceiros estratégicos ou sócios minoritários.
                        </p>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            Auditoria Preventiva e Auditoria Permanente
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                    <p>
                        Esta análise tem por princípio manter as organizações preparadas para situações adversas, seja na prevenção de fraudes, desvios, 
                        falhas e/ou erros internos, até mesmo para o caso de levantamento de pontos vulneráveis quanto a 
                        procedimentos de controle financeiro, estoque, materiais de consumo e custos.
                        A Auditoria Preventiva é uma ferramenta que possibilita às empresas condições para a tomada de decisões estratégicas relevantes,
                         gerando métodos que possibilitem o fortalecimento de seus controles internos consolidando vantagens competitivas e minimizando fragilidades.
                    </p>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            Auditoria Tributária
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <p>
                            A Auditoria fiscal e tributária pode ser de natureza preventiva ou corretiva. São avaliados os procedimentos adotados pela empresa em todas as rotinas que tenham
                             interface com exigências e procedimentos de natureza fiscal. O objetivo é identificar falhas ou riscos de contingências fiscais / tributárias, gastos 
                            indevidos ou oportunidades de redução de gastos através da adoção de procedimentos alternativos. 
                            Compreende a revisão dos cálculos dos tributos diretos (Imposto sobre a Renda e Contribuição Social) e os indiretos (ICMS, IPI, ISS e outros)
                             e as exigências acessórias para atendimento à legislação vigente.
                        </p>
                    </div>
                </div>
            </div>
    </section>
</asp:Content>
