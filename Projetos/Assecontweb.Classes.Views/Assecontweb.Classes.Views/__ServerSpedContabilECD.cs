using System;
using System.ComponentModel;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assecontweb.Classes.Views
{
    [DefaultProperty("aspx")]
    [ToolboxData("<{0}:ServerSpedContabilECD runat=\"server\"></{0}:ServerSpedContabilECD>")]
    public class __ServerSpedContabilECD : WebControl, INamingContainer
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        private int obrigacaoArquivo = 0;
        int _Ano = 0;

        public int ObrigacaoArquivo
        {
            get { return obrigacaoArquivo; }
            set { obrigacaoArquivo = value; }
        }

        public int Ano
        {
            get
            {
                return _Ano;
            }
            set
            {
                _Ano = value;
            }
        }

        private BDAppLocal bd;
        private SpedContabil sped;
        protected override void RenderContents(HtmlTextWriter output)
        {
            bd = new BDAppLocal();
            bd.Conectar("200.170.88.138", "assecont2", "assecont5272", "*h6prMvr");
            sped = new SpedContabil();
            output.WriteLine(getSpedContabil());
        }

        private string getSpedContabil()
        {
            string cliente = string.Empty;
            DataTable dados = bd.getDataTable(String.Format("SELECT CLI_RAZAOSOCIAL, INDI_DATAINICIAL, INDI_DATAFINAL, INDI_ATIVO_CIRCULANTE, INDI_PASSIVO_CIRCULANTE, INDI_ESTOQUES, " +
                  "INDI_DISPONIBILIDADES, INDI_ATIVO_REALIZAVEL_LONGO_PRAZO, INDI_PASSIVO_EXIGIVEL_LONGO_PRAZO, INDI_PATRIMONIO_LIQUIDO, INDI_ATIVO_NAO_CIRCULANTE, " +
                  "INDI_PASSIVO_NAO_CIRCULANTE, INDI_IMOBILIZADOS FROM SpedIndices " +
                  "INNER JOIN ObrigacoesArquivos ON OBRARQ_IND = INDI_OBRIGACAOARQUIVO " +
                  "INNER JOIN ObrigacoesClientesPeriodos ON OBRARQ_OBRIGACAOCLIENTEPERIODO = OBRCLIPER_IND " +
                  "INNER JOIN Clientes ON CLI_IND = INDI_CLIENTE " +
                  "WHERE " + (Ano > 0 ? "YEAR(INDI_DATAINICIAL) = {1}" : "INDI_OBRIGACAOARQUIVO = {0}"), obrigacaoArquivo, Ano));

            foreach (DataRow dr in dados.Rows)
            {
                cliente = dr["CLI_RAZAOSOCIAL"].ToString();

                sped.setDataInicial(Convert.ToDateTime(dr["INDI_DATAINICIAL"]));
                sped.setDataFinal(Convert.ToDateTime(dr["INDI_DATAFINAL"]));

                sped.setAtivoCirculante(Convert.ToDecimal(dr["INDI_ATIVO_CIRCULANTE"]));
                sped.setPassivoCirculante(Convert.ToDecimal(dr["INDI_PASSIVO_CIRCULANTE"]));

                sped.setEstoques(Convert.ToDecimal(dr["INDI_ESTOQUES"]));
                sped.setDisponibilidades(Convert.ToDecimal(dr["INDI_DISPONIBILIDADES"]));

                sped.setAtivoRealizavelLongoPrazo(Convert.ToDecimal(dr["INDI_ATIVO_REALIZAVEL_LONGO_PRAZO"]));
                sped.setPassivoExigivelLongoPrazo(Convert.ToDecimal(dr["INDI_PASSIVO_EXIGIVEL_LONGO_PRAZO"]));

                sped.setAtivoNaoCirculante(Convert.ToDecimal(dr["INDI_ATIVO_NAO_CIRCULANTE"]));
                sped.setPassivoNaoCirculante(Convert.ToDecimal(dr["INDI_PASSIVO_NAO_CIRCULANTE"]));

                sped.setImobilizados(Convert.ToDecimal(dr["INDI_IMOBILIZADOS"]));
                sped.setPatrimonioLiquido(Convert.ToDecimal(dr["INDI_PATRIMONIO_LIQUIDO"]));
            }

            string html = "<table style='font-size: 12pt;'>" +
                "<tr><td colspan='2' style='font-size: 16pt; padding-top: 10px; color: #00A4EC;'> " + cliente + "</td></tr>" +
                "<tr><td colspan='2' style='padding-top: 10px; padding-bottom: 20px; '> Periodo: " + sped.getDataInicial().ToString("dd/MM/yyyy") + " - " + sped.getDataFinal().ToString("dd/MM/yyyy") + "</td></tr>" +
                "<tr><td colspan='2' valign='top' style='border-bottom: 2px solid #E4E6E7; padding-bottom: 20px;'><table> " +
                    "<tr><td style='width: 450px;'><b>  Ativo Circulante                </b></td><td>" + String.Format("{0:N2}", sped.getAtivoCirculante()) + "</td></tr>" +
                    "<tr><td style='width: 450px;'><b>  Passivo Circulante              </b></td><td>" +  String.Format("{0:N2}", sped.getPassivoCirculante()) + "</td></tr>" +
                    "<tr><td style='width: 450px;'><b>  Disponibilidades                </b></td><td>" +  String.Format("{0:N2}", sped.getDisponibilidades()) + "</td></tr>" +
                    "<tr><td style='width: 450px;'><b>  Estoque                         </b></td><td>" +  String.Format("{0:N2}", sped.getEstoques()) + "</td></tr>" +
                    "<tr><td style='width: 450px;'><b>  Patrimonio Liquido              </b></td><td>" +  String.Format("{0:N2}", sped.getPatrimonioLiquido()) + "</td></tr>" +
                    "<tr><td style='width: 450px;'><b>  Imobilizados                    </b></td><td>" +  String.Format("{0:N2}", sped.getImobilizados()) + "</td></tr>" +
                    "<tr><td style='width: 450px;'><b>  Ativo Realizavel Longo Prazo    </b></td><td>" +  String.Format("{0:N2}", sped.getAtivoRealizavelLongoPrazo()) +
                    "<tr><td style='width: 450px;'><b>  Passivo Exigivel Longo Prazo    </b></td><td>" +  String.Format("{0:N2}", sped.getPassivoExigivelLongoPrazo()) + "</td></tr>" +
                    "<tr><td style='width: 450px;'><b>  Ativo não circulante            </b></td><td>" +  String.Format("{0:N2}", sped.getAtivoNaoCirculante()) + "</td></tr>" +
                    "<tr><td style='width: 450px;'><b>  Passivo não circulante          </b></td><td>" +  String.Format("{0:N2}", sped.getPassivoNaoCirculante()) + "</td></tr></table>" +

            "</td></tr><tr><td colspan='2' valign='top'><table style='padding-top: 20px;'>" +
                   "<tr><td style='width: 450px;'><b> Liquidez Corrente                             </b></td><td>" + String.Format("{0:N2}", sped.getLiquidezCorrente()) + "</td></tr>" +
                   "<tr><td style='width: 450px;'><b> Liquidez Seca                                 </b></td><td>" + String.Format("{0:N2}", sped.getLiquidezSeca()) + "</td></tr>" +
                   "<tr><td style='width: 450px;'><b> Liquidez Imediata                             </b></td><td>" + String.Format("{0:N2}", sped.getLiquidezImediata()) + "</td></tr>" +
                   "<tr><td style='width: 450px;'><b> Liquidez Geral                                </b></td><td>" + String.Format("{0:N2}", sped.getLiquidezGeral()) + "</td></tr>" +
                   "<tr><td style='width: 450px;'><b> Capital Giro Proprio                          </b></td><td>" + String.Format("{0:N2}", sped.getCapitalGiroProprio()) + "</td></tr>" +
                   "<tr><td style='width: 450px;'><b> Participacao Terceiros Recursos Totais        </b></td><td>" + String.Format("{0:N2}", sped.getParticipacaoTerceirosRecursosTotais()) + "</td></tr>" +
                   "<tr><td style='width: 450px;'><b> Participacao Terceiros Patrimonio Liquido     </b></td><td>" + String.Format("{0:N2}", sped.getParticipacaoTerceirosPatrimonioLiquido()) + "</td></tr>" +
                   "<tr><td style='width: 450px;'><b> Participacao Curto Prazo Endividamento Total  </b></td><td>" + String.Format("{0:N2}", sped.getParticipacaoCurtoPrazoEndividamentoTotal()) + "</td></tr></table>" +
            "</td></tr></table>";

            return html;
        }
    }
}