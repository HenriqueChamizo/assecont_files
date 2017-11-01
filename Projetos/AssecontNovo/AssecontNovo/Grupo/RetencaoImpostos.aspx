<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="RetencaoImpostos.aspx.cs" Inherits="AssecontNovo.Grupo.RetencaoImpostos" %>

<%@ Register Src="~/WebControl/MenuLeftAssecontWeb.ascx" TagPrefix="flv" TagName="MenubottomAssecontWeb" %>

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
        <img src="http://www.assecont.com.br/Imagens/Assecont/gestao_fiscal.jpg" />
        <p>
            A Assecont Contabilidade desenvolveu um sistema informatizado para facilitar o trabalho de retenção 
            de tributos e contribuições quando tomados pelos seus clientes, de forma rápida, segura e integrada.
             Esse sistema encontra-se na Assecontweb.
        </p>
        <p>
            <b>SERVIÇOS PRESTADOS PESSOA JURIDICA - RETENÇÕES DE IMPOSTOS</b>
            <br />
            Vanderlei Arraes<br />
            Neste trabalho iremos abordar sobre as retenções de impostos sobre as prestações de serviços pessoa 
            jurídicas para outras pessoas jurídicas, essas retenções podemos entender como "antecipações" de pagamentos e 
            podem ser compensados desde que não haja algum impedimento nos preceitos legais.
        </p>
        <p>
            As importâncias pagas ou creditadas por pessoas jurídicas a outras pessoas jurídicas, civis ou mercantis, pela 
            prestação de serviços caracterizadamente de natureza profissional estão sujeitas à incidência do Imposto de Renda na Fonte, que deve ser retido no momento do pagamento ou do crédito do rendimento, neste caso o que ocorrer primeiro.
        </p>

        <div class="akordeon" id="buttons">
            <div class="akordeon-item expanded">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            IRRF – RETENÇÕES – Atividades sujeitas
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <p>
                            Segue abaixo uma lista de empresas sujeitas as retenções tratadas neste documento tanto para Imposto de Renda quanto para a retenção dos demais tributos federais;
                            
                        </p>
                        <ul>
                            <b>Serviços sujeitos à retenção do IR pela Alíquota de 1,5%:</b>
                            <li>administração de bens ou negócios em geral (exceto consórcios ou fundos mútuos para aquisição de bens);
                            </li>
                            <li>advocacia;
                            </li>
                            <li>análise clínica laboratorial;</li>
                            <li>análises técnicas;</li>
                            <li>arquitetura; </li>
                            <li>assessoria e consultoria técnica (exceto o serviço de assistência técnica prestado a terceiros e concernente a ramo de indústria ou comércio explorado pelo prestador de serviço);</li>
                            <li>assistência social;</li>
                            <li>auditoria;</li>
                            <li>avaliação e perícia;</li>
                            <li>biologia e biomedicina;</li>
                            <li>cálculo em geral;</li>
                            <li>consultoria;</li>
                            <li>contabilidade;</li>
                            <li>desenho técnico;</li>
                            <li>economia;</li>
                            <li>elaboração de projetos;</li>
                            <li>engenharia (exceto construção de estradas, pontes, prédios e obras assemelhadas);</li>
                            <li>ensino e treinamento;</li>
                            <li>estatística;</li>
                            <li>fisioterapia;</li>
                            <li>fonoaudiologia;</li>
                            <li>geologia;</li>
                            <li>leilão;</li>
                            <li>medicina, médico (exceto a prestada por ambulatório, banco de sangue, casa de saúde, casa de recuperação ou repouso sob orientação médica, hospital e pronto-socorro;</li>
                            <li>nutricionismo e dietética;</li>
                            <li>odontologia;</li>
                            <li>organização de feiras de amostras, congressos, seminários, simpósios e congêneres;</li>
                            <li>pesquisa em geral;</li>
                            <li>planejamento;</li>
                            <li>programação;</li>
                            <li>prótese;</li>
                            <li>psicologia e psicanálise;</li>
                            <li>química;</li>
                            <li>radiologia e radioterapia;</li>
                            <li>relações públicas;</li>
                            <li>serviço de despachante;</li>
                            <li>terapêutica ocupacional;</li>
                            <li>tradução ou interpretação comercial;</li>
                            <li>urbanismo;</li>
                            <li>veterinária</li>
                        </ul>
                        <p><b>Fundamento Legal:</b> art. 647 do RIR/99 e art. 6º da Lei nº 9.064/95 </p>
                        <ul>
                            <b>Serviços sujeitos à retenção do IR pela Alíquota de 1,0%:</b>
                            <li>limpeza; </li>
                            <li>conservação; </li>
                            <li>segurança;</li>
                            <li>vigilância;</li>
                            <li>ocação de mão-de-obra.</li>
                        </ul>
                        <p><b>Fundamento Legal:</b> art. 649 do RIR/99 e ADN COSIT nº 6/00 </p>
                        <ul>
                            <b>Observações importantes: </b>
                            <li>A retenção somente é obrigatória quando os serviços forem prestados por pessoas jurídicas para outras pessoas jurídicas. </li>
                            <li>A retenção do IR fica dispensada quando resultar em valor igual ou inferior a R$ 10,00. </li>
                        </ul>
                        <p>
                            <b>Exemplo:</b>
                            Se o serviço for igual ou inferior a 1.000,00 para a alíquota de 1% e 667,00 para alíquota de 1,5% estão dispensados de retenção.
                        </p>
                        <p><b>Fundamento Legal:</b> RIR/1999 (Decreto 3000/99) </p>
                        <p>
                            <i><b>Lembramos que a partir de janeiro de 2007 a apuração do IRRF dos códigos acima citados voltará a 
                               ser mensal com pagamento no último dia útil do primeiro decêndio do mês subsequente.
                              <br />
                                FONTE: <a href="http://www.receita.fazenda.gov.br/atendvirtual/centroatendvirtual/procedimentosErroSicalc.htm">Receita Federal do Brasil</a>
                            </b></i>
                        </p>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            RETENÇÕES PIS,  COFINS E CSLL.
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <p>
                            Com o advento da Lei 10.833 de 29 de dezembro de 2003, a qual regulou entre outras matérias, a instituição da retenção de Tributos e Contribuições Federais, 
                            passou-se ao recolhimento antecipado destes tributos, os quais deverão ser retidos diretamente pelo tomador dos serviços,
                             no momento do pagamento ou da emissão da nota fiscal ou do recibo do prestador de serviços.
                        </p>
                        <p>
                            A fim de promover instruções adicionais das novas regras do pagamento dos tributos, a Secretaria da Receita Federal editou a Instrução Normativa
                             nº 381 de 30 de dezembro de 2003, a qual sintetiza toda a matéria abordada.
                        </p>
                        <p>
                            De acordo com o artigo 93 da Lei 10833, as novas regras para a retenção dos Tributos e Contribuições Federais somente produzirão efeitos a partir de 1º de fevereiro de 2004,
                             sendo que, a partir desta data, todos os pagamentos realizados por pessoas jurídicas a outras pessoas jurídicas, referentes aos serviços mencionados no artigo 30 da Lei em 
                            epígrafe e no artigo 647 do Decreto nº 3.000, de 26 de março de 1999 (Regulamento do Imposto de Renda), estarão sujeitos a retenção dos Tributos e Contribuições Federais,
                             com exceção das empresas mencionadas no artigo 32 da Lei 10833.
                        </p>
                        <p>
                            <b>Tributos e Contribuições abrangidas e Alíquotas Incidentes</b>
                            Os Tributos e Contribuições abrangidos pela Lei 10.833 de 2003 e suas respectivas alíquotas, foram os seguintes:
                        </p>
                        <p>
                            <b>CSLL - Contribuição Social sobre o Lucro Líquido 1,00%<br />
                                COFINS - Contribuição para o Financiamento da Seguridade Social 3,00%<br />
                                PIS - Contribuição para o Programa de Integração Social 0,65%<br />
                                TOTAL - 4,65%
                            </b>
                        </p>
                        <p>
                            Tais retenções deverão ocorrer sem prejuízo da retenção para o Imposto de Renda na Fonte das Pessoas Jurídicas sujeitas as alíquotas específicas previstas na legislação do Imposto de Renda (Decreto nº 3.000 de 1999).
                        </p>
                        <p>Sendo assim, com relação ao Imposto de Renda na Fonte, as empresas deverão observar a alíquota correspondente, discriminada no Decreto nº. 3000/1999, CONFORME DESCRITO NO TÓPICO ANTERIOR.</p>
                        <p>
                            Desta forma, todas as Pessoas Jurídicas, inclusive os condomínios de edifícios e exceto as empresas optantes pelo SIMPLES ME ou EPP, que contratarem com outras Pessoas Jurídicas a prestação dos serviços relacionados acima, 
                            estarão obrigadas a realizarem a retenção da CSLL, COFINS,  PIS e IR, sendo este último, na forma descrita neste material (Tributos e Contribuições abrangidas e Alíquotas Incidentes) e prevista no Regulamento do Imposto de Renda.
                        </p>
                        <ul>
                            <b>Compreendem-se entre os sujeitos obrigados a efetuarem as retenções:</b>
                            <li>Associações, inclusive entidades sindicais, federações, confederações, centrais sindicais e serviços sociais autônomos;</li>
                            <li>Sociedades Simples (antigas S/C - Sociedades Civis, de acordo com o Novo Código Civil), inclusive sociedades cooperativas;</li>
                            <li>Fundações de Direito Privado;</li>
                            <li>Condomínios de edifícios ou residenciais.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            Hipóteses da não Retenção dos Tributos e Contribuições Federais
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <p>
                            hipóteses da não retenção dos Tributos e Contribuições Federais, em regra, são três, ou seja, nos casos em que o prestador de serviços estiver amparado por medida judicial que lhe garanta a não retenção; 
                            nos pagamentos efetuados a Itaipu Binacional; nos pagamentos efetuados a empresas estrangeiras de transporte de cargas ou passageiros; nos casos em que o prestador ou o tomador dos serviços seja 
                            optante do sistema SIMPLES ME ou EPP; e por fim, nas hipóteses em que o valor retido seja inferior a R$ 10,00 (dez reais), desde que, não haja retenções subseqüentes em que somadas atinjam o valor de R$ 10,00 (dez reais).
                            <br />
                        </p>
                        <p>
                            <b>Suspensão da exigibilidade do crédito tributário </b>
                            <br />
                            No caso de pessoa jurídica amparada pela suspensão da exigibilidade do crédito tributário, nas hipóteses a que se referem os incisos II, IV e V do artigo 151 do Código Tributário Nacional, 
                            ou por sentença judicial transitada em julgado, o beneficiário do rendimento deverá apresentar a fonte pagadora, a cada pagamento, a comprovação de que a não retenção continua amparada 
                            por medida judicial.
                        </p>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            Dos Prestadores de Serviços optantes pelo Simples
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <p>
                            Os prestadores de serviços que estiverem enquadrados no sistema de pagamento de impostos SIMPLES, na condição de micro empresa ou empresa de pequeno porte, deverão apresentar, 
                            a cada pagamento, à pessoa jurídica que for responsável por efetuar a retenção, declaração, na forma do Anexo I da Instrução Normativa nº 381/2003 - SRF, 
                            em duas vias, assinadas pelo seu representante legal, sendo que, a pessoa jurídica tomadora dos serviços, deverá arquivar a 1ª via da declaração, 
                            que ficará à disposição da Secretaria da Receita Federal, devendo a 2ª via ser devolvida ao interessado, como recibo.
                        </p>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            Recolhimento dos Tributos e Contribuições Retidos
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <p>
                            Os pagamentos da CSLL,  da COFINS e do PIS/Pasep, que forem retidos, deverão ser recolhidos em uma única guia DARF, 
                            a qual deverá constar o código de recolhimento 5952, e terá como data de vencimento o terceiro dia útil da semana 
                            subsequente àquela em que tiver ocorrido o pagamento à pessoa jurídica prestadora do serviço.
                            <br />
                            Na hipótese de pessoa jurídica amparada pela suspensão da exigibilidade do crédito tributário, a pessoa jurídica que efetuar o pagamento, 
                            deverá calcular, individualmente, os valores das contribuições consideradas devidas, aplicando as alíquotas correspondentes, 
                            e efetuar o recolhimento em Darf´s distintos para cada uma delas, utilizando-se os seguintes códigos de arrecadação:
                        </p>
                        <ul>
                            <li>5987 - no caso de CSLL;
                            </li>
                            <li>5960 - no caso de COFINS; 
                            </li>
                            <li>5979 - no caso de PIS/PASEP.
                            </li>
                        </ul>

                        <p>
                            <b>Do recolhimento do IRRF</b>
                            <br />
                            Quanto ao Imposto de Renda Retido na Fonte, nada foi alterado, devendo sua retenção permanecer na forma do Decreto 3.000/1999 - Regulamento do IR,
                             descrito sucintamente neste relatório, sendo certo que, em regra, o código de recolhimento do DARF deverá ser 1708 e o vencimento deverá ocorrer 
                            sempre no terceiro dia útil da semana seguinte ao pagamento da pessoa jurídica prestadora dos serviços.<br />
                            <i>Lembramos que a partir de janeiro de 2007 a apuração do IRRF dos códigos acima citados voltará a ser mensal com pagamento no último dia útil do primeiro decêndio do mês subsequente.<br />
                                FONTE:<a href=" http://www.receita.fazenda.gov.br/atendvirtual/centroatendvirtual/procedimentosErroSicalc.htm"> Receita Federal </a></i>
                        </p>

                        <p>
                            <b>Compensação dos Tributos retidos</b><br />
                            Os valores dos tributos e das contribuições retidos serão considerados como antecipação do que for devido pelo contribuinte que sofreu a retenção, em relação às respectivas contribuições, devendo estes valores ser compensados com os tributos e contribuições de mesma espécie, devidos relativamente a fatos geradores ocorridos a partir do mês da retenção.
                        </p>
                        <p>
                            <b>Informe de Rendimentos Anual</b>
                            <br />
                            As pessoas jurídicas que efetuarem a retenção dos seus prestadores de serviços, deverão fornecer, à pessoa jurídica beneficiária do pagamento, comprovante anual da retenção, até o dia 28 de fevereiro do ano subsequente, informando relativamente a cada mês em que houver sido efetuado o pagamento, sendo que, o documento poderá ser disponibilizado, à pessoa jurídica beneficiária do pagamento, que possua endereço eletrônico, por meio de Internet.
                        </p>
                        <p>
                            <b>Declaração de Imposto Retido na Fonte</b>
                            <br />
                            Anualmente, até o dia 28 de fevereiro do ano subsequente, as pessoas jurídicas que efetuarem a retenção dos tributos e contribuições Federais que se referem a lei 10.833/2003, deverão apresentar à Secretaria da Receita Federal a Declaração de Imposto de Renda Retido na Fonte (DIRF) , nela discriminando, mensalmente, o somatório dos valores pagos e o total retido, por contribuinte e por código de recolhimento.
                            <br />
                            <b>Fundamento legal: Lei 10.833/2003</b>
                        </p>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            Retenção do INSS
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <p>
                            Podemos entender como <b>Cessão de mão-de-obra</b>, a colocação à disposição da contratante, em suas dependências ou nas de terceiros,
                             de trabalhadores que realizem serviços contínuos, relacionados ou não com a sua atividade, independentemente da natureza e da forma de contratação, inclusive por meio de trabalho temporário.
                        </p>
                        <p>
                            No que tange a <b>Empreitada </b>podemos entender que é a execução, contratualmente estabelecida de tarefa, obra ou de serviço, por preço ajustado, 
    com ou sem fornecimento de material ou e equipamentos, que podem ou não ser utilizados, realizada nas dependências da empresa contratante, 
    nas de terceiros ou nas das empresas contratada, tendo como objeto um fim específico ou um resultado pretendido.
                        </p>

                        <b>Contratante</b> - é a empresa tomadora de serviços mediante cessão de mão-de-obra ou empreitada.
                        <br />
                        <b>Contratada</b> - é a empresa prestadora de serviços que os executa por cessão de mão-de-obra ou empreitada.
                        <br />

                        <b>Empresa de Trabalho Temporário </b>é a pessoa jurídica urbana cuja atividade consiste em colocar à disposição de outras empresas, em suas dependências ou nas de terceiros, temporariamente, trabalhadores devidamente qualificados, por ele remunerados e assistidos, de acordo com a Lei 6.019/74.
                            Abaixo transcrevo um dos fundamentos legal para que possamos entender;
                        <br />

                        <p>
                            <b>DA RETENÇÃO
                                <br />
                                Seção I
                                <br />
                                Da Obrigação Principal da Retenção
                                <br />
                                Art. 112. A empresa contratante de serviços prestados mediante cessão de mão-de-obra ou empreitada, 
                            inclusive em regime de trabalho temporário, a partir da competência fevereiro de 1999, 
                            deverá reter 11% (onze por cento) do valor bruto da nota fiscal,  da fatura ou do recibo de prestação de serviços e recolher à Previdência Social a 
                            importância retida, em documento de arrecadação identificado com a denominação social e o CNPJ da empresa contratada, observado o disposto no art. 79 e no art. 145.</b>
                        </p>
                        <p>
                            § 1º Para fins do disposto no caput, a empresa contratada deverá emitir nota fiscal, fatura ou recibo de prestação de serviços específica para os serviços prestados em condições especiais pelos segurados ou discriminar o valor desses na nota fiscal, na fatura ou no recibo de prestação de serviços.
                        </p>
                        <p>
                            § 2º Aplica-se o disposto neste artigo ao serviço ou obra de construção civil executado por empresas em consórcio constituído na forma dos arts. 278 e 279 da Lei nº 6.404, de 1976, observados os seguintes procedimentos: (Redação dada pela Instrução Normativa RFB nº 1.080, de 3 de novembro de 2010)
                            <br />
                            IV - o contratante do serviço ou da obra deve fazer a retenção e recolher o respectivo valor em nome e no CNPJ do emitente da fiscal, fatura ou recibo, ressalvado o disposto nos incisos V e VI; (Redação dada pela Instrução Normativa RFB nº 1.080, de 3 de novembro de 2010)
                            <br />
                            V - se a nota fiscal,  fatura ou recibo for emitida pelo consórcio, poderá este informar a participação individualizada de cada consorciada que atuou na obra ou serviço e o valor da respectiva retenção, proporcionalmente à sua participação; (Redação dada pela Instrução Normativa RFB nº 1.080, de 3 de novembro de 2010)
                            <br />
                            VI - na hipótese do inciso V, o contratante poderá recolher os valores retidos no CNPJ de cada consorciada, de acordo com as informações prestadas pelo consórcio; (Redação dada pela Instrução Normativa RFB nº 1.080, de 3 de novembro de 2010)
                            <br />
                            VII - o valor recolhido na forma do inciso VI poderá ser compensado pela empresa consorciada com os valores das contribuições devidas à previdência social, vedada a compensação com as contribuições destinadas a outras entidades e fundos (terceiros), e o saldo remanescente, se houver, poderá ser compensado nas competências subsequentes ou ser objeto de pedido de restituição;
                            (Redação dada pela Instrução Normativa RFB nº 1.080, de 3 de novembro de 2010)
                            <br />
                            VIII - as informações sobre a mão de obra empregada no serviço ou na obra de construção civil executados em consórcio serão prestadas pelo contratante dos trabalhadores, em GFIP individualizada por tomador, com o CNPJ identificador do tomador do serviço ou a matrícula da obra, conforme o caso; (Redação dada pela Instrução Normativa RFB nº 1.080, de 3 de novembro de 2010)
                            <br />
                            IX - se a retenção e o recolhimento forem feitos no CNPJ do consórcio, somente este poderá realizar a compensação ou apresentar pedido de restituição. (Redação dada pela Instrução Normativa RFB nº 1.080, de 3 de novembro de 2010)
                        </p>

                        <p>§ 3º Aplica-se ao valor da taxa de administração cobrada pelo consórcio o disposto no § 1º do art. 124. (Redação dada pela Instrução Normativa RFB nº 1.071, de 15 de setembro de 2010)</p>

                        <p>
                            <b>Dispensa da Retenção</b><br />
                            A contratante está dispensada de efetuar a retenção quando:<br />
                            - O valor for inferior ao limite permitido para recolhimento em GPS, atualmente o valor é de R$ 29,00, conforme Artigo 398, da IN RFB 1.238/2012. (anterior à 2012 era R$ 10,00 o limite)<br />
                            - O serviço tiver prestado pessoalmente pelo sócio ou titular.<br />
                            - A contratada não tiver empregado.<br />
                            - Prestação de serviços relativos ao exercício de profissão regulamentada, desde que prestada pessoalmente pelos sócios ou cooperados, devendo este fato constar da própria nota fiscal.<br />
                            A partir de 01.09.2002 as empresas optantes pelo SIMPLES estão obrigadas a reter do INSS fonte, 11% Seguridade Social (IN/INSS 80/2002 – Art.119 item VII), podendo ser compensada na GPS da contratante.
                        </p>
                    </div>
                </div>
            </div>
            <div class="akordeon-item">
                <div class="akordeon-item-head">
                    <div class="akordeon-item-head-container">
                        <div class="akordeon-heading">
                            Fundamento Legal
                        </div>
                    </div>
                </div>
                <div class="akordeon-item-body">
                    <div class="akordeon-item-content">
                        <p>
                            Art. 112 da Instrução Normativa RFB nº 971/2009<br />
                            Inciso VII, Art. 119, da IN/INSS 80/2002<br />
                            Art. 31, da Lei n° 8.212/91<br />
                            Art. 156, da IN MPS/SRP 3/2005<br />
                            Artigo 398, da IN RFB 1.238/2012
                        </p>
                        <p>
                            <b>Retenção do ISS – Campo Grande/MS</b><br />
                            <b>Fundamento Legal:</b> Decreto 11.077, de 28 de dezembro de 2009<br />
                            Link: <a href="http://issdigital.pmcg.ms.gov.br/legislacao/DecretoRespTribu.pdf">http://issdigital.pmcg.ms.gov.br/legislacao/DecretoRespTribu.pdf</a>
                        </p>
                        <p>
                            <b>* Ler o artigo 1º e seus incisos</b><br />
                            <b>Veja também:</b> incisos I ao XXII, artigo 3º, da <a href="http://www.planalto.gov.br/ccivil_03/leis/LCP/Lcp116.htm">Lei Complementar nº 116/2003.</a><br />
                            <b>* âmbito federal</b>
                        </p>
                        <p>
                            <b>Outros fundamentos legais </b>
                            <br />
                            RIR/1999<br />
                            Instrução Normativa SRF nº 459/2004<br />
                            Lei Complementar nº 116/2003<br />
                            Lei nº 10.833/2003<br />
                            Parecer Normativo <a href="http://www.contabeis.com.br/termos-contabeis/cst">CST</a> nº 121/1973
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <p>
        <flv:MenubottomAssecontWeb runat="server" ID="MenubottomAssecontWeb" />

        </p>
    </section>
</asp:Content>
