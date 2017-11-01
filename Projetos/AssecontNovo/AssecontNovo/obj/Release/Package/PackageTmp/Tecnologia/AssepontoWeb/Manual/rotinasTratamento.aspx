<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="rotinasTratamento.aspx.cs" Inherits="AssecontNovo.Tecnologia.AssepontoWeb.Manual.rotinasTratamento" %>

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
                <td class="titleSubs font_red">Rotinas de Tratamento
                </td>
            </tr>
            <tr>
                <td>
                    <div class="akordeon" id="buttons">
                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Menu Apontamento
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Esse procedimento só deve ser realizado quando um novo mês (apontamento) começar, 
                             ou quando acessar o sistema e o mesmo exibir a mensagem de " Apontamento não iniciado".
                            <br />
                                        <br />
                                        - Menu Apontamento -> Iniciar Novo Apontamento -> Defina o dia base, selecione o mês desejado e clique em ok.<br />
                                        O Asseponto4, permite consultar, reimprimir e alterar os mêses anteriores.<br />

                                        - Menu Apontamento - Abrir Apontamento , selecione o mês e ok.<br />
                                        <br />

                                        <b style="color: red;">Dica:</b> Visualize no rodapé do sistema, o mês de apontamento ativo.
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Importar marcações do REP
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Esta opção tem como objetivo transferir as marcações do REP, para o software AssePonto4.<br />
                                        Este procedimento pode ser realizado diariamente, o AssePonto4 sempre adciona as marcações e nunca
                         sobrepõe o trabalho realizado.
                                    </p>

                                    <p>
                                        <b>** 1° CASO: RELÓGIO CONECTADO EM REDE</b><br />
                                        <br />
                                        Os REPS relacionados abaixo, realizam comunicação via rede com o software asseponto:<br />

                                        <b>Iddata &nbsp;&nbsp;&nbsp;   Gertec &nbsp;&nbsp;&nbsp;  Prisma &nbsp;&nbsp;&nbsp; Elgin/ZPM &nbsp;&nbsp;&nbsp; Trilobit &nbsp;&nbsp;&nbsp; Henry
                                &nbsp;&nbsp;&nbsp; Orion6 &nbsp;&nbsp;&nbsp; Dimep &nbsp;&nbsp;&nbsp; Trix &nbsp;&nbsp;&nbsp; Digicom</b>
                                        <br />
                                        <br />
                                        - Menu Utilitários -> Terminal<br />
                                        - Clicar no relógio<br />
                                        - Menu Manutenção -> Importação de Marcações -> Terminal Selecionado (se solicitado defina o periodo que deseja importar).
                                    </p>

                                    <p>
                                        <b>** 2° CASO: COLETA VIA PEN DRIVE</b><br />
                                        <br />
                                        - Ir até o relógio com um pen drive (preferencialmente com capacidade de 2 GB)<br />
                                        - Espetar o pen drive na posta USB FISCAL na lateral do relógio e aguardar<br />
                                        - Espetar o pen drive no computado<br />
                                        - Abrir o sistema Asseponto4<br />
                                        - Menu Apontamento -> Importar Marcações -> Escolher o arquivo com as iniciais AFD no pendrive -
                                <b style="color: red">Deixar marcado a opção “O arquivo Selecionado é um AFD” </b>-> Avançar
                            <br />
                                        - Escolher o período que deseja importar - Avançar<br />
                                        - Aguardar ele fazer a verificação e a importação do arquivo - Avançar - Concluir<br />
                                        - Fechar a Janela.<br />
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Marcações Incluir / Excluir
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Esse procedimento esta de acordo com a Portaria 1.510 MTB.<br />
                                        <br />
                                        A marcação pode ser incluida em casos que o funcionário esqqueceu de marcar o ponto, ou realizou algum trabalho externo.
                            Para evitar alguma alguima ocorrência com a fiscalização do trabalho é recomendavel que o funcionário assinale de próprio punho o horario que deicou de registrar e assinale abaixo.
                            <br />
                                        <br />
                                        Clicar no dia para selecionar, o dia fica marcado em amarelo.<br />
                                        - Clicar com o botão direito do Mouse - Inclusão de Marcações<br />
                                        - Colocar o horário que o funcionário deveria ter realizado a marcação do ponto, pode ser entrada,intervalo,saida ou todas as marcações não registradas.<br />
                                        - Colocar o motivo pelo qual o você está inserindo essa marcação (por exemplo: Falta de Marcação) - OK<br />
                                        <br />
                                        <b>EXCLUIR MARCAÇÃO INCLUIDA</b><br />
                                        <br />
                                        Caso deseje excluir a marcação incluida, selecione o dia botão direito do mouse,marcações do dia.
                            Selecione a marcação que deseja excluir, clique acima em excluir marcação lançada e depois processo no raio.<br />
                                        <br />
                                        <b style="color: red;">DICA:</b> Quando for incluir uma marcação noturna,após as 00:00, clica na seta dia seguinte.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Marcações Indevidas - Desconsiderar - Reconsiderar
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Esse procedimento esta de acordo com a Portaria 1.510 MTB.<br />
                                        <br />

                                        Para evitar desconsiderar marcações, oriente seus funcionários a não registrarem o ponto indevidamente,
                            fora dos horários estipulados pela empresa sem necessidade.<br />
                                        <br />

                                        Clicar no dia que deseja desconsiderar uma marcação<br />

                                        - Clicar com o botão direito do mouse - Desconsiderar Marcações<br />
                                        - Escolher a marcação que deseja desconsiderar clicando na caixinha ao lado do horário da marcação<br />
                                        - Escolher o motivo (caso não conste na lista você pode digita-lo) - OK<br />
                                        <br />

                                        <b>RECONSIDERAR UMA MARCAÇÃO DESCONSIDERADA</b><br />
                                        <br />

                                        - Clicar no dia em que a marcação foi desconsiderada<br />
                                        - Clicar com o botão direito do mouse - Escolha a opção Marcações do dia<br />
                                        - Clicar sobre a marcação que foi desconsiderada (ela estará com status Desconsiderada) - Clicar no botão Reconsiderar Marcações<br />
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Marcações ignoradas
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        O Asseponto ignora as marcações na seguinte situação:
                            <br />
                                        <br />

                                        <b>1º</b> Quando o funcionário regsitra a marcação na sequencia.
                            De acordo com a portaria 1.510, esta marcação não pode ser excluida e deve constar no espelho de ponto.<br />
                                        <br />

                                        <b>2º</b> Quando a marcação esta fora da faixa permitida<br />
                                        <br />

                                        Dentro dos horários nós ainda temos que cadastrar  faixas do sistema.<br />
                                        <br />

                                        Apenas para que seja possível o entendimento da mesma, a faixa do sistema serve única e exclusivamente 
                            para que o programa entenda o que vai ser entrada, o que ele vai considerar como intervalo e o que ele vai considerar como saída.<br />
                                        <br />

                                        Desta forma, qualquer horário que seja registrado pelo funcionário entre 07:50 e 11:00 Hs da manhã,  
                            tendo uma faixa definida como 06:00 - 11:00 o programa vai considerar esta marcação como entrada do primeiro período, utilizando-se 
                            do horário cadastrado como entrada para os respectivos cálculos de extra/atraso.<br />
                                        <br />

                                        Caso ele registrasse no relógio uma marcação antes das 06:00 Hs por exemplo, o sistema iria ignorar essa marcação, sendo necessário
                             aumentar a faixa para que essa marcação seja considerada.<br />
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Inclusão e exclusão  de Justificativas (Abonos)
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        <br />
                                        <b>INCLUIR UMA JUSTIFICATIVA (ABONO)</b><br />
                                        <br />

                                        Esse procedimento deve ser feito quando a empresa vai abonar algum desconto do funcionário (por exemplo em caso de atestados médicos)
                            <br />
                                        <br />
                                        - Clicar no dia a ser justificado para seleciona-lo
                            - Clicar com o botão direito do mouse - Justificar<br />
                                        - Escolher o motivo da justificativa (caso não conste na lista você pode digita-lo)<br />
                                        - Escolher a opção JUSTIFICAR TUDO caso queria justificar o dia inteiro ou o total que esta sendo descontado. 
                            Caso você queira justificar apenas parte do desconto (por exemplo metade de um dia que o funcionário faltou) digitar a 
                            quantidade de horas a ser justificada ao invés de clicar em justificar tudo - OK
                            <br />
                                        <br />

                                        <b>EXCLUSÃO DE UMA JUSTIFICATIVA (ABONO)</b>
                                        <br />
                                        <br />
                                        - Clicar no nome do funcionário ao lado esquerdo da tela<br />
                                        - Clicar no menu Funcionários - Justificativas<br />
                                        - Clicar sobre a justificativa que deseja excluir - Clicar no botão Excluir.<br />
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Inclusão e Exclusão de expedientes Alternativos
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Esse procedimento deve ser utilizado sempre que o funcionário for fazer um expediente diferenciado do expediente normal 
                            (outro horário, folga em um dia de trabalho normal, trabalhar em dias de feriado).<br />
                                        <br />

                                        - Clica no dia para selecionar<br />
                                        - Clicar com o botão direto do mouse - Escolha a opção Definir Expediente Alternativo<br />
                                        - Escolha o horário que o funcionário realizou nesse dia, marque a opção dia normal, ou extra caso o expediente seja pago como extra.<br />
                                        <br />

                                        <b style="color: red;">*</b> Se o funcionário estiver trabalhando em um dia de folga ou em um feriado, marcar a opção Extra em Folga/Feriado.<br />
                                        <br />


                                        <b>LANÇAR FOLGA</b><br />
                                        <br />
                                        Clicar com o botão direto do mouse - Escolha a opção Definir Expediente Alternativo e selecione a opção Folga.<br />
                                        <br />
                                        <b>EXCLUIR EXPEDIENTES ALTERNATIVOS</b><br />
                                        <br />
                                        - Clicar no dia em que o expediente alternativo foi lançado para seleciona-lo.<br />
                                        - Clicar com o botão direito do mouse - Escolha a opção Excluir Expediente Alternativo.<br />
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Lançar, editar,excluir férias
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Clique no nome do funcionário que irá entrar de férias para selecionado (lado esquerdo da tela principal)<br />
                                        - Clique no menu Funcionários - Registro Eletrônico<br />
                                        - Clique na aba Férias e Afastamentos<br />
                                        - No campo Férias (período concessivo) clique na opção Novo Registro<br />
                                        - Coloque a data inicial e final das férias do funcionário - OK<br />
                                        - Reprocesse o apontamento do funcionário no botão do raio.<br />
                                        <br />

                                        <b>Editando e excluindo férias</b><br />
                                        <br />
                                        Selecione o periodo para editar clique com botão direito do mouse, propiedades.<br />
                                        Selecione o periodo e para excluir clique com botão direito do mouse, excluir.<br />

                                        <div style="color: red;">Não se esqueça de processar o funcionário ao termino dos processos.</div>
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Lançar, editar,excluir afastamentos
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Clique no nome do funcionário que será aplicado o afastamento. (lado esquerdo da tela principal)<br />
                                        - Clique no menu Funcionários - Registro Eletrônico<br />
                                        - Clique na aba Férias e Afastamentos<br />
                                        - No campo Afastamentos clique na opção Novo Registro<br />
                                        - Coloque a data inicial e final do afastamento do funcionário - OK<br />
                                        - Reprocesse o apontamento do funcionário no botão do raio.<br />
                                        <br />

                                        <b>Editando e excluindo afastamentos</b><br />
                                        <br />


                                        Selecione o periodo para editar clique com botão direito do mouse, propiedades.
                                        <br />
                                        Selecione o periodo e para excluir clique com botão direito do mouse, excluir.<br />


                                        <div style="color: red;">Não se esqueça de processar o funcionário ao termino dos processos.</div>
                                    </p>
                                </div>
                            </div>
                        </div>


                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Lançar, editar,excluir demissão
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Primeiramente excluir o funcionário do terminal da seguinte forma (pelo sistema Asseponto):
                                        <br />
                                        <br />

                                        - Menu Utilitários, Terminal;<br />
                                        - Seleciona o relógio;<br />
                                        - Encontra o funcionário do lado direito da tela e clica sobre ele para selecionar;<br />
                                        - Clica com o botão direito do mouse, depois Excluir Funcionário do Terminal;<br />
                                        - Fecha a janela;<br />
                                        <br />

                                        <b style="color: red;">*</b> Em seguida fazer o seguinte:<br />
                                        - Clica no nome do funcionário para selecionar;<br />
                                        - Botão direito do mouse, propriedades<br />
                                        - NA ABA TERMINAL: seleciona o relógio, clica com botão direito do mouse, excluir terminal;<br />
                                        - NA ABA GERAL: colocar a data de demissão (até o ultimo dia que ele trabalhou).<br />
                                        - Clicar em OK.<br />
                                        <br />


                                        <b>Para excluir a demissão</b><br />
                                        <br />

                                        Clica no nome do funcionário para selecionar;<br />
                                        - Botão direito do mouse, propriedades.<br />
                                        - NA ABA GERAL: apague data de demissão, e processe o funcionário.<br />
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
                <%--            <td valign="top">
                    <img src="../../Imagens/logos/logoAsseponto.png" width="300" />
                    <div style="margin-top: 90px;">
                        <img src="../../Imagens/Tecnologia/parceiros.png" width="450" />
                    </div>

                </td>--%>
            </tr>
        </table>
    </section>
</asp:Content>
