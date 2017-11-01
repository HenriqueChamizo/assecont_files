<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="OcorrenciaTratamentos.aspx.cs" Inherits="AssecontNovo.Tecnologia.AssepontoWeb.Manual.OcorrenciaTratamentos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="http://www.assecont.com.br/Jquery/Arccodion/arccodion.js"></script>
    <link href="http://www.assecont.com.br/Styles/arccodion.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#buttons').akordeon({ abertaPrimeira: true });

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <flv:MenuTopManulAsseponto runat="server" ID="MenuTopManulAsseponto" />
    <section class="ContentText">
        <table>
            <tr>
                <td class="titleSubs font_red">Ocorrência Tratamento
                </td>
            </tr>
            <tr>
                <td>
                    <div class="akordeon" id="buttons">
                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Consulte no menu a opção marcações ignoradas
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        O Asseponto ignora as marcações na seguinte situação.
                                        <br />
                                        <br />
                                        <b>1º</b> Quando o funcionário regsitra a marcação na sequencia.<br />
                                        De acordo com a portaria 1.510, esta marcação não pode ser excluida e deve constar no espelho de ponto.<br />
                                        <br />
                                        <b>2º</b> Quando a marcação esta fora da faixa permitida<br />
                                        Dentro dos horários nós ainda temos que cadastrar  faixas do sistema.<br />
                                        <br />
                                        Apenas para que seja possível o entendimento da mesma, a faixa do sistema serve única e exclusivamente para que o 
                                        programa entenda o que vai ser entrada, o que ele vai considerar como intervalo 
                                        e o que ele vai considerar como saída.<br />
                                        <br />
                                        Desta forma, qualquer horário que seja registrado pelo funcionário entre 07:50 e 11:00 Hs da manhã,  
                                        tendo uma faixa definida como 06:00 - 11:00 o programa vai considerar esta marcação como entrada do primeiro período, 
                                        utilizando-se do horário cadastrado como entrada para os respectivos cálculos de extra/atraso.
                                        <br />
                                        <br />
                                        Caso ele registrasse no relógio uma marcação antes das 06:00 Hs por exemplo, o sistema iria ignorar essa marcação, 
                                        sendo necessário aumentar a faixa para que essa marcação seja considerada.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Alterar horário do Funcionário
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Verifique se o expediente esta cadastrado no AssePonto4<br />
                                        <br />
                                        -Menu tabelas expedientes.<br />
                                        <br />
                                        Para alterar o expediente do funcionário, clique em seu nome,depois botão direito do mouse,propriedades.
                                        <br />
                                        <br />
                                        -Na aba horários, seelcione o horário que deseja alterar,na tela seguinte clique com botão direito do mouse, 
                                        novo horário e defina a data de inicio do novo expediente.<br />
                                        <br />
                                        <b style="color: red;">DICA: </b>Jamais exclua o expediente anterior, somente adcione novos horários com a data de inicio.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Erro na leitura da digital
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Muitas vezes após cadastrar o funcionário o mesmo pode não conseguir registrar o ponto com a sua digital.   
                                        <br />
                                        <br />
                                        - Cadastre uma nova biometria;   
                                        <br />
                                        <br />
                                        - Verifique se o seu modelo de REP permite a marcação de ponto através de cartões de proximidade e barras, ou digitando o código no teclado.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Como o sistema calcula adcional noturno
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        O o adicional é regulado no Art. 73, o trabalhador noturno terá remuneração superior à do diurno e, para esse efeito, sua remuneração terá um acréscimo de 20% 
                                        (vinte por cento), pelo menos, sobre a hora diurna.  A hora do trabalho noturno será computada como de 52 (cinqüenta e dois) minutos e 30 (trinta) 
                                        segundos. Considera-se noturno, o trabalho executado entre as 22 (vinte e duas) horas de um dia e as 5 (cinco) horas do dia seguinte.<br />
                                        <br />

                                        A cada hora trabalhada o sistema calcula 01:08 como adcional noturno.<br />
                                        As extras noturnas tambem tem estes minutos acrescidos.<br />
                                    </p>
                                </div>
                            </div>
                        </div>


                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Pis Invalido - Sistema não importa marcações
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Para que não ocorra este tipo de situação, sempre cadastre primeiro o funcionário no AssePonto4 e depois no REP.<br />
                                        <br />

                                        Caso importe as marcações, via USB ou rede e o sistema não exiba as marcações do funcionário.<br />
                                        <br />
                                        - Confira a numeração de PIS do comprovante com a do funcionário no AssePonto4.<br />
                                        - Acesse o menu , apontamento,marcações,invalidas.<br />
                                        - Clique na lupa e digite o PIS do funcionário que não exibe as marcações.<br />
                                        - Selecione as marcações abaixo, e com o botão direito do mouse opção mover marcações para funcionário.<br />
                                        - Selecione o funcionário e ok, o sistema vai mover as marcações.<br />
                                        <br />
                                        <b style="color: red;">Atenção: </b>Confira sempre a numeração de PIS antes de cadastrar.O PIS deve sempre ter um total de 11 digitos.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Expedientes variavéis
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Horário Variável é uma jornada  onde não existe horário fixo de entrada e saída, apenas o funcionário tendo que
                                         cumprir o horário determinado (08:00 Hs diárias por exemplo)<br />
                                        <br />

                                        Este expediente pode ser utilizado sempre que o funcionário realiza mais de 4 marcações no dia.<br />
                                        <br />

                                        Devemos ter o expediente cadastrado no AssePonto4, e para definir em algum dia em especial podemos
                                                                             consultar Expedientes Alternativos.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Erro ao acessar sistema
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Muitas vezes ao acessar o sistema, o AssePonto4 apresenta o erro de OBDC, não foi possivel localizar o servidor.
                                        <br />
                                        <br />
                                        - Reinicie seu computador e o servidor onde o SQL esta instalado.<br />

                                        - Verifique com seu TI, se o computador servidor teve seu nome ou endereço IP alterado.<br />

                                        - Verifique se o TI, criou alguma regra nova de bloqueio.<br />

                                        - Solicite a seu TI, para verificar se o serviço do SQL esta ativo na estação/Servidor.<br />

                                        Acesse o link e visualize o manual com instruções para desbloqueio SQL.<br />
                                        <br />

                                        Caso não obtenha sucesso, entre em contato com nosso suporte.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Mensagem ao tentar conectar com terminal
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Através do menu utilitários, terminal erro ao comunicar com rep.          
                                    <br />
                                        <br />
                                        Para realziar a comunicação software AssePonto4 com rep devemos selecionar a imagem do equipamento.          
                                    <br />
                                        <br />
                                        Caso o erro persista reinstale o net framework4.
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
