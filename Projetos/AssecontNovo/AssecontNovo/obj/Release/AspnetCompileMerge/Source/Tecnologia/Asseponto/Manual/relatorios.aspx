<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="relatorios.aspx.cs" Inherits="Assecont2.Tecnologia.Manual.relatorios" %>

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
            <flv:MenuTopManulAsseponto runat="server" ID="MenuTopManulAsseponto" />
    <section class="ContentText">
        <table>
            <tr>
                <td class="titleSubs font_red">Relatórios
                </td>
            </tr>
            <tr>
                <td>
                    <div class="akordeon" id="buttons">
                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Imprimir,visualizar e salvar o espelho de ponto
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        O espelho de ponto deve ser impresso ao termino do tratamento do ponto.
                                        <br />
                                        <br />
                                        O espelho de ponto foi desenvolvido de acordo com o anexo II da portaria 1.510,MTB e 
                                        não pode ser alterado.O mesmo exibe em seu resumo as variáveis que devem ser exportadas ou 
                                         no sistema de folha de pagamento.
                                        <br />
                                        <br />

                                        - Clique no nome do funcionário para seleciona-lo<br />
                                        - Clique no botão Espelho de Ponto ao lado esquerdo do botão do Mouse<br />
                                        - Na barra de ferramentas (na janela do relatório) clique no botão Salvar Relatório 
                                        (botão com ícone do disquete)<br />
                                        - Escolha o local onde deseja salvar<br />
                                        - No campo Tipo:  Mude o Tipo de Quick Report para PDF Document<br />
                                        - No campo Nome: coloque o nome que você quiser e a extensão .pdf (por exemplo: Apontamento.pfd) - Salvar<br />
                                        <br />
                                        <b style="color: red;">DICA: </b>Caso queira gerar o espelho de ponto de todos os funcionários de uma única vez, antes de iniciar 
                                        esse procedimento, clique com o botão direito do mouse no nome de qualquer funcionário na lista e clique na opção 
                                        selecionar tudo. Em seguida clique no botão Espelho de Ponto.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Relatórios
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        O Asseponto permite relatórios personalizados em SQL de acordo com a necessidade das empresas.
                                        Para solicitar um relatório envie um email para <a href="mailto:suporte@assecont.com.br" target="_top">supote@assecont.com.br</a> com a solicitação desejada.<br />
                                        <br />

                                        <ul>
                                            <li><b>Apontamentos</b><br />
                                                Este relatório exibe os apontamentos de acordo com a opção selecionada.<br />

                                                - Selecione a opção que deseja visualizar no relatório. (Até 8 opções simultâneas).<br />
                                                - Defina o titulo do relatório.<br />
                                                - Defina em seguida a orientação retrato ou paisagem.<br />
                                                - Opções de visualização da ordem de visualização do funcionário.<br />
                                                Nome, nome e registro e registro e nome.
                                                <br />
                                                - Tipo de relatório detalhado dia a dia com as ocorrências selecionadas ou totalizado.<br />
                                                - Selecione o departamento ou somente o funcionário selecionado.<br />
                                                <br />
                                            </li>
                                            <li><b>Banco de horas</b><br />

                                                Este relatório exibe o banco de horas com a opção selecionada.<br />
                                                <br />

                                                -Defina o titulo do relatório.<br />
                                                -Tipo de relatório detalhado dia a dia com as ocorrências selecionadas ou totalizado.<br />
                                                -Selecione o departamento ou somente o funcionário selecionado.<br />
                                                -Opções de visualização da ordem de visualização do funcionário.<br />
                                                Nome, nome e registro e registro e nome.
                                                <br />
                                                -Exibir marcações no relatório<br />
                                                -Exibir apenas funcionário ativos.<br />
                                                <br />
                                            </li>
                                            <li><b>Justificativas</b><br />

                                                Este relatório exibe as justificativas realizadas no sistema.<br />
                                                <br />

                                                -Defina o titulo do relatório.<br />
                                                -Podemos definir o tipo de justificativa para exibir no relatório.<br />
                                                -Defina o período que deseja visualizar.<br />
                                                -Selecione o departamento ou somente o funcionário selecionado.<br />
                                                Variáveis<br />
                                                -Defina o titulo do relatório.<br />
                                                -Selecione o departamento ou somente o funcionário selecionado.<br />

                                            </li>
                                        </ul>
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
