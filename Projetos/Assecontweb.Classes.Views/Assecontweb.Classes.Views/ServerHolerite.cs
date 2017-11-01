using System.ComponentModel;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Data;
using Wr.Classes;

namespace Assecontweb.Classes.Views
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:ServerHolerite runat=server></{0}:ServerHolerite>")]

    public class ServerHolerite : WebControl
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        #region Getters & Setters
        private int _Funcionario;
        public int Funcionario
        {
            get { return _Funcionario; }
            set { _Funcionario = value; }
        }

        private int _Cliente;
        public int Cliente
        {
            get { return _Cliente; }
            set { _Cliente = value; }
        }

        private int _Mes;
        public int Mes
        {
            get { return _Mes; }
            set { _Mes = value; }
        }

        private int _Ano;
        public int Ano
        {
            get { return _Ano; }
            set { _Ano = value; }
        }

        private int _HoleriteTipo;
        public int HoleriteTipo
        {
            get { return _HoleriteTipo; }
            set { _HoleriteTipo = value; }
        }
        #endregion

        //public ServerHolerite()
        //{

        //}

        protected override void RenderContents(HtmlTextWriter output)
        {
            BDAppLocal bd = new BDAppLocal();
            string html = string.Empty;
            //html += Global.inicioHtml;

            if (string.IsNullOrEmpty(Funcionario.ToString()) || Funcionario == 0)
                html += gerarRelatorioHoleriteCliente(bd);
            else
                html += gerarRelatorioHoleriteFuncionario(bd);

            //html += Global.fimHtml;

            output.WriteLine(html);
        }

        public string gerarRelatorioHoleriteCliente(BDAppLocal bd)
        {
            string html = string.Empty;

            html += style();

            DataTable tbHolerite = bd.getDataTable(string.Format("EXEC rs_holerite_gerar {0}, {1}, {2}, {3}, 2 ", _Cliente, _Mes, _Ano, _HoleriteTipo));

            int i = 0;

            for (; i < tbHolerite.Rows.Count; i++)
            {
                html += Holerite(tbHolerite.Rows[i]);
                html += primeiraViaFuncionario();
                html += Holerite(tbHolerite.Rows[i]);
                html += rodapeAssinatura();
                html += Global.quebraPagina();
            }

            return html;
        }

        public string gerarRelatorioHoleriteFuncionario(BDAppLocal bd)
        {
            string html = string.Empty;

            html += style();

            DataTable tbHolerite = bd.getDataTable(string.Format("EXEC rs_holerite_gerar {0}, {1}, {2}, {3}, 1 ", _Funcionario, _Mes, _Ano, _HoleriteTipo));

            int i = 0;

            for (; i < tbHolerite.Rows.Count; i++)
            {
                html += Holerite(tbHolerite.Rows[i]);
                if (_Cliente <= 0)
                    html += rodapeDisponivelOnline(Convert.ToDateTime(tbHolerite.Rows[i]["SAL_DATA_CRIACAO"]));
                else
                {
                    html += primeiraViaFuncionario();
                    html += Holerite(tbHolerite.Rows[i]);
                    html += rodapeAssinatura();
                }
                html += Global.quebraPagina();
            }

            return html;
        }

        #region Holerite
        public string Holerite(DataRow reader)
        {
            string html = string.Empty;

            html += "<table class='tableHolerite' style='border: 1px solid Black; width: 800px;' cellspacing='0' cellpadding='0'> " +
                      "<tr><td valign='top' class='tableTd'> " +
                      "<table style='width: 600px; white-space: nowrap;' border='0' cellspacing='0' cellpadding='0' class='tableHolerite'>" +
                          "<tr><td><div align='center' style='margin-bottom: 3px;'> " +
                              reader["HOLERITE_TITULO"].ToString() +
                                  "</div>" + String.Format("{0:0000}", reader["CLI_NUMERO"]) + "&nbsp;&nbsp;" +
                                  reader["CLI_RAZAOSOCIAL"].ToString() + "<br />" +
                                  reader["CLI_ENDERECO"].ToString() + reader["CLI_ENDERECO_NUMERO"].ToString() + reader["CLI_ENDERECO_MUNICIPIO"].ToString() +
                                  "<br />" + reader["EST_NOME"].ToString() + " - SP&nbsp;&nbsp;" + reader["CLI_ENDERECO_CEP"] + "&nbsp;&nbsp;" + reader["CNPJ_CPF"].ToString() +
                                  "<br /></td></tr></table> </td>";

            html += "<td align='right' style='border-left: 1px solid Black;'>" +
                          "<table style='width: 200px;' class='tableHolerite' border='0' cellspacing='0' cellpadding='0'> " +
                              "<tr><td class= tableTd'  style='border-bottom: 1px solid Black; height: 25px;'> " +
                                  "<div align='left'>Competência </div>" +
                                  "<div align='right'> " + String.Format("{0:MM/yyyy}", reader["SAL_COMPETENCIA"]) + "</div></td></tr> " +
                              "<tr><td class='tableTd' style='height: 25px'> " +
                                  "<div align='left'>Divisão R.H.</div> <div align='right'> " + reader["SAL_DIVISAO"] +
                               "</div></td></tr></table></td></tr>";

            html += "<tr><td style='border: 1px solid Black;' colspan='2'> " +
                           "<table border='0' cellspacing='0' cellpadding='0' class='tableHolerite'><tr>" +
                               "<td class='tableTd' style='width: 132px; border-right: 1px solid Black;'> <div>Nº Reg. </div> " + String.Format("{0:00000}", reader["FUNC_REG"]) + "</td>" +
                               "<td class='tableTd' style='width: 380px; border-right: 1px solid Black;'> <div>Nome </div> " + reader["FUNC_NOME"] + "</td> " +
                               " <td class='tableTd' style='width: 195px;'> <div>Função </div> " + reader["SAL_FUNCAO"] + "</td> " +
                        "</tr></table></td></tr>";

            html += "<tr><td style='border: 1px solid Black;' colspan='2'> " +
                           "<table border='0' cellspacing='0' cellpadding='0' class='tableHolerite'> " +
                               "<tr><td class='tableTd' style='width: 132px; border-right: 1px solid Black;'> " +
                                   "<div>CPF </div> " + String.Format(@"{0:000\.000\.000\-00}", Convert.ToDouble(reader["FUNC_CPF"])) +
                                   "</td><td class='tableTd' style='width: 180px; border-right: 1px solid Black;'> " +
                                       "<div>Banco/AG</div> " + reader["FUNC_BANCO"] +
                                   "</td><td class='tableTd' style='width: 193px; border-right: 1px solid Black;'> " +
                                       "<div>Conta Corrente</div> " + reader["FUNC_CONTA"] + "</td> " +
                                   "<td class='tableTd'> <div>Creditado</div> " + reader["SAL_CREDITO"] + "</td> " +
                               "<tr></table></td></tr>";

            html += "<tr><td style='border: 1px solid Black;' colspan='2'> " +
                           "<table border='0' cellspacing='0' cellpadding='0' class='tableHolerite'><tr> " +
                               "<td class='tableTd' align='center' style='width: 32px; border-right: 1px solid Black;'>Cód.</td> " +
                                   "<td class='tableTd' align='center' style='width: 292px; border-right: 1px solid Black;'>Descrição</td> " +
                                   "<td class='tableTd' align='center' style='width: 85px; border-right: 1px solid Black;'>Referência</td> " +
                                   "<td class='tableTd' align='center' style='width: 160px; border-right: 1px solid Black;'>Vencimentos</td> " +
                                   "<td class='tableTd' align='center' style='width: 190px;'>Descontos</td> " +
                             "</tr></table></td></tr> ";

            html += "<tr><td style='border: 1px solid Black;' colspan='2'> " +
                           "<table border='0' cellspacing='0' cellpadding='0' class='tableHolerite'><tr> " +
                                   "<td class='tableTd' align='center' valign='top' style='width: 32px; height: 270px; border-right: 1px solid Black;'> " +
                                           reader["EVENTOCODIGO"].ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") + "</td> " +
                                   "<td class='tableTd' valign='top' style='width: 292px; height: 270px; border-right: 1px solid Black;'> " +
                                           reader["EVENTODESCRICAO"].ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") + "</td> " +
                                   "<td class='tableTd' align='right' valign='top' style='width: 85px; height: 270px; border-right: 1px solid Black;'> " +
                                           reader["EVENTOREFERENCIA"].ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") + "</td> " +
                                   "<td class='tableTd' align='right' valign='top' style='width: 160px; height: 270px; border-right: 1px solid Black;'> " +
                                           reader["EVENTOVENCIMENTO"].ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") + "</td> " +
                                   "<td class='tableTd' align='right' valign='top' style='width: 204px; height: 270px'> " +
                                           reader["EVENTODESCONTO"].ToString().Replace(Environment.NewLine, "<br/>").Replace("\n", "<br />") + "</td> " +
                               "</tr></table></td></tr> ";

            html += "<tr><td style='border: 1px solid Black;' colspan='2'> " +
                            "<table border='0' cellspacing='0' cellpadding='0' class='tableHolerite'><tr> " +
                                    "<td style='width: 100px; border-right: 1px solid Black; padding-left: 5px;'> " +
                                        "<b>Resumo do Salário</b> " + "</td> " +
                                    "<td style='width: 155px; border-right: 1px solid Black; padding-right: 5px;' align='right'> " +
                                        "<div align='center'>Salário Base </div> " + reader["SAL_BASE"] + "</td> " +
                                    "<td style='width: 157px; border-right: 1px solid Black; padding-right: 5px;' align='right'> " +
                                        "<div align='center'>Salário Contribuição</div> " + reader["SAL_CONTRIBUICAO"] + "</td> " +
                                    "<td style='width: 161px; border-right: 1px solid Black; padding-right: 5px;' align='right'> " +
                                        "<div align='center'>Total de vecimentos</div> " + reader["SAL_VENCIMENTOS"] + "</td> " +
                                    "<td style='width: 205px; padding-right: 5px;' align='right'> " +
                                        "<div align='center'>Total de descontos</div> " + reader["SAL_DESCONTOS"] + "</td> " +
                                "</tr></table></td></tr> ";

            html += "<tr><td style='border: 1px solid Black;' colspan='2'> " +
                     "<table border='0' cellspacing='0' cellpadding='0' class='tableHolerite'><tr> " +
                             "<td style='width: 145px; border-right: 1px solid Black; padding-right: 5px;' align='right'> " +
                                 "<div align='center'>Base Cál. F.G.T.S</div> " + reader["SAL_BASEFGTS"] + "</td> " +
                             "<td style='width: 145px; border-right: 1px solid Black; padding-right: 5px;' align='right'> " +
                                 "<div align='center'> F.G.T.S do Més</div> " + reader["SAL_MESFGTS"] + "</td> " +
                             "<td style='width: 145px; border-right: 1px solid Black; padding-right: 5px;' align='right'> " +
                                 "<div align='center'>Base Cál. I.R.</div> " + reader["SAL_BASECALIR"] +
                             "</td> " +
                             "<td style='width: 143px; border-right: 1px solid Black;' align='center'> " +
                                 "<b>LÍQUIDO<br />A RECEBER</b> " +
                             "</td> " +
                             "<td style='width: 205px; padding-right: 5px;' align='right'><br /> " + reader["SAL_LIQUIDO"] +
                             "</td> " +
                     "</tr></table></td></tr> ";

            html += "<tr><td colspan='2'> " +
                            "<div style='height: 15px; padding-left: 5px;'> " + reader["SAL_FRASE"] + "</div> " +
                    "</tr></table></td></tr> ";

            return html;
        }
        #endregion

        private string style()
        {
            return "<style> .tableHolerite{ font-size: 8.5pt; font-family: Arial; border-collapse: collapse;} " +
                           ".tableTd{padding: 0px 3px 0px 3px;} </style> ";
        }


        private string rodapeAssinatura()
        {
            return "<table style='width: 808px; height: 70px; border: 1px solid Black; margin: 12px 0px 5px 0px;' class='tableHolerite' cellspacing='0' cellpadding='0'> " +
                   "<tr><td colspan='2' align='center'>DECLARO TER RECEBIDO A IMPORTÂNCIA LÍQUIDA DISCRIMINADA NESTE RECIBO</td></tr> " +
                   "<tr><td colspan='2'></td></tr> " +
                   "<tr><td style='padding-left: 60px'>___________________________ <div style='padding-left: 60px'>DATA</div></td> " +
                   "<td style='padding-left: 80px'>________________________________________________________<div style='padding-left: 80px'>ASSINATURA DO FUNCIONARIO</div> </td></tr></table> ";
        }

        private string rodapeDisponivelOnline(DateTime dataCriacao)
        {
            return "<table style='width: 808px; height: 70px; border: 1px solid Black; border-collapse: collapse; margin: 12px 0px 5px 0px;' class='tableHolerite' cellspacing='0' cellpadding='0'> " +
                               "<tr><td colspan='2' align='center'>DECLARO TER RECEBIDO A IMPORTÂNCIA LÍQUIDA DISCRIMINADA NESTE RECIBO</td></tr>" +
                               "<tr><td colspan='2'></td></tr> " +
                               "<tr><td style='padding-left: 60px'><b>RECIBO DISPONIBILIZADO EM: <span style='font-size: 9pt';>" + dataCriacao.ToString("dd/MM/yyyy") + "</span></b> </td> " +
                               "<td style='padding-left: 180px'><b>HOLERITE ELETRÔNICO</b></td></tr></table> ";
        }

        private string primeiraViaFuncionario()
        {
            return "<div class='tableHolerite' style='position: relative; font-weight: bold; margin: 6px 0px 6px 0px;'>1º&nbsp;via/Funcionário<br /> " +
                "------------------------------------------------------------------------------------------------------------------------</div>";
        }
    }
}