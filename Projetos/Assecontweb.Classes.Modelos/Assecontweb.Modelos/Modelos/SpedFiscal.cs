using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using Wr.Classes;

namespace Assecontweb.Modelos
{
    public class SpedFiscal
    {
        #region Struct's Bloco 0
        struct AberturaIndetficacao //0000
        {
            public int registro;
            public string versao;
            public bool finalidade; // 0 - Remessa do arquivo original; 1 - Remessa do arquivo substituto.
            public DateTime dataInicial;
            public DateTime dataFinal;
            public string razaoSocial;
            public string cnpj;
            public string cpf;
            public string uf;
            public string ie;
            public string cod_municipal;
            public string im;
            public string suframa;
            public char perfil; //A – Perfil A; B – Perfil B.; C – Perfil C.
            public bool atividade; //0 – Industrial ou equiparado a industrial; 1 – Outros.

        }

        struct AberturaBloco0 //0001
        {
            public int registro;
            public bool movimento; //0- Bloco com dados informados; 1- Bloco sem dados informados.
        }

        struct DadosComplementaresEntidade //0005
        {
            public int registro;
            public string nomefantasia;
            public string cep;
            public string endereco;
            public int numero;
            public string end_complemento;
            public string bairro;
            public string telefone; //ddd+fone
            public string fax;
            public string email;
        }

        struct DadosContribuinteSubstituto //0015
        {
            public int registro;
            public string uf;
            public string ie;
        }

        struct DadosDoContabilista //0100
        {
            public int registro;
            public string nome;
            public string cpf;
            public string crc;
            public string cnpj;
            public string cep;
            public string endereco;
            public int numero;
            public string complemento;
            public string bairro;
            public string telefone;
            public string fax;
            public string email;
            public string cod_municipal;
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
            public string suframa;
            public string endereco;
            public string numero; //teve um que apareceu 76b
            public string complemento;
            public string bairro;
        }

        struct AlteracaoCadastroParticipante //0175
        {
            public int registro;
            public DateTime dataAlteracao;
            public string campo; //exceto 07)
            public string conteudoAnterior;
        }

        struct IdentificacaoUnidadesMedida //0190
        {
            public int registro;
            public string cod_unidade;
            public string descricao;
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
            public string EX_IPI;
            public string cod_gen;
            public Single cod_list;
            public int aliquota;
        }

        struct AlteracaoItem //0205
        {
            public int registro;
            public string descricao;
            public DateTime dataInicial;
            public DateTime dataFinal;
            public int cod_anterior;
        }

        struct CodigoProdutoAnp //0206
        {
            public int registro;
            public int cod_combustivel;
        }

        struct ConsumoPadronizado //0210
        {
            public int registro;
            public int cod_item_componente;
            public int qtd_componente;
            public int perda;
        }

        struct FatoresConversaoUnidades //0220
        {
            public int registro;
            public string unidade_comercial;
            public int fator_conversao;
        }

        struct CadastroBensImobilizado //0300
        {
            public int registro;
            public int cod_individual;
            public int tipo_mercadoria; //1 = bem; 2 = componente.
            public string descricao;
            public string cod_principal;
            public string cod_cta;
            public int parcelas;
        }

        struct UtilizacaoBem //0305
        {
            public int registro;
            public int cod_ccus;
            public string func;
            public string vidaUtil;
        }

        struct NaturezaOperacaoPrestacao //0400
        {
            public int registro;
            public int cod_natureza;
            public string descricao;
        }

        struct ComplementarDocumentoFiscal //0450
        {
            public int registro;
            public int cod_complementar_fiscal;
            public string txt;
        }

        struct LancamentoFiscal //0460
        {
            public int registro;
            public int cod_observacao;
            public string txt;
        }

        struct ContasContabeis //0500
        {
            public int registro;
            public DateTime data_include_edit;
            public int cod_natureza;
            /*  01 - Contas de ativo;
                02 - Contas de passivo;
                03 - Patrimônio líquido;
                04 - Contas de resultado;
                05 - Contas de compensação;
                09 - Outras   */
            public char tipo_conta; /* S - Sintética (grupo de contas); A - Analítica (conta). */
            public string nivel;
            public int cod_conta;
            public string nome_conta;
        }

        struct CentroCusto //0600
        {
            public int registro;
            public DateTime data_include_edit;
            public int cod_custo;
            public string nome_centro_custo;
        }

        struct EncerramentoBloco0 //0999
        {
            public int registro;
            public int qtdLinha;
        }
        #endregion

        #region Struct's Bloco C DOCUMENTOS FISCAIS I - MERCADORIAS (ICMS/IPI)
        struct AberturaBlocoC //C001
        {
            public string registro;
            public bool movimento; //0- Bloco com dados informados; 1- Bloco sem dados informados.
        }

        struct NotaFiscal //C100
        {
            public string registro;
            public bool operacao; //0- Entrada; 1- Saída;
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
            public Single Abatimento;
            public Single mercadorias;
            public int tipo_frente; /* 0- Por conta do emitente; 1- Por conta do destinatário/remetente; Por conta de terceiros; 9- Sem cobrança de frete.*/
            public Single frente;
            public Single seguro;
            public Single outras_despesas;
            public Single base_calculo;
            public Single icms;
            public Single icms_retido;
            public Single ipi;
            public Single pis;
            public Single confis;
            public Single pis_retido;
            public Single confis_retido;
            //List<Object> listaItem();
        }

        struct OperacaoICMSrecolhido //C105
        {
            public string registro;
            public bool operacao; //0- Combustíveis e Lubrificantes; 1- leasing de veículos ou faturamento direto.
            public string uf_destino; //Sigla da UF de destino do ICMS_ST 
        }

        struct ComplementarNotaFiscal //C110
        {
            public string registro;
            public int cod_info;
            public string desccricao;
        }

        struct ProcessoReferenciado //C111
        {
            public string registro;
            public int processo;
            public int processo_original;
            /*  0 - SEFAZ;
                1 - Justiça Federal;
                2 - Justiça Estadual;
                3 - SECEX/SRF
                9 - Outros.*/
        }

        struct DocumentoArrecadacaoReferenciado //C112
        {
            public string registro;
            public int cod_modelo; //0 - documento estadual de arrecadação; 1 – GNRE
            public string uf;
            public string numDocumento;
            public int cod_autenticacao;
            public Single valorTotal;
            public DateTime data_vencimento;
            public DateTime data_pagamento;
        }

        struct DocumentoFiscalReferenciado //C113
        {
            public string registro;
            public int cod_operacao; //0- Entrada/aquisição; 1- Saída/prestação
            public int indicador_emitente; //0- Emissão própria; 1- Terceiros
            public int cod_participante;
            public int cod_documento;
            public string serie;
            public string subSerie;
            public string numDocumento;
            public DateTime emissao;
        }

        struct CumpoFiscalReferenciado //C114
        {
            public string registro;
            public int cod_modelo;
            public string serieECF;
            public string caixaECF;
            public string numDocumento;
            public DateTime emissao;
        }

        struct LocalColetaEntrega //C115
        {
            public string registro;
            public int transporte;
            /* 0 – Rodoviário; 1 – Ferroviário; 
             * 2 – Rodo-Ferroviário; 3 – Aquaviário;
             * 4 – Dutoviário; 5 – Aéreo; 9 – Outros. */
            public string cnpj_coleta;
            public string ie_coleta;
            public string cpf_coleta;
            public int cod_municipal_coleta;
            public string cnpj_entrega;
            public string ie_entrega;
            public string cpf_entrega;
            public int cod_municipal_entrega;
        }

        struct CupomFiscalEletronico //C116
        {
            public string registro;
            public int cod_modelo;
            public string serieEquipamentoSAT;
            public string chave;
            public string numCupom;
            public DateTime emissao;
        }

        struct ComplementoDocumento //C120
        {
            public string registro;
            public int cod_importacao; //0 – Declaração de Importação; 1 – Declaração Simplificada de Importação.
            public string numDocumento;
            public Single pis;
            public Single confis;
            public string numDrawback;
        }

        struct IrrfPrevidenciaSocial //C130
        {
            public string registro;
            public int cod_importacao;
            public Single servico;
            public Single base_ISSQN;
            public Single ISSQN;
            public Single base_irrf;
            public Single irrf;
            public Single base_previdencia;
            public Single previdencia;
        }

        struct Fatura //C140
        {
            public string registro;
            public int cod_emitente; // 0- Emissão própria; 1- Terceiros
            public int tipo_titular;
            /*  00- Duplicata;
                01- Cheque; 
                02- Promissória;
                03- Recibo;
                99- Outros (descrever)  */
            public string descricao_titular;
            public int numTitular;
            public int parcela;
            public Single valorTotal;
        }

        struct VencimentoFatura //C141
        {
            public string registro;
            public int numParcela;
            public DateTime dataVencimento;
            public Single valorParcela;
        }

        struct volumesTransporte //C160
        {
            public string registro;
            public int cod_participante;
            public string placa;
            public int qtdVolume;
            public Single pesoBrutoVolume;
            public Single pesoLiquidoVolume;
            public string uf;
        }

        struct OperacaoCombustivel //C165
        {
            public string registro;
            public int cod_participante;
            public string placa;
            public int cod_SEFAZ;
            public int passeFiscal;
            public DateTime horaSaida;
            public string temperatura;
            public int qtdVolume;
            public Single pesoBrutoVolume;
            public Single pesoLiquidoVolume;
            public string cpfMotorista;
            public string uf;
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
            public bool movimentacaofisica; //0. SIM 1. NÃO
            public int cod_icms;
            public int cod_ceop;
            public int cod_natureza;
            public Single VL_BC_ICMS;
            public Single ALIQ_ICMS;
            public Single VL_ICMS;
            public Single VL_BC_ICMS_ST;
            public int ALIQ_ST;
            public Single VL_ICMS_ST;
            public string IND_APUR;
            public string CST_IPI;
            public string COD_ENQ;
            public Single VL_BC_IPI;
            public int ALIQ_IPI;
            public Single VL_IPI;
            public string CST_PIS;
            public Single VL_BC_PIS;
            public int ALIQ_PIS_PORCT;
            public int QUANT_BC_PIS;
            public Single ALIQ_PIS_REAIS;
            public Single VL_PIS;
            public int CST_COFINS;
            public Single VL_BC_COFINS;
            public int ALIQ_COFINS_PORC;
            public int QUANT_BC_COFINS;
            public Single ALIQ_COFINS_REAIS;
            public Single VL_COFINS;
            public string COD_CTA;
            public List<Object> itens;
        }

        struct OperacoesIssqn //C172
        {
            public string registro;
            public Single baceISSQN;
            public string aliquota;
            public Single valorISSQN;
        }

        struct OperacoesMedicamentos //C173
        {
            public string registro;
            public string numLote;
            public int qtdItem;
            public DateTime dataFabricacao;
            public DateTime dataValidade;
            public int referencia; /*0- Base de cálculo referente ao preço tabelado ou preço máximo sugerido;
                1- Base cálculo – Margem de valor agregado;
                2- Base de cálculo referente à Lista Negativa;
                3- Base de cálculo referente à Lista Positiva;
                4- Base de cálculo referente à Lista Neutra*/
            public int tipoProduto; //0- Similar; 1- Genérico; 2- Ético ou de marca;
            public Single valor; //valor tabelado
        }

        struct OperacoesArmasFogos //C175
        {
            public string registro;
            public int tipo; //0- Uso permitido; 1- Uso restrito
            public string numeracao;
            public string descricao;
        }

        struct OperacoesVeiculosNovos //C175
        {
            public string registro;
            public int tipo;
            /*  0- Venda para concessionária;
                1- Faturamento direto;
                2- Venda direta;
                3- Venda da concessionária;
                9- Outros */
            public string cnpj_concessionaria;
            public string uf_concessionaria;
            public string chassi;
        }

        struct RessarcimentoIcms //C176
        {
            public string registro;
            public int cod_modelo;
            public string numDocumento;
            public string serieDocumento;
            public DateTime ultimaEntrada;
            public int cod_participante;
            public int qtd_item;
            public Single valorUnitario;
            public Single baseValorUnitario;
        }

        struct EncerramentoBlocoC //C177
        {
            public string registro;
            public int cod_selo;
            public int qtd_selo;
        }

        struct ProdutosSujeitosTributacao //C178
        {
            public string registro;
            public int cod_ipi;
            public Single valorUnitario;
            public int qtdProdutos;
        }

        struct InformacoesComplementares //C179
        {
            public string registro;
            public Single valorBaseCalculo;
            public Single valorIcmsST;
            public Single valorIcmsSTComplementar;
            public Single valorBc;
            public Single valorParcela;
        }

        struct RegistroAnaliticoDocumento //C190
        {
            public string registro;
            public int cod_icms;
            public int ceop;
            public string aliquotaIcms;
            public Single valorOperacao;
            public Single valorbaseIcms;
            public Single valorIcms;
            public Single valorbaseIcmsSt;
            public Single valorIcmsSt;
            public Single valorReducaoIcms;
            public Single valorIpi;
            public string cod_obs; //(campo 02 do Registro 0460)
        }

        struct ObservacoesLancamentoFiscal //C195
        {
            public string registro;
            public int cod_obs; //(campo02 do Registro 0460)
            public string descricao;
        }

        struct OutrasObrigacoesTributarias //C197
        {
            public string registro;
            public int cod_ajuste;
            public string descricao;
            public int cod_item; // Código do item (campo 02 do Registro 0200)
            public Single valorbaseIcms;
            public string aliquota;
            public Single valorIcms;
            public Single outrosValores;
        }

        struct ResumoNotasFiscais //C300
        {
            public string registro;
            public int cod_modelo;
            public string serieDocumento;
            public string numDocumentoInicial;
            public string numDocumentoFinal;
            public DateTime emissao;
            public Single valorTotal;
            public Single valorPis;
            public Single valorConfins;
            public int cod_contabil;
        }

        struct CanceladosNotasFiscais //C310
        {
            public string registro;
            public string numDocumento;
        }

        struct EncerramentoBloco9 //9990
        {
            public string registro;
            public int qtdLinha;
        }
        #endregion

        #region struct Campo
        struct Campo
        {
            public int Inicio;
            public int Tamanho;
        }
        #endregion

        private BD bd;
        private string fileName;
        private bool publish;
        private List<IdentificacaoItem> listaItens;

        public SpedFiscal(BD bd, string fileName, bool publish)
        {
            this.bd = bd;
            this.fileName = fileName;
            this.publish = publish;
            this.listaItens = new List<IdentificacaoItem>();
            lerArquivo();
        }

        private void lerArquivo()
        {
            List<string> Arquivo = new List<string>();
            List<CadastroParticipante> listaParticipante = new List<CadastroParticipante>();

            AberturaIndetficacao Cliente = new AberturaIndetficacao();
            List<Object> listaNotaFiscal = new List<Object>();
            StreamReader reader = new StreamReader(fileName, Encoding.ASCII);

            string aux = string.Empty;
            while ((aux = reader.ReadLine()) != null)
            {
                Arquivo.Add(aux);
            }

            if ((publish == false) && !Arquivo[0].Contains("|0000|"))
            {
                throw new Exception("Formato do Anexo Incorreto");
            }

            #region Leitura do Arquivo
            //while ((aux = reader.ReadLine()) != null)
            for (int i = 0; i < Arquivo.Count; i++)
            {
                string[] linha = Arquivo[i].Split('|');

                if (linha[1] == "0000")
                {
                    Cliente = (AberturaIndetficacao)metodAberturaIndetficacao(linha);
                }

                if (linha[1] == "0001")
                {
                    if (ConvertBool(linha[3]))
                        throw new Exception("Bloco 0 - Entidade sem dados informados.");
                }

                //if (linha[1] == "0005")
                //{
                //listaSped.Add(metodDadosComplementaresEntidade(linha));
                //}

                //if (linha[1] == "0100")
                //{
                //    listaSped.Add(metodDadosDoContabilista(linha));
                //}

                if (linha[1] == "0150")
                {
                    listaParticipante.Add((CadastroParticipante)metodCadastroParticipante(linha));
                }

                //if (linha[1] == "0190")
                //{
                //listaSped.Add(metodIdentificacaoUnidadesMedida(linha));
                //}

                if (linha[1] == "0200")
                {
                    listaItens.Add((IdentificacaoItem)metodIdentificacaoItem(linha));
                }

                if (linha[1] == "C001")
                {
                    if (ConvertBool(linha[3]))
                        throw new Exception("Bloco C - Mercadoria sem dados informados.");
                }

                if (linha[1] == "C100")
                {
                    listaNotaFiscal.Add(metodNotaFiscal(linha));
                }

                if (linha[1] == "C170")
                {
                    listaNotaFiscal.Add(metodItensDocumento(linha));
                }

                //if (linha[1] == "C190")
                //{
                //    listaNotaFiscal.Add(metodRegistroAnaliticoDocumento(linha));
                //}

                if (linha[1] == "9999")
                    break;
            }
            #endregion

            bd.openConnection();
            int indCliente = VerificarCliente(Cliente);
            if (indCliente != 0)
            {
                salvarParticipantes(listaParticipante);
                vodNotaFiscal(listaNotaFiscal, indCliente);
            }
            bd.closeConnection();
        }

     
        public void vodNotaFiscal(List<Object> listaNotaFiscal, int idCliente)
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

        int VerificarCliente(AberturaIndetficacao Cliente)
        {
            string query = "SELECT CLI_IND FROM Clientes WHERE CLI_CNPJ = '{0}' OR CLI_CPF = '{1}'";

            return bd.getFieldValueInteger(string.Format(query, Cliente.cnpj, Cliente.cpf));
        }

        #region Banco
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
            cmd.Parameters.AddWithValue("@P_ENTRADA_SAIDA", Nota.operacao);
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

        void salvarParticipantes(List<CadastroParticipante> listaParticipante)
        {
            foreach (CadastroParticipante part in listaParticipante)
            {
                SqlCommand cmd = new SqlCommand("importacao_sped_participante", bd.Conn);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@P_CODIGO", part.cod_identificacao);
                cmd.Parameters.AddWithValue("@P_NOME", Wr.Classes.Strings.capitalizeWords(part.nome));
                cmd.Parameters.AddWithValue("@P_COD_PAIS", part.cod_pais);
                if (part.cnpj != "") cmd.Parameters.AddWithValue("@P_CNPJ", part.cnpj);
                if (part.cpf != "") cmd.Parameters.AddWithValue("@P_CPF", part.cpf);
                cmd.Parameters.AddWithValue("@P_IE", part.ie);
                cmd.Parameters.AddWithValue("@P_COD_MUN", part.cod_municipal);
                if (part.suframa != "") cmd.Parameters.AddWithValue("@P_SUFRAMA", part.suframa);
                cmd.Parameters.AddWithValue("@P_LOGRADOURO", part.endereco);
                cmd.Parameters.AddWithValue("@P_NUMERO", part.numero);
                if (part.complemento != "") cmd.Parameters.AddWithValue("@P_COMPLEMENTO", part.complemento);
                cmd.Parameters.AddWithValue("@P_BAIRRO", part.bairro);

                //SqlParameter parameter_result = cmd.Parameters.Add("@RESULT", SqlDbType.Int);
                //parameter_result.Direction = ParameterDirection.ReturnValue;

                cmd.ExecuteNonQuery();
            }
        }
        #endregion

        IdentificacaoItem relacionarProdutoItem(itensDocumento Item)
        {
            foreach (IdentificacaoItem Identificacao in listaItens)
            {
                if (Identificacao.cod_item == Item.cod_item)
                    return Identificacao;
            }

            return new IdentificacaoItem();
        }

        #region metodos dos Itens do SpedFIscal
        public Object metodRegistroAnaliticoDocumento(string[] linha) //C190
        {
            RegistroAnaliticoDocumento param = new RegistroAnaliticoDocumento();

            for (int j = 1; j < linha.Length; j++)
            {
                param.registro = linha[j++];
                param.cod_icms = Convert.ToInt32(linha[j++]);
                param.ceop = Convert.ToInt32(linha[j++]);
                param.aliquotaIcms = linha[j++];
                param.valorOperacao = Convert.ToSingle(linha[j++]);
                param.valorbaseIcms = Convert.ToSingle(linha[j++]);
                param.valorIcms = Convert.ToSingle(linha[j++]);
                param.valorbaseIcmsSt = Convert.ToSingle(linha[j++]);
                param.valorIcmsSt = Convert.ToSingle(linha[j++]);
                param.valorReducaoIcms = Convert.ToSingle(linha[j++]);
                param.valorIpi = Convert.ToSingle(linha[j++]);
                param.cod_obs = linha[j++]; //(campo 02 do Registro 0460)
            }

            return param;
        }

        public Object metodItensDocumento(string[] linha) //C170
        {
            itensDocumento param = new itensDocumento();

            for (int j = 1; j < linha.Length; j++)
            {
                param.registro = linha[j++];
                param.num_item = Convert.ToInt32(linha[j++]);
                param.cod_item = linha[j++];  // (campo 02 do Registro 0200)
                param.descricao = linha[j++];
                param.qtdItem = Convert.ToInt32(linha[j++]);
                param.unidade = linha[j++];  //(Campo 02 do registro 0190)
                param.valorItem = Convert.ToSingle(linha[j++]);
                param.valorDesconto = Convert.ToSingle(linha[j++]);
                break;
                //param.movimentacaofisica = ConvertBool(linha[j++]);  //0. SIM 1. NÃO
                //param.cod_icms = Convert.ToInt32(linha[j++]);
                //param.cod_ceop = Convert.ToInt32(linha[j++]);
                //param.cod_natureza = Convert.ToInt32(linha[j++]);
                //param.VL_BC_ICMS = Convert.ToSingle(linha[j++]);
                //param.ALIQ_ICMS = Convert.ToSingle(linha[j++]);
                //param.VL_ICMS = Convert.ToSingle(linha[j++]);
                //param.VL_BC_ICMS_ST = Convert.ToSingle(linha[j++]);
                //param.ALIQ_ST = Convert.ToInt32(linha[j++]);
                //param.VL_ICMS_ST = Convert.ToSingle(linha[j++]);
                //param.IND_APUR = linha[j++];
                //param.CST_IPI = linha[j++];
                //param.COD_ENQ = linha[j++];
                //param.VL_BC_IPI = Convert.ToSingle(linha[j++]);
                //param.ALIQ_IPI = Convert.ToInt32(linha[j++]);
                //param.VL_IPI = Convert.ToSingle(linha[j++]);
                //param.CST_PIS = linha[j++];
                //param.VL_BC_PIS = Convert.ToSingle(linha[j++]);
                //param.ALIQ_PIS_PORCT = Convert.ToInt32(linha[j++]);
                //param.QUANT_BC_PIS = Convert.ToInt32(linha[j++]);
                //param.ALIQ_PIS_REAIS = Convert.ToSingle(linha[j++]);
                //param.VL_PIS = Convert.ToSingle(linha[j++]);
                //param.CST_COFINS = Convert.ToInt32(linha[j++]);
                //param.VL_BC_COFINS = Convert.ToSingle(linha[j++]);
                //param.ALIQ_COFINS_PORC = Convert.ToInt32(linha[j++]);
                //param.QUANT_BC_COFINS = Convert.ToInt32(linha[j++]);
                //param.ALIQ_COFINS_REAIS = Convert.ToSingle(linha[j++]);
                //param.VL_COFINS = Convert.ToSingle(linha[j++]);
                //param.COD_CTA = linha[j++];
            }

            return param;
        }

        public Object metodNotaFiscal(string[] linha) //C100
        {
            NotaFiscal param = new NotaFiscal();

            for (int j = 1; j < linha.Length; j++)
            {
                param.registro = linha[j++];
                param.operacao = ConvertBool(linha[j++]);
                param.emitente = ConvertBool(linha[j++]);
                param.cod_participante = linha[j++];
                param.cod_modelo = Convert.ToInt32(linha[j++]);
                param.cod_situacao = Convert.ToInt32(linha[j++]);
                param.serie = linha[j] == "" ? 0 : Convert.ToInt32(linha[j]);
                j++;
                param.NumDoc = linha[j] == "" ? 0 : Convert.ToInt32(linha[j]);
                j++;
                param.chave_NFE = linha[j++];
                if (linha[j] != "")
                    param.dataEmissao = ConvertDate(linha[j++]);
                else
                    break;
                param.dataEntrada_saida = ConvertDate(linha[j++]);
                param.valorTotal = Convert.ToSingle(linha[j++]);
                param.tipoPagamento = Convert.ToInt32(linha[j++]); //tipo 
                string x = linha[j++];
                param.desconto = x == "" ? 0 : Convert.ToSingle(linha[j]);
                param.Abatimento = Convert.ToSingle(linha[j++]);
                param.mercadorias = Convert.ToSingle(linha[j++]);
                param.tipo_frente = Convert.ToInt32(linha[j++]);
                param.frente = Convert.ToSingle(linha[j++]);
                param.seguro = Convert.ToSingle(linha[j++]);
                param.outras_despesas = Convert.ToSingle(linha[j++]);
                param.base_calculo = Convert.ToSingle(linha[j++]);
                param.icms = Convert.ToSingle(linha[j++]);
                param.icms_retido = Convert.ToSingle(linha[j++]);
                param.ipi = Convert.ToSingle(linha[j++]);
                param.pis = Convert.ToSingle(linha[j++]);
                param.confis = Convert.ToSingle(linha[j++]);
                param.pis_retido = Convert.ToSingle(linha[j++]);
                param.confis_retido = Convert.ToSingle(linha[j++]);
                break;
            }

            return param;
        }

        public Object metodIdentificacaoItem(string[] linha) //0200
        {
            IdentificacaoItem param = new IdentificacaoItem();

            for (int j = 1; j < linha.Length; j++)
            {
                param.registro = Convert.ToInt32(linha[j++]);
                param.cod_item = linha[j++];
                param.descricao = linha[j++];
                param.cod_barra_alfanumerico = linha[j++];
                param.cod_naterior = linha[j++];
                param.quantificacao_estoque = linha[j++];
                param.tipo_item = Convert.ToInt32(linha[j++]);
                param.cod_ncm = linha[j++];
                param.EX_IPI = linha[j++];
                param.cod_gen = linha[j++];
                j++;
                param.cod_list = Convert.ToSingle(linha[j++]);
                //param.aliquota = Convert.ToInt32(linha[j++]);
            }

            return param;
        }

        //public Object metodIdentificacaoUnidadesMedida(string[] linha)
        //{
        //    IdentificacaoUnidadesMedida param = new IdentificacaoUnidadesMedida();

        //    for (int j = 1; j < linha.Length; j++)
        //    {
        //        param.registro = Convert.ToInt32(linha[j++]);
        //        param.cod_unidade = linha[j++];
        //        param.descricao = linha[j++];
        //    }

        //    return param;
        //}

        public Object metodDadosDoContabilista(string[] linha)
        {
            DadosDoContabilista param = new DadosDoContabilista();

            for (int j = 1; j < linha.Length; j++)
            {
                param.registro = Convert.ToInt32(linha[j++]);
                param.nome = linha[j++];
                param.cpf = linha[j++];
                param.crc = linha[j++];
                param.cnpj = linha[j++];
                param.cep = linha[j++];
                param.endereco = linha[j++];
                param.numero = Convert.ToInt32(linha[j++]);
                param.complemento = linha[j++];
                param.bairro = linha[j++];
                param.telefone = linha[j++];
                param.fax = linha[j++];
                param.email = linha[j++];
                param.cod_municipal = linha[j++];
            }

            return param;
        }

        public Object metodCadastroParticipante(string[] linha)
        {
            CadastroParticipante param = new CadastroParticipante();

            for (int j = 1; j < linha.Length; j++)
            {
                param.registro = Convert.ToInt32(linha[j++]);
                param.cod_identificacao = linha[j++];
                param.nome = linha[j++];
                param.cod_pais = Convert.ToInt32(linha[j++]);
                param.cnpj = linha[j++];
                param.cpf = linha[j++];
                param.ie = linha[j++];
                param.cod_municipal = linha[j++];
                param.suframa = linha[j++];
                param.endereco = linha[j++];
                param.numero = linha[j++];
                param.complemento = linha[j++];
                param.bairro = linha[j++];
            }

            return param;
        }


        //public Object metodDadosComplementaresEntidade(string[] linha)
        //{
        //    DadosComplementaresEntidade param = new DadosComplementaresEntidade();

        //    for (int j = 1; j < linha.Length; j++)
        //    {
        //        param.registro = Convert.ToInt32(linha[j++]);
        //        param.nomefantasia = linha[j++];
        //        param.cep = linha[j++];
        //        param.endereco = linha[j++];
        //        param.numero = Convert.ToInt32(linha[j++]);
        //        param.end_complemento = linha[j++];
        //        param.bairro = linha[j++];
        //        param.telefone = linha[j++];
        //        param.fax = linha[j++];
        //        param.email = linha[j++];
        //    }

        //    return param;
        //}

        public Object metodAberturaIndetficacao(string[] linha)
        {
            AberturaIndetficacao param = new AberturaIndetficacao();

            for (int j = 1; j < linha.Length; j++)
            {
                param.registro = Convert.ToInt32(linha[j++]);
                param.versao = linha[j++];
                param.finalidade = ConvertBool(linha[j++]); // 0 - Remessa do arquivo original; 1 - Remessa do arquivo substituto.
                param.dataInicial = ConvertDate(linha[j++]);
                param.dataFinal = ConvertDate(linha[j++]);
                param.razaoSocial = linha[j++];
                param.cnpj = linha[j++];
                param.cpf = linha[j++];
                param.uf = linha[j++];
                param.ie = linha[j++];
                param.cod_municipal = linha[j++];
                param.im = linha[j++];
                param.suframa = linha[j++];
                param.perfil = Convert.ToChar(linha[j++]); //A – Perfil A; B – Perfil B.; C – Perfil C.
                param.atividade = ConvertBool(linha[j++]); //0 – Industrial ou equiparado a industrial; 1 – Outros.
            }

            return param;
        }
        #endregion

        #region util
        public bool ConvertBool(string bit)
        {
            if (bit != "")
            {
                if (Convert.ToInt32(bit) == 1)
                    return true;
            }

            return false;
        }

        public DateTime ConvertDate(string data)
        {
            //if (data != "")
            //{
            return Convert.ToDateTime(data.Substring(0, 2) + "/" + data.Substring(2, 2) + "/" + data.Substring(4, 4));
            //}

            //return DateTime.Parse("");
        }
        #endregion
    }
}
