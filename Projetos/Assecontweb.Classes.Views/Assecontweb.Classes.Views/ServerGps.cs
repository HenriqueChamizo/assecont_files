using System;
using System.ComponentModel;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Assecontweb.Classes.Views
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:ServerGps runat=server></{0}:ServerGps>")]

    public class ServerGps : WebControl
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        #region Getters & Setters
        private int _Gps;
        public int Gps
        {
            get { return _Gps; }
            set { _Gps = value; }
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

        //public ServerGps(int Gps, int Cliente, int Recalculo)
        //{
        //    this.Gps = Gps;
        //    this.Cliente = Cliente;
        //    this.Recalculo = Recalculo;
        //}

        protected override void RenderContents(HtmlTextWriter output)
        {
            StringBuilder html = new StringBuilder();

            html.Append(gerarGpsHtml());

            output.WriteLine(html);
        }

        public string gerarGpsHtml()
        {
            string html = string.Empty;

            html += style();

            BDAppLocal bd = new BDAppLocal();

            string execute = "EXEC rs_darf  @P_DARF = {0}, @P_CLIENTE = {1}, @P_RECALCULO = {2},  @P_DATA_PAGAMENTO = '{3}'";

            if (dataPagamento == (new DateTime()))
                execute = "EXEC rs_darf  @P_DARF = {0}, @P_CLIENTE = {1}, @P_RECALCULO = {2}";


            DataTable tbDados = bd.getDataTable(string.Format(execute, Gps, Cliente, Recalculo ? 1 : 0, dataPagamento));

            int i = 0;

            for (; i < tbDados.Rows.Count; i++)
            {
                html += gps(tbDados.Rows[i]);
                html += primeiraVia();
                html += gps(tbDados.Rows[i]);
            }

            return html;
        }

        #region Recibo gps
        private string gps(DataRow reader)
        {
            string html = string.Empty;

            html += "<table class='tableRendimento' style='border: 1px solid Black; border-collapse: collapse; margin-left: 20px;' cellspacing='0' cellpadding='0'> " +
            "<tr><td valign='top' class='td_equerdo'> " +
                "<table class='tableRendimento' border='0' cellspacing='0' cellpadding='0' style='width: 100%;'> " +
            "<tr><td style='height: 101px; padding: 2px 0px 2px 2px;'> " +
            "<img id='logoReceita' alt='' src='" + Global.getImagem(Properties.Resources.marcaPrevidenciaSocial_GPS).ImageUrl + "' Width='60'> </img></td> " +
                 "<td style='padding: 2px 2px 2px 0px; text-align: center; font-size: 8pt' valign='top'> " +
                        "<b>MINISTÉRIO DA PREVIDÊNCIA SOCIAL - MPS<br /><br />INSTITUTO NACIONAL DO SEGURO SOCIAL - INSSL<br /><br />GUIA DA PREVIDÊNCIA SOCIAL - GPS</b> </td></tr> ";

            html += "<tr><td style='height: 58px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-top: 1px solid Black;' valign='top' colspan='2'>01.NOME OU RAZÃO SOCIAL/ FONE/ ENDEREÇO <br />";

            if(!(reader["PRESTADOR"] is DBNull)) 
                 html += reader["PRESTADOR"].ToString() + " <br /> ";

            if (!(reader["CLI_RAZAOSOCIAL"] is DBNull))
                html += reader["CLI_RAZAOSOCIAL"].ToString() + " <br /> ";

            if (!(reader["CLI_TELEFONE"] is DBNull))
                html += reader["CLI_TELEFONE"].ToString() + " <br /> ";

            if (!(reader["CLI_ENDERECO"] is DBNull))
                html += reader["CLI_ENDERECO"].ToString() + " <br /> ";

            if (!(reader["CLI_ENDERECO2"] is DBNull))
                html += reader["CLI_ENDERECO2"].ToString() + " <br /> ";

            if (!(reader["NOTA"] is DBNull))
                html += reader["NOTA"].ToString();

            if (!Convert.ToBoolean(reader["SELICNAODISPONIVEL"] is DBNull) && Recalculo)
                html += "<p><b>válido para pagamento até " + String.Format("{0: dd/MM/yyyy}", reader["DATAPAGAMENTO"]) + "</b></p>";


            html += "</td></tr> ";

            html += "<tr><td valign='top' style='height: 32px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black;' colspan='2'>02.VENCIMENTO " +
                                   "<div style='text-align: right'>" + String.Format("{0: dd/MM/yyyy}", reader["DARF_VENCIMENTO"]) + "</div></td></tr>";

            html += "<tr><td style='height: 98px; padding: 5px 5px 5px 5px; font-size: 10px;' colspan='2'><b>ATENÇÃO:</b>&nbsp; " +
                                   "É vedada a utilização de GPS para recolhimento de receita de valor inferior ao estipulado em Resolução " +
                                   "publicada pelo INSS. A receita que resultar valor inferior deverá ser adicionada à contribuição ou importância correspondente " +
                                   "nos meses subsequentes, até que o total seja igual ou superior ao valor mínimo fixado. </td></tr></table></td>";

            html += "<td valign='top' class='td_direito'><table class='tableRendimento' border='0' cellspacing='0' cellpadding='0' style='width: 100%;'> ";

            html += "<tr><td style='height: 32px; width: 160px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>03.CÓDIGO DE PAGAMENTO</td> " +
                              "<td style='text-align: right; border-bottom: 1px solid Black; border-left: 1px solid Black; width: 160px;'> " +
                              reader["DARF_CODIGORECEITA"].ToString() + "</td></tr>";

            html += "<tr><td style='height: 32px; width: 160px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>04.COMPETÊNCIA</td> " +
                               "<td style='text-align: right; border-bottom: 1px solid Black; border-left: 1px solid Black; width: 160px;'> " +
                               (Convert.ToBoolean(reader["DECIMOTERCEIRO"]) ? String.Format("{0:13/yyyy}", reader["DARF_PERIODOAPURACAO"]) : String.Format("{0:MM/yyyy}", reader["DARF_PERIODOAPURACAO"])) + "</td></tr>";

            html += "<tr><td style='height: 32px; width: 160px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>05.IDENTIFICADOR</td> " +
                               "<td style='text-align: right; border-bottom: 1px solid Black; border-left: 1px solid Black;'> " +
                               (String.IsNullOrEmpty(reader["DARF_GPS_PIS"].ToString()) ? reader["CNPJCPF"].ToString() : String.Format(@"{0:00\.00000\.00\-0}", Convert.ToDouble(reader["DARF_GPS_PIS"]))) + "</td></tr>";

            html += "<tr><td style='height: 32px; width: 160px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>06.VALOR DO INSS</td> " +
                              "<td style='text-align: right; border-bottom: 1px solid Black; border-left: 1px solid Black; width: 160px;'> " +
                             String.Format("{0:n2}", reader["DARF_GPS_INSS"]) + "</td></tr>";

            html += "<tr><td style='height: 32px; width: 160px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>07.</td> " +
                             "<td style='text-align: right; border-bottom: 1px solid Black; border-left: 1px solid Black;'> </td></tr>";

            html += "<tr><td style='height: 32px; width: 160px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>08.</td> " +
                              "<td style='text-align: right; border-bottom: 1px solid Black; border-left: 1px solid Black;'> </td></tr>";

            html += "<tr><td style='height: 32px; width: 160px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>09.VALOR DE OUTRAS ENTIDADES</td> " +
                               "<td style='text-align: right; border-bottom: 1px solid Black; border-left: 1px solid Black; '> " +
                              String.Format("{0:n2}", reader["DARF_GPS_ENTIDADES"]) + "</td></tr>";

            html += "<tr><td style='height: 32px; width: 160px; padding: 2px 2px 2px 2px; border-bottom: 1px solid Black; border-left: 1px solid Black;' valign='top'>10.ATM, MULTA E JUROS</td> " +
                "<td style='text-align: right; border-bottom: 1px solid Black; border-left: 1px solid Black;'> " + String.Format("{0:n2}", Convert.ToDecimal(reader["MULTAVALOR"]) + Convert.ToDecimal(reader["JUROSVALOR"])) + " </td></tr>";

            html += "<tr><td style='height: 32px; width: 160px; padding: 2px 2px 2px 2px; border-left: 1px solid Black;' valign='top'>11.TOTAL</td> " +
              "<td style='text-align: right; border-left: 1px solid Black;'>" +
             String.Format("{0:n2}", reader["VALORTOTAL"]) + "</td></tr></table></td></tr>";

            html += "<tr><td style='height: 32px; padding: 2px 2px 2px 2px; border-top: 1px solid Black; font-size: 9px; font-family: Arial;' valign='top' colspan='2'> " +
                         "<div style='text-align: right;'>12. AUTENTICAÇÃO BANCÁRIA</div></td></tr></table>";

            return html;
        }
        #endregion

        private string primeiraVia()
        {
            return "<div class='tabela' style='margin-left: 20px; margin-top: 10px; margin-bottom: 10px; font-size: 9pt;'> " +
                        "<span>1º Via ---------------------------------------------------------------------------------------------------------</span> " +
                    "</div> ";
        }

        private string style()
        {
            return "<style> " +
                        ".imageajust1 {position: relative; top: -1px; } " +
                        ".tabela{font-size: 11pt; font-family: 'Segoe UI' } " +
                        ".titulo{font-size: 22pt; font-family: 'Segoe UI' } " +
                        ".infodestaque{ font-size: 13pt; 'Segoe UI' } " +
                        ".tableRendimento {font-size: 9pt; font-family: Arial; border-collapse: collapse;} " +
                        ".td_direito{padding: 3px; width: 360px;} " +
                        ".td_equerdo{padding: 3px; width: 400px;} " +
                        ".borda{border: 1px solid Black;} " +
                        "</style> ";
        }

    }
}
