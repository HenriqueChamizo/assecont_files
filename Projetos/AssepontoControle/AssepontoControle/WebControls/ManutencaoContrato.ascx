<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManutencaoContrato.ascx.cs" Inherits="Asseponto.WebControls.ManutencaoContrato" %>



<div>
    <p style="font-size: 12pt;">
        <input type="button" value="Imprimir Contrato" onclick="JavaScript: imprimePanel('impressao');" class="sitebutton" />
    </p>
</div>

<div id="impressao">
    <style type="text/css">
        /*body
        {
            font-family: Arial;
            font-size: 10pt;
        }*/

        table
        {
            border: 0;
            border-collapse: collapse;
        }

        .table td
        {
            padding-bottom: 6px;
        }

        li
        {
            padding-top: 7px;
            text-align: justify;
            font-size: 10pt;
        }

        ul
        {
            margin-top: 0px;
            margin-bottom: 0px;
        }
    </style>

    <table style="width: 780px;font-family: Arial;font-size: 10pt;">
        <tr>
            <td>
                <img alt="" src="http://www.asseponto.com.br/assepontocontrole/Images/Emails/cabecalho.png" width="780" />
            </td>
        </tr>
        <tr>
            <td align="center" style="padding-top: 0px; padding-bottom: 8px;"><b>CONTRATO PARTICULAR DE PRESTAÇÃO DE SERVIÇOS</b>
            </td>
        </tr>
        <tr>
            <td style="padding-left: 20px; padding-left: 30px;">
                <table style="width: 100%" class="table">

                    <tr>
                        <td valign="top"><b>CONTRATADA:</b>
                        </td>
                        <td><b>Assecont Tecnologia Ltda EPP
                                    <br />
                            Rua Mario, 194 - Vila Romana – SP – CEP 05048-010
                                    <br />
                            CNPJ: 13.369.340/0001-36 </b>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top"><b>CONTRATANTE:</b>
                        </td>
                        <td style="word-break: break-word;"><b>
                            <asp:Label ID="lbContratante" runat="server" Text=""></asp:Label><br />
                            <asp:Label ID="lbCnpjContratante" runat="server" Text=""></asp:Label></b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="font-size: 10pt; padding-top: 10px;">As partes acima qualificadas representadas têm entre si como justas e combinadas o 
                                            presente contrato de prestação de serviços ("CONTRATO") que se regerá pelas cláusulas e condições seguintes:
                        </td>
                    </tr>
                    <tr>
                        <% if (Web == 0)
                            { %>
                        <td colspan="2" style="font-size: 8pt;">
                            <ul style="list-style-type: decimal; font-size: 8pt;">
                                <li>O presente contrato tem por objeto a manutenção do software ASSEPONTO, serviços de suporte técnico para operação os quais se darão por: telefones, skype, internet (acessos remotos), e chat, bem como assessoria e consultoria legal sobre os dispostos na CLT e jurisprudências sobre jornadas de trabalho e intrajornada, acompanhamento para fechamento de ponto, atualizações (up-grades) do software e orientação para operação do REP.
                                       <br />
                                    a)	Problemas com arquivos e reinstalações serão resolvidos por e-mail <b style="color:blue;">suporte@assecont.com.br</b> internet (acesso remoto), skype ou chat;
                                       <br />
                                    b)	As visitas técnicas não estão inclusas no objeto do contrato, devendo ser orçadas à parte junto à CONTRATADA. 
                                       <br />
                                    c)	Inclui treinamento operacional online (acesso remote skype ou telefone). Visita para treinamento (in-loco) quando solicitado, será cobrado à parte, vide valores da CONTRATADA.
                                        <br />
                                </li>

                                <li>As partes se obrigam a informar eventuais mudanças de endereços, e-mail e telefones, presumindo-se recebidas pela outra parte às mensagens eletrônicas encaminhadas pelo correio eletrônico constante quando da realização do cadastro.</li>

                                <li>Pela prestação de serviços pagará a CONTRATANTE à CONTRATADA a quantia mensal de
                                                    <b style="font-size: 12pt; word-break: normal;">R$&nbsp;<asp:Label ID="lbValor2" runat="server" Text=""></asp:Label>
                                                    </b><b>(<asp:Label ID="lbValorDescricao" runat="server" Text=""></asp:Label>), pagáveis através de cobrança bancária com vencimento no último dia útil do mês e reajustáveis anualmente pelo índice acumulado do IGPM.
                                                    </b>
                                </li>

                                <li>Sem prejuízo do disposto na cláusula anterior, o início da prestação de serviços está condicionada ao pagamento de taxa de adesão, no valor de 
                                                    <b style="font-size: 12pt; word-break: normal;">R$&nbsp;<asp:Label ID="lbValor3" runat="server" Text=""></asp:Label>
                                                    </b><b>(<asp:Label ID="lbValorDescricao3" runat="server" Text=""></asp:Label>)</b>
                                </li>

                                <li>Os boletos serão enviados por e-mail cerca de 15 (quinze) dias antes do vencimento. A CONTRATANTE poderá também extrair o respectivo boleto através do site <b style="color:blue">www.assecont.com.br</b>  sistema desenvolvido pela CONTRATADA.</li>

                                <li>O presente contrato vigorará pelo prazo de <b><asp:Label ID="lbMeses" runat="server" Text=""></asp:Label> meses</b>, contados da data de sua assinatura, 
                                        renovando-se automaticamente por período indeterminado, salvo pedido de rescisão nos termos da cláusula seguinte.</li>

                                <li>Caso o CONTRATANTE opte pela rescisão imotivada do contrato antes de seu termo ou, por culpa ou dolo, deixe de cumprir quaisquer das disposições contratuais, a CONTRATADA poderá declarar o CONTRATO rescindido de pleno direito, ficando desde já arbitrada multa de 50% (cinquenta por cento) sobre as prestações vincendas que seriam devidas até o termo estabelecido na cláusula anterior.
                                    <br />
                                    <b>Parágrafo único:</b> na hipótese de pedido de rescisão, os serviços de suporte, mencionados na cláusula 1º. e liberações de senhas, serão imediatamente suspensos.
                                </li>

                                <li>Tanto a CONTRATADA como o CONTRATANTE poderão rejeitar os serviços que a seu entender estejam fora dos padrões preestabelecidos ou em desacordo com as especificações da proposta.
                                        <br />
                                        <b>Paragrafo único:</b> Caberá a Contratante permitir que o software objeto deste Contrato seja somente manuseados por seus funcionários, <b>previamente treinados</b>, aptos e capazes da operação, sem apresentar maiores riscos para o bom funcionamento do Software AssePonto”.
                                </li>

                                <li>O presente contrato será considerado rescindido em caso de descumprimento a qualquer de suas cláusulas ou condições, por qualquer uma das partes, ou em virtudes de falência, recuperação judicial, insolvência ou dissolução judicial, requeridas, homologadas ou decretadas.</li>

                                <li>Em caso de inadimplência das parcelas, a parte infratora ficará sujeita ao pagamento de multa moratória de 2% (dois por cento) e juros de mora de 1% (um por cento), devidamente atualizados pelo índice previsto na cláusula 2ª.</li>

                                <li>Após 4 meses de inadimplência das parcelas, sem que haja renegociação, o contrato será considerado rescindido de pleno direito, momento a partir do qual os serviços serão suspensos, ficando a parte infratora sujeita à multa compensatória prevista na cláusula 7ª.</li>

                                <li>Decorridos 30 (trinta) dias vencimento sem que haja uma posição, as faturas serão encaminhadas ao departamento jurídico para cobrança e/ou propositura de ação judicial para cobrança, o que acarretará, além do acréscimo das multas previstas, da aplicação da atualização monetária e dos juros, também o pagamento de honorários advocatícios, arbitrados em 10% (dez por cento) na fase amigável e 20% (vinte por cento) na hipótese de procedimento judicial, a serem aplicados sobre o valor global da obrigação sem prejuízo de eventuais honorários de sucumbência.</li>

                                <li>As partes elegem como competente para qualquer ação decorrente, deste contrato, com exclusão de qualquer outro, por mais privilegiado que seja, o Foro da Comarca da cidade de São Paulo/ SP.</li>
                            </ul>
                        </td>
                        <%}
                            else
                            { %>
                        <td colspan="2" style="font-size: 8pt;">
                            <ul style="list-style-type: decimal; font-size: 8pt;">
                                <li>O presente contrato tem por objeto a locação do software AssePontoWeb (Programa para Apontamento de Horas e Controle de Freqüência de Funcionários pela internet), serviços de suporte técnico para operação os quais se darão por: telefones, skype, internet (acessos remotos), e chat, bem como. Assessoria e consultoria legal sobre os dispostos na CLT e jurisprudências sobre jornadas de trabalho, acompanhamento para fechamento de ponto, atualizações (up-grades) do software e orientação para operação do REP.
                                       <br />
                                    a)	Problemas com arquivos e reinstalações serão resolvidos por e-mail <b style="color:blue;">suporte@assecont.com.br</b> internet (acesso remoto), skype ou chat;
                                       <br />
                                    b)	As visitas técnicas não estão inclusas no objeto do contrato, devendo ser orçadas à parte junto à CONTRATADA. 
                                       <br />
                                    c)	Treinamento operacional online (acesso remoto Skype ou telefone). Visita para treinamento quando solicitado, será cobrado à parte, vide valores da CONTRATADA.  
                                       <br />
                                </li>

                                <li>As partes se obrigam a informar eventuais mudanças de endereços, e-mail e telefones, presumindo-se recebidas pela outra parte as mensagens eletrônicas encaminhadas pelo correio eletrônico constante quando da realização do cadastro.</li>

                                <li>Pela locação e prestação de serviços pagará a CONTRATANTE à CONTRATADA a quantia mensal de 
                                                    <b style="font-size: 12pt; word-break: normal;">R$&nbsp;<asp:Label ID="lbValor4" runat="server" Text=""></asp:Label>
                                                    </b><b>(<asp:Label ID="lbValorDescricao4" runat="server" Text=""></asp:Label>), pagáveis através de cobrança bancária com vencimento no último dia útil do mês e reajustáveis anualmente pelo índice acumulado do IGPM.
                                                    </b>
                                </li>

                                <li>Os boletos serão enviados por e-mail cerca de 15 (quinze) dias antes do vencimento. A CONTRATANTE poderá também extrair o respectivo boleto através do site <b style="color:blue">www.assecont.com.br</b>. Sistema desenvolvido pela CONTRATADA.</li>

                                <li>O presente contrato vigorará por tempo indeterminado, contados da data de sua assinatura, renovando-se automaticamente mês a mês, salvo pedido de rescisão nos termos da cláusula seguinte.</li>

                                <li>Caso o CONTRATANTE opte pela rescisão imotivada do contrato, ou, por culpa ou dolo, deixe de cumprir quaisquer das disposições contratuais, a CONTRATADA poderá declarar o CONTRATO rescindido de pleno direito.
                                    <br />
                                    <b>Parágrafo único:</b> na hipótese de pedido de rescisão, o acesso ao software AssePontoWeb e os serviços de suporte, mencionados na cláusula 1º. serão imediatamente suspensos.
                                </li>

                                <li>Tanto a CONTRATADA como o CONTRATANTE poderão rejeitar os serviços que a seu entender estejam fora dos padrões preestabelecidos ou em desacordo com as especificações da proposta.
                                        <br />
                                        <b>Paragrafo único:</b> Caberá a Contratante permitir que o software objeto deste Contrato seja somente manuseados por seus funcionários, <b>previamente treinados</b>, aptos e capazes da operação, sem apresentar maiores riscos para o bom funcionamento do Software AssePontoWeb”.
                                </li>

                                <li>O presente contrato será considerado rescindido em caso de descumprimento a qualquer de suas cláusulas ou condições, por qualquer uma das partes, ou em virtudes de falência, concordata, insolvência ou dissolução judicial, requeridas, homologadas ou decretadas.</li>

                                <li>Em caso de inadimplência das parcelas, a parte infratora ficará sujeita ao pagamento de multa moratória de 2% (dois por cento) e juros de mora de 1% (um por cento), devidamente atualizados pelo índice previsto na cláusula 2ª.</li>

                                <li>Após 15 (Quinze) dias do vencimento, caso não haja a confirmação de pagamento, o acesso ao software AssePontoWeb é automaticamente bloqueado, sendo liberado após comprovação da pendencia motivo do bloqueio. </li>

                                <li>Após 4 meses de inadimplência das parcelas, sem que haja renegociação, o contrato será considerado rescindido de pleno direito, momento a partir do qual os serviços serão suspensos, ficando a parte infratora sujeita à multa compensatória prevista na cláusula 7ª.</li>

                                <li>Decorridos 30 (trinta) dias vencimento sem que haja uma posição, as faturas serão encaminhadas ao departamento jurídico para cobrança e/ou propositura de ação judicial para cobrança, o que acarretará, além do acréscimo das multas previstas, da aplicação da atualização monetária e dos juros, também o pagamento de honorários advocatícios, arbitrados em 10% (dez por cento) na fase amigável e 30% (trinta por cento) na hipótese de procedimento judicial, a serem aplicados sobre o valor global da obrigação sem prejuízo de eventuais honorários de sucumbência.</li>

                                <li>As partes elegem como competente para qualquer ação decorrente, deste contrato, com exclusão de qualquer outro, por mais privilegiado que seja, o Foro da Comarca da cidade de São Paulo/ SP.</li>
                            </ul>
                        </td>
                        <% } %>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-bottom: 6px">E, por estarem assim, de pleno e comum acordo com as condições estatuídas no presente instrumento, as partes contratantes o assinam com duas testemunhas, em duas vias de igual teor e forma, para um só efeito.</td>
                    </tr>
                    <tr>
                        <td valign="top" style="padding-left: 60px;">São Paulo, <%= DateTime.Now.Day %> de <%= Wr.Classes.Strings.capitalizeWords(Wr.Classes.DateUtils.getMonthName(DateTime.Now.Month)) %> de <%= DateTime.Now.Year %>.   
                        </td>
                        <td style="padding-left: 200px">Testemunhas
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-left: 50px;">
                            <table>
                                <tr>
                                    <td>
                                        <img src="http://www.asseponto.com.br/assepontocontrole/Images/Emails/assJrContrato.png" width="360" />
                                    </td>
                                    <td>1)__________________________</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-left: 50px;">
                            <table>
                                <tr>
                                    <td>_________________________
                                                <br />
                                        <b style="font-size: 9pt;">CONTRATANTE</b>
                                    </td>
                                    <td style="padding-left: 140px">2)__________________________</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <%-- <tr>
                            <td colspan="2" align="center" style="padding-top: 20px;">
                                <img src="http://www.asseponto.com.br/assepontocontrole/Images/Emails/Rodape.png" />
                            </td>
                        </tr>--%>
</div>
