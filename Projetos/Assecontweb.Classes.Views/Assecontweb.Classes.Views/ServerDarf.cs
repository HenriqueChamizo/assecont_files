using System;
using System.ComponentModel;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using Wr.Classes;
using System.Data;

namespace Assecontweb.Classes.Views
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:ServerDarf runat=server></{0}:ServerDarf>")]

    public class ServerDarf : WebControl
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        #region Getters & Setters
        private int _Darf;
        public int Darf
        {
            get { return _Darf; }
            set { _Darf = value; }
        }

        private int _Cliente;
        public int Cliente
        {
            get { return _Cliente; }
            set { _Cliente = value; }
        }

        private Boolean _Recalculo;
        public Boolean Recalculo
        {
            get { return _Recalculo; }
            set { _Recalculo = value; }
        }

        private DateTime _dataPagamento;
        public DateTime dataPagamento
        {
            get { return _dataPagamento; }
            set { _dataPagamento = value; }
        }
        #endregion

        //public ServerDarf(int Darf, int Cliente, int Recalculo)
        //{
        //    this.Darf = Darf;
        //    this.Cliente = Cliente;
        //    this.Recalculo = Recalculo;
        //}

        protected override void RenderContents(HtmlTextWriter output)
        {
            StringBuilder html = new StringBuilder();

            html.Append(gerarDarfHtml());

            output.WriteLine(html);
        }

        public string gerarDarfHtml()
        {
            string html = string.Empty;

            html += Global.rotate;
            html += style();

            BDAppLocal bd = new BDAppLocal();

            string execute = "EXEC rs_darf  @P_DARF = {0}, @P_CLIENTE = {1}, @P_RECALCULO = {2},  @P_DATA_PAGAMENTO = '{3}'";

            if (dataPagamento == (new DateTime()))
                execute = "EXEC rs_darf  @P_DARF = {0}, @P_CLIENTE = {1}, @P_RECALCULO = {2}";

            DataTable tbDados = bd.getDataTable(string.Format(execute, Darf, Cliente, Recalculo ? 1 : 0, dataPagamento));

            int i = 0;

            for (; i < tbDados.Rows.Count; i++)
            {
                html += getDarf(tbDados.Rows[i], bd);
                html += primeiraVia();
                html += getDarf(tbDados.Rows[i], bd);
            }

            return html;
        }

        #region Recibo Darf
        private string getDarf(DataRow reader, BDAppLocal bd)
        {
            string html = string.Empty;

            if (Convert.ToInt16(reader["DARFPAGO"]) == 1) //Rotação Darf Pago
            {
                html += "<div style='position: absolute; left: 316px; top: 274px; font-size: 45pt; color: #777777;' class='rotate'> Darf Pago</div>" +
                        "<div style='position: absolute; left: 316px; top: 825px; font-size: 45pt; color: #777777;' class='rotate'>Darf Pago </div>";
            }
            else
                if (Convert.ToBoolean(reader["DARFUNIFICADONAOCONSOLIDADO"])) //Rotação Darf não consolidado
                {
                    html += "<div style='position: absolute; left: 316px; top: 274px; font-size: 45pt; color: #777777;' class='rotate'>Não consolidado</div>" +
                            "<div style='position: absolute; left: 316px; top: 825px; font-size: 45pt; color: #777777;' class='rotate'>Não consolidado</div>";
                }
                else
                    if (Convert.ToDateTime(reader["DARF_VENCIMENTO"]).CompareTo(DateTime.Now) > 1) //Rotação Darf Vencido
                    {
                        html += "<div style='position: absolute; left: 316px; top: 274px; font-size: 45pt; color: #777777;' class='rotate'>Darf Vencido</div>" +
                                "<div style='position: absolute; left: 316px; top: 825px; font-size: 45pt; color: #777777;' class='rotate'>Darf Vencido</div>";
                    }

            html += "<table style='border: 1px solid Black; border-collapse: collapse; margin-left: 10px; width: 820px;' cellspacing='0' cellpadding='0' class='tabela'> " +
                            "<tr><td valign='top'>";

            html += "<table border='0' cellspacing='0' cellpadding='0' style='border-collapse: collapse; width: 410px;' class='tabela'><tr>";

            html += "<td style='height: 180px; padding: 2px 0px 2px 2px;'><img id='logoReceita' alt='' src='" + Global.getImagem(Properties.Resources.logoDarf).ImageUrl + "' Width='80'> </img></td> "; //logo

            html += "<td style='padding: 6px 6px 2px 6px; font-size: 13pt;'> <b>MINISTÉRIO DA FAZENDA <br /> SECRETARIA DA RECEITA FEDERAL</b><br /><br /> " +
                                "<div style='font-size: 10pt;'>Documento de Arrecadação de Receitas Federais</div><br /><br /> " +
                                "<b><div style='text-align: center;' class='titulo'>DARF</div></b> </td></tr>";

            html += "<tr><td style='height: 110px; padding: 2px 2px 2px 5px; border-bottom: 1px solid Black; border-top: 1px solid Black;' valign='top' colspan='2'>01.NOME/TELEFONE <br />" +
                         reader["CLI_RAZAOSOCIAL"].ToString() + "<br />" + reader["CLI_TELEFONE"].ToString() + "</td></tr> ";

            #region  Referencia Dados
            html += "<tr><td style='height: 140px; padding: 5px 5px 5px 5px; vertical-align: top;' colspan='2' class='infodestaque'>DARF referente ";

            if (!(reader["OBRCLIPER_PARCELA"] is DBNull))
                html += reader["OBRCLIPER_PARCELADESCRICAO"].ToString() + "<br />";

            //html += reader["OBR_DESCRICAO_SIMPLIFICADA"].ToString() + "<br />";

            if (Convert.ToBoolean(reader["DARF_UNIFICADO"]))
                html += "<br />DARF UNIFICADO<br />";

            if (!(reader["NOTA"] is DBNull))
                html += reader["NOTA"].ToString();

            if (!(reader["PRESTADOR"] is DBNull))
                html += " - " + reader["PRESTADOR"].ToString() + "<br />";

            if (!(reader["PRE_PROC_PIS"] is DBNull))
                html += "Processo não retenção Pis nº " + reader["PRE_PROC_PIS"].ToString() + "<br />";

            if (!(reader["PRE_PROC_COFINS"] is DBNull))
                html += "Processo não retenção Cofins nº " + reader["PRE_PROC_COFINS"].ToString() + "<br />";

            if (!(reader["PRE_PROC_CSLL"] is DBNull))
                html += "Processo não retenção CSLL nº " + reader["PRE_PROC_CSLL"].ToString() + "<br />";

            if (!Convert.ToBoolean(reader["SELICNAODISPONIVEL"] is DBNull))
                html += "<b>válido para pagamento até " + String.Format("{0: dd/MM/yyyy}", reader["DATAPAGAMENTO"]) + "</b><br />";

            if (!(reader["DARF_FRASE"] is DBNull))
                html += reader["DARF_FRASE"].ToString() + "<br />";

            html += "</td></tr>";
            #endregion

            html += "<tr><td style='height: 20px; padding: 2px 2px 2px 2px;' valign='top' colspan='2'>&nbsp;</td> " +
                             "</tr></table></td>";

            html += "<td valign='top'><table border='0' cellspacing='0' cellpadding='0' class='tabela'> ";

            html += "<tr><td style='height: 45px; width: 180px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black; width: 160px;' valign='top'>02.PERÍODO DE APURAÇÃO</td> " +
                                " <td style='text-align: right; padding: 2px 5px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black; width: 160px;'> " +
                                         String.Format("{0: dd/MM/yyyy}", reader["DARF_PERIODOAPURACAO"]) + " </td></tr> ";

            html += "<tr><td style='height: 45px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>03.NÚMERO DO CPF OU CNPJ</td> " +
                                "<td style='text-align: right; padding: 2px 5px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;'> " +
                                    reader["CNPJCPF"].ToString() + "</td></tr> ";

            html += "<tr><td style='height: 45px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>04.CÓDIGO DA RECEITA</td> " +
                                 "<td style='text-align: right; padding: 2px 5px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;'> " +
                                 String.Format("{0:0000}", reader["DARF_CODIGORECEITA"]) + "</td></tr> ";

            html += "<tr><td style='height: 45px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>05.NÚMERO DE REFERÊNCIA</td> " +
                                "<td style='text-align: right; padding: 2px 5px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;'> " +
                                reader["DARF_NUMEROREFERENCIA"].ToString() + "</td></tr>";

            html += "<tr><td style='height: 45px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>06.DATA DE VENCIMENTO</td> " +
                                "<td style='text-align: right; padding: 2px 5px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;'> " +
                                    String.Format("{0: dd/MM/yyyy}", reader["DARF_VENCIMENTO"]) + "</td></tr>";

            html += "<tr><td style='height: 45px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>07.VALOR DO PRINCIPAL</td> " +
                              "<td style='text-align: right; padding: 2px 5px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;'>";

            html += Convert.ToBoolean(reader["SELICNAODISPONIVEL"]) ? "Selic não Disponível" : String.Format("{0:N}", reader["DARF_VALOR"]);
            //if (!Convert.ToBoolean(reader["SELICNAODISPONIVEL"]))
            //    html += String.Format("{0:N}", reader["DARF_VALOR"]);

            //if (Convert.ToBoolean(reader["SELICNAODISPONIVEL"]))
            //    html += "Selic não Disponível";

            html += "</td></tr>";

            html += "<tr><td style='height: 45px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>08.VALOR DA MULTA</td> " +
                             "<td style='text-align: right; padding: 2px 5px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;'> " +
                                 String.Format("{0:N}", reader["MULTAVALOR"]) + "</td></tr> ";

            html += "<tr><td style='height: 45px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>09.VALOR DOS JUROS E/OU ENCARGOS </td>" +
                            "<td style='text-align: right; padding: 2px 5px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;'> " +
                            String.Format("{0:N}", reader["JUROSVALOR"]) + "</td></tr>";


            html += "<tr><td style='height: 45px; padding: 2px 2px 2px 2px; border-left: 1px solid Black; border-bottom: 1px solid Black;' valign='top'>10.VALOR TOTAL </td>" +
                        "<td style='text-align: right; padding: 2px 5px 2px 2px; border-left: 1px solid Black; border-bottom: 1px solid Black;'> ";

            html += Convert.ToBoolean(reader["SELICNAODISPONIVEL"]) ? "Selic não Disponível" : String.Format("{0:N}", reader["VALORTOTAL"]);

            //if (!Convert.ToBoolean(reader["SELICNAODISPONIVEL"]))
            //    html += String.Format("{0:N}", reader["VALORTOTAL"]);

            //if (Convert.ToBoolean(reader["SELICNAODISPONIVEL"]))
            //    html += "Selic não Disponível";

            html += "</td></tr>";

            html += "<tr><td style='height: 60px; padding: 2px 2px 2px 2px; border-left: 1px solid Black;' valign='top' colspan='2'>11.AUTENTICAÇÃO BANCÁRIA (SOMENTE NAS 1a E 2a VIAS) " +
                                "</td></tr></table></td></tr></table> ";

            #region Codigo de Barras
            html += "<table style='border-collapse: collapse; font-size: 12pt; margin-top: 10px; margin-left: 10px; width: 820px;'> " +
                "<tr><td style='width: 130px; font-size: 9pt; padding-bottom: 5px;'> " +
                    reader["DARF_DAS_BARRAS1"].ToString() +
                    "</td><td style='width: 130px; font-size: 9pt; padding-bottom: 5px;'> " +
                    reader["DARF_DAS_BARRAS2"].ToString() +
                    "</td><td style='width: 130px; font-size: 9pt; padding-bottom: 5px;'> " +
                        reader["DARF_DAS_BARRAS3"].ToString() +
                   "</td><td style='font-size: 9pt; padding-bottom: 5px;'> " +
                        reader["DARF_DAS_BARRAS4"].ToString() +
                    "</td></tr><tr><td colspan='4'> ";

            if (!(reader["DARF_DAS_BARRAS1"] is DBNull))
            {
                html += "<img alt='' src='" + getCodigoBarras(bd).ImageUrl + "' > </img>";
            }

            html += "</td></tr></table>";
            #endregion

            return html;
        }
        #endregion

        #region getCodigoBarras

        private Image getCodigoBarras(BDAppLocal bd)
        {
            string sql = "SELECT RTRIM(REPLACE(DARF_DAS_BARRAS1, '-', '')) +" +
                                "RTRIM(REPLACE(DARF_DAS_BARRAS2, '-', '')) + " +
                                "RTRIM(REPLACE(DARF_DAS_BARRAS3, '-', '')) + " +
                                "RTRIM(REPLACE(DARF_DAS_BARRAS4, '-', '')) " +
                                "FROM Darfs WHERE DARF_IND = {0}";

            CodigoBarras ba = new CodigoBarras();

            System.Drawing.Image img = ba.REGGerarCodigoBarra(bd.getFieldValueString(string.Format(sql, _Darf)));

            //Image imgBarCode = new Image();
            //using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            //{
            //    img.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
            //    byte[] byteImage = ms.ToArray();

            //    Convert.ToBase64String(byteImage);

            //    imgBarCode.ImageUrl = "data:image/jpg;base64," + Convert.ToBase64String(byteImage);
            //}

            return Global.getImagem(img);
        }
        #endregion

        private string style()
        {
            return "<style> " +
                      ".imageajust1 { position: relative; top: -1px; } " +
                      ".tabela{ font-size: 11pt; font-family: 'Segoe UI' } " +
                      ".titulo{ font-size: 22pt; font-family: 'Segoe UI' } " +
                      ".infodestaque{ font-size: 13pt; } </style> ";
        }

        private string primeiraVia()
        {
            return "<div class='tabela' style='margin-left: 20px; margin-top: 10px; margin-bottom: 18px; font-size: 9pt;'> " +
                        "<span>1º Via -----------------------------------------------------------------------------------------</span> " +
                    "</div> ";
        }
    }
}
