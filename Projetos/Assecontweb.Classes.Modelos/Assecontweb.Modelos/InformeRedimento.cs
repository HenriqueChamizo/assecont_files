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
        public class InformeRedimento
        {
            BD bd;
            private bool Publish;
            private int ObrigacaoArquivo;

            #region Struct Funcionario
            struct Funcionario
            {
                public int anoReferente;
                public string Nome;
                public string CPF;
                public string NaturezaRendimento;
                public RendimentosTributaveis Tributaveis;
                public RendimentosIsentos Isentos;
                public RendimentoLiquido Liquido;
                public RendimentosAcumuladamente Acumuladamente;
                public List<string> Complementares;
                public Responsavel Responsavel;
            }

            struct RendimentosTributaveis
            {
                public Single TotalRendimentos;
                public Single ContribuicaoPrevidenciaria;
                public Single ContribuicaoPrevidenciaPrivada;
                public Single PensaoAlimenticia;
                public Single ImpostoRendaRetido;
            }

            struct RendimentosIsentos
            {
                public Single ParcIsenta;
                public Single AjudaDeCusto;
                public Single Pensao;
                public Single Lucro;
                public Single pagosTitular;
                public Single RescisaoContratoTrabalho;
                public Single Outros;
            }

            struct RendimentoLiquido
            {
                public Single Salario13;
                public Single impostoRetidoSalario13;
                public Single Outros;
            }

            struct RendimentosAcumuladamente
            {
                public string NumeroProcesso;
                public int QuantMeses;
                public string AcumulamenteNatureza;
                public Single totalTributaveis;
                public Single ExclusaoDespesasAcaoJudicial;
                public Single DeducaoContribuicaoPrevidenciaria;
                public Single DeducaoPensaoAlimenticia;
                public Single ImpostoRetidoFonte;
                public Single RendIsentosPensao;
            }

            struct Responsavel
            {
                public string ResponsavelNome;
                public DateTime ResponsavelData;
                public string Assinatura;
            }
            #endregion

            #region struct Campo
            struct Campo
            {
                public int Inicio;
                public int Tamanho;
            }
            #endregion

            public InformeRedimento(BD bd, string fileName, int ObrigacaoClientePeriodo, int ObrigacaoArquivo, bool Publish)
            {
                this.bd = bd;
                this.Publish = Publish;
                this.ObrigacaoArquivo = ObrigacaoArquivo;

                //try
                //{
                Global.Cultura();

                if (Path.GetExtension(fileName).ToLower() == ".txt")
                    LerArquivo(fileName, ObrigacaoClientePeriodo);
                else
                    throw new Exception("O arquivo deve estar em formato .txt");
                //}
                //catch (Exception ex)
                //{
                //    throw new Exception(ex.Message());
                //}
            }

            private void LerArquivo(string fileName, int ObrigacaoClientePeriodo)
            {
                #region Const int
                const int empresa = 0;
                const int ano = 1;
                const int Nome = 2;
                const int CPF = 3;
                const int NaturezaRendimento = 4;

                /*RendimentosTributaveis*/
                const int TotalRendimentos = 5;
                const int Previdenciaria = 6;
                const int PrevidenciaPrivada = 7;
                const int PensaoAlimenticia = 8;
                const int ImpostoRendaRetido = 9;

                /*RendimentosIsentos*/
                const int ParcIsenta = 10;
                const int AjudaDeCusto = 11;
                const int Pensao = 12;
                const int Lucro = 13;
                const int pagosTitular = 14;
                const int Trabalho = 15;
                const int IsentoOutros = 16;

                /*RendimentoLiquido*/
                const int Salario13 = 17;
                const int impostoRetidoSalario13 = 18;
                const int LiquidoOutros = 19;

                /*RendimentosAcumuladamente*/
                const int NumeroProcesso = 20;
                const int QuantMeses = 21;
                const int AcumuladamenteNatureza = 22;
                const int totalTributaveis = 23;
                const int ExclusaoAcaoJudicial = 24;
                const int DeducaoPrevidenciaria = 25;
                const int DeducaoAlimenticia = 26;
                const int ImpostoRetidoFonte = 27;
                const int RendIsentosPensao = 28;

                /*Complementares*/
                const int Complementares = 29;

                /*Responsavel*/
                const int ResponsavelNome = 30;
                const int ResponsavelData = 31;
                const int Assinatura = 32;
                #endregion

                #region Campos
                List<Campo> Campos = new List<Campo>()
            {
                new Campo() {Inicio = 15, Tamanho = 18}, // empresa 
                new Campo() {Inicio = 55, Tamanho = 4},  // ano
                new Campo() {Inicio = 20, Tamanho = 32}, // Nome
                new Campo() {Inicio = 56, Tamanho = 14}, // CPF
                new Campo() {Inicio = 29, Tamanho = 46}, // NaturezaRendimento

                ///*RendimentosTributaveis*/
                new Campo() {Inicio = 62, Tamanho = 10}, // TotalRendimentos
                new Campo() {Inicio = 62, Tamanho = 10}, // ContribuicaoPrevidenciaria
                new Campo() {Inicio = 62, Tamanho = 10}, // ContribuicaoPrevidenciaPrivada
                new Campo() {Inicio = 62, Tamanho = 10}, // PensaoAlimenticia
                new Campo() {Inicio = 62, Tamanho = 10}, // ImpostoRendaRetido

                ///*RendimentosIsentos*/
                new Campo() {Inicio = 62, Tamanho = 10}, // ParcIsenta
                new Campo() {Inicio = 62, Tamanho = 10}, // AjudaDeCusto
                new Campo() {Inicio = 62, Tamanho = 10}, // Pensao
                new Campo() {Inicio = 62, Tamanho = 10}, // Lucro
                new Campo() {Inicio = 62, Tamanho = 10}, // pagoTitular
                new Campo() {Inicio = 62, Tamanho = 10}, // Trabalho
                new Campo() {Inicio = 62, Tamanho = 10}, // IsentoOutros

                ///*RendimentoLiquido*/
                new Campo() {Inicio = 62, Tamanho = 10}, // Salario13
                new Campo() {Inicio = 62, Tamanho = 10}, // impostoRetidoSalario13
                new Campo() {Inicio = 62, Tamanho = 10}, // LiquidoOutros

                ///*RendimentosAcumuladamente*/
                new Campo() {Inicio = 28, Tamanho = 10}, // NumeroProcesso
                new Campo() {Inicio = 68, Tamanho = 4},  // QuantMeses
                new Campo() {Inicio = 28, Tamanho = 10}, // AcumuladamenteNatureza
                new Campo() {Inicio = 62, Tamanho = 10}, // totalTributaveis
                new Campo() {Inicio = 62, Tamanho = 10}, // ExclusaoDespesasAcaoJudicial
                new Campo() {Inicio = 62, Tamanho = 10}, // DeducaoContribuicaoPrevidenciaria
                new Campo() {Inicio = 62, Tamanho = 10}, // DeducaoPensaoAlimenticia
                new Campo() {Inicio = 62, Tamanho = 10}, // ImpostoRetidoFonte
                new Campo() {Inicio = 62, Tamanho = 10}, // RendIsentosPensao

                ///Complementares
                new Campo() {Inicio = 5, Tamanho = 71},  // Complementares

                ///*Responsavel*/
                new Campo() {Inicio = 5, Tamanho = 26},  // nome
                new Campo() {Inicio = 32, Tamanho = 10}, // data
                new Campo() {Inicio = 106, Tamanho = 10}, // Assinatura
            };
                #endregion

                List<string> Arquivo = new List<string>();
                Funcionario funcionario = new Funcionario();
                List<Funcionario> listaFucionarios = new List<Funcionario>();

                Files.ReadFile(fileName, Arquivo);

                try
                {
                    #region Leitura do Arquivo
                    for (int i = 0; i < Arquivo.Count; i++)
                    {
                        if ((Publish == false) && !Arquivo[2].Contains("*****"))
                        {
                            throw new Exception("Formato do arquivo incorreto");
                        }

                        if ((Publish == false) && Arquivo[i].Contains("1 - FONTE PAGADORA - PESSOA JURIDICA OU FISICA"))
                        {
                            i += 3;

                            int aux = VerificarEmpresa(Arquivo[i].Substring(Campos[empresa].Inicio, Campos[empresa].Tamanho).Trim(), ObrigacaoClientePeriodo);
                            if (aux <= 0)
                                throw new Exception("Erro de Validação:<br/> CNPJ no Informe de Rendimento não corresponde com o código de empresa");
                            break;
                        }

                        if (Arquivo[i].Contains("Ano Calendario:"))
                        {
                            funcionario = new Funcionario();
                            funcionario.anoReferente = Convert.ToInt32(Arquivo[i].Substring(Campos[ano].Inicio, Campos[ano].Tamanho).Trim());
                        }

                        if (Arquivo[i].Contains("2 - PESSOA FISICA BENEFICIARIA DOS RENDIMENTOS"))
                        {
                            i++;
                            funcionario.Nome = Arquivo[i].Substring(Campos[Nome].Inicio, Campos[Nome].Tamanho).Trim();
                            funcionario.CPF = Arquivo[i].Substring(Campos[CPF].Inicio, Campos[CPF].Tamanho).Trim();

                            i += 2;
                            funcionario.NaturezaRendimento = Arquivo[i].Substring(Campos[NaturezaRendimento].Inicio, Campos[NaturezaRendimento].Tamanho).Trim();
                        }

                        if (Arquivo[i].Contains("3 - RENDIMENTOS TRIBUTAVEIS, DEDUCOES"))
                        {
                            i += 4;

                            funcionario.Tributaveis.TotalRendimentos = Convert.ToSingle(Arquivo[i++].Substring(Campos[TotalRendimentos].Inicio, Campos[TotalRendimentos].Tamanho).Trim());
                            funcionario.Tributaveis.ContribuicaoPrevidenciaria = Convert.ToSingle(Arquivo[i++].Substring(Campos[Previdenciaria].Inicio, Campos[Previdenciaria].Tamanho).Trim());
                            funcionario.Tributaveis.ContribuicaoPrevidenciaPrivada = Convert.ToSingle(Arquivo[i++].Substring(Campos[PrevidenciaPrivada].Inicio, Campos[PrevidenciaPrivada].Tamanho).Trim());
                            funcionario.Tributaveis.PensaoAlimenticia = Convert.ToSingle(Arquivo[i++].Substring(Campos[PensaoAlimenticia].Inicio, Campos[PensaoAlimenticia].Tamanho).Trim());
                            funcionario.Tributaveis.ImpostoRendaRetido = Convert.ToSingle(Arquivo[i].Substring(Campos[ImpostoRendaRetido].Inicio, Campos[ImpostoRendaRetido].Tamanho).Trim());
                        }

                        if (Arquivo[i].Contains("4 - RENDIMENTOS ISENTOS E NAO TRIBUTAVEIS"))
                        {
                            i += 2;

                            funcionario.Isentos.ParcIsenta = Convert.ToSingle(Arquivo[i++].Substring(Campos[ParcIsenta].Inicio, Campos[ParcIsenta].Tamanho).Trim());
                            funcionario.Isentos.AjudaDeCusto = Convert.ToSingle(Arquivo[i++].Substring(Campos[AjudaDeCusto].Inicio, Campos[AjudaDeCusto].Tamanho).Trim());
                            funcionario.Isentos.Pensao = Convert.ToSingle(Arquivo[i++].Substring(Campos[Pensao].Inicio, Campos[Pensao].Tamanho).Trim());
                            funcionario.Isentos.Lucro = Convert.ToSingle(Arquivo[i++].Substring(Campos[Lucro].Inicio, Campos[Lucro].Tamanho).Trim());
                            funcionario.Isentos.pagosTitular = Convert.ToSingle(Arquivo[i++].Substring(Campos[Lucro].Inicio, Campos[Lucro].Tamanho).Trim());
                            i++;
                            funcionario.Isentos.RescisaoContratoTrabalho = Convert.ToSingle(Arquivo[i++].Substring(Campos[Trabalho].Inicio, Campos[Trabalho].Tamanho).Trim());
                            funcionario.Isentos.Outros = Convert.ToSingle(Arquivo[i].Substring(Campos[IsentoOutros].Inicio, Campos[IsentoOutros].Tamanho).Trim());
                        }

                        if (Arquivo[i].Contains("5 - RENDIMENTOS SUJEITOS A TRIBUTACAO EXCLUSIVA (RENDIMENTO LIQUIDO)"))
                        {
                            i += 2;

                            funcionario.Liquido.Salario13 = Convert.ToSingle(Arquivo[i++].Substring(Campos[Salario13].Inicio, Campos[Salario13].Tamanho).Trim());
                            funcionario.Liquido.impostoRetidoSalario13 = Convert.ToSingle(Arquivo[i++].Substring(Campos[impostoRetidoSalario13].Inicio, Campos[impostoRetidoSalario13].Tamanho).Trim());
                            funcionario.Liquido.Outros = Convert.ToSingle(Arquivo[i].Substring(Campos[LiquidoOutros].Inicio, Campos[LiquidoOutros].Tamanho).Trim());
                        }

                        if (Arquivo[i].Contains("6 - RENDIMENTOS RECEBIDOS ACUMULADAMENTE"))
                        {
                            i += 3;

                            funcionario.Acumuladamente.NumeroProcesso = Arquivo[i].Substring(Campos[NumeroProcesso].Inicio, Campos[NumeroProcesso].Tamanho).Trim();
                            funcionario.Acumuladamente.QuantMeses = Convert.ToInt32(Arquivo[i++].Substring(Campos[QuantMeses].Inicio, Campos[QuantMeses].Tamanho).Trim());
                            funcionario.Acumuladamente.AcumulamenteNatureza = Arquivo[i].Substring(Campos[AcumuladamenteNatureza].Inicio, Campos[AcumuladamenteNatureza].Tamanho).Trim();

                            i += 4;

                            funcionario.Acumuladamente.totalTributaveis = Convert.ToSingle(Arquivo[i++].Substring(Campos[totalTributaveis].Inicio, Campos[totalTributaveis].Tamanho).Trim());
                            funcionario.Acumuladamente.ExclusaoDespesasAcaoJudicial = Convert.ToSingle(Arquivo[i++].Substring(Campos[ExclusaoAcaoJudicial].Inicio, Campos[ExclusaoAcaoJudicial].Tamanho).Trim());
                            funcionario.Acumuladamente.DeducaoContribuicaoPrevidenciaria = Convert.ToSingle(Arquivo[i].Substring(Campos[DeducaoPrevidenciaria].Inicio, Campos[DeducaoPrevidenciaria].Tamanho).Trim());

                            i += 4;

                            funcionario.Acumuladamente.DeducaoPensaoAlimenticia = Convert.ToSingle(Arquivo[i++].Substring(Campos[DeducaoAlimenticia].Inicio, Campos[DeducaoAlimenticia].Tamanho).Trim());
                            funcionario.Acumuladamente.ImpostoRetidoFonte = Convert.ToSingle(Arquivo[i++].Substring(Campos[ImpostoRendaRetido].Inicio, Campos[ImpostoRendaRetido].Tamanho).Trim());
                            funcionario.Acumuladamente.RendIsentosPensao = Convert.ToSingle(Arquivo[i].Substring(Campos[RendIsentosPensao].Inicio, Campos[RendIsentosPensao].Tamanho).Trim());
                        }

                        if (Arquivo[i].Contains("7 - INFORMACOES COMPLEMENTARES"))
                        {
                            i += 2;
                            funcionario.Complementares = new List<string>();

                            if (Arquivo[i].Substring(0, 50).Trim() != "*")
                            {
                                do
                                {
                                    string dado = Arquivo[i].Substring(Campos[Complementares].Inicio, Campos[Complementares].Tamanho).Trim();
                                    funcionario.Complementares.Add(dado);
                                    i++;

                                } while (Arquivo[i].Substring(0, 50).Trim() != "*");
                            }
                        }

                        if (Arquivo[i].Contains("8 - RESPONSAVEL PELAS INFORMACOES"))
                        {
                            i += 4;

                            funcionario.Responsavel.ResponsavelNome = Arquivo[i].Substring(Campos[ResponsavelNome].Inicio, Campos[ResponsavelNome].Tamanho).Trim();
                            funcionario.Responsavel.ResponsavelData = Convert.ToDateTime(Arquivo[i].Substring(Campos[ResponsavelData].Inicio, Campos[ResponsavelData].Tamanho).Trim());
                            //funcionario.Responsavel.Assinatura = Arquivo[i].Substring(Campos[Assinatura].Inicio, Campos[Assinatura].Tamanho).Trim();
                        }

                        if (Arquivo[i].Contains("Aprovado pela IN RFB"))
                        {
                            listaFucionarios.Add(funcionario);
                            if (!Publish)
                                break;
                        }
                    }
                    #endregion
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }

                if (Publish)
                    SalvarBanco(listaFucionarios, ObrigacaoClientePeriodo);
            }

            public int VerificarEmpresa(string CnpjCpf, int ObrigacaoClientePeriodo)
            {
                return bd.getFieldValueInteger(string.Format("SELECT OBR_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                  "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                  "WHERE (dbo.fn_trim_cnpj(CLI_CNPJ) = dbo.fn_trim_cnpj('{0}') OR " +
                                                  "dbo.fn_trim_cnpj(CLI_CPF) = dbo.fn_trim_cnpj('{0}')) AND " +
                                                  "OBRCLIPER_IND = {1}",
                                                  CnpjCpf, ObrigacaoClientePeriodo));
            }

            private void SalvarBanco(List<Funcionario> listFuncionarios, int ObrigacaoClientePeriodo)
            {
                try
                {
                    foreach (Funcionario funcionario in listFuncionarios)
                    {
                        #region procedure informeRendimentos_importacao
                        SqlCommand cmd = new SqlCommand("informeRendimentos_importacao", bd.Conn);

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@P_OBRIGACAOARQUIVO", ObrigacaoArquivo);
                        cmd.Parameters.AddWithValue("@P_ANO_REFERENTE", funcionario.anoReferente);
                        cmd.Parameters.AddWithValue("@P_NOME", funcionario.Nome);
                        cmd.Parameters.AddWithValue("@P_CPF", funcionario.CPF);
                        cmd.Parameters.AddWithValue("@P_NATUREZA_RENDIMENTO", funcionario.NaturezaRendimento);

                        ///*RendimentosTributaveis*/
                        cmd.Parameters.AddWithValue("@P_TOTAL_RENDIMENTO", funcionario.Tributaveis.TotalRendimentos.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_CONTRIBUICAO_PREVIDENCIARIA", funcionario.Tributaveis.ContribuicaoPrevidenciaria.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_PREVIDENCIARIA_PRIVADA", funcionario.Tributaveis.ContribuicaoPrevidenciaPrivada.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_PENSAO_ALIMENTICIA", funcionario.Tributaveis.PensaoAlimenticia.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_RENDA_RETIDO", funcionario.Tributaveis.ImpostoRendaRetido.ToString().Replace(',', '.'));

                        ///*RendimentosIsentos*/
                        cmd.Parameters.AddWithValue("@P_PARC_ISENTA", funcionario.Isentos.ParcIsenta.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_AJUDA_CUSTO", funcionario.Isentos.AjudaDeCusto.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_PENSAO", funcionario.Isentos.Pensao.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_LUCRO", funcionario.Isentos.Lucro.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_PAGOS_TITULAR", funcionario.Isentos.pagosTitular.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_CONTRATO_TRABALHO", funcionario.Isentos.RescisaoContratoTrabalho.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_ISENTOS_OUTROS", funcionario.Isentos.Outros.ToString().Replace(',', '.'));

                        ///*RendimentoLiquido*/
                        cmd.Parameters.AddWithValue("@P_SALARIO13", funcionario.Liquido.Salario13.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_RETIDOSALARIO13", funcionario.Liquido.impostoRetidoSalario13.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_LIQUIDO_OUTROS", funcionario.Liquido.Outros.ToString().Replace(',', '.'));

                        ///*RendimentosAcumuladamente*/
                        cmd.Parameters.AddWithValue("@P_NUMERO_PROCESSOS", funcionario.Acumuladamente.NumeroProcesso);
                        cmd.Parameters.AddWithValue("@P_QUANT_MESES", funcionario.Acumuladamente.QuantMeses);
                        cmd.Parameters.AddWithValue("@P_ACUMULADAMENTE_NATUREZA", funcionario.Acumuladamente.AcumulamenteNatureza.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_TOTAL_TRIBUTAVEL", funcionario.Acumuladamente.totalTributaveis.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_EXCLUSAO_ACAO_JUDICIAL", funcionario.Acumuladamente.ExclusaoDespesasAcaoJudicial.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_DEDUCAO_PREVIDENCIARIA", funcionario.Acumuladamente.DeducaoContribuicaoPrevidenciaria.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_DEDUCAO_PENSAO_ALIMENTICIA", funcionario.Acumuladamente.DeducaoPensaoAlimenticia.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_IMPOSTO_RETIDO_FONTE", funcionario.Acumuladamente.ImpostoRetidoFonte.ToString().Replace(',', '.'));
                        cmd.Parameters.AddWithValue("@P_REND_INSENTOS_PENSAO", funcionario.Acumuladamente.RendIsentosPensao.ToString().Replace(',', '.'));

                        ///*Responsavel*/
                        cmd.Parameters.AddWithValue("@P_RESPONSAVEL_NOME", funcionario.Responsavel.ResponsavelNome);
                        cmd.Parameters.AddWithValue("@P_RESPONSAVEL_DATA", funcionario.Responsavel.ResponsavelData.ToString().Replace(',', '.'));
                        //cmd.Parameters.AddWithValue("@P_VALOR", funcionario.Responsavel.Assinatura.ToString().Replace(',', '.'));

                        ///*Complementares*/
                        if (funcionario.Complementares.Count > 0)
                        {
                            for (int i = 0; i < funcionario.Complementares.Count; i++)
                            {
                                cmd.Parameters.AddWithValue("@P_DADOS" + i, funcionario.Complementares[i]);
                            }
                        }
                        cmd.ExecuteNonQuery();

                        #endregion
                    }
                }
                catch (Exception ex)
                {
                    throw new System.ArgumentException(ex.Message);
                }
            }
        }
    }
}