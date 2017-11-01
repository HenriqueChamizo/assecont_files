using System;
using System.ComponentModel;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Assecontweb.Classes.Views
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:ServerInformeRedimento runat=server></{0}:ServerInformeRedimento>")]

    public class ServerInformeRedimento : WebControl
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        #region Getters & Setters
        private int _ObrigacaoArquivo;
        public int ObrigacaoArquivo
        {
            get { return _ObrigacaoArquivo; }
            set { _ObrigacaoArquivo = value; }
        }

        private int _Funcionario;
        public int Funcionario
        {
            get { return _Funcionario; }
            set { _Funcionario = value; }
        }
        #endregion

        //public ServerInformeRedimento(int ObrigacaoArquivo)
        //{
        //    this.ObrigacaoArquivo = ObrigacaoArquivo;
        //}

        protected override void RenderContents(HtmlTextWriter output)
        {
            StringBuilder html = new StringBuilder();

            //html.Append(Global.inicioHtml + Global.rotate);

            if(Funcionario < 0)
                html.Append(gerarInformeClienteHtml());
            else
                html.Append(gerarInformeFuncionarioHtml());

            //html.Append(Global.fimHtml);

            output.WriteLine(html);
        }

        public string gerarInformeClienteHtml()
        {
            string html = string.Empty;

            html += Global.rotate;
            html += style();

            BDAppLocal bd = new BDAppLocal();

            DataTable tbDados = bd.getDataTable(string.Format("SELECT *, dbo.fn_cliente_cnpj_cpf(CLI_IND) AS CLI_CNPJ_CPF, dbo.fn_format_cpf(FUNC_CPF) AS FUNCIONARIO_CPF FROM InformesRendimento " +
                                                    "INNER JOIN Funcionarios ON FUNC_IND = INFRE_FUNC " +
                                                    "INNER JOIN Clientes ON FUNC_EMPRESA = CLI_IND WHERE INFRE_OBRIGACAOARQUIVO = {0}", _ObrigacaoArquivo));

            int i = 0;

            for (; i < tbDados.Rows.Count; i++)
            {
                html += getInforme(tbDados.Rows[i]);
                html += Global.quebraPagina();
            }

            return html;
        }

        public string gerarInformeFuncionarioHtml()
        {
            string html = string.Empty;

            html += Global.rotate;
            html += style();

            BDAppLocal bd = new BDAppLocal();

            DataTable tbDados = bd.getDataTable(string.Format("SELECT *, dbo.fn_cliente_cnpj_cpf(CLI_IND) AS CLI_CNPJ_CPF, dbo.fn_format_cpf(FUNC_CPF) AS FUNCIONARIO_CPF FROM InformesRendimento " +
                                                    "INNER JOIN Funcionarios ON FUNC_IND = INFRE_FUNC " +
                                                    "INNER JOIN Clientes ON FUNC_EMPRESA = CLI_IND WHERE INFRE_FUNC = {0}", _Funcionario));

            int i = 0;

            for (; i < tbDados.Rows.Count; i++)
            {
                html += getInforme(tbDados.Rows[i]);
                html += Global.quebraPagina();
            }

            return html;
        }

        #region Recibo Informe de Rendimento
        public string getInforme(DataRow reader)
        {
            string html = string.Empty;

            html += "<table class='tableRendimento' cellspacing='0' cellpadding='0'> " +
                     "<tr class='borda'><td colspan='2'> ";

            html += "<table style='border-collapse: collapse;' cellspacing='0' cellpadding='0'> " +
                                 "<tr><td style='padding: 5px;'> " +
                                         "<img id='logo' alt='' width='80' src='" + Global.getImagem(Properties.Resources.logoDarf).ImageUrl + "' /> </td> " +
                                     "<td align='Center' style='padding: 5px; width: 350px; white-space: nowrap; border-right: 1px solid black;'> " +
                                         "<b>MINISTÉRIO DA FAZENDA<br />SECRETARIA DA RECEITA FEDERAL DO BRASIL<br />IMPOSTO SOBRE A RENDA DA PESSOA FÍSICA<br />Exercício de " + reader["INFRE_ANO"] + "</b></td> " +
                                     "<td align='Center' style='padding: 5px; width: 350px; white-space: nowrap;'> " +
                                         "<b>COMPROVANTE DE RENDIMENTOS PAGOS E DE<br />RETENÇÃO DE IMPOSTO DE RENDA NA FONTE<br />Ano-Calendário " + reader["INFRE_ANO_REF"] + "</b> </td> " +
                                 "</tr>" +
                             "</table></td></tr>";

            html += "<tr><td colspan='2' style='text-align: center;' class='borda'>Verifique as condições e o prazo para a apresentação da Declaração do Imposto sobre a Renda da Pessoa Física para este Ano-Calendário " +
             "no sítio da Secretaria da Receita Federal do Brasil na Internet, no endereço&lt;www.receita.fazenda.gov.br&gt;</td></tr>";

            //1 - FONTE PAGADORA PESSOA JURÍDICA OU PESSOA FÍSICA
            html += "<tr><td colspan='2' class='titulo'><b>1 - FONTE PAGADORA PESSOA JURÍDICA OU PESSOA FÍSICA</b></td></tr> ";

            html += "<tr class='borda'><td class='td_equerdo'>Nome Empresarial/Nome<br /> " + reader["CLI_RAZAOSOCIAL"] + "</td>";

            html += "<td class='td_direito'>CNPJ/CPF<br /> " + reader["CLI_CNPJ_CPF"] + "</td></tr> ";

            //2 - PESSOA FÍSICA BENEFICIÁRIA
            html += "<tr><td colspan='2' class='titulo'><b>2 - PESSOA FÍSICA BENEFICIÁRIA DOS RENDIMENTOS</b></td></tr> ";

            html += "<tr class='borda'><td colspan='2'> " +
                      "<table class='tableRendimento' cellspacing='0' cellpadding='0'> " +
                          "<tr><td class='td_direito' style='border-right: 1px solid black;'>CPF<br /> " + reader["FUNCIONARIO_CPF"] + "</td>";

            html += "<td class='td_equerdo' style='border-right: 0;'>Nome Completo<br />" + reader["FUNC_NOME"] + "</td></tr></table> </td></tr>";

            html += "<tr class='borda'><td colspan='2' style='padding: 3px;'>Natureza do Rendimento <br />" +
                       reader["INFRE_NATUREZA_RENDIMENTO"] + "</td></tr> ";

            //3 - RENDIMENTOS TRIIBUTÁVEIS, DEDUÇÕES 
            html += "<tr><td class='titulo'><b>3 - RENDIMENTOS TRIIBUTÁVEIS, DEDUÇÕES E IMPOSTO RETIDO NA FONTE</b> </td> " +
                "<td align='Center'>Valores em Reais</td></tr> ";

            html += "<tr class='borda'> <td class='td_equerdo'>01 - Total dos Rendimentos (inclusive Férias)</td> " +
               "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_TOTAL"]) + "</td></tr> ";

            html += "<tr class='borda'> <td class='td_equerdo'>02 - Contribuição Previdenciária Oficial </td> ";

            html += "<td align='Right' class='td_direit'> " + string.Format("{0:n2}", reader["INFRE_CONTRIBUICAO_PREVIDENCIARIA"]) + "</td></tr>";

            html += "<tr class='borda td_direito'><td class='td_equerdo'>03 - Contribuição à Previdência Privada e ao Fundo de Aposentadoria Individual - FAPI</td> " +
                                "<td align='Right'> " + string.Format("{0:n2}", reader["INFRE_CONTRIBUICAO_PREVIDENCIARIA_PRIVADA"]) + "</td></tr>";

            html += "<tr class='borda'> " +
                        "<td class='td_equerdo'>04 - Pensão Alimentícia (informar o beneficiário no quadro 7) </td> " +
                        "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_PENSAO_ALIMENTICIA"]) +
                          "</td></tr> ";

            html += "<tr class='borda'> " + "<td class='td_equerdo'>05 - Imposto de Renda Retido </td> " +
                    "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_IMPOSTO_RENDA_RETIDO"]) +
                    "</td></tr>";

            //4 - RENDIMENTOS ISENTOS E NÃO TRIBUTÁVEIS
            html += "<tr><td class='titulo'><b>4 - RENDIMENTOS ISENTOS E NÃO TRIBUTÁVEIS</b></td>" +
                     "<td align='Center'>Valores em Reais </td></tr> ";

            html += "<tr class='borda'><td class='td_equerdo'>01 - Parcela Isenta dos Proventos de Aposentadoria, Reserva, Reforma e Pensão (65 anos ou mais)</td> ";

            html += "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_PARCIAL_ISENTA"]) + "</td></tr> ";

            html += "<tr class='borda'><td class='td_equerdo'>02 - Diárias e Ajudas de Custo </td> " +
                           "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_AJUDA_DE_CUSTO"]) +
                          "</td></tr>";


            html += "<tr class='borda'>" +
                        "<td class='td_equerdo'>03 - Pensão, Prov.de Aposentadoria ou Reforma por Moléstia Grave e aposentadoria ou <br /> Reforma por Acidente em Serviço </td> " +
                        "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_PENSAO"]) +
                        "</td></tr>";


            html += "<tr class='borda'> " +
                "<td class='td_equerdo'>04 - Lucro e Dividendo Apurado a partir de 1996 pago por PJ (Lucro Real, Presumido ou Arbitrado) </td> " +
                "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_LUCRO"]) + "</td></tr>";

            html += "<tr class='borda'><td class='td_equerdo'>05 - Vlr. Pago ao Titular ou Sócio da Microempresa ou Empr.de Pequeno Porte, exceto Pro-labore, aluguéis ou Serv.Prest. " +
                     "</td><td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_PAGOS_TITULAR"]) + "</td></tr>";


            html += "<tr class='borda'> " +
                    "<td class='td_equerdo'>06 - Indenizações por Rescisão de Contrato de trabalho, PDV e Acidente de trabalho </td> ";

            html += "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_RESCISAO_CONTRATO_TRABALHO"]) + "</td></tr>";

            html += "<tr class='borda'><td class='td_equerdo'>07 - Outros (Salário Família, Abono Pecuniário ou Outros) </td> ";

            html += "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_ISENTOS_OUTROS"]) + "</td></tr>";

            //5 - RENDIMENTOS SUJEITOS À TRIBUTAÇÃO EXCLUSIVA
            html += "<tr><td class='titulo'><b>5 - RENDIMENTOS SUJEITOS À TRIBUTAÇÃO EXCLUSIVA (RENDIMENTO LÍQUIDO)</b></td> " +
                    "<td align='Center'>Valores em Reais</td></tr> ";

            html += "<tr class='borda'><td class='td_equerdo'>01 - Décimo Terceiro Salário </td> " +
                    "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_SALARIO13"]) + "</td></tr>";

            html += "<tr class='borda'> " +
                    "<td class='td_equerdo'>02 - Imposto sobre a renda retido na fonte sobre 13º</td> " +
                    "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_RETIDOSALARIO13"]) + "</td></tr>";

            html += "<tr class='borda'> " +
                  "<td class='td_equerdo'>03 - Outros</td> " +
                  "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_LIQUIDO_OUTROS"]) + "</td></tr>";

            //6 - RENDIMENTOS RECEBIDOS ACUMULADAMENTE
            html += "<tr><td colspan='2' class='Table_td titulo'> " +
                    "<b>6 - RENDIMENTOS RECEBIDOS ACUMULADAMENTE ART. 12-A DA LEI No. 7.713, DE 1988 (Sujeito à tributação Exclusiva)</b></td></tr> ";

            html += "<tr class='borda'> <td style='border-right: 1px solid black;'> ";

            html += "<table style='border-collapse: collapse; border-bottom: 1px solid black; width: 100%; font-size: 10pt;' cellspacing='0' cellpadding='0'> " +
                    "<tr><td style='width: 300px; border-right: 1px solid black; padding: 3px;'>6.1 - Número do Processo: ";

            if (Convert.ToInt32(reader["INFRE_PROCESSOS"].ToString()) > 0)
                html += reader["INFRE_PROCESSOS"];

            //<asp:Label ID="lbNumeroProcesso" Visible='<%# Convert.ToInt32(Eval("INFRE_PROCESSOS").ToString()) > 0 ? true : false %>' runat="server" Text='<%# Eval("INFRE_PROCESSOS") %>'></asp:Label>
            html += "</td><td style='padding: 3px; border-bottom: 1px solid black;'>Quantidade de meses:  " +
                reader["INFRE_QUANTIDADE_MESES"] + "</td></tr></table>";

            html += "<table><tr><td style='padding: 3px;'>Natureza do Rendimento: </td>" +
                    "<td style='padding: 3px;'>";

            if (reader["INFRE_ACUMULADAMENTE_REDIMENTOS"].ToString() == "0.00".Trim())
                html += reader["INFRE_ACUMULADAMENTE_REDIMENTOS"];


            //<asp:Label ID="lbAcumuladamenteNaturezaRendimento" Visible='<%# Eval("INFRE_ACUMULADAMENTE_REDIMENTOS").ToString() == "0.00" ? true : false %>' runat="server" Text='<%# Eval("INFRE_ACUMULADAMENTE_REDIMENTOS") %>'></asp:Label>
            html += " </td></tr></table></td>";

            html += "<td valign='bottom' align='center'>Valores em Reais </td></tr>";

            html += "<tr class='borda'><td class='td_equerdo'>01 - Total dos Rendimentos tributáveis (inclusive Férias e Décimo Terceiro Salário) </td> " +
                            "<td align='Right' class='td_direito'> " +
                            string.Format("{0:n2}", reader["INFRE_TOTAL_TRIBUTAVEL"]) +
                            "</td></tr>";

            html += "<tr class='borda'> <td class='td_equerdo'>02 - Exclusão: Despesas com a Ação Judicial </td>" +
                      "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_EXCLUSAO_ACAO_JUDICIAL"]) +
                      "</td></tr> ";

            html += "<tr class='borda'><td class='td_equerdo'>03 - Dedução: Contribuição Previdenciária Oficial</td> " +
                   "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_DEDUCAO_PREVIDENCIARIA"]) +
                   "</td></tr>";

            html += "<tr class='borda'><td class='td_equerdo'>04 - Dedução: Pensão Alimentícia (informar o beneficiário no quadro 7)</td> "
                    + "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_DEDUCAO_PENSAO_ALIMENTICIA"]) +
                "</td></tr>";

            html += "<tr class='borda'><td class='td_equerdo'>05 - Imposto sobre a Renda Retido na Fonte</td> " +
                 "<td align='Right' class='td_direito'>" + string.Format("{0:n2}", reader["INFRE_IMPOSTO_RETIDO_FONTE"]) +
                 "</td></tr>";

            html += "<tr class='borda'><td class='td_equerdo'>06 - Rendimentos Isentos de Pensão, Proventos de Aposentadoria ou Reforma por Moléstia Grave ou " +
                         "Aposentadoria ou Reforma por Acidente em Serviço</td>" +
                 "<td align='Right' class='td_direito'> " + string.Format("{0:n2}", reader["INFRE_INSENTOS_PENSAO"]) +
                 "</td></tr>";

            //7 - INFORMAÇÕES COMPLEMENTARES
            html += "<tr><td colspan='2' class='titulo'><b>7 - INFORMAÇÕES COMPLEMENTARES</b> </td> </tr>";


            html += "<tr><td colspan='2' class='borda Table_td' style='padding: 5px;'> " +
                    "<table class='tableRendimento' style='width: 750px; min-height: 20px;' cellspacing='0' cellpadding='0'> ";

            if (Convert.ToDouble(reader["INFRE_LIQUIDO_OUTROS"]) > 0 && !String.IsNullOrEmpty(reader["INFRE_LIQUIDO_OUTROS"].ToString()))
                html += "<tr><td style='padding-top: 4px; padding-bottom: 4px;'>O total informado na linha 03 do Quadro 5 já inclui o valor total pago a título de PLR correspondente a " + string.Format("{0:n2}", reader["INFRE_LIQUIDO_OUTROS"]) + "</td></tr>";

            if (!String.IsNullOrEmpty(reader["INFRE_AC_DADOS1"].ToString()))
                html += "<tr><td>" + reader["INFRE_AC_DADOS1"] + "</td></tr>";

            if (!String.IsNullOrEmpty(reader["INFRE_AC_DADOS2"].ToString()))
                html += "<tr><td>" + reader["INFRE_AC_DADOS2"] + "</td></tr>";

            if (!String.IsNullOrEmpty(reader["INFRE_AC_DADOS3"].ToString()))
                html += "<tr><td>" + reader["INFRE_AC_DADOS3"] + "</td></tr>";

            if (!String.IsNullOrEmpty(reader["INFRE_AC_DADOS4"].ToString()))
                html += "<tr><td>" + reader["INFRE_AC_DADOS4"] + "</td></tr>";

            if (!String.IsNullOrEmpty(reader["INFRE_AC_DADOS5"].ToString()))
                html += "<tr><td>" + reader["INFRE_AC_DADOS5"] + "</td></tr>";

            html += "</table></td></tr> ";

            //8 - RESPONSÁVEL PELAS INFORMAÇÕES
            html += "<tr><td colspan='2' class='titulo'><b>8 - RESPONSÁVEL PELAS INFORMAÇÕES</b></td></tr> ";
            html += "<tr><td colspan='2' class='borda'> ";

            html += "<table style='font-size: 10pt; border-collapse: collapse;' cellspacing='0' cellpadding='0'> " +
                     "<tr><td style='width: 300px; padding: 3px;'>Nome<br /> " + reader["INFRE_RESPONSAVEL_NOME"] +
                //<asp:Label ID="lbResponsavelNome" runat="server" Text='<%# Eval("INFRE_RESPONSAVEL_NOME") %>'></asp:Label>
                        " </td>";

            html += "<td style='width: 150px; padding: 3px;'>Data <br />" + Convert.ToDateTime(reader["INFRE_DATA"]).ToString("dd/MM/yyyy") + "</td>";

            html += "<td style='border-left: 1px solid black; padding: 3px; white-space: nowrap;'>Assinatura<br />Isento de Assinatura conf.instr.normat.RFB/1215/2011" +
                        "</td></tr></table></td></tr>";

            html += "<tr><td colspan='2' style='padding: 3px;'> </td></tr></table>";

            //html += "<div style='min-height: 50px;'>Aprovado pela IN RFB No. 1.522, de " +
            //    Convert.ToDateTime(reader["INFRE_DATA"]).Day + " de "  +
            //    DateUtils.getMonthName(Convert.ToDateTime(reader["INFRE_DATA"]).Month) + " de " +
            //    Convert.ToDateTime(reader["INFRE_DATA"]).Year + "</div>";
            return html;
        }
        #endregion

        private string style()
        {
            return "<style> " +
                     ".tableRendimento { " +
                         "font-size: 10pt; " +
                         "font-family: Arial; " +
                         "width: 800px; " +
                         "border-collapse: collapse; } " +

                     ".titulo { " +
                         "padding: 3px; " +
                         "margin-top: 5px; " +
                         "margin-bottom: 5px; } " +

                     ".td_direito { " +
                         "padding: 3px; " +
                         "width: 200px; } " +

                     ".td_equerdo { " +
                         "padding: 3px; " +
                         "width: 600px; " +
                         "border-right: 1px solid black; }  " +

                     ".borda { " +
                         "border: 1px solid Black; } " +
                 "</style>";
        }
    }
}
