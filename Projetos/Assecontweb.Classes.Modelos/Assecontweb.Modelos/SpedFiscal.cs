using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Assecontweb.Classes;

namespace Assecontweb
{
    namespace Modelos
    {
        public class SpedFiscal
        {
            #region Struct's Bloco 0
            struct AberturaIndentificacao //0000
            {
                public DateTime dataInicial;
                public DateTime dataFinal;
                public string razaoSocial;
                public string cnpj;
                public string cpf;
            }

            struct CadastroParticipante //0150
            {
                public int registro;
                public string cod_identificacao;
                public string nome;
                public int cod_pais;
                public string cnpj;
                public string cpf;
                public string ie;
                public string cod_municipal;
                public string endereco;
                public string numero; //teve um que apareceu 76b
                public string complemento;
                public string bairro;
            }

            struct IdentificacaoItem //0200
            {
                public int registro;
                public string cod_item;
                public string descricao;
                public string cod_barra_alfanumerico;
                public string cod_naterior;
                public string quantificacao_estoque;
                public int tipo_item;
                /* TIPO:
                    00 – Mercadoria para Revenda;
                    01 – Matéria-Prima;
                    02 – Embalagem;
                    03 – Produto em Processo;
                    04 – Produto Acabado;
                    05 – Subproduto;
                    06 – Produto Intermediário;
                    07 – Material de Uso e Consumo;
                    08 – Ativo Imobilizado;
                    09 – Serviços;
                    10 – Outros insumos;
                 */
                public string cod_ncm;
            }
            #endregion

            #region Struct's Bloco C DOCUMENTOS FISCAIS I - MERCADORIAS ENTRADA (ICMS/IPI)
            struct NotaFiscal //C100
            {
                public string registro;
                public TipoNota tipoNota;  //0- Entrada; 1- Saída;
                public bool emitente; //0- Emissão própria; 1- Terceiros
                public string cod_participante; //Código do participante (campo 02 do Registro 0150)
                public int cod_modelo;
                public int cod_situacao;
                public int serie;
                public int NumDoc;
                public string chave_NFE;
                public DateTime dataEmissao;
                public DateTime dataEntrada_saida;
                public Single valorTotal;
                public int tipoPagamento; /*0- À vista; 1- A prazo; 2 - Outros*/
                public Single desconto;
            }

            struct itensDocumento //C170
            {
                public string registro;
                public int num_item;
                public string cod_item; // (campo 02 do Registro 0200)
                public string descricao;
                public int qtdItem;
                public string unidade; //(Campo 02 do registro 0190)
                public Single valorItem;
                public Single valorDesconto;
                public int cfop;
            }
            #endregion

            private BDApp bd;
            private string fileName;
            private bool publish = false, blocoC = false, getItem = false;
            int obrigacaoArquivo;
            private List<IdentificacaoItem> listaItens = new List<IdentificacaoItem>();
            private bool ProcessarArquivo = false;
            private byte[] byteArquivo;

            public SpedFiscal(BDApp bd, byte[] byteArquivo, int ArquivoIndice, bool ProcessarArquivo)
            {
                this.bd = bd;
                this.publish = true;
                this.byteArquivo = byteArquivo;
                this.ProcessarArquivo = ProcessarArquivo;
                this.obrigacaoArquivo = ArquivoIndice;
                try
                {
                    lerArquivo();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }

            public SpedFiscal(BDApp bd, string fileName, int obrigacaoArquivo, bool publish)
            {
                this.bd = bd;
                this.fileName = fileName;
                this.publish = publish;
                this.obrigacaoArquivo = obrigacaoArquivo; // wr
                lerArquivo();
            }

            private void lerArquivo()
            {
                List<string> Arquivo = new List<string>();
                List<CadastroParticipante> listaParticipante = new List<CadastroParticipante>();
                List<Object> listaNotaFiscal = new List<Object>();
                AberturaIndentificacao Cliente = new AberturaIndentificacao();

                if (!ProcessarArquivo)
                    Wr.Classes.Files.ReadFile(fileName, Arquivo, 1252);
                else
                {
                    Arquivo = Global.ByteToListString_Txt(byteArquivo);
                }

                if (!publish && !Arquivo[0].Contains("|0000|"))
                {
                    throw new Exception("Formato do Anexo Incorreto");
                }

                if (!publish && string.IsNullOrEmpty(Arquivo[0].Split('|')[4]))
                {
                    throw new Exception("Formato Inválido <br />ERRO: Formato do EFD Contribuições");
                }

                const int numRegistro = 1;
                const int operacao = 2;

                #region Leitura do Arquivo
                for (int i = 0; i < Arquivo.Count; i++)
                {
                    try
                    {
                        string[] linha = Arquivo[i].Split('|');
                        switch (linha[numRegistro])
                        {
                            case "0000":
                                Cliente = (AberturaIndentificacao)metodAberturaIndentificacao(linha);
                                continue;

                            case "0001":
                                if (ConvertBool(linha[3])) throw new Exception("Bloco 0 - Entidade sem dados informados.");
                                continue;

                            case "0150":
                                listaParticipante.Add((CadastroParticipante)metodCadastroParticipante(linha));
                                continue;

                            case "0200":
                                listaItens.Add((IdentificacaoItem)metodIdentificacaoItem(linha));
                                continue;

                            case "C001":
                                blocoC = !ConvertBool(linha[2]);
                                continue;

                            case "C100":
                                {
                                    if (!ConvertBool(linha[operacao]) && linha[6].Equals("00") /*situação: documento original*/)
                                    {
                                        if (CFOPCompra().Contains(Convert.ToInt32(Arquivo[i + 1].Split('|')[11])))
                                        {
                                            listaNotaFiscal.Add(metodNotaFiscal(linha));
                                            getItem = true;
                                        }
                                        else
                                            getItem = false;
                                    }
                                    continue;
                                }


                            case "C170":
                                {
                                    try
                                    { if (getItem) listaNotaFiscal.Add(metodItensDocumento(linha)); }
                                    catch (Exception ex) { }
                                    continue;
                                }
                        }

                        if (linha[numRegistro] == "9001")
                        {
                            string msgErro = string.Empty;
                            if (!blocoC)
                                msgErro = "O Bloco C (NOTA FISCAL) tem que conter dados.<br />";

                            if (!string.IsNullOrEmpty(msgErro))
                                throw new Exception(msgErro + "Verifique o arquivo.");
                            break;
                        }
                    }
                    catch (Exception ex) { }
                }
                #endregion

                int indCliente = VerificarCliente(Cliente);
                if (indCliente != 0 && publish)
                {
                    bd.openConnection();
                    salvarParticipantes(listaParticipante, indCliente);
                    voidNotaFiscal(listaNotaFiscal, indCliente);
                }
            }

            int VerificarCliente(AberturaIndentificacao Cliente)
            {
                string query = "SELECT CLI_IND FROM Clientes WHERE CLI_CNPJ = '{0}' OR CLI_CPF = '{1}'";
                return bd.getFieldValueInteger(string.Format(query, Cliente.cnpj, Cliente.cpf));
            }

            private void voidNotaFiscal(List<Object> listaNotaFiscal, int idCliente)
            {
                int nota = 0;

                foreach (Object lista in listaNotaFiscal)
                {
                    try
                    {
                        if (((NotaFiscal)lista).registro == "C100")
                        {
                            nota = salvarNota((NotaFiscal)lista, idCliente);
                        }
                    }
                    catch (InvalidCastException ex)
                    {
                        if (((itensDocumento)lista).registro == "C170")
                        {
                            SalvarProduto((itensDocumento)lista, nota);
                        }
                    }
                }
            }

            #region Save
            void SalvarProduto(itensDocumento produto, int idNota)
            {
                IdentificacaoItem identItem = relacionarProdutoItem(produto);
                if (identItem.cod_item != null)
                {
                    SqlCommand cmd = new SqlCommand("importacao_sped_produtos", bd.Conn);

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@P_NUM", produto.num_item);
                    cmd.Parameters.AddWithValue("@P_CODIGO", produto.cod_item);
                    cmd.Parameters.AddWithValue("@P_DESCRICAO", produto.descricao);
                    cmd.Parameters.AddWithValue("@P_QUANTIDADE", produto.qtdItem);
                    cmd.Parameters.AddWithValue("@P_UNIDADE", produto.unidade);
                    cmd.Parameters.AddWithValue("@P_VALOR", produto.valorItem);
                    cmd.Parameters.AddWithValue("@P_COD_NCM", identItem.cod_ncm);
                    cmd.Parameters.AddWithValue("@P_TIPO_ATIVIDADE", identItem.tipo_item);
                    cmd.Parameters.AddWithValue("@P_NOTA_FISCAL", idNota);
                    cmd.Parameters.AddWithValue("@P_CFOP", produto.cfop);

                    SqlParameter parameter_result = cmd.Parameters.Add("@R_RESULT", SqlDbType.Int);
                    parameter_result.Direction = ParameterDirection.ReturnValue;

                    cmd.ExecuteNonQuery();
                }
            }

            int salvarNota(NotaFiscal Nota, int idCliente)
            {
                int idNota = 0;

                SqlCommand cmd = new SqlCommand("importacao_sped_nota_fiscal", bd.Conn);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@P_PARTICIPANTE", Nota.cod_participante.Trim());
                cmd.Parameters.AddWithValue("@P_TIPO_DA_NOTA", (int)Nota.tipoNota);
                cmd.Parameters.AddWithValue("@P_EMITENTE", Nota.emitente);
                cmd.Parameters.AddWithValue("@P_MODELO", Nota.cod_modelo);
                cmd.Parameters.AddWithValue("@P_SITUACAO_FISCAL", Nota.cod_situacao);
                cmd.Parameters.AddWithValue("@P_SERIE", Nota.serie);
                cmd.Parameters.AddWithValue("@P_NUM_DOCUMENTO", Nota.NumDoc);
                cmd.Parameters.AddWithValue("@P_CHAVE_NFE", Nota.chave_NFE);
                if (Nota.dataEmissao.ToString("dd/MM/yyyy") != "01/01/0001")
                {
                    cmd.Parameters.AddWithValue("@P_DATA_EMISSAO", Nota.dataEmissao);
                    cmd.Parameters.AddWithValue("@P_DATA_ENTRADA_SAIDA", Nota.dataEntrada_saida);
                    cmd.Parameters.AddWithValue("@P_VALOR_TOTAL", Nota.valorTotal);
                    cmd.Parameters.AddWithValue("@P_VALOR_DESCONTO", Nota.desconto);
                    cmd.Parameters.AddWithValue("@P_TIPO_PAGAMENTO", Nota.tipoPagamento);
                }
                cmd.Parameters.AddWithValue("@P_EMPRESA", idCliente);

                SqlParameter parameter_result = cmd.Parameters.Add("@R_RESULT", SqlDbType.Int);
                parameter_result.Direction = ParameterDirection.ReturnValue;

                cmd.ExecuteNonQuery();

                if (parameter_result != null)
                    idNota = Convert.ToInt32(parameter_result.Value);

                return idNota;
            }

            void salvarParticipantes(List<CadastroParticipante> listaParticipante, int idCliente)
            {
                foreach (CadastroParticipante part in listaParticipante)
                {
                    SqlCommand cmd = new SqlCommand("importacao_sped_participante", bd.Conn);

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@P_CODIGO", part.cod_identificacao);
                    cmd.Parameters.AddWithValue("@P_NOME", Wr.Classes.Strings.capitalizeWords(part.nome));
                    cmd.Parameters.AddWithValue("@P_COD_PAIS", part.cod_pais);
                    if (!string.IsNullOrEmpty(part.cnpj)) cmd.Parameters.AddWithValue("@P_CNPJ", part.cnpj);
                    if (!string.IsNullOrEmpty(part.cpf)) cmd.Parameters.AddWithValue("@P_CPF", part.cpf);
                    cmd.Parameters.AddWithValue("@P_IE", part.ie);
                    cmd.Parameters.AddWithValue("@P_COD_MUN", part.cod_municipal);
                    cmd.Parameters.AddWithValue("@P_LOGRADOURO", part.endereco);
                    cmd.Parameters.AddWithValue("@P_NUMERO", part.numero);
                    if (!string.IsNullOrEmpty(part.complemento)) cmd.Parameters.AddWithValue("@P_COMPLEMENTO", part.complemento);
                    cmd.Parameters.AddWithValue("@P_BAIRRO", part.bairro);
                    cmd.Parameters.AddWithValue("@P_EMPRESA", idCliente);

                    cmd.ExecuteNonQuery();
                }
            }
            #endregion

            #region metodos dos Itens do SpedFIscal
            private Object metodAberturaIndentificacao(string[] linha)
            {
                const int POS_DATAINICIAL = 4;
                const int POS_DATAFINAL = 5;
                const int POS_NOME = 6;
                const int POS_CNPJ = 7;
                const int POS_CPF = 8;

                AberturaIndentificacao param = new AberturaIndentificacao();

                param.dataInicial = ConvertDate(linha[POS_DATAINICIAL]);
                param.dataFinal = ConvertDate(linha[POS_DATAFINAL]);
                param.razaoSocial = linha[POS_NOME];
                param.cnpj = linha[POS_CNPJ];
                param.cpf = linha[POS_CPF];

                return param;
            }

            private Object metodItensDocumento(string[] linha) //C170
            {
                const int POS_REGISTRO = 1;
                const int POS_ITEM = 2;
                const int POS_COD_ITEM = 3;
                const int POS_DESCRICAO = 4;
                const int POS_QTD_ITEM = 5;
                const int POS_UNIDADE = 6;
                const int POS_VALOR_ITEM = 7;
                const int POS_VALOR_DESCONTO = 8;
                const int POS_CFOP = 11;

                itensDocumento param = new itensDocumento();
                param.registro = linha[POS_REGISTRO];
                param.num_item = Convert.ToInt32(linha[POS_ITEM]);
                param.cod_item = linha[POS_COD_ITEM];  // (campo 02 do Registro 0200)
                param.descricao = linha[POS_DESCRICAO];
                param.qtdItem = Convert.ToInt32(linha[POS_QTD_ITEM]);
                param.unidade = linha[POS_UNIDADE];  //(Campo 02 do registro 0190)
                param.valorItem = Convert.ToSingle(linha[POS_VALOR_ITEM]);
                param.valorDesconto = Convert.ToSingle(linha[POS_VALOR_DESCONTO]);
                param.cfop = Convert.ToInt32(linha[POS_CFOP]);
                return param;
            }

            private Object metodNotaFiscal(string[] linha) //C100
            {
                #region consts
                const int POS_REGISTRO = 1;
                const int POS_OPERACAO = 2;
                const int POS_EMITENTE = 3;
                const int POS_PARTICIPANTE = 4;
                const int POS_MODELO = 5;
                const int POS_SITUACAO = 6;
                const int POS_SERIE = 7;
                const int POS_DOCUMENTO = 8;
                const int POS_NFE = 9;
                const int POS_DATAEMISSAO = 10;
                const int POS_DATA_ENTRADA_SAIDA = 11;
                const int POS_VALOR_TOTAL = 12;
                const int POS_TIPO_PAGAMENTO = 13;
                const int POS_DESCONTO = 14;
                #endregion

                NotaFiscal param = new NotaFiscal();

                param.registro = linha[POS_REGISTRO];
                param.tipoNota = (TipoNota)Convert.ToInt32(linha[POS_OPERACAO]);
                param.emitente = ConvertBool(linha[POS_EMITENTE]);
                param.cod_participante = linha[POS_PARTICIPANTE];
                param.cod_modelo = Convert.ToInt32(linha[POS_MODELO]);
                param.cod_situacao = Convert.ToInt32(linha[POS_SITUACAO]);
                param.serie = string.IsNullOrEmpty(linha[POS_SERIE]) ? 0 : Convert.ToInt32(linha[POS_SERIE]);
                param.NumDoc = string.IsNullOrEmpty(linha[POS_DOCUMENTO]) ? 0 : Convert.ToInt32(linha[POS_DOCUMENTO]);
                param.chave_NFE = linha[POS_NFE];

                if (!string.IsNullOrEmpty(linha[POS_DATAEMISSAO])) param.dataEmissao = ConvertDate(linha[POS_DATAEMISSAO]);
                else return param;

                param.dataEntrada_saida = ConvertDate(linha[POS_DATA_ENTRADA_SAIDA]);
                param.valorTotal = Convert.ToSingle(linha[POS_VALOR_TOTAL]);
                param.tipoPagamento = Convert.ToInt32(linha[POS_TIPO_PAGAMENTO]); //tipo 
                param.desconto = string.IsNullOrEmpty(linha[POS_DESCONTO]) ? 0 : Convert.ToSingle(linha[POS_DESCONTO]);

                return param;
            }

            private Object metodIdentificacaoItem(string[] linha) //0200
            {
                const int POS_REGISTRO = 1;
                const int POS_ITEM = 2;
                const int POS_DESCRICAO = 3;
                const int POS_ALFANUMERICO = 4;
                const int POS_NATERIOR = 5;
                const int POS_ESTOQUE = 6;
                const int POS_TIPO = 7;
                const int POS_NCM = 8;

                IdentificacaoItem param = new IdentificacaoItem();
                param.registro = Convert.ToInt32(linha[POS_REGISTRO]);
                param.cod_item = linha[POS_ITEM];
                param.descricao = linha[POS_DESCRICAO];
                param.cod_barra_alfanumerico = linha[POS_ALFANUMERICO];
                param.cod_naterior = linha[POS_NATERIOR];
                param.quantificacao_estoque = linha[POS_ESTOQUE];
                param.tipo_item = Convert.ToInt32(linha[POS_TIPO]);
                param.cod_ncm = linha[POS_NCM];
                return param;
            }

            private Object metodCadastroParticipante(string[] linha)
            {
                const int POS_REGISTRO = 1;
                const int POS_IDENTIFICACAO = 2;
                const int POS_NOME = 3;
                const int POS_PAIS = 4;
                const int POS_CNPJ = 5;
                const int POS_CPF = 6;
                const int POS_IE = 7;
                const int POS_COD_MUNICIPAL = 8;
                const int POS_ENDERECO = 10;
                const int POS_ENDERECO_NUMERO = 11;
                const int POS_ENDERECO_COMPL = 12;
                const int POS_BAIRRO = 13;

                CadastroParticipante param = new CadastroParticipante();
                param.registro = Convert.ToInt32(linha[POS_REGISTRO]);
                param.cod_identificacao = linha[POS_IDENTIFICACAO];
                param.nome = linha[POS_NOME];
                param.cod_pais = Convert.ToInt32(linha[POS_PAIS]);
                param.cnpj = linha[POS_CNPJ];
                param.cpf = linha[POS_CPF];
                param.ie = linha[POS_IE];
                param.cod_municipal = linha[POS_COD_MUNICIPAL];
                param.endereco = linha[POS_ENDERECO];
                param.numero = linha[POS_ENDERECO_NUMERO];
                param.complemento = linha[POS_ENDERECO_COMPL];
                param.bairro = linha[POS_BAIRRO];

                return param;
            }
            #endregion

            #region util
            private bool ConvertBool(string bit)
            {
                if (!string.IsNullOrEmpty(bit))
                    return bit.Equals("1");

                return false;
            }

            private DateTime ConvertDate(string data)
            {
                return Convert.ToDateTime(data.Substring(0, 2) + "/" + data.Substring(2, 2) + "/" + data.Substring(4, 4));
            }

            IdentificacaoItem relacionarProdutoItem(itensDocumento Item)
            {
                foreach (IdentificacaoItem Identificacao in listaItens)
                {
                    if (Identificacao.cod_item == Item.cod_item)
                        return Identificacao;
                }

                return new IdentificacaoItem();
            }
            #endregion

            private enum TipoNota
            {
                Compra = 0, //entrada
                Venda = 1, //saida            
                Servico = 2
            }

            private List<int> CFOPCompra() //Entrada
            {
                List<int> cfopCompra = new List<int>();
                cfopCompra.Add(1101);
                cfopCompra.Add(1102);
                cfopCompra.Add(1126);
                cfopCompra.Add(1128);
                cfopCompra.Add(1252);
                cfopCompra.Add(1253);
                cfopCompra.Add(1401);
                cfopCompra.Add(1403);
                cfopCompra.Add(1652);
                cfopCompra.Add(2101);
                cfopCompra.Add(2102);
                cfopCompra.Add(2403);
                cfopCompra.Add(3101);
                cfopCompra.Add(3102);

                return cfopCompra;
            }
        }
    }
}