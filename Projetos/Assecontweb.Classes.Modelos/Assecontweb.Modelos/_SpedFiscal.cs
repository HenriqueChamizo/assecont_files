using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using Wr.Classes;

namespace Assecontweb
{
    public class _SpedFiscal
    {
        #region Struct's Bloco 0
        struct AberturaIndentificacao //0000
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

        private BD bd;
        private string fileName;
        private bool publish;
        private List<IdentificacaoItem> listaItens;

        public _SpedFiscal(BD bd, string fileName, int obrigacaoArquivo, bool publish)
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

            AberturaIndentificacao Cliente = new AberturaIndentificacao();
            List<Object> listaNotaFiscal = new List<Object>();
            //StreamReader reader = new StreamReader(fileName, Encoding.ASCII);

            //Global.Cultura();

            //string aux = string.Empty;
            //while ((aux = reader.ReadLine()) != null)
            //{
            //    Arquivo.Add(aux);
            //}

            Wr.Classes.Files.ReadFile(fileName, Arquivo);

            if (!publish && !Arquivo[0].Contains("|0000|"))
            {
                throw new Exception("Formato do Anexo Incorreto");
            }

            #region Leitura do Arquivo
            for (int i = 0; i < Arquivo.Count; i++)
            {
                string[] linha = Arquivo[i].Split('|');

                if (linha[1] == "0000")
                {
                    Cliente = (AberturaIndentificacao)metodAberturaIndetficacao(linha);
                }

                if (linha[1] == "0001")
                {
                    if (ConvertBool(linha[3]))
                        throw new Exception("Bloco 0 - Entidade sem dados informados.");
                }

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
                    try
                    {
                        listaNotaFiscal.Add(metodItensDocumento(linha));
                    }
                    catch (Exception ex)
                    {

                    }
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
            if (indCliente != 0 && publish)
            {
                salvarParticipantes(listaParticipante, indCliente);
                vodNotaFiscal(listaNotaFiscal, indCliente);
            }
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

        int VerificarCliente(AberturaIndentificacao Cliente)
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
                if (!string.IsNullOrEmpty(part.suframa)) cmd.Parameters.AddWithValue("@P_SUFRAMA", part.suframa);
                cmd.Parameters.AddWithValue("@P_LOGRADOURO", part.endereco);
                cmd.Parameters.AddWithValue("@P_NUMERO", part.numero);
                if (!string.IsNullOrEmpty(part.complemento)) cmd.Parameters.AddWithValue("@P_COMPLEMENTO", part.complemento);
                cmd.Parameters.AddWithValue("@P_BAIRRO", part.bairro);
                cmd.Parameters.AddWithValue("@P_EMPRESA", idCliente);

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
            int j = 1;

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

            return param;
        }

        public Object metodItensDocumento(string[] linha) //C170
        {
            itensDocumento param = new itensDocumento();
            int j = 1;

            param.registro = linha[j++];
            param.num_item = Convert.ToInt32(linha[j++]);
            param.cod_item = linha[j++];  // (campo 02 do Registro 0200)
            param.descricao = linha[j++];
            param.qtdItem = Convert.ToInt32(linha[j++]);
            param.unidade = linha[j++];  //(Campo 02 do registro 0190)
            param.valorItem = Convert.ToSingle(linha[j++]);
            param.valorDesconto = Convert.ToSingle(linha[j++]);

            return param;
        }

        public Object metodNotaFiscal(string[] linha) //C100
        {
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
            const int POS_ABATIMENTO = 15;
            const int POS_MERCADORIAS = 16;
            const int POS_TIPO_FRENTE = 17;
            const int POS_FRENTE = 18;
            const int POS_SEGURO = 19;
            const int POS_OUTRAS_DESPESAS = 20;
            const int POS_BASE_CALCULO = 21;
            const int POS_ICMS = 22;
            const int POS_ICMS_RETIDO = 24;
            const int POS_IPI = 25;
            const int POS_PIS = 26;
            const int POS_CONFIS = 27;
            const int POS_PIS_RETIDO = 28;
            const int POS_CONFIS_RETIDO = 29;

            NotaFiscal param = new NotaFiscal();

            param.registro = linha[POS_REGISTRO];
            param.operacao = ConvertBool(linha[POS_OPERACAO]);
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
            param.Abatimento = Convert.ToSingle(linha[POS_ABATIMENTO]);
            param.mercadorias = Convert.ToSingle(linha[POS_MERCADORIAS]);
            param.tipo_frente = Convert.ToInt32(linha[POS_TIPO_FRENTE]);
            param.frente = Convert.ToSingle(linha[POS_FRENTE]);
            param.seguro = Convert.ToSingle(linha[POS_SEGURO]);
            param.outras_despesas = Convert.ToSingle(linha[POS_OUTRAS_DESPESAS]);
            param.base_calculo = Convert.ToSingle(linha[POS_BASE_CALCULO]);
            param.icms = Convert.ToSingle(linha[POS_ICMS]);
            param.icms_retido = Convert.ToSingle(linha[POS_ICMS_RETIDO]);
            param.ipi = Convert.ToSingle(linha[POS_IPI]);
            param.pis = Convert.ToSingle(linha[POS_PIS]);
            param.confis = Convert.ToSingle(linha[POS_CONFIS]);
            param.pis_retido = Convert.ToSingle(linha[POS_PIS_RETIDO]);
            param.confis_retido = Convert.ToSingle(linha[POS_CONFIS_RETIDO]);

            return param;
        }

        public Object metodIdentificacaoItem(string[] linha) //0200
        {
            IdentificacaoItem param = new IdentificacaoItem();
            int j = 1;

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

            return param;
        }

        public Object metodDadosDoContabilista(string[] linha)
        {
            DadosDoContabilista param = new DadosDoContabilista();
            int j = 1;

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

            return param;
        }

        public Object metodCadastroParticipante(string[] linha)
        {
            CadastroParticipante param = new CadastroParticipante();
            int j = 1;

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

            return param;
        }

        public Object metodAberturaIndetficacao(string[] linha)
        {
            AberturaIndentificacao param = new AberturaIndentificacao();
            int j = 1;
            // for (int j = 1; j < linha.Length; j++)
            //{
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
