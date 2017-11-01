<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Accounting.Master" AutoEventWireup="true" CodeBehind="gestaoContabilidade.aspx.cs" Inherits="Assecont2.Contabilidade.gestaoContabilidade" %>

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
            Segundo dados divulgados pelos órgãos oficiais, metade das pequenas e médias empresas; existentes hoje no Brasil
             estão condenadas à morte do primeiro ao terceiro ano de existência, e a principal causa apontada para essa
             mortandade é a falta de informações para tomada de decisões e ferramentas adequadas para a gestão do negócio.
        </p>
        <p>
            A Assecont Contabilidade possui, no seu quadro profissional, Bacharéis em Ciências Contábeis, pós-graduados em 
            Controladoria e sempre atualizados, que dentro de um programa prévio e observando os princípios fundamentais e 
            normas de práticas contábeis, fará toda a escrituração, e disponibilizará, via Assecontweb, os relatórios 
            devidamente analisados, necessários para facilitar a tarefa de seus clientes na tomada de decisões.
        </p>
        <p>
            Fornecemos, ainda, os aplicativos para integração informatizada com nosso sistema. Abrangência do nosso trabalho:
        </p>

        <div class="akordeon" id="buttons">
            <div class="akordeon-item expanded">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            1) Contabilidade 
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <ul>
                            <li>Lançamento, classificação, conciliação, emissão, disponibilização e arquivo, 
                                    na  Assecontweb, dos Balancetes, Balanços Mensais e Análise Econômico-Financeira 
                                    de Demonstrativos Contábeis.
                            </li>
                            <li>Apuração, emissão e disponibilização dos tributos e impostos incidentes sobre lucro - IRPJ, CSSL; 
                            </li>
                            <li>Escrituração, emissão, encadernação e registro do Livro Diário Geral e Livro Razão;
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            2) Obrigações Acessórias
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <ul>
                            <li>Elaboração, emissão, entrega e arquivo na Assecontweb, das obrigações acessórias,
                                    como EFD-IRPJ, PER/DCOMP, DCTF, DIRF, DIPJ, DIMOB e outras obrigações que venham a ser criadas;
                            </li>
                            <li>Emissão e disponibilização na Assecontweb do Comprovante Anual de Rendimentos Pagos ou 
                                    Creditados e de Retenção de Imposto de Renda na Fonte - Pessoa Jurídica e Pessoa Física.
                            </li>
                            <li>Análise e emissão do DECORE - DECLARAÇÃO COMPROBATÓRIA DE PERCEPÇÃO DE RENDIMENTOS – que é o 
                                    documento contábil destinado a fazer prova de informações sobre percepção de rendimentos em 
                                    favor de pessoas físicas, nossos clientes.
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            3) Estudo tributário
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <p>
                            Com base nas informações do cliente em nosso banco de dados, 
                                Assecont Contabilidade realiza uma Análise Comparativa entre os diferentes regimes de apuração, 
                                objetivando avaliar o melhor enquadramento tributário, visando redução da carga tributária.
                        </p>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            4) Orientações e Procedimentos
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <ul>
                            <li>Orientação, para operação e conferencia e confirmação, via sistema na Assecontweb, 
                                    das retenções do Imposto de Renda e Contribuições Sociais sobre serviços tomados de terceiros. 
                            </li>
                            <li>Consultoria, orientação e controle dos dispositivos legais vigentes.
                            </li>
                            <li>Orientação para utilização dos arquivos feitos através da Assecontweb e formas de arquivo na empresa, 
                                    respeitando o prazo prescricional determinado pela legislação, visando a segurança dos documentos e 
                                    para atendimento à fiscalização.
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <p>
            Emissão e disponibilização na Assecontweb do Comprovante Anual de Rendimentos Pagos ou Creditados e de Retenção
             de Imposto de Renda na Fonte - Pessoa Jurídica e Pessoa Física.
        </p>
    </section>
</asp:Content>
