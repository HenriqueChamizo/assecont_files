using System;
using System.Data;
using BoletoNet;

namespace AssecontNovo.Classes
{
    public class GerarBoletoItau
    {
        #region private's
        private int BoId;
        private DateTime Vencimento;
        //private DateTime DataDocumento;
        private DateTime DataProcessamento;
        private Decimal ValorBoleto;
        private string DescricaoBoleto;
        private string NumeroCarteira;
        private string ContaCedente; //Codigo do Banco
        private string Aceita;
        //private Decimal BoletoMulta;

        private DateTime DataPagamento; // joe

        /*CEDENTE*/
        private string NomeCedente;
        private string AgenciaCendente;
        private string digitoCedente;
        private string CodigoCedente;
        private string NossoNumeroBoleto;
        private string NumeroDocumento;

        /*SACADO*/
        private string CnpjCpf;
        private string NomeSacado;
        private string EnderecoSacado;
        private string BairroSacado;
        private string CidadeSacado;
        private string CepSacado;
        private string UfSacado;
        #endregion

        private const string Especie = "99"; //codigo para R$

        private BDAppAssefin bd;
        public GerarBoletoItau(string CnpjCpf, DateTime DataPagamento, int BoId, BDAppAssefin bd)
        {
            this.bd = bd;
            this.DataPagamento = DataPagamento;  // joe
            this.BoId = BoId;
            this.CnpjCpf = CnpjCpf;
            getBol();
        }

        public void getBol()
        {
            string s = "SELECT BOL_EMITIDOEM ,BOL_NOSSO_NUMERO ,BOL_NUMERO_DOCTO ,BOL_VALOR , " +
                    "(CASE WHEN dbo.fn_data_eh_feriado(dbo.fn_dia_util(BOL_VENCIMENTO)) = 1 THEN DATEADD(DAY, 1, dbo.fn_dia_util(BOL_VENCIMENTO)) ELSE dbo.fn_dia_util(BOL_VENCIMENTO) END) AS BOL_VENCIMENTO " +
                    ",CAD_RAZAOSOCIAL, CAD_ESTADO, CAD_CIDADE, CAD_ENDERECO ,CAD_ENDERECO_NUMERO ,CAD_BAIRRO, CAD_CEP ,BCO_NUMERO ,GRU_RAZAOSOCIAL " +
                    ",CTAP_AGENCIA ,CTAP_NUMERO, CTAP_NUMERO_DIGITO " +
                    ",CFGB_BOLETO_CARTEIRA ,CFGB_BOLETO_ACEITE ,CFGB_BOLETO_CODIGO_CLIENTE ,CFGB_BOLETO_LOCAL_PAGAMENTO " +
                    //",dbo.fn_multa_juros(BOL_VALOR, (CASE WHEN BOL_CONTRA_APRESENTACAO = 1 AND BOL_CONTRA_APRESENTACAO_EXIBIR_VENCIMENTO = 0 THEN DATEADD(DAY, 15, GETDATE()) ELSE " +
                    //"(CASE WHEN dbo.fn_data_eh_feriado(dbo.fn_dia_util(BOL_VENCIMENTO)) = 1 THEN DATEADD(DAY, 1, dbo.fn_dia_util(BOL_VENCIMENTO)) ELSE dbo.fn_dia_util(BOL_VENCIMENTO) END) END), '{2}', 2, 0.033) AS MULTA " +
                    ",(CASE WHEN BOL_INSTRUCOES IS NOT NULL THEN BOL_INSTRUCOES ELSE CFGB_BOLETO_INSTRUCOES END) AS INSTRUCOES " +
                    ",(CASE WHEN BOL_RECIBO_CORPO IS NOT NULL THEN BOL_RECIBO_CORPO ELSE CFGB_BOLETO_RECIBO_CORPO END) AS RECIBO " +
                    "FROM Boletos  " +
                    "INNER JOIN Grupos ON BOL_GRUPO = GRU_IND " +
                    "INNER JOIN Cadastros ON BOL_CADASTRO = CAD_IND  " +
                    "INNER JOIN ConfigBoletos ON BOL_CONTAP = CFGB_CONTAP  " +
                    "INNER JOIN ContasParticulares ON BOL_CONTAP = CTAP_IND " +
                    "INNER JOIN Bancos ON BCO_IND = CTAP_BANCO  " +
                    "INNER JOIN ContasRegistros ON BOL_IND = CTAR_BOLETO " +
                    "WHERE BOL_IND = {0} AND dbo.fn_trim_cnpj((CASE WHEN CAD_CNPJ IS NULL THEN CAD_CPF ELSE CAD_CNPJ END)) =  dbo.fn_trim_cnpj('{1}') ";

            DataTable table = bd.getDataTable(string.Format(s, BoId, CnpjCpf, DataPagamento.ToString("dd/MM/yyyy")));

            foreach (DataRow dr in table.Rows)
            {
                //this.BoletoMulta = dr["MULTA"] is DBNull && dr["MULTA"].ToString() == "" ? 0 : Convert.ToDecimal(dr["MULTA"].ToString()) ;
                
                this.Vencimento = this.DataPagamento; // joe
                this.DataProcessamento = Convert.ToDateTime(dr["BOL_EMITIDOEM"].ToString());
                this.ValorBoleto = Convert.ToDecimal(dr["BOL_VALOR"].ToString()); //+ this.BoletoMulta;
                this.NumeroCarteira = dr["CFGB_BOLETO_CARTEIRA"].ToString().Trim();
                this.ContaCedente = dr["BCO_NUMERO"].ToString().Trim();
                this.Aceita = dr["CFGB_BOLETO_ACEITE"].ToString().Trim();

                /*CEDENTE*/
                this.NomeCedente = dr["GRU_RAZAOSOCIAL"].ToString().Trim();
                this.AgenciaCendente = dr["CTAP_AGENCIA"].ToString().Trim();
                //this.CnpjCpf = dr["CNPJ_CPF"].ToString().Trim();
                this.CodigoCedente = dr["CTAP_NUMERO"].ToString().Trim();
                this.digitoCedente = dr["CTAP_NUMERO_DIGITO"].ToString().Trim();
                this.NossoNumeroBoleto = dr["BOL_NOSSO_NUMERO"].ToString().Trim();
                this.NumeroDocumento = dr["BOL_NUMERO_DOCTO"].ToString().Trim() == "" ? dr["BOL_NOSSO_NUMERO"].ToString().Trim() : dr["BOL_NUMERO_DOCTO"].ToString().Trim();
                this.DescricaoBoleto = dr["RECIBO"].ToString().Trim() + "<br /><br />" + dr["CFGB_BOLETO_LOCAL_PAGAMENTO"].ToString().Trim() + "<br /><br />" + dr["INSTRUCOES"].ToString().Trim();

                ///if (this.BoletoMulta > 0)
                    ///this.DescricaoBoleto += "<br /><br />Vecimento Original: " + Convert.ToDateTime(dr["BOL_VENCIMENTO"]).ToString("dd/MM/yyyy") + "<br />Valor Original: " + String.Format("{0:0.00}", Convert.ToDouble(dr["BOL_VALOR"].ToString()));

                /*SACADO*/
                this.NomeSacado = dr["CAD_RAZAOSOCIAL"].ToString().Trim();
                this.EnderecoSacado = dr["CAD_ENDERECO"].ToString().Trim() + "  " + dr["CAD_ENDERECO_NUMERO"].ToString().Trim();
                this.BairroSacado = dr["CAD_BAIRRO"].ToString().Trim();
                this.CidadeSacado = dr["CAD_CIDADE"].ToString().Trim();
                this.UfSacado = dr["CAD_ESTADO"].ToString().Trim();
                this.CepSacado = dr["CAD_CEP"].ToString().Trim();   
            }
        }

        #region BoletoBancario 
        public BoletoBancario BoletoItau()
        {
            CnpjCpf = CnpjCpf.PadLeft(14, '0');

            //'Informa os dados do cedente
            Cedente Cedente = new Cedente(CnpjCpf, NomeCedente, AgenciaCendente.PadLeft(4, '0'), CodigoCedente);
            //'Dependendo da carteira, é necessário informar o código do cedente (o banco que fornece)
            Cedente.Codigo = CodigoCedente + digitoCedente;

            //'Dados para preenchimento do boleto (data de vencimento, valor, carteira e nosso número)
            Boleto Boleto = new Boleto(Vencimento, Convert.ToDecimal(ValorBoleto), NumeroCarteira, NossoNumeroBoleto.PadLeft(8, '0'), Cedente);

            //'Dependendo da carteira, é necessário o número do documento
            Boleto.NumeroDocumento = NumeroDocumento.PadLeft(9, '0');
            //Boleto.Aceite = Aceita;
            Boleto.DataDocumento = Vencimento;
            
            Boleto.ValorBoleto = ValorBoleto;

            //'Informa os dados do sacado
            Boleto.Sacado = new Sacado(CnpjCpf, NomeSacado);
            Boleto.Sacado.Endereco.End = EnderecoSacado;
            Boleto.Sacado.Endereco.Bairro = BairroSacado;
            Boleto.Sacado.Endereco.Cidade = CidadeSacado;
            Boleto.Sacado.Endereco.CEP = CepSacado;
            Boleto.Sacado.Endereco.UF = UfSacado;

            Instrucao_Itau itau = new Instrucao_Itau();
            itau.Descricao = DescricaoBoleto;

            Boleto.Instrucoes.Add(itau);
            Boleto.EspecieDocumento = new EspecieDocumento_Itau(Especie);
            //Boleto.NumeroDocumento = NumeroDocumento;
            //'Espécie do Documento - [R] Recibo;
            

            BoletoBancario BoletoBancario = new BoletoBancario();
            BoletoBancario.CodigoBanco = 341; //'-> Referente ao código do ;
            BoletoBancario.Boleto = Boleto;
            BoletoBancario.MostrarCodigoCarteira = true;
            BoletoBancario.Boleto.Valida();

            //BoletoBancario.OcultarReciboSacado = false;
            //'true -> Mostra o compravante de entrega
            //'false -> Oculta o comprovante de entrega
            BoletoBancario.MostrarComprovanteEntrega = false;
            
            return BoletoBancario;
        }
        #endregion
    }
}