using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using Wr.Classes;

namespace Assecontweb
{
    namespace Modelos
    {
        public class GPS
        {
            BD bd;
            private bool Publish;
            private int ArquivoIndice;
            private int ObrigacaoClientePeriodo;
            private bool ProcessarArquivo;
            private byte[] byteArquivo;
            private string fileName;
            //private bool Domestica = false;

            #region struct Cliente
            struct Cliente
            {
                public DateTime competencia;
                public string empresa;
                public string pis;
                public int codigoReceita;
                public Int32 numero;
                public string dataVencimento;
                public Single valorINSS;
                public Single valorEntidades;
                public Single valorPrincipal;
                public string endereco;
                public string endereco2;
                public string nome;
                public int ArqIndice;
            }
            #endregion

            #region struct Campo
            struct Campo
            {
                public int Inicio;
                public int Tamanho;
            }
            #endregion

            //Assinatura para reeler o arquivo.
            public GPS(BD bd, byte[] byteArquivo, int ObrigacaoClientePeriodo, int ArquivoIndice, bool ProcessarArquivo)
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
                    int a = LerArquivo();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }

            public GPS(BD bd, string fileName, int ObrigacaoClientePeriodo, int ArquivoIndice, bool Publish, out int GpsInd)
            {
                this.bd = bd;
                this.Publish = Publish;
                this.ArquivoIndice = ArquivoIndice;
                this.ObrigacaoClientePeriodo = ObrigacaoClientePeriodo;
                this.fileName = fileName;

                try
                {
                    Global.Cultura();

                    if (Path.GetExtension(fileName).ToLower() == ".txt")
                        GpsInd = LerArquivo();
                    else
                        throw new Exception("O arquivo deve estar em formato .txt");
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }

            public int LerArquivo()
            {
                #region Campos
                /*Cliente*/
                const int competencia = 0;
                const int cpfCnpj = 1;
                const int codigoPagamento = 2;
                const int numero = 3;
                const int dataVencimento = 4;
                const int valorINSS = 5;
                const int valorEntidades = 6;
                const int valorPrincipal = 7;
                const int endereco = 8;
                const int endereco2 = 9;
                const int nome = 10;

                List<Campo> Campos = new List<Campo>()
            {
                new Campo() {Inicio = 108, Tamanho = 10}, // competencia
                new Campo() {Inicio = 106, Tamanho = 18}, // cpfCnpj
                new Campo() {Inicio = 106, Tamanho = 6}, // codigoPagamento
                new Campo() {Inicio = 2, Tamanho = 4}, // numero
                new Campo() {Inicio = 114, Tamanho = 10}, // dataVencimento
                new Campo() {Inicio = 108, Tamanho = 14}, // valorINSS
                new Campo() {Inicio = 108, Tamanho = 14}, // valorEntidades
                new Campo() {Inicio = 108, Tamanho = 14}, // valorTotal
                new Campo() {Inicio = 2, Tamanho = 66}, // endereco
                new Campo() {Inicio = 2, Tamanho = 66}, // endereco2
                 new Campo() {Inicio = 2, Tamanho = 66}, // nome
            };
                #endregion

                int contadorLinha = 0;
                int contadorArquivo = 1;

                List<string> Arquivo = new List<string>();
                List<Cliente> listaClientes = new List<Cliente>();

                Cliente cliente = new Cliente();
                //try
                //{

                if (!ProcessarArquivo)
                    Files.ReadFile(fileName, Arquivo);
                else
                {
                    Arquivo = Global.ByteToListString_Txt(byteArquivo);
                }

                if (Arquivo[1].Substring(1, 3) != "---")
                {
                    throw new Exception("Formato do arquivo incorreto");
                }

                #region Leitura do Arquivo
                foreach (string linha in Arquivo)
                {
                    contadorLinha++;
                    if (contadorLinha == 1)
                    {
                        cliente.numero = Convert.ToInt32(linha.Substring(Campos[numero].Inicio, Campos[numero].Tamanho));
                        cliente.dataVencimento = Convert.ToDateTime(linha.Substring(Campos[dataVencimento].Inicio, Campos[dataVencimento].Tamanho)).ToString("dd/MM/yyyy");
                    }

                    if (contadorLinha == 3)
                    {
                        cliente.codigoReceita = Convert.ToInt32(linha.Substring(Campos[codigoPagamento].Inicio, Campos[codigoPagamento].Tamanho));
                    }

                    if (contadorLinha == 5)
                    {
                        string Competencia = linha.Substring(Campos[competencia].Inicio, Campos[competencia].Tamanho).Trim();
                        if (Competencia.Split('/')[0] == "13") Competencia = "12/" + Competencia.Split('/')[1]; // décimo terceiro: trocar 13 pelo 12 :p
                        cliente.competencia = Convert.ToDateTime(Competencia);
                    }

                    if (contadorLinha == 7)
                    {
                        if (ValidaDomestica(ObrigacaoClientePeriodo))
                        {
                            cliente.pis = linha.Substring(Campos[cpfCnpj].Inicio, Campos[cpfCnpj].Tamanho).Trim().Replace(".", "").Replace("-", "").Replace("/", "");

                            if (Validadores.ValidaCpf(cliente.pis))
                                throw new Exception("O Funcionario contém CPF em vez de PNIT/PIS");
                        }
                        else
                            cliente.empresa = linha.Substring(Campos[cpfCnpj].Inicio, Campos[cpfCnpj].Tamanho).Trim();
                    }

                    if (contadorLinha == 9)
                    {
                        if (linha.Substring(Campos[valorINSS].Inicio, Campos[valorINSS].Tamanho).Trim() != "")
                            cliente.valorINSS = Global.CultureInfoValue(linha.Substring(Campos[valorINSS].Inicio, Campos[valorINSS].Tamanho));
                    }

                    if (contadorLinha == 10)
                    {
                        cliente.nome = linha.Substring(Campos[nome].Inicio, Campos[nome].Tamanho).Trim();
                    }

                    if (contadorLinha == 11)
                    {
                        cliente.endereco = linha.Substring(Campos[endereco].Inicio, Campos[endereco].Tamanho).Trim();
                    }

                    if (contadorLinha == 13)
                    {
                        cliente.endereco2 = linha.Substring(Campos[endereco2].Inicio, Campos[endereco2].Tamanho).Trim();
                    }

                    if (contadorLinha == 15)
                    {
                        cliente.valorEntidades = Global.CultureInfoValue(linha.Substring(Campos[valorEntidades].Inicio, Campos[valorEntidades].Tamanho));
                    }

                    if (contadorLinha == 21)
                    {
                        cliente.valorPrincipal = Global.CultureInfoValue(linha.Substring(Campos[valorPrincipal].Inicio, Campos[valorPrincipal].Tamanho));
                    }

                    if (linha.Contains("\f"))
                    {
                        if (contadorArquivo > 1 && Publish)
                            ArquivoIndice = ArquivoUpload(Convert.ToByte(contadorArquivo), fileName);

                        cliente.ArqIndice = ArquivoIndice;
                        listaClientes.Add(cliente);
                        cliente = new Cliente();
                        contadorLinha = 0;
                        contadorArquivo++;
                    }
                }
                #endregion

                if (!Publish)
                {
                    VerificarDarf(listaClientes[0], ObrigacaoClientePeriodo);
                }
                else
                {
                    for (int i = 0; i < listaClientes.Count; i++)
                    {
                        SalvarBanco(listaClientes[i]);
                    }
                }
                //}
                //catch (ArgumentOutOfRangeException ex)
                //{
                //    throw new Exception("Arquivo em branco");
                //}
                //finally
                //{

                //}

                return 1;
            }

            #region Validação

            private bool ValidaDomestica(int ObrigacaoClientePeriodo)
            {
                return bd.getFieldValueBool(string.Format("SELECT CASE WHEN OBR_ABREVIACAO = 'gpsdomt' THEN 1 ELSE 0 END FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                  "WHERE OBRCLIPER_IND = {0}", ObrigacaoClientePeriodo));
            }

            private void VerificarDarf(Cliente cliente, int ObrigacaoClientePeriodo)
            {
                string Mensagem = string.Empty;
                int dados = 0;
                //cadastro = 0;
                bool domestica = ValidaDomestica(ObrigacaoClientePeriodo);

                if (domestica)
                {
                    dados = bd.getFieldValueInteger(string.Format("SELECT CLI_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                  "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                  "WHERE CLI_NUMERO = {0} AND OBRCLIPER_IND = {1}",
                                                  cliente.numero, ObrigacaoClientePeriodo));

                    //cadastro = bd.getFieldValueInteger(string.Format("SELECT FUNC_IND FROM Funcionarios " +
                    //                              "WHERE dbo.fn_trim_cnpj(FUNC_CPF) = dbo.fn_trim_cnpj('{0}') ", cliente.pis));
                }
                else
                {
                    dados = bd.getFieldValueInteger(string.Format("SELECT OBR_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                  "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                  "WHERE (dbo.fn_trim_cnpj(CLI_CNPJ) = dbo.fn_trim_cnpj('{0}') OR " +
                                                  "dbo.fn_trim_cnpj(CLI_CPF) = dbo.fn_trim_cnpj('{0}')) AND OBRCLIPER_IND = {1}",
                                                  cliente.empresa, ObrigacaoClientePeriodo));
                }

                int dataVencimento = bd.getFieldValueInteger(string.Format("SELECT OBR_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                    "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                    "WHERE OBRCLIPER_PRAZO_OU_VENCIMENTO = '{0}' AND " +
                                                    "OBRCLIPER_IND = {1}",
                                                    cliente.dataVencimento, ObrigacaoClientePeriodo));

                //int codigoReceita = bd.getFieldValueInteger(string.Format("SELECT OBR_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                //                                    "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                //                                    "WHERE OBR_CODIGO_RECEITA = {0} AND " +
                //                                    "OBRCLIPER_IND = {1}",
                //                                    cliente.codigoReceita, ObrigacaoClientePeriodo));

                int Competencia = bd.getFieldValueInteger(string.Format("SELECT OBR_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                    "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                    "WHERE OBRCLIPER_ANO = {0} AND OBRCLIPER_MES_FINAL = {1} AND " +
                                                    "OBRCLIPER_IND = {2} ",
                                                    cliente.competencia.Year, cliente.competencia.Month, ObrigacaoClientePeriodo));

                if (dados <= 0)
                {
                    if (!domestica)
                    {
                        Mensagem += "CNPJ ou CPF no GPS não corresponde com o código de empresa<br/> ";
                    }
                    else
                    {
                        Mensagem += "Número no GPS não corresponde com o código de empresa<br/> ";
                    }
                }

                //if (cadastro <= 0 && domestica)
                //    Mensagem += "Funcionario não tem holerite anexado pelo PIS<br/> ";

                if (dataVencimento <= 0)
                    Mensagem += "o vencimento no GPS não corresponde com o vencimento da obrigação<br/> ";
                //if (codigoReceita <= 0)
                // Mensagem += "o codigo da Receita no GPS não corresponde com o código da receita da obrigação<br/> ";
                if (Competencia <= 0)
                    Mensagem += "a competência no GPS não corresponde com a competência da obrigação<br/>";

                if (Mensagem != "")
                {
                    string MensagemFinal = "Erro de Validação:<br/> " + Mensagem;
                    throw new Exception(MensagemFinal);
                }
            }
            #endregion

            #region Gravar
            private void SalvarBanco(Cliente cliente)
            {
                int GPS = 0;

                try
                {
                    SqlCommand cmd = new SqlCommand("gps_importacao", bd.Conn);

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@P_CODIGORECEITA", cliente.codigoReceita);
                    cmd.Parameters.AddWithValue("@P_OBRIGACAOARQUIVO", cliente.ArqIndice);
                    cmd.Parameters.AddWithValue("@P_PERIODOAPURACAO", cliente.competencia);
                    cmd.Parameters.AddWithValue("@P_VENCIMENTO", cliente.dataVencimento);
                    cmd.Parameters.AddWithValue("@P_VALOR", cliente.valorPrincipal);
                    cmd.Parameters.AddWithValue("@P_NUMEROREFERENCIA", cliente.numero);
                    cmd.Parameters.AddWithValue("@P_DARF_GPS_ENTIDADES", cliente.valorEntidades);
                    cmd.Parameters.AddWithValue("@P_DARF_GPS_INSS", cliente.valorINSS);
                    cmd.Parameters.AddWithValue("@P_DARF_GPS_ENDERECO", cliente.endereco);
                    cmd.Parameters.AddWithValue("@P_DARF_GPS_ENDERECO2", cliente.endereco2);

                    if (cliente.pis != "" && cliente.pis != null)
                    {
                        cmd.Parameters.AddWithValue("@P_DOMESTICA", 1);
                        cmd.Parameters.AddWithValue("@P_DARF_GPS_NOME", cliente.nome);
                        cmd.Parameters.AddWithValue("@P_DARF_GPS_PIS", cliente.pis);
                    }

                    SqlParameter parameter_result = cmd.Parameters.Add("@RESULT", SqlDbType.Int);
                    parameter_result.Direction = ParameterDirection.ReturnValue;

                    cmd.ExecuteNonQuery();

                    if (parameter_result.Value != null)
                    {
                        GPS = Convert.ToInt32(parameter_result.Value);
                    }
                }
                catch (Exception ex)
                {
                    throw new System.ArgumentException("Erro Banco", ex.Message);
                }
            }
            #endregion

            #region ArquivoUpload
            ///Para adicionar mais de um GPS
            private int ArquivoUpload(byte numero, string fileName)
            {
                //string arquivo = string.Empty;
                int arquivotipo = 0;
                int arquivosubtipo = 0;
                int user = 0;
                string memorando = string.Empty;

                string query = "SELECT OBRARQ_ARQUIVO, OBRARQ_TIPO, OBRARQ_SUBTIPO, OBRARQ_DISPONIVELPOR FROM ObrigacoesArquivos WHERE OBRARQ_IND = {0}";

                SqlCommand cmd = new SqlCommand(string.Format(query, ArquivoIndice), bd.Conn);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    //arquivo = dr["OBRARQ_ARQUIVO"].ToString();
                    arquivotipo = Convert.ToInt32(dr["OBRARQ_TIPO"].ToString());
                    arquivosubtipo = Convert.ToInt32(dr["OBRARQ_SUBTIPO"].ToString());
                    user = Convert.ToInt32(dr["OBRARQ_DISPONIVELPOR"].ToString());
                }

                dr.Close();

                return uploadArquivoNovo(ObrigacaoClientePeriodo, fileName, (Types.Types.ObrigacaoArquivoTipo)arquivotipo, (Types.Types.ObrigacaoArquivoSubTipo)arquivosubtipo,
                    false, user, memorando, numero);
            }

            private int uploadArquivoNovo(int ObrigacaoClientePeriodo, string Arquivo, Types.Types.ObrigacaoArquivoTipo tipo, Types.Types.ObrigacaoArquivoSubTipo subtipo, bool Provisorio, int User, string Memorando, byte ArquivoNumero)
            {
                FileInfo f = new FileInfo(Arquivo);

                SqlCommand cmd = new SqlCommand("arquivo_upload", bd.Conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@P_OBRIGACAOCLIENTEPERIODO", ObrigacaoClientePeriodo);
                cmd.Parameters.AddWithValue("@P_TIPO", (int)tipo);
                cmd.Parameters.AddWithValue("@P_SUBTIPO", (int)subtipo);
                cmd.Parameters.AddWithValue("@P_TAMANHO", f.Length);
                cmd.Parameters.AddWithValue("@P_ARQUIVO", Wr.Classes.Files.ReadStream(Arquivo));
                cmd.Parameters.AddWithValue("@P_EXTENSAO", f.Extension.Remove(0, 1));
                cmd.Parameters.AddWithValue("@P_DISPONIVELPOR", User);
                cmd.Parameters.AddWithValue("@P_MEMORANDO", Memorando);
                cmd.Parameters.AddWithValue("@P_PROVISORIO", Provisorio);
                cmd.Parameters.AddWithValue("@P_ARQUIVONUMERO", ArquivoNumero);
                SqlParameter parameter_indice = cmd.Parameters.Add("@R_INDICE", SqlDbType.Int);
                parameter_indice.Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                return Convert.ToInt32(parameter_indice.Value);
            }

            #endregion
        }
    }
}