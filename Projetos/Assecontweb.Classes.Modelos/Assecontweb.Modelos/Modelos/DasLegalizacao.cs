using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using Wr.Classes;

namespace Assecontweb.Modelos
{
    public class DasLegalizacao
    {
        BD bd;
        private bool Publish;

        #region struct Cliente
        struct Cliente
        {
            public DateTime competencia;
            public string empresa;
            public string numeroDocumento;
            public DateTime dataVencimento;
            public Single valorPrincipal;
            public Single jurosEncargos;
            public Single multa;
            public Single valorTotal;
            public string obs;
            public string codigoBarras1;
            public string codigoBarras2;
            public string codigoBarras3;
            public string codigoBarras4;
        }
        #endregion

        #region struct Campo
        struct Campo
        {
            public int Inicio;
            public int Tamanho;
        }
        #endregion

        public DasLegalizacao(BD bd, string fileName, int ObrigacaoClientePeriodo, /* bool ValorAtualizavel, */ bool Publish, out int DarfInd)
        {
            this.bd = bd;
            this.Publish = Publish;

            if (Path.GetExtension(fileName).ToLower() == ".txt")
                DarfInd = LerArquivotxt(fileName, ObrigacaoClientePeriodo /*, ValorAtualizavel */);
            else
                throw new Exception("O arquivo deve estar em formato .txt");
        }

        #region Leitura do Arquivo TXT
        private int LerArquivotxt(string fileName, int ObrigacaoClientePeriodo /*, bool ValorAtualizavel */)
        {
            int Result = 0;

            #region Campos
            /*Cliente*/
            const int competencia = 0;
            const int empresa = 1;
            const int numeroDocumento = 2;
            const int dataVencimento = 3;
            const int valorPrincipal = 4;
            const int jurosEncargos = 5;
            const int multa = 6;
            const int obs = 7;
            const int valorTotal = 8;
            const int codigoBarras1 = 9;
            const int codigoBarras2 = 10;
            const int codigoBarras3 = 11;
            const int codigoBarras4 = 12;

            List<Campo> Campos = new List<Campo>()
            {
                new Campo() {Inicio = 0, Tamanho = 8}, // competencia
                new Campo() {Inicio = 0, Tamanho = 18}, // cpfCnpj
                new Campo() {Inicio = 0, Tamanho = 22}, // numeroDocumento
                new Campo() {Inicio = 0, Tamanho = 10}, // dataVencimento
                new Campo() {Inicio = 0, Tamanho = 10}, // valorPrincipal
                new Campo() {Inicio = 0, Tamanho = 10}, // jurosEncargos
                new Campo() {Inicio = 0, Tamanho = 10}, // multa
                new Campo() {Inicio = 0, Tamanho = 19}, // obs
                new Campo() {Inicio = 0, Tamanho = 10}, // valorTotal
                new Campo() {Inicio = 0, Tamanho = 14}, // codigoBarras1
                new Campo() {Inicio = 14, Tamanho = 14}, // codigoBarras2
                new Campo() {Inicio = 28, Tamanho = 14}, // codigoBarras3
                new Campo() {Inicio = 42, Tamanho = 14}, // codigoBarras4

            };
            #endregion

            List<string> Arquivo = new List<string>();
            Cliente cliente = new Cliente();

            int contadorLinha = 0;
            Files.ReadFile(fileName, Arquivo);

            foreach (string linha in Arquivo)
            {
                contadorLinha++;
                if (contadorLinha == 1)
                {
                    if (linha != "1a. via ")
                    {
                        throw new Exception("Formato do arquivo incorreto");
                        return Result;
                    }
                }
                if (contadorLinha == 22)
                {
                    cliente.dataVencimento = Convert.ToDateTime(linha.Substring(Campos[dataVencimento].Inicio, Campos[dataVencimento].Tamanho).Trim());
                }
                if (contadorLinha == 23)
                {
                    cliente.valorPrincipal = Convert.ToSingle(linha.Substring(Campos[valorPrincipal].Inicio, linha.Length).Trim());
                }
                if (contadorLinha == 24)
                {
                    cliente.multa = Convert.ToSingle(linha.Substring(Campos[multa].Inicio, linha.Length).Trim());
                }
                if (contadorLinha == 25)
                {
                    cliente.jurosEncargos = Convert.ToSingle(linha.Substring(Campos[jurosEncargos].Inicio, linha.Length).Trim());
                }
                if (contadorLinha == 26)
                {
                    cliente.valorTotal = Convert.ToSingle(linha.Substring(Campos[valorTotal].Inicio, linha.Length).Trim());
                }
                if (contadorLinha == 29)
                {
                    cliente.numeroDocumento = linha.Substring(Campos[numeroDocumento].Inicio, Campos[numeroDocumento].Tamanho).Trim();
                }
                if (contadorLinha == 30)
                {
                    cliente.codigoBarras1 = linha.Substring(Campos[codigoBarras1].Inicio, Campos[codigoBarras1].Tamanho).Trim();
                    cliente.codigoBarras2 = linha.Substring(Campos[codigoBarras2].Inicio, Campos[codigoBarras2].Tamanho).Trim();
                    cliente.codigoBarras3 = linha.Substring(Campos[codigoBarras3].Inicio, Campos[codigoBarras3].Tamanho).Trim();
                    cliente.codigoBarras4 = linha.Substring(Campos[codigoBarras4].Inicio, Campos[codigoBarras4].Tamanho).Trim();
                }
                if (contadorLinha == 31)
                {
                    cliente.empresa = linha.Substring(Campos[empresa].Inicio, Campos[empresa].Tamanho).Trim();
                }
                if (contadorLinha == 32)
                {
                    cliente.competencia = Convert.ToDateTime(linha.Substring(Campos[competencia].Inicio, Campos[competencia].Tamanho).Trim());
                }
                if (contadorLinha == 40)
                {
                    if (linha.Length > 2)
                        cliente.obs = linha.Substring(Campos[obs].Inicio, linha.Length - 1).Trim();
                    else
                        cliente.obs = string.Empty;

                    Result = SalvarBanco(cliente, ObrigacaoClientePeriodo);
                    return Result;
                }

            }

            return Result;
        }
        #endregion

        #region Validação
        private void VerificarDas(Cliente cliente, int ObrigacaoClientePeriodo)
        {
            string Mensagem = string.Empty;
            int cnpj = bd.getFieldValueInteger(string.Format("SELECT OBR_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                "WHERE (SUBSTRING(dbo.fn_trim_cnpj(CLI_CNPJ), 0 , 9) = SUBSTRING(dbo.fn_trim_cnpj('{0}'), 0 , 9) OR " +
                                                "dbo.fn_trim_cnpj(CLI_CPF) = dbo.fn_trim_cnpj('{0}')) AND " +
                                                "OBRCLIPER_IND = {1}",
                                                cliente.empresa, ObrigacaoClientePeriodo));


            int dataVencimento = bd.getFieldValueInteger(string.Format("SELECT OBR_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                "WHERE OBRCLIPER_PRAZO_OU_VENCIMENTO = '{0}' AND " +
                                                "OBRCLIPER_IND = {1}",
                                                cliente.dataVencimento, ObrigacaoClientePeriodo));

            int Competencia = bd.getFieldValueInteger(string.Format("SELECT OBR_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                "WHERE OBRCLIPER_ANO = {0} AND OBRCLIPER_MES_FINAL = {1} AND " +
                                                "OBRCLIPER_IND = {2} ",
                                                cliente.competencia.Year, cliente.competencia.Month, ObrigacaoClientePeriodo));

            if (cnpj <= 0)
                Mensagem += "CNPJ ou CPF na Das não corresponde com o código de empresa<br/> ";
            if (dataVencimento <= 0)
                Mensagem += "o vencimento na Das não corresponde com o vencimento da obrigação<br/> ";
            if (Competencia <= 0)
                Mensagem += "a competência na Das não corresponde com a competência da obrigação<br/>";

            if (Mensagem != "")
            {
                string MensagemFinal = "Erro de Validação:<br/> " + Mensagem;
                throw new Exception(MensagemFinal);
            }

        }
        #endregion

        private int SalvarBanco(Cliente cliente, int ObrigacaoClientePeriodo)
        {
            int Das = 0;

            if (!Publish)
            {
                VerificarDas(cliente, ObrigacaoClientePeriodo);
            }
            else
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("das_importacao", bd.Conn);

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@P_OBRIGACAOCLIENTEPERIODO", ObrigacaoClientePeriodo);
                    cmd.Parameters.AddWithValue("@P_COMPETENCIA", cliente.competencia);
                    cmd.Parameters.AddWithValue("@P_VENCIMENTO", cliente.dataVencimento);
                    cmd.Parameters.AddWithValue("@P_VALOR_TOTAL", cliente.valorTotal.ToString().Replace(',', '.'));
                    cmd.Parameters.AddWithValue("@P_VALOR_PRINCIPAL", cliente.valorPrincipal.ToString().Replace(',', '.'));
                    cmd.Parameters.AddWithValue("@P_VALOR_JUROS_ENCARGOS", cliente.jurosEncargos.ToString().Replace(',', '.'));
                    cmd.Parameters.AddWithValue("@P_VALOR_MULTA", cliente.multa.ToString().Replace(',', '.'));
                    cmd.Parameters.AddWithValue("@P_NUMERODOCUMENTO", cliente.numeroDocumento);
                    cmd.Parameters.AddWithValue("@P_OBS", cliente.obs);
                    cmd.Parameters.AddWithValue("@P_CODIGO_BARRAS1", cliente.codigoBarras1);
                    cmd.Parameters.AddWithValue("@P_CODIGO_BARRAS2", cliente.codigoBarras2);
                    cmd.Parameters.AddWithValue("@P_CODIGO_BARRAS3", cliente.codigoBarras3);
                    cmd.Parameters.AddWithValue("@P_CODIGO_BARRAS4", cliente.codigoBarras4);

                    SqlParameter parameter_result = cmd.Parameters.Add("@RESULT", SqlDbType.Int);
                    parameter_result.Direction = ParameterDirection.ReturnValue;

                    cmd.ExecuteNonQuery();

                    if (parameter_result.Value != null)
                    {
                        Das = Convert.ToInt32(parameter_result.Value);
                    }
                }
                catch (Exception ex)
                {
                    throw new System.ArgumentException("Erro Banco", ex.Message);
                }
            }

            return Das;
        }
    }
}
