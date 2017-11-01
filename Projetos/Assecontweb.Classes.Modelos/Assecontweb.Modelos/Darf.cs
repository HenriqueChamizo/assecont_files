using System;
using System.Collections.Generic;
using Wr.Classes;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;
using System.IO;

namespace Assecontweb
{
    namespace Modelos
    {
        public class Darf
        {
            BD bd;
            private bool Publish;
            private int ArquivoIndice;
            private int ObrigacaoClientePeriodo;
            private bool ProcessarArquivo;
            private byte[] byteArquivo;
            private string fileName;

            #region struct Cliente
            struct Cliente
            {
                public DateTime competencia;
                public string empresa;
                public int codigoReceita;
                public int numeroReferecia;
                public string dataVencimento;
                public Single valorPrincipal;
                public Single valorMulta;
                public Single valorJurosEncargos;
                public Single valorTotal;
                public string frase;
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

            #region Const
            const string msgFormat = "table[{0}], tr[{1}], td[{2}], a: {3}, b: {4}";

            const string table_pattern = "<table.*?>(.*?)</table>";

            const string tr_pattern = "<tr.*?>(.*?)</tr>";

            const string td_pattern = "<td.*?>(.*?)</td>";

            const string div_pattern = "<div.*?>(.*?)</div>";

            const string span_pattern = "<span.*?>(.*?)</span>";
            #endregion

            //Assinatura para reeler o arquivo.
            public Darf(BD bd, byte[] byteArquivo, Types.Types.ArquivoModelo DarfTipo, int ObrigacaoClientePeriodo, int ArquivoIndice, bool ProcessarArquivo)
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

                    if (DarfTipo == Types.Types.ArquivoModelo.DarfHtml)
                    {
                        fileName = Global.ByteToString_Html(byteArquivo);
                        verificarDarfHtml(fileName, false);
                    }
                    else
                    {
                        LerArquivotxt(false);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }


            public Darf(BD bd, string fileName, Types.Types.ArquivoModelo DarfTipo, int ObrigacaoClientePeriodo, int ArquivoIndice, bool ValorAtualizavel, bool Publish, out int DarfInd)
            {
                this.bd = bd;
                this.Publish = Publish;
                this.ArquivoIndice = ArquivoIndice;
                this.ObrigacaoClientePeriodo = ObrigacaoClientePeriodo;
                this.fileName = fileName;

                try
                {
                    Global.Cultura();

                    if (DarfTipo == Types.Types.ArquivoModelo.DarfHtml)
                    {
                        if (Path.GetExtension(fileName).ToLower() == ".html" || Path.GetExtension(fileName).ToLower() == ".htm")
                            DarfInd = verificarDarfHtml(fileName /*, ObrigacaoClientePeriodo */, ValorAtualizavel);
                        else
                            throw new Exception("O arquivo deve estar em formato .html");
                    }
                    else
                    {
                        if (Path.GetExtension(fileName).ToLower() == ".txt")
                            DarfInd = LerArquivotxt(ValorAtualizavel);
                        else
                            throw new Exception("O arquivo deve estar em formato .txt");
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }

            #region Verificar HTML
            int verificarDarfHtml(string fileName,/* int ObrigacaoClientePeriodo, */ bool ValorAtualizavel)
            {
                int Result = -1;
                try
                {
                    string htmlString = Wr.Classes.Files.ReadFile(fileName);

                    List<string> DivContents = GetContents(htmlString, div_pattern);

                    if (Regex.Replace(DivContents[0], @"<[^>]*>", string.Empty).ToString().Substring(0, 32) == "tributo&nbsp;de&nbsp;mesmo&nbsp;")
                    {
                        Result = LerArquivoHtml(fileName, /* ObrigacaoClientePeriodo, */ ValorAtualizavel);
                        //throw new Exception("Formato do arquivo incorreto");
                        //return Result;
                    }

                    if (Regex.Replace(DivContents[1], @"<[^>]*>", string.Empty).ToString().Trim().Contains("Aprovado pela IN/RFB n&o"))
                    {
                        Result = LerHtmlLegal11941(fileName, /* ObrigacaoClientePeriodo, */ ValorAtualizavel);
                    }

                    if (Regex.Replace(DivContents[17], @"<[^>]*>", string.Empty).ToString().Trim().Contains("PAES-Parcelamento Especial"))
                    {
                        Result = LerHtmlLegalPaes(fileName, /* ObrigacaoClientePeriodo, */ ValorAtualizavel);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }

                if (Result == -1)
                    throw new Exception("Formato do arquivo incorreto");

                return Result;
            }
            #endregion

            #region Leitura do Arquivo HTML - Legalização 11941
            private int LerHtmlLegal11941(string fileName, /* int ObrigacaoClientePeriodo, */ bool ValorAtualizavel)
            {
                int Result = 0;
                Cliente cliente = new Cliente();

                string htmlString = Wr.Classes.Files.ReadFile(fileName);

                List<string> DivContents = GetContents(htmlString, div_pattern);

                cliente.empresa = Regex.Replace(DivContents[39], @"<[^>]*>", string.Empty).Replace("&nbsp;", "  ");
                cliente.competencia = Convert.ToDateTime(Regex.Replace(DivContents[38], @"<[^>]*>", string.Empty).Replace("&nbsp;", "  "));
                cliente.codigoReceita = Convert.ToInt32(Regex.Replace(DivContents[40], @"<[^>]*>", string.Empty).Replace("&nbsp;", "  "));
                cliente.dataVencimento = Regex.Replace(DivContents[42], @"<[^>]*>", string.Empty).Replace("&nbsp;", "  ");
                cliente.valorPrincipal = Global.CultureInfoValue((Regex.Replace(DivContents[46], @"<[^>]*>", string.Empty).Replace("&nbsp;", "  ")));
                cliente.frase = Regex.Replace(DivContents[13], @"<[^>]*>", string.Empty).ToString().Replace("&nbsp;", "  ");
                cliente.frase += "<br /><br />" + Regex.Replace(DivContents[18], @"<[^>]*>", string.Empty).ToString().Replace("&nbsp;", "  ");

                List<string> SpanContents = GetContents(htmlString, span_pattern);

                cliente.codigoBarras1 = Regex.Replace(SpanContents[2], @"<[^>]*>", string.Empty).ToString().Replace("&nbsp;", "").Trim();
                cliente.codigoBarras2 = Regex.Replace(SpanContents[3], @"<[^>]*>", string.Empty).ToString().Replace("&nbsp;", "").Trim();
                cliente.codigoBarras3 = Regex.Replace(SpanContents[4], @"<[^>]*>", string.Empty).ToString().Replace("&nbsp;", "").Trim();
                cliente.codigoBarras4 = Regex.Replace(SpanContents[5], @"<[^>]*>", string.Empty).ToString().Replace("&nbsp;", "").Trim();

                Result = SalvarBanco(cliente);

                return Result;
            }
            #endregion

            #region Leitura do Arquivo HTML - Legalização Paes
            private int LerHtmlLegalPaes(string fileName, /* int ObrigacaoClientePeriodo, */ bool ValorAtualizavel)
            {
                int Result = 0;
                Cliente cliente = new Cliente();

                string htmlString = Wr.Classes.Files.ReadFile(fileName);

                List<string> DivContents = GetContents(htmlString, div_pattern);

                cliente.empresa = Regex.Replace(DivContents[38], @"<[^>]*>", string.Empty).Replace("&nbsp;", "  ");
                cliente.competencia = Convert.ToDateTime(Regex.Replace(DivContents[37], @"<[^>]*>", string.Empty).Replace("&nbsp;", ""));
                cliente.codigoReceita = Convert.ToInt32(Regex.Replace(DivContents[39], @"<[^>]*>", string.Empty).Replace("&nbsp;", ""));
                cliente.dataVencimento = Regex.Replace(DivContents[41], @"<[^>]*>", string.Empty).Replace("&nbsp;", "");
                cliente.valorPrincipal = Global.CultureInfoValue(Regex.Replace(DivContents[45], @"<[^>]*>", string.Empty).Replace("&nbsp;", ""));
                cliente.frase = Regex.Replace(DivContents[17], @"<[^>]*>", string.Empty).ToString().Replace("&nbsp;", "").Replace("\t", "").Trim();

                Result = SalvarBanco(cliente);

                return Result;
            }
            #endregion

            #region Leitura do Arquivo HTML - PIS/CONFINS
            private int LerArquivoHtml(string fileName, /* int ObrigacaoClientePeriodo, */ bool ValorAtualizavel)
            {
                int Result = 0;

                List<string> Arquivo = new List<string>();
                Cliente cliente = new Cliente();

                string htmlString = Wr.Classes.Files.ReadFile(fileName);

                List<string> DivContents = GetContents(htmlString, div_pattern);

                //if (Regex.Replace(DivContents[0], @"<[^>]*>", string.Empty).ToString().Substring(0, 32) != "tributo&nbsp;de&nbsp;mesmo&nbsp;")
                //{
                //    throw new Exception("Formato do arquivo incorreto");
                //    return Result;
                //}
                cliente.empresa = Regex.Replace(DivContents[28], @"<[^>]*>", string.Empty);

                string snumeroReferecia = Regex.Replace(DivContents[39], @"<[^>]*>", string.Empty);
                if (snumeroReferecia != string.Empty) cliente.numeroReferecia = Convert.ToInt32(snumeroReferecia);

                cliente.competencia = Convert.ToDateTime(Regex.Replace(DivContents[29], @"<[^>]*>", string.Empty));
                cliente.codigoReceita = Convert.ToInt32(Regex.Replace(DivContents[27], @"<[^>]*>", string.Empty));
                cliente.dataVencimento = Regex.Replace(DivContents[20], @"<[^>]*>", string.Empty);
                cliente.valorPrincipal = Global.CultureInfoValue(Regex.Replace(DivContents[21], @"<[^>]*>", string.Empty));
                cliente.frase = Regex.Replace(DivContents[37], @"<[^>]*>", string.Empty).ToString().Replace("&nbsp;", "  ");
                cliente.valorJurosEncargos = string.IsNullOrEmpty(Regex.Replace(DivContents[23], @"<[^>]*>", string.Empty)) ? 0 : Global.CultureInfoValue(Regex.Replace(DivContents[23], @"<[^>]*>", string.Empty));
                cliente.valorMulta = string.IsNullOrEmpty(Regex.Replace(DivContents[22], @"<[^>]*>", string.Empty)) ? 0 : Global.CultureInfoValue(Regex.Replace(DivContents[22], @"<[^>]*>", string.Empty));
                cliente.valorTotal = string.IsNullOrEmpty(Regex.Replace(DivContents[15], @"<[^>]*>", string.Empty)) ? 0 : Global.CultureInfoValue(Regex.Replace(DivContents[15], @"<[^>]*>", string.Empty));

                Result = SalvarBanco(cliente);

                return Result;
            }
            #endregion

            #region GetContents
            List<string> GetContents(string input, string pattern)
            {
                MatchCollection matches = Regex.Matches(input, pattern, RegexOptions.Singleline);
                List<string> contents = new List<string>();

                foreach (Match match in matches)
                    contents.Add(match.Value);

                return contents;
            }
            #endregion

            #region Leitura do Arquivo TXT
            private int LerArquivotxt(bool ValorAtualizavel)
            {
                int Result = 0;

                #region Campos
                /*Cliente*/
                const int periodoApuracao = 0;
                const int empresa = 1;
                const int codigoReceita = 2;
                const int numeroReferecia = 3;
                const int dataVencimento = 4;
                const int valorPrincipal = 5;
                const int valorMulta = 6;
                const int valorJurosEncargos = 7;
                const int valorTotal = 8;
                const int frase = 9;

                List<Campo> Campos = new List<Campo>()
            {
                new Campo() {Inicio = 106, Tamanho = 10}, // periodoApuracao
                new Campo() {Inicio = 106, Tamanho = 18}, // cpfCnpj
                new Campo() {Inicio = 106, Tamanho = 4}, // codigoReceita
                new Campo() {Inicio = 2, Tamanho = 4}, // numeroReferecia
                new Campo() {Inicio = 106, Tamanho = 10}, // dataVencimento
                new Campo() {Inicio = 106, Tamanho = 18}, // valorPrincipal
                new Campo() {Inicio = 106, Tamanho = 10}, // valorMulta
                new Campo() {Inicio = 106, Tamanho = 10}, // valorJurosEncargos
                new Campo() {Inicio = 106, Tamanho = 10}, // valorTotal
                new Campo() {Inicio = 1, Tamanho = 50}, // frase
            };
                #endregion

                List<string> Arquivo = new List<string>();
                Cliente cliente = new Cliente();

                int contadorLinha = 0;

                if (!ProcessarArquivo)
                    Files.ReadFile(fileName, Arquivo);
                else
                {
                    Arquivo = Global.ByteToListString_Txt(byteArquivo);
                }

                try
                {
                    if (Arquivo[0].Substring(1, 3) != "---")
                    {
                        throw new Exception("Formato do arquivo incorreto");
                        return Result;
                    }

                    foreach (string linha in Arquivo)
                    {
                        contadorLinha++;
                        //if (contadorLinha == 1)
                        //{
                        //    if (linha.Substring(1, 3) != "---")
                        //    {
                        //        throw new Exception("Formato do arquivo incorreto");
                        //        return Result;
                        //    }
                        //}
                        if (contadorLinha == 2)
                        {
                            //cliente.numeroReferecia = Convert.ToInt32(linha.Substring(Campos[numeroReferecia].Inicio, Campos[numeroReferecia].Tamanho));
                            cliente.competencia = Convert.ToDateTime(linha.Substring(Campos[periodoApuracao].Inicio, Campos[periodoApuracao].Tamanho));
                        }
                        if (contadorLinha == 4)
                        {
                            cliente.empresa = linha.Substring(Campos[empresa].Inicio, Campos[empresa].Tamanho);
                        }
                        if (contadorLinha == 6)
                        {
                            cliente.codigoReceita = Convert.ToInt32(linha.Substring(Campos[codigoReceita].Inicio, Campos[codigoReceita].Tamanho));
                        }
                        if (contadorLinha == 10)
                        {
                            cliente.dataVencimento = linha.Substring(Campos[dataVencimento].Inicio, Campos[dataVencimento].Tamanho);
                        }
                        if (contadorLinha == 12)
                        {
                            cliente.valorPrincipal = Global.CultureInfoValue(linha.Substring(Campos[valorPrincipal].Inicio, Campos[valorPrincipal].Tamanho).Trim());
                        }

                        if (contadorLinha == 20)
                        {
                            cliente.frase = linha.Substring(Campos[frase].Inicio, Campos[frase].Tamanho).Trim();
                            Result = SalvarBanco(cliente);
                            return Result;
                        }
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
            private void VerificarDarf(Cliente cliente)
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
                                                    "WHERE (OBRCLIPER_PRAZO_OU_VENCIMENTO = '{0}' OR OBRCLIPER_PARCELADESCRICAO = 'Antecipação') AND " +
                                                    "OBRCLIPER_IND = {1}",
                                                    cliente.dataVencimento, ObrigacaoClientePeriodo));

                //int codigoReceita = bd.getFieldValueInteger(string.Format("SELECT OBR_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                //                                    "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                //                                    "WHERE OBR_CODIGO_RECEITA = {0} AND " +
                //                                    "OBRCLIPER_IND = {1}",
                //                                    cliente.codigoReceita, ObrigacaoClientePeriodo));

                int Competencia = bd.getFieldValueInteger(string.Format("SELECT OBR_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                    "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                    "WHERE ((OBRCLIPER_ANO = {0} AND OBRCLIPER_MES_FINAL = {1}) OR OBRCLIPER_PARCELADESCRICAO = 'Antecipação')  AND " +
                                                    "OBRCLIPER_IND = {2} ",
                                                    cliente.competencia.Year, cliente.competencia.Month, ObrigacaoClientePeriodo));

                if (cnpj <= 0)
                    Mensagem += "CNPJ ou CPF no Darf não corresponde com o código de empresa<br/> ";
                if (dataVencimento <= 0)
                    Mensagem += "o vencimento no Darf não corresponde com o vencimento da obrigação<br/> ";
                //if (codigoReceita <= 0)
                //    Mensagem += "o codigo da Receita no Darf não corresponde com o código da receita da obrigação<br/> ";
                if (Competencia <= 0)
                    Mensagem += "a competência no Darf não corresponde com a competência da obrigação<br/>";

                if (Mensagem != "")
                {
                    string MensagemFinal = "Erro de Validação:<br/> " + Mensagem;
                    throw new Exception(MensagemFinal);
                }

            }
            #endregion

            #region Salvar Banco
            private int SalvarBanco(Cliente cliente)
            {
                int Darf = 0;

                if (!Publish)
                {
                    VerificarDarf(cliente);
                }
                else
                {
                    try
                    {
                        SqlCommand cmd = new SqlCommand("darf_importacao", bd.Conn);

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@P_CODIGORECEITA", cliente.codigoReceita);
                        cmd.Parameters.AddWithValue("@P_OBRIGACAOARQUIVO", ArquivoIndice);
                        cmd.Parameters.AddWithValue("@P_PERIODOAPURACAO", cliente.competencia);
                        cmd.Parameters.AddWithValue("@P_VENCIMENTO", cliente.dataVencimento);
                        cmd.Parameters.AddWithValue("@P_VALOR", cliente.valorPrincipal);
                        //cmd.Parameters.AddWithValue("@P_NUMEROREFERENCIA", cliente.numeroReferecia);
                        cmd.Parameters.AddWithValue("@P_FRASE", cliente.frase);

                        if (cliente.codigoBarras1 != "" || cliente.codigoBarras1 != null)
                        {
                            cmd.Parameters.AddWithValue("@P_CODIGO_BARRAS1", cliente.codigoBarras1);
                            cmd.Parameters.AddWithValue("@P_CODIGO_BARRAS2", cliente.codigoBarras2);
                            cmd.Parameters.AddWithValue("@P_CODIGO_BARRAS3", cliente.codigoBarras3);
                            cmd.Parameters.AddWithValue("@P_CODIGO_BARRAS4", cliente.codigoBarras4);
                        }

                        cmd.Parameters.AddWithValue("@P_VALOR_MULTA", cliente.valorMulta);
                        cmd.Parameters.AddWithValue("@P_VALOR_JUROS", cliente.valorJurosEncargos);
                        cmd.Parameters.AddWithValue("@P_VALOR_TOTAL", cliente.valorTotal);

                        SqlParameter parameter_result = cmd.Parameters.Add("@RESULT", SqlDbType.Int);
                        parameter_result.Direction = ParameterDirection.ReturnValue;

                        cmd.ExecuteNonQuery();

                        if (parameter_result.Value != null)
                        {
                            Darf = Convert.ToInt32(parameter_result.Value);
                        }
                    }
                    catch (Exception ex)
                    {
                        throw new System.ArgumentException("Erro: ", ex.Message);
                    }
                }

                return Darf;
            }
            #endregion
        }
    }
}