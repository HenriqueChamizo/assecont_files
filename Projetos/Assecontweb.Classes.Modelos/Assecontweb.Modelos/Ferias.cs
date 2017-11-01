using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using Wr.Classes;

namespace Assecontweb
{
    namespace Modelos
    {
        public class Ferias
        {
            BD bd;
            private bool Publish;
            private int ArquivoIndice;
            private int ObrigacaoClientePeriodo;
            private bool ProcessarArquivo;
            private byte[] byteArquivo;
            private string fileName;

            #region struct's
            struct Funcionario
            {
                public string registro;
                public DateTime dtAdmissao;
                public Single saldoDias;
                public int totalFaltas;
                public int posicao;
                public DateTime per;
                public int vencidas;
                public string proporc;
                public DateTime periodoAquisicao1;
                public DateTime periodoAquisicao2;
                public DateTime periodoGozo1;
                public DateTime periodoGozo2;
                public DateTime limitePagto;
            }

            struct Cliente
            {
                public DateTime competencia;
                public string empresa;
                public List<Funcionario> listFuncionarios;
            }

            struct Campo
            {
                public int Inicio;
                public int Tamanho;
            }
            #endregion

            //Assinatura para reeler o arquivo.
            public Ferias(BD bd, byte[] byteArquivo, int ObrigacaoClientePeriodo, int ArquivoIndice, bool ProcessarArquivo)
            {
                this.bd = bd;
                this.Publish = true;
                this.ArquivoIndice = ArquivoIndice;
                this.ObrigacaoClientePeriodo = ObrigacaoClientePeriodo;
                this.ProcessarArquivo = ProcessarArquivo;
                this.byteArquivo = byteArquivo;

                try
                {
                    Global.Cultura();

                    LerArquivotxt();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }

            public Ferias(BD bd, string fileName, int ObrigacaoClientePeriodo, /* bool ValorAtualizavel, */ bool Publish, out int DarfInd)
            {
                this.bd = bd;
                this.Publish = Publish;
                this.ObrigacaoClientePeriodo = ObrigacaoClientePeriodo;
                this.fileName = fileName;

                //try
                //{
                Global.Cultura();

                if (Path.GetExtension(fileName).ToLower() == ".txt")
                    DarfInd = LerArquivotxt();
                else
                    throw new Exception("O arquivo deve estar em formato .txt");
                //}
                //catch (Exception ex)
                //{
                //    throw new Exception(ex.Message);
                //}
            }

            #region Leitura do Arquivo TXT
            private int LerArquivotxt()
            {
                int Result = 0;

                #region Campos
                /*Cliente*/
                const int competencia = 0;
                const int empresa = 1;
                const int registro = 2;
                const int vencidas = 3;
                const int proporc = 4;
                const int dtAdmissao = 5;
                const int totalFaltas = 6;
                const int periodoAquisicao1 = 7;
                const int periodoAquisicao2 = 8;
                const int saldoDias = 9;
                const int posicao = 10;
                const int per = 11;
                const int periodoGozo1 = 12;
                const int periodoGozo2 = 13;
                const int LimitePagto = 14;

                List<Campo> Campos = new List<Campo>()
            {
                new Campo() {Inicio = 11, Tamanho = 10}, // competencia
                new Campo() {Inicio = 114, Tamanho = 18}, // cpfCnpj
                new Campo() {Inicio = 16, Tamanho = 5}, // registro
                new Campo() {Inicio = 109, Tamanho = 1}, // vencidas
                new Campo() {Inicio = 126, Tamanho = 5}, // proporc
                new Campo() {Inicio = 27, Tamanho = 10}, // dtAdmissao
                new Campo() {Inicio = 67, Tamanho = 3}, // totalFaltas
                new Campo() {Inicio = 109, Tamanho = 10}, // periodoAquisicao1
                new Campo() {Inicio = 122, Tamanho = 10}, // periodoAquisicao2
                new Campo() {Inicio = 24, Tamanho = 6}, // saldoDias
                new Campo() {Inicio = 59, Tamanho = 1}, // posicao
                new Campo() {Inicio = 66, Tamanho = 8}, // per
                new Campo() {Inicio = 109, Tamanho = 10}, // periodoGozo1
                new Campo() {Inicio = 122, Tamanho = 10}, // periodoGozo2
                new Campo() {Inicio = 66, Tamanho = 10}, // LimitePagto                
            };
                #endregion

                List<string> Arquivo = new List<string>();

                Cliente cliente = new Cliente();
                cliente.listFuncionarios = new List<Funcionario>();
                Funcionario Func = new Funcionario();

                //int contadorLinha = 0;
                int contadorFunc = 0;

                if (!ProcessarArquivo)
                    Files.ReadFile(fileName, Arquivo);
                else
                {
                    Arquivo = Global.ByteToListString_Txt(byteArquivo);
                }

                try
                {
                    if (Arquivo[0].Substring(35, 18) != "CONTROLE DE FERIAS")
                    {
                        throw new Exception("Formato do arquivo incorreto");
                        return Result;
                    }

                    for (int contadorLinha = 0; contadorLinha < Arquivo.Count - 1; contadorLinha++)
                    //string linha in Arquivo)
                    {

                        string linha = Arquivo[contadorLinha];

                        //contadorLinha++;               

                        if (contadorLinha == 1)
                        {
                            cliente.competencia = Convert.ToDateTime(linha.Substring(Campos[competencia].Inicio, Campos[competencia].Tamanho).Trim());
                        }

                        if (contadorLinha == 3)
                        {
                            cliente.empresa = linha.Substring(Campos[empresa].Inicio, (linha.Length - 114)).Trim();
                        }

                        if (linha.Substring(9, 6) == "Func.:")
                        {
                            Func.registro = linha.Substring(Campos[registro].Inicio, Campos[registro].Tamanho).Trim();
                            Func.vencidas = Convert.ToInt32(linha.Substring(Campos[vencidas].Inicio, Campos[vencidas].Tamanho).Trim());
                            Func.proporc = linha.Length > 126 ? linha.Substring(Campos[proporc].Inicio, linha.Length - 126).Trim() : "";
                        }

                        if (linha.Substring(9, 17) == "Data da Admissao:")
                        {
                            Func.dtAdmissao = Convert.ToDateTime(linha.Substring(Campos[dtAdmissao].Inicio, Campos[dtAdmissao].Tamanho).Trim());
                            Func.totalFaltas = Convert.ToInt32(linha.Substring(Campos[totalFaltas].Inicio, Campos[totalFaltas].Tamanho).Trim());
                            if (linha.Length > ((Campos[periodoAquisicao1].Inicio + 1)))
                                Func.periodoAquisicao1 = Convert.ToDateTime(linha.Substring(Campos[periodoAquisicao1].Inicio, Campos[periodoAquisicao1].Tamanho).Trim());
                            if (linha.Length > ((Campos[periodoAquisicao2].Inicio + 1)))
                                Func.periodoAquisicao2 = Convert.ToDateTime(linha.Substring(Campos[periodoAquisicao2].Inicio, Campos[periodoAquisicao2].Tamanho).Trim());
                        }

                        if (linha.Substring(9, 14) == "Saldo de Dias:")
                        {
                            Func.saldoDias = Convert.ToSingle(linha.Substring(Campos[saldoDias].Inicio, Campos[saldoDias].Tamanho).Trim());

                            //try
                            //{
                            //    if (linha.Substring(Campos[LimitePagto].Inicio, Campos[LimitePagto].Tamanho).Trim().Length > 0)
                            //        Func.limitePagto = Convert.ToDateTime(linha.Substring(Campos[LimitePagto].Inicio, Campos[LimitePagto].Tamanho).Trim());
                            //}
                            //catch (Exception ex)
                            //{
                            //    throw new Exception("Campo do Limite de Pagamento em branco.");
                            //}

                            if (linha.Substring(Campos[posicao].Inicio, Campos[posicao].Tamanho).Trim().Length > 0)
                                Func.posicao = Convert.ToInt32(linha.Substring(Campos[posicao].Inicio, Campos[posicao].Tamanho).Trim());

                            if (!linha.Contains("Periodo(s)") && linha.Substring(Campos[per].Inicio, Campos[per].Tamanho).Trim().Length > 0)
                                Func.per = Convert.ToDateTime(linha.Substring(Campos[per].Inicio, Campos[per].Tamanho).Trim());

                            if (linha.Length > ((Campos[periodoGozo1].Inicio + 1)))
                                Func.periodoGozo1 = Convert.ToDateTime(linha.Substring(Campos[periodoGozo1].Inicio, Campos[periodoGozo1].Tamanho).Trim());

                            if (linha.Length > ((Campos[periodoGozo2].Inicio + 1)))
                                Func.periodoGozo2 = Convert.ToDateTime(linha.Substring(Campos[periodoGozo2].Inicio, Campos[periodoGozo2].Tamanho).Trim());

                            cliente.listFuncionarios.Add(Func);
                            Func = new Funcionario();
                            contadorFunc++;
                            contadorLinha++;
                        }

                        if (contadorFunc == 14)
                        {
                            contadorLinha += 5;
                            contadorFunc = 0;
                        }
                    }

                    if (cliente.listFuncionarios.Count > 0)
                    {
                        Result = SalvarBanco(cliente, ObrigacaoClientePeriodo);
                        return Result;
                    }

                }
                catch (ArgumentOutOfRangeException ex)
                {
                    throw new Exception("Arquivo em branco");
                }
                catch (Exception ex)
                {
                    throw new System.ArgumentException(ex.Message);
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

                int Competencia = bd.getFieldValueInteger(string.Format("SELECT OBR_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                    "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                    "WHERE OBRCLIPER_ANO = {0} AND OBRCLIPER_MES_FINAL = {1} AND " +
                                                    "OBRCLIPER_IND = {2} ",
                                                    cliente.competencia.AddMonths(-1).Year, cliente.competencia.AddMonths(-1).Month, ObrigacaoClientePeriodo));

                if (cnpj <= 0)
                    Mensagem += "CNPJ ou CPF no arquivo de Férias não corresponde com o código de empresa<br/> ";

                if (Competencia <= 0)
                    Mensagem += "a competência no arquivo de Férias não corresponde com a competência da obrigação<br/>";

                if (Mensagem != "")
                {
                    string MensagemFinal = "Erro de Validação:<br/> " + Mensagem;
                    throw new Exception(MensagemFinal);
                }

            }
            #endregion

            private int SalvarBanco(Cliente cliente, int ObrigacaoClientePeriodo)
            {
                if (!Publish)
                {
                    VerificarDas(cliente, ObrigacaoClientePeriodo);
                }
                else
                {
                    try
                    {
                        foreach (Funcionario Func in cliente.listFuncionarios)
                        {
                            SqlCommand cmd = new SqlCommand("ferias_importacao", bd.Conn);

                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("@P_OBRIGACAOCLIENTEPERIODO", ObrigacaoClientePeriodo);
                            cmd.Parameters.AddWithValue("@P_REG_FUNC", Func.registro);
                            cmd.Parameters.AddWithValue("@P_VENCIDAS", Func.vencidas);
                            cmd.Parameters.AddWithValue("@P_DATA_ADMISSAO", Func.dtAdmissao);
                            cmd.Parameters.AddWithValue("@P_SALDO_DIAS", Func.saldoDias);
                            cmd.Parameters.AddWithValue("@P_TOTAL_FALTAS", Func.totalFaltas);
                            // if (checarDateTimeNull(Func.limitePagto)) cmd.Parameters.AddWithValue("@P_LIMITE_PAGAMENTO", Func.limitePagto);
                            cmd.Parameters.AddWithValue("@P_POSICAO", Func.posicao);
                            if (checarDateTimeNull(Func.per)) cmd.Parameters.AddWithValue("@P_PERIODO", Func.per);
                            cmd.Parameters.AddWithValue("@P_PROPORC", Func.proporc);
                            if (checarDateTimeNull(Func.periodoAquisicao1)) cmd.Parameters.AddWithValue("@P_PERIODO_AQUISICAO1", Func.periodoAquisicao1);
                            if (checarDateTimeNull(Func.periodoAquisicao2)) cmd.Parameters.AddWithValue("@P_PERIODO_AQUISICAO2", Func.periodoAquisicao2);
                            if (checarDateTimeNull(Func.periodoGozo1)) cmd.Parameters.AddWithValue("@P_PERIODO_GOZO1", Func.periodoGozo1);
                            if (checarDateTimeNull(Func.periodoGozo2)) cmd.Parameters.AddWithValue("@P_PERIODO_GOZO2", Func.periodoGozo2);

                            //SqlParameter parameter_result = cmd.Parameters.Add("@RESULT", SqlDbType.Int);
                            //parameter_result.Direction = ParameterDirection.ReturnValue;

                            cmd.ExecuteNonQuery();
                        }
                    }
                    catch (Exception ex)
                    {
                        throw new System.ArgumentException("Erro Banco", ex.Message);
                    }
                }

                return 1;
            }

            public Boolean checarDateTimeNull(DateTime dateTime)
            {
                return dateTime != new DateTime();
            }
        }
    }
}