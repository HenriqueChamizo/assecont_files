<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="cadastro.aspx.cs" Inherits="Assecont2.Tecnologia.Manual.cadastro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="http://www.assecont.com.br/assecont/Jquery/Arccodion/arccodion.js"></script>
    <link href="http://www.assecont.com.br/assecont/Styles/arccodion.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#buttons').akordeon({ abertaPrimeira: true });

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section class="ContentText">
        <flv:MenuTopManulAsseponto runat="server" ID="MenuTopManulAsseponto" />
        <table>
            <tr>
                <td class="titleSubs font_red">Cadastro
                </td>
            </tr>
            <tr>
                <td>
                    <div class="akordeon" id="buttons">
                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Cadastrar novo usuário no AssePonto4
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        O Asseponto4 permite cadastrar usuário a niveis de acesso.
                                        <br />
                                        <br />

                                        Assim que executar o atalho do Asseponto4, acesse com login SA senha sa, padrão Asseponto, acesse o menu utilitários, usuários e clique em novo.<br />
                                        <br />
                                        Defina login, senha alfanumerica,minimo de 1 digito , máximo de 6.<br />
                                        <br />
                                        Abaixo nome de usuário.<br />
                                        <br />
                                        Defina acesso a todas as funções para ser um usuário administrador, ou defina abaixo a permissão de uso do software.
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Cadastrar Funcionários
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        O AssePonto  permite cadastrar o funcionário de acordo com o departamento ou  empresa que atua.
                                        <br />
                                        <br />

                                        Para cadastrar um funcionário clique sobre o departamento , empresa em que o mesmo atua, menu funcionários Novo.<br />
                                        <br />

                                        O Cadastro é dividido por abas.<br />

                                        <ul>
                                            <li><b>Aba  Geral </b>
                                                <br />
                                                É obrigatório o preenchimento dos campos; registro, nome, admissão numeração de PIS e Cargo
                                                <br />
                                                <br />
                                                Opções:<br />
                                                &gt;
                                                Descontar DSR se a empresa deseja descontar o domingo caso o funcionário atrase ou falte na semana.<br />
                                                &gt;
                                                Avulso, caso a empresa controle o ponto do funcionário mas não envia suas variáveis para a folha de pagamento.<br />
                                                &gt;
                                                Banco de horas automático, se o funcionário trabalhar em regime de banco de horas.<br />
                                                <br />
                                            </li>
                                            <li><b>Aba  Apontamento </b>
                                                <br />
                                                &nbsp;&nbsp;&nbsp;
                                                1º Definimos a tabela de parâmetros , previamente cadastrada com as opções de pagamento de horas extras,
                                                 atrasos e banco de horas.Estes parâmetros podem ser criados pelo asseponto de acordo com a convenção 
                                                coletiva aplicada a empresa..<br />
                                                <br />
                                                &nbsp;&nbsp;&nbsp;
                                                2º Definimos o valor do DSR (descanso semanal remunerado ), que é de 07:20 conforme CLT.
                                                (salvo funcionários com jornada de trabalho inferior a  06:00 horas diárias.<br />
                                                <br />
                                            </li>
                                            <li><b>Aba Horários </b>
                                                <br />
                                                &nbsp;&nbsp;&nbsp;
                                                1º Para definir um expediente ao funcionário devemos clicar sobre o nome dele com o botão direito do mouse, propriedades em horário podemos definir um horário da seguinte forma.<br />
                                                <br />
                                                Principal = horário de segunda a sexta feira.<br />
                                                <br />
                                                Associamos o expediente e definimos a data inicial que o funcionário ira realizar a jornada.<br />
                                                Dia a dia = Podemos definir expedientes diferenciados em dias da semana.<br />
                                                <br />
                                            </li>
                                            <li><b>Aba  Escalas
                                            </b>
                                                <br />
                                                &nbsp;&nbsp;&nbsp;
                                                1º Para definir uma escala no funcionário, devemos clicar sobre o nome  dele com o botão direito do mouse,na guia escala definir a 
                                                escala previamente cadastrada no Asseponto.<br />
                                                <br />
                                                Defina a data inicial de quando o funcionário ira trabalhar com esta escala.Com esta data inicial podemos alterar a escala 
                                                de um mês para outro sem interferir nos apontamentos anteriores.

                                                Clique em ok e o sistema irá entender que o funcionário trabalha de acordo com a escala selecionada.<br />
                                                <br />
                                            </li>
                                            <li><b>Aba Crachá / Digitais
                                            </b>
                                                <br />
                                                &nbsp;
                                                1º Clique na guia crachás, em seguida defina a numeração do crachá e a data de inicio de utilização do mesmo.  
                                                <br />
                                                <br />
                                                <b style="color: red;">Dica:</b>
                                                <br />
                                                &gt;  
                                                Sempre quando o funcionário for demitido, em crachás coloque a data de demissão 
                                                para que a empresa possa reutilizar o crachá para outro funcionário.  
                                                Esta data serve também para quando o funcionário perde o seu cartão e é necessário associar um novo numero.  
                                                <br />
                                                &gt;
                                                No menu tabelas crachás, verifique os crachás existentes na empresa e os funcionários a eles associados.  
                                                <br />
                                                <br />
                                            </li>
                                            <li><b>Aba Terminais
                                            </b>
                                                <br />
                                                Verifique com seu representante se o REP adquirido realiza comunicação direta com o Asseponto4, 
                                                para configurar o terminal.
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
                                        Readmitir Funcionários
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Após demitir o funcionário, acesse a lista de funcionários inativos, caso ele não exiba mais na tela inicial do sistema.
                                        <br />
                                        <br />
                                        Clique duas vezes sobre o funcionário, delete a numeração de pis.
                                        <br />
                                        <br />
                                        Cadastre o funcionário novamente no asseponto, com o novo numero de registro e nova data de admissão.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Cadastrar Expedientes
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Aqui nessa tabela é onde o usuário vai cadastrar os horários que constam em seu quadro de horários. O sistema permite a criação de 3 tipos de horários.<br />
                                        <br />
                                        <b>1</b> - Horário fixo (inclusive o intervalo de almoço)<br />
                                        <br />
                                        <b>2</b> - Horário fixo (intervalo de almoço variável) com compensação no intervalo<br />
                                        <br />
                                        <b>3</b> - Horário Variável onde não existe horário fixo de entrada e saída, apenas o funcionário tendo que cumprir o horário determinado (08:00 Hs diárias por exemplo)<br />
                                        <br />
                                        O sistema ainda permite que caso algum dos horários (entrada, saída para intervalo, retorno do intervalo e saída definitiva) não vá ser registrado pelo funcionário, o AssePonto
                                         crie o mesmo definindo no horário como "Automático Parcial" (ver imagem das propriedades)
                                        Para criar os horários você deve entrar em "Tabelas e selecionar a opção "Horários". Dentro da tabela você pode tanto selecionar os botões que se encontram acima da tabela conforme
                                         imagem, ou então clicar com o botão direito do mouse dentro da tabela e Escolher entre as opções
                                        <br />
                                        <br />
                                        Abaixo as telas das propriedades (edição) do horário fixo quando aberto
                                        Ao iniciar o novo horário, você deve colocar a descrição do mesmo, sendo que o código quem vai criar é o sistema na ordem que os mesmos forem sendo criados.
                                        <br />
                                        <br />

                                        Quando falamos dos campos entrada/saída temos que notar que é esse é o primeiro período do horário, então nessa tela teremos a entrada do funcionário na empresa e a sua saída para o intervalo, 
                                        sendo que é necessário completar também o segundo período com seu respectivo retorno do almoço (entrada) e sua saída definitiva da empresa.
                                        <br />
                                        <br />

                                        De acordo com os horários cadastrados nos campos entrada/saída o sistema ira efetuar os cálculos para extras/atrasos (ou créditos/débitos para Banco de horas).
                                        <br />
                                        <br />
                                        Quando você seleciona a opção Marcação obrigatória você esta indicando para o programa que o funcionário vai registrar seu ponto e que você vai se basear nessa marcação para os cálculos. 
                                        Quando você seleciona a opção "Automático Parcial" você esta indicando para o programa que ele deve criar essa marcação, baseado no horário cadastrado nos campos "entrada/saída".
                                         De qualquer maneira, caso exista o registro da marcação o sistema vai aceitar a marcação registrada, não criando automaticamente o horário. Se o horário de intervalo for
                                         baseado no horário flexível você deve entrar em "Opções" e selecionar "Compensação no Intervalo". A partir desse momento o programa vai calcular uma hora (ou mais)
                                         através das marcações registradas pelo funcionário.
                                        <br />
                                        <br />
                                        Dentro dos horários nós ainda temos que cadastrar nossas faixas do sistema e as respectivas tolerâncias tanto para horas extras/ atrasos, e caso tratando-se de Banco de horas créditos/débitos.

                                        <br />
                                        <br />
                                        Apenas para que seja possível o entendimento da mesma, a faixa do sistema serve única e exclusivamente para que o programa entenda o que vai ser entrada, o que ele vai considerar como 
                                        intervalo e o que ele vai considerar como saída.
                                        Desta forma, qualquer horário que seja registrado pelo funcionário entre 07:50 e 11:00 Hs da manhã, o programa vai considerar esta marcação como entrada do primeiro período, 
                                        utilizando-se do horário cadastrado como entrada para os respectivos cálculos de extra/atraso.
                                        <br />
                                        <br />
                                        Caso ele registrasse no relógio uma marcação antes das 07:50 Hs por exemplo, o sistema iria ignorar essa marcação, sendo necessário aumentar a faixa para que essa marcação seja considerada.
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Cadastrar feriados
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Cadastre no AssePonto a tabela de feriados, regionais,estaduais e municipais.
                                        <br />
                                        <br />
                                        - Acesse tabelas -> Feriados<br />
                                        - Clicar em novo feriado.<br />
                                        <br />
                                        Temos duas opções, feriado data fixa e feriado móvel.<br />
                                        <b>Feriado Fixo</b><br />
                                        - Defina a data e o mês , no campo data fixa caso o feriado seja no mesmo dia sempre;(Aniversário de São Paulo, Natal entre outros).<br />
                                        <br />
                                        <b>Feriado móvel</b><br />
                                        - Clique na opção de Data Móvel,caso o feriado seja diferente a cada ano;
                                        Carnaval, Sexta Feira santa, Páscoa.<br />
                                        -Opção aplicar feriado a empresa / departamento utilizamos caso o ferido  cadastrado seja de outro município / Estado.<br />
                                        <br />
                                        Para alterar o feriado, selecione o feriado e clique em propriedades.<br />
                                        <br />
                                        Para excluir selecione o feriado ,e clique no <b style="color: red;">X</b> para excluir.<br />
                                        <br />
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Cadastrar Motivos
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Cadastre no asseponto os motivos pelo qual você deseja abonar um atraso ou uma falta, bem como incluir
                                         ou desconsiderar uma marcação de ponto. Conforme instrução da portaria 1510.<br />
                                        <br />
                                        -clique no asseponto no menu tabelas -> motivos de justificativas;<br />
                                        -Clique em novo motivo;<br />
                                        -Digite a descrição e clique em OK.<br />
                                        <br />
                                        Se desejar alterar a justificativa, clique sobre o mesmo e clique na opção propriedades   altere a descrição e clique em OK.<br />
                                        Para excluir, selecione a justificativa e clique na opção, <b style="color: red;">X</b> clique em sim para confirmar a exclusão.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Cadastrar Cargos
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Cadastre no asseponto a tabela de cargos dos seus funcionários.<br />
                                        <br />
                                        - Para cadastrar um cargo, devemos acessar o menu tabelas -> cargos;<br />
                                        - Clique em  novo cargo, digite a descrição e ok.<br />
                                        - Para alterar selecione o  cargo clique em propriedades edite e ok.<br />
                                        - Para excluir selecione o cargo, clique no <b style="color: red;">X</b> confirme a exclusão;
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
