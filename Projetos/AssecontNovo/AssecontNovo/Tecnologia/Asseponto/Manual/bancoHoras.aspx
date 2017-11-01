<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="bancoHoras.aspx.cs" Inherits="AssecontNovo.Teste.Manual.bancoHoras" %>

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
    <section class="ContentText">
        <flv:MenuTopManulAsseponto runat="server" ID="MenuTopManulAsseponto" />
        <table>
            <tr>
                <td class="titleSubs font_red">
                    Banco de Horas
                </td>
            </tr>
            <tr>
                <td>
                    <p>
                        Banco de horas é uma possibilidade admissível de compensação de horas, vigente a partir da Lei 9.601/1998.
                                        <br />
                        <br />
                        Trata-se de um sistema de compensação de horas extras mais flexível, mas que exige autorização por convenção 
                                        ou acordo coletivo, possibilitando à empresa adequar a jornada de trabalho dos empregados às suas necessidades 
                                        de produção e demanda de serviços.<br />
                        <br />

                        <b>CARACTERÍSTICAS</b><br />
                        <br />

                        As pessoas estão chamando esse sistema de "banco de horas" porque ele pode ser utilizado, por exemplo, nos momentos
                                         de pouca atividade da empresa para reduzir a jornada normal dos empregados durante um período, sem redução do salário,
                                         permanecendo um crédito de horas para utilização quando a produção crescer ou a atividade acelerar, ressalvado o que 
                                        for passível de negociação coletiva (convenção ou acordo coletivo).<br />
                        <br />

                        Se o sistema começar em um momento de grande atividade da empresa; aumenta-se a jornada de trabalho (no máximo de 
                                        2 horas extras por dia) durante um período. Nesse caso, as horas extras não serão remuneradas, sendo concedidas, 
                                        como compensação, folgas correspondentes ou sendo reduzida a jornada de trabalho até a "quitação" das horas excedentes.
                                        <br />
                        <br />

                        O sistema pode variar dependendo do que for negociado nas convenções ou acordos coletivos, mas o limite será sempre de 
                                        10 horas diárias trabalhadas, não podendo ultrapassar, no prazo negociado no Acordo Coletivo - em período máximo de 1 ano, 
                                        a soma das jornadas semanais de trabalho previstas. A cada período fixado no Acordo, recomeça o sistema de compensação e 
                                        a formação de um novo "banco de horas".
                                        <br />
                        <br />
                        <b>RESCISÃO DO CONTRATO ANTES DA COMPENSAÇÃO DAS HORAS</b><br />

                        A compensação das horas extras deverá ser feita durante a vigência do contrato, ou seja, na hipótese de rescisão de contrato 
                                        (de qualquer natureza), sem que tenha havido a compensação das horas extras trabalhadas, o empregado tem direito ao recebimento 
                                        destas horas, com o acréscimo previsto na convenção ou acordo coletivo, que não poderá ser inferior a 50 % da hora normal.
                    </p>

                    <div class="akordeon" id="buttons">
                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Como pagar/ descontar o banco de horas em folha
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Para pagar ou descontar o saldo do banco de horas, selecione o funcionário na tela inicial acesse banco de horas.<br />
                                        <br />

                                        - Clique sobre a data que deseja pagar-crédito ou descontar - debito e com o botão direito do mouse, lançar saldo em folha.<br />
                                        - Selecione o evento horas extras para pagar e atrasos para decontar, confirme a data e ok.<br />
                                        <br />

                                        <b>Excluir um pagamento/desconto realziado.</b><br />

                                        - Clique sobre a data que realizou o lançamento pagar-crédito ou descontar - debito e com o botão direito do mouse,excluir.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="akordeon-item">
                            <div class="akordeon-item-head">
                                <div class="akordeon-item-head-container">
                                    <div class="akordeon-heading">
                                        Como lançar um saldo anterior no banco de horas
                                    </div>
                                </div>
                            </div>
                            <div class="akordeon-item-body">
                                <div class="akordeon-item-content">
                                    <p>
                                        Para lançar um saldo avulso de créditos ou debitos no banco de horas:<br />
                                        <br />
                                        - Selecione o funcionário, na tela inicial acesse banco de horas.
                                        <br />
                                        - Selecione a esquerda lançamento avulso.
                                        <br />
                                        - Define se é crédito / Débito, a data e o valor, em seguida clique em ok.
                                        <br />
                                        <br />

                                        <b>Excluir um lançamento avulso realziado.</b><br />

                                        - Clique sobre a data que realizou o lançamento direito do mouse,excluir.
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
