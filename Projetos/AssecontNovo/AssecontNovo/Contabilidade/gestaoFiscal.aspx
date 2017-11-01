<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Accounting.Master" AutoEventWireup="true" CodeBehind="gestaoFiscal.aspx.cs" Inherits="AssecontNovo.Contabilidade.GestaoFiscal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="http://www.assecont.com.br/Jquery/Arccodion/arccodion.js"></script>
    <link href="http://www.assecont.com.br/Styles/arccodion.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#buttons').akordeon({ buttons: true, toggle: true });
        });
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section class="ContentText">
        <img src="http://www.assecont.com.br/Imagens/Assecont/gestao_contabil.jpg" alt="contabil" />
        <p>
            Segundo dados levantados pelo Instituto Brasileiro de Planejamento Tributário (IBTP) são editados diariamente 
            no País 37 normas tributárias, nas esferas federal, estadual e municipal.
        </p>
        <p>
            Sobre os contribuintes incidem 76 tributos diferentes. Muitos deles são contribuições, 38 ao todo, incluindo nesse 
            rol as três contribuições para o INSS (dos empregados, patronal, e de autônomos e empresários) e o PIS-PASEP; são 
            12 os impostos e 26 as taxas. O recolhimento desses tributos é regulado por 3.200 normas tributárias de diversas hierarquias, 
            incluindo leis, medidas provisórias, decretos, portarias e instruções.
        </p>
        <p>
            Muitas medidas de difícil interpretação, um grande número de impostos, uma fiscalização atuante, principalmente com
             cruzamento de dados e altas multas pelo não cumprimento das obrigações acessórias, levam naturalmente as empresas a 
            terceirizarem sua área fiscal e tributária. A Assecont Contabilidade, através de profissionais especializados e bem preparados, 
            auxiliará sua empresa na correta aplicação de legislação em vigor, seja na emissão de Notas Fiscais, como na interpretação
             e aplicação de leis e normas tributárias.
        </p>
        <div class="akordeon" id="buttons">
            <div class="akordeon-item expanded">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            1)	Orientação e Procedimentos
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <ul>
                            <li>Orientação legal e procedimentos fiscais de competência federal, estadual e municipal;
                            </li>
                            <li>Procedimentos para emissão e cancelamento de documentos fiscais;
                            </li>
                            <li>Orientação quanto às formas de arquivo a serem usados para segurança
                                     documental tanto para empresa como para atendimento de uma eventual fiscalização.
                            </li>
                            <li>Pedido para autorização de emissão de notas fiscais;
                            </li>
                            <li>Orientação nos procedimentos para integração de sistemas Cliente x Assecont Contabilidade.
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            2)	Integração de Dados através arquivos XML
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <p>
                            <ul>
                                <li>O projeto da Nota Fiscal eletrônica (NF-e) trouxe muitas mudanças nos processos das
                                         empresas, entre elas a gestão dos documentos XML das notas fiscais de compras e vendas.
                                </li>
                                <li>Para atender a essas necessidades a Assecont  utiliza  um software  que  gerencia todos os XML recebidos
                                        que ficam armazenados em um servidor  protegidos  em  “data Center”,  próprio para armazenagem, com muita
                                         segurança e tecnologia garantindo que estejam sempre disponíveis  a qualquer momento evitando multas
                                         previstas em lei.
                                </li>
                            </ul>
                        </p>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            3)	Escrituração de Registros Fiscais
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <ul>
                            <li>Livro de Registro de Entradas;
                            </li>
                            <li>Livro de Registro de Saídas;
                            </li>
                            <li>Livro de Registro Controle Produção Estoque;
                            </li>
                            <li>Livro de Registro de Utilização de Documentos Fiscais e Termos de Ocorrência;
                            </li>
                            <li>Livro de Registro de Inventário;
                            </li>
                            <li>Livro de Registro de Apuração do IPI;
                            </li>
                            <li>Livro de Registro de Apuração do ICMS; 
                            </li>
                            <li>Livro de Registro de Serviços Prestados;
                            </li>
                            <li>Livro de Registro de Serviços Tomados de Terceiros.
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            4)	Apuração de Impostos de Contribuições
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <ul>
                            <li>Conferência, classificação, cadastro, escrituração e recuperação
                                     de impostos de notas fiscais de fornecedores; Conferência, cadastro e escrituração de notas fiscais de vendas;
                            </li>
                            <li>Conferência, cadastro e escrituração do registro de serviços tomados; Conferência, cadastro e escrituração de 
                                    notas fiscais de serviços. Apuração de impostos e contribuições (SIMPLES, ICMS, IPI, ISS, COFINS, PIS, CSSL e IRPJ);
                            </li>
                        </ul>
                        <p>
                            Disponibilização e arquivo na Assecontweb das guias para recolhimento e relatórios;
                        </p>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            5)	Obrigações Acessórias 

                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <ul>
                            <b>Rotinas mensais</b>
                            <li>Emissão de livros fiscais;
                            </li>
                            <li>Elaboração, conferência, entrega, arquivo e disponibilização na Assecontweb:<br />
                                > GIA– Guia de Informação e Apuração,<br />
                                > PER/DCOMP– Pedido Eletrônico de Restituição ou Ressarcimento e da Declaração de Compensação,<br />
                                > SINTEGRA– Sistema de Informações sobre Operações interestaduais com Mercadorias e Serviços,<br />
                                > EFD- PIS/COFINS,<br />
                                > SPEF – ICMS/IPI.<br />
                            </li>
                        </ul>
                        <ul>
                            <b>Rotinas Trimestrais</b>
                            <li>Elaboração e envio da CSSL e IRPJ - Trimestrais;
                            </li>
                        </ul>
                        <ul>
                            <b>Rotinas Semestrais</b>
                            <li>Elaboração e envio da DCTF Semestral - Declaração de Contribuições e Tributos Federais e Pedido Eletrônico de Restituição.
                            </li>
                        </ul>
                        <ul>
                            <b>Rotinas anuais</b>
                            <li>Arquivo Magnético – Secretaria da Fazenda;
                            </li>
                            <li>TFE – Taxa Local. e Funcionamento;
                            </li>
                            <li>TFA – Taxa de Anúncios;
                            </li>
                            <li>DSN - Declaração do Simples Nacional - SP
                            </li>
                            <li>Encadernação dos livros fiscais escriturados mensalmente
                                     (saídas, serviços, entradas, apuração de ICMS e IPI).
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="akordeon-item expanded">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            6) Retenção de Impostos e Contribuições
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <p>
                            Orientação para operação, conferencia e confirmação, via  sistema e pela Assecontweb,  
                            das retenções de Impostos e Contribuições sobre serviços tomados de terceiros.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
