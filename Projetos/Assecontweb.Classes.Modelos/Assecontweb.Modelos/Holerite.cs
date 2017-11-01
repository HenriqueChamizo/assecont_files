using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Wr.Classes;

namespace Assecontweb
{
    namespace Modelos
    {
        public class Holerite
        {
            #region struct Funcionario
            struct Funcionario
            {
                public int ind;
                public string Nome;
                public string reg;
                public int Chapa;
                public int CBO;
                public int setorLocal;
                public DateTime admissao;
                //public int fir;
                public string cpf;
                //public string endereco;
                //public string identidade;
                //public string contaCorrente;
                //public string FGTS;
                //public int PIS;
                //public string CtpsUF;
                public string CnpjCpf;
                //public int Empresa_cpf; //Verifica se é cnpj ou cpf
                public List<Evento> FuncionarioEventos;
                public ResumoSalario FuncionarioResumo;
            }
            #endregion

            #region struct Evento
            struct Evento
            {
                public string codigo;
                public string descricao;
                public string referencia;
                public string vencimento;
                public string desconto;
            }
            #endregion

            #region struct ResumoSalario
            struct ResumoSalario
            {
                public string SalarioBase;
                public string SalContribuicao;
                public string TotalVencimentos;
                public string TotalDescontos;
                public string BaseFGTS;
                public string MesFGTS;
                public string BaseIR;
                public string Liquido;
                public DateTime Competencia;
                public string banco;
                public string frase;
                //public int Recibo;
                public string Conta;
                public string divisao;
                public string funcao;
                public string credito;
            }
            #endregion

            #region struct Campo
            struct Campo
            {
                public int Inicio;
                public int Tamanho;
            }
            #endregion

            BD bd;
            private bool publish;
            private bool provisorio;
            private string fileName;
            private List<Funcionario> ListaFuncionarios = new List<Funcionario>();
            private Types.Types.HoleritesTipos holeritetipo;
            private int ObrigacaoClientePeriodo;
            private Types.Types.ObrigacaoArquivoTipo ArquivoTipo;
            private int ObrigacaoArquivo;
            private bool ProcessarArquivo = false;
            private byte[] byteArquivo;

            #region Construtor LerArquivo
            public Holerite(BD bd, string fileName, Types.Types.HoleritesTipos holeritetipo, Types.Types.ObrigacaoArquivoTipo ArquivoTipo, int ObrigacaoClientePeriodo, int ObrigacaoArquivo, bool publish, bool provisorio, out int HoleriteInd)
            {
                this.bd = bd;
                this.publish = publish;
                this.provisorio = provisorio;
                this.holeritetipo = holeritetipo;
                this.fileName = fileName;
                this.ObrigacaoClientePeriodo = ObrigacaoClientePeriodo;
                this.ObrigacaoArquivo = ObrigacaoArquivo;
                this.ArquivoTipo = ArquivoTipo;

                try
                {
                    Global.Cultura();

                    //domestica = validarHoleriteDomestica();
                    HoleriteInd = LerArquivo();
                    if (publish && !provisorio) EnviarEmail(ObrigacaoClientePeriodo, holeritetipo);
                }
                catch (ArgumentOutOfRangeException ex)
                {
                    throw new System.ArgumentException("Arquivo .txt contem funcionarios sem CPF");
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
            #endregion

            #region Construtor Processar Arquivo
            public Holerite(BD bd, byte[] byteArquivo, Types.Types.HoleritesTipos holeritetipo, Types.Types.ObrigacaoArquivoTipo ArquivoTipo, int ObrigacaoClientePeriodo, int ObrigacaoArquivo, bool ProcessarArquivo)
            {
                this.bd = bd;
                this.publish = true;
                this.provisorio = false;
                this.ProcessarArquivo = ProcessarArquivo;
                this.holeritetipo = holeritetipo;
                this.byteArquivo = byteArquivo;
                this.ObrigacaoClientePeriodo = ObrigacaoClientePeriodo;
                this.ObrigacaoArquivo = ObrigacaoArquivo;
                this.ArquivoTipo = ArquivoTipo;

                Global.Cultura();
                LerArquivo();
            }
            #endregion

            private int LerArquivo()
            {
                #region Campos
                /*Funcionario*/
                const int divisao = 0;
                const int reg = 1;
                const int Chapa = 2;
                const int Nome = 3;
                const int CBO = 4;
                const int funcao = 5;
                const int setorLocal = 6;
                const int admissao = 7;
                const int fir = 8;
                const int cpf = 9;
                const int endereco = 10;
                const int identidade = 11;
                const int contaCorrente = 12;
                const int FGTS = 13;
                const int PIS = 14;
                const int CtpsUF = 15;
                /*Eventos*/
                const int codigo = 16;
                const int descricao = 17;
                const int referencia = 18;
                const int vencimento = 19;
                const int desconto = 20;
                const int Empresa = 21;
                /*Resumo*/
                const int SalarioBase = 22;
                const int SalContribuicao = 23;
                const int TotalVencimentos = 24;
                const int TotalDescontos = 25;
                const int BaseFGTS = 26;
                const int MesFGTS = 27;
                const int BaseIR = 28;
                const int Liquido = 29;
                const int Competencia = 30;
                const int banco = 31;
                const int Conta = 32;
                const int frase = 33;
                const int credito = 34;

                List<Campo> Campos = new List<Campo>()
            {
                new Campo() {Inicio = 46, Tamanho = 11}, // divisao
                new Campo() {Inicio = 1, Tamanho = 6}, // registro
                new Campo() {Inicio = 10, Tamanho = 20}, // Chapa
                new Campo() {Inicio = 7, Tamanho = 38}, // Nome
                new Campo() {Inicio = 10, Tamanho = 20}, // CBO
                new Campo() {Inicio = 46, Tamanho = 15}, // funcao
                new Campo() {Inicio = 10, Tamanho = 20}, // setorLocal
                new Campo() {Inicio = 10, Tamanho = 20}, // admissao
                new Campo() {Inicio = 10, Tamanho = 20}, // Dep.s.F/IR
                new Campo() {Inicio = 1, Tamanho = 12}, // cpf
                new Campo() {Inicio = 10, Tamanho = 20}, // endereco
                new Campo() {Inicio = 10, Tamanho = 20}, // identidade
                new Campo() {Inicio = 10, Tamanho = 20}, // contaCorrente
                new Campo() {Inicio = 10, Tamanho = 20}, // FGTS
                new Campo() {Inicio = 10, Tamanho = 20}, // PIS
                new Campo() {Inicio = 10, Tamanho = 20}, // CtpsUF
              
                new Campo() {Inicio = 1, Tamanho = 3}, // codigo
                new Campo() {Inicio = 6, Tamanho = 21}, // descricao
                new Campo() {Inicio = 28, Tamanho = 6}, // referencia
                new Campo() {Inicio = 40, Tamanho = 9}, // vencimento
                new Campo() {Inicio = 56, Tamanho = 9}, // desconto
                new Campo() {Inicio = 6, Tamanho = 18}, // Empresa - CNPJ

                new Campo() {Inicio = 14, Tamanho = 9}, // SalarioBase
                new Campo() {Inicio = 26, Tamanho = 9}, // SalContribuicao
                new Campo() {Inicio = 41, Tamanho = 9}, // TotalVencimentos
                new Campo() {Inicio = 57, Tamanho = 9}, // TotalDescontos
                new Campo() {Inicio = 2, Tamanho = 9}, // BaseFGTS
                new Campo() {Inicio = 14, Tamanho = 9}, // MesFGTS
                new Campo() {Inicio = 26, Tamanho = 9}, // BaseIR
                new Campo() {Inicio = 55, Tamanho = 10}, // Liquido
                new Campo() {Inicio = 46, Tamanho = 11}, // Competencia
                new Campo() {Inicio = 2, Tamanho = 9}, // banco
                new Campo() {Inicio = 34, Tamanho = 10}, // Conta-corrente
                new Campo() {Inicio = 2, Tamanho = 63}, // FRASE
                new Campo() {Inicio = 46, Tamanho = 11}, // credito
            };
                #endregion

                int contadorLinha = 0;
                int pular = 0;
                int Result = 0;

                List<string> Arquivo = new List<string>();
                Funcionario Func = new Funcionario();
                Func.FuncionarioEventos = new List<Evento>();

                if (!ProcessarArquivo)
                    Wr.Classes.Files.ReadFile(fileName, Arquivo, 1252);
                else
                {
                    Arquivo = Global.ByteToListString_Txt(byteArquivo);
                }

                try
                {
                    if (Arquivo.Count == 0)
                        throw new Exception("Arquivo em branco");

                    #region LendoArquivo
                    foreach (string Linha in Arquivo)
                    {
                        contadorLinha++;
                        if (Linha != "" && Linha != "\r\n")
                        {
                            if (contadorLinha == 1 + pular)
                            {
                                Func = new Funcionario();
                                Func.FuncionarioEventos = new List<Evento>();
                            }

                            if (contadorLinha == 4 + pular)
                            {
                                if (Linha.Substring(1, 6) != "RECIBO")
                                {
                                    throw new Exception("Formato do arquivo incorreto");
                                }

                                Func.FuncionarioResumo.Competencia = Convert.ToDateTime(Linha.Substring(Campos[Competencia].Inicio, Campos[Competencia].Tamanho));
                            }

                            if (contadorLinha == 6 + pular)
                            {
                                Func.FuncionarioResumo.divisao = Linha.Substring(Campos[divisao].Inicio, Campos[divisao].Tamanho).Trim();
                            }

                            if (contadorLinha == 7 + pular)
                            {
                                Func.CnpjCpf = Linha.Substring(Campos[Empresa].Inicio, Campos[Empresa].Tamanho).Trim();
                            }

                            if (contadorLinha == 8 + pular)
                            {
                                Func.reg = Linha.Substring(Campos[reg].Inicio, Campos[reg].Tamanho).Trim();
                                Func.Nome = Linha.Substring(Campos[Nome].Inicio, Campos[Nome].Tamanho).Trim();
                                if (Linha.Length < 62)
                                {
                                    Func.FuncionarioResumo.funcao = Linha.Substring(Campos[funcao].Inicio, Linha.Length - 46).Trim();
                                }
                                else
                                    Func.FuncionarioResumo.funcao = Linha.Substring(Campos[funcao].Inicio, Campos[funcao].Tamanho).Trim();
                            }

                            if (contadorLinha == 9 + pular)
                            {
                                double numero = 0;
                                if (Linha.Trim() == "" && !(double.TryParse(Linha.Trim(), out numero)))
                                {
                                    pular++;
                                }
                                else
                                {
                                    Func.cpf = Linha.Substring(Campos[cpf].Inicio, Campos[cpf].Tamanho).Replace(".", "").Replace("-", "").Trim();

                                    if (!Validadores.ValidaCpf(Func.cpf))
                                        throw new Exception("CPF INVALIDO - Funcionario(a) " + Func.Nome);

                                    //if (domestica && !Validadores.ValidaPis(Func.cpf))
                                    //    throw new Exception("Holerite Domestica - PIS INVALIDO  - Funcionario(a) " + Func.Nome);
                                }
                            }

                            if (contadorLinha >= 10 + pular && contadorLinha <= 27 + pular)
                            {
                                Evento eventos = new Evento();
                                if (Linha.Substring(Campos[referencia].Inicio, Campos[referencia].Tamanho) != " ")
                                {
                                    eventos.referencia = Linha.Substring(Campos[referencia].Inicio, Campos[referencia].Tamanho).Trim();
                                }
                                eventos.codigo = Linha.Substring(Campos[codigo].Inicio, Campos[codigo].Tamanho).Trim();
                                eventos.descricao = Linha.Substring(Campos[descricao].Inicio, Campos[descricao].Tamanho).Trim();
                                eventos.vencimento = Linha.Substring(Campos[vencimento].Inicio, Campos[vencimento].Tamanho).Trim();
                                eventos.desconto = Linha.Substring(Campos[desconto].Inicio, Campos[desconto].Tamanho).Trim();
                                Func.FuncionarioEventos.Add(eventos);
                            }

                            if (contadorLinha == 28 + pular)
                            {
                                Func.FuncionarioResumo.SalarioBase = Linha.Substring(Campos[SalarioBase].Inicio, Campos[SalarioBase].Tamanho).Trim();
                                Func.FuncionarioResumo.SalContribuicao = Linha.Substring(Campos[SalContribuicao].Inicio, Campos[SalContribuicao].Tamanho).Trim();
                                Func.FuncionarioResumo.TotalVencimentos = Linha.Substring(Campos[TotalVencimentos].Inicio, Campos[TotalVencimentos].Tamanho).Trim();
                                Func.FuncionarioResumo.TotalDescontos = Linha.Substring(Campos[TotalDescontos].Inicio, Campos[TotalDescontos].Tamanho).Trim();
                            }

                            if (contadorLinha == 30 + pular)
                            {
                                Func.FuncionarioResumo.BaseFGTS = Linha.Substring(Campos[BaseFGTS].Inicio, Campos[BaseFGTS].Tamanho).Trim();
                                Func.FuncionarioResumo.MesFGTS = Linha.Substring(Campos[MesFGTS].Inicio, Campos[MesFGTS].Tamanho).Trim();
                                Func.FuncionarioResumo.BaseIR = Linha.Substring(Campos[BaseIR].Inicio, Campos[BaseIR].Tamanho).Trim();
                                Func.FuncionarioResumo.Liquido = Linha.Substring(Campos[Liquido].Inicio, Campos[Liquido].Tamanho).Trim();
                            }

                            if (contadorLinha == 31 + pular)
                            {
                                Func.FuncionarioResumo.banco = Linha.Substring(Campos[banco].Inicio, Campos[banco].Tamanho).Trim();
                                Func.FuncionarioResumo.Conta = Linha.Substring(Campos[Conta].Inicio, Campos[Conta].Tamanho).Trim();
                                Func.FuncionarioResumo.credito = Linha.Length > 47 ? Linha.Substring(Campos[credito].Inicio, Campos[credito].Tamanho).Trim() : "";
                            }

                            if (contadorLinha == 32 + pular)
                            {
                                Func.FuncionarioResumo.frase = Linha.Substring(Campos[frase].Inicio, Campos[frase].Tamanho);
                            }

                            if (contadorLinha == 34 + pular)
                            {
                                contadorLinha = 0;
                                ListaFuncionarios.Add(Func);
                                pular = 0;
                            }
                        }
                    }
                    #endregion
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }

                if (!publish)
                {
                    VerificarHolerite(ListaFuncionarios[0]);
                }
                else
                {
                    Result = AtribuirBanco();
                }

                return Result;
            }

            private void BDAppNovo()
            {
                throw new System.ArgumentException("Erro");
            }

            #region GravarDadosSql
            private int AtribuirBanco()
            {
                try
                {
                    int cliente = getCliente(ListaFuncionarios[0].CnpjCpf);

                    setDemitidos(cliente);

                    if (ArquivoTipo != Types.Types.ObrigacaoArquivoTipo.Retificacao)
                    {
                        bd.executeCommand(string.Format("DELETE FROM HoleriteResumoSalario " +
                                "FROM Funcionarios WHERE FUNC_IND = SAL_FUNC AND FUNC_EMPRESA = {0} AND SAL_COMPETENCIA = '{1}' AND SAL_HOLERITE_TIPO = {2}", cliente, ListaFuncionarios[0].FuncionarioResumo.Competencia, (int)holeritetipo));

                        bd.executeCommand(string.Format("DELETE FROM HoleriteEventos " +
                                "FROM Funcionarios WHERE FUNC_IND = EVENT_FUNC AND FUNC_EMPRESA = {0} AND EVENT_COMPETENCIA = '{1}' AND EVENT_HOLERITE_TIPO = {2}", cliente, ListaFuncionarios[0].FuncionarioResumo.Competencia, (int)holeritetipo));
                    }

                    foreach (Funcionario func in ListaFuncionarios)
                    {
                        int recibo = 1;
                        int func_id = 0;

                        if (func.FuncionarioResumo.frase.Substring(0, 20) == "QUEBRA DE RECIBO 2/2")
                            recibo = 2;
                        else
                        {
                            if (ArquivoTipo == Types.Types.ObrigacaoArquivoTipo.Retificacao)
                            {
                                bd.executeCommand(string.Format("DELETE FROM HoleriteResumoSalario " +
                                  "FROM Funcionarios WHERE FUNC_IND = SAL_FUNC AND FUNC_EMPRESA = {0} AND FUNC_CPF = '{1}' AND SAL_COMPETENCIA = '{2}' AND SAL_HOLERITE_TIPO = {3}", cliente, func.cpf, func.FuncionarioResumo.Competencia, (int)holeritetipo));

                                bd.executeCommand(string.Format("DELETE FROM HoleriteEventos " +
                                        "FROM Funcionarios WHERE FUNC_IND = EVENT_FUNC AND FUNC_EMPRESA = {0} AND FUNC_CPF = '{1}' AND EVENT_COMPETENCIA = '{2}' AND EVENT_HOLERITE_TIPO = {3}", cliente, func.cpf, func.FuncionarioResumo.Competencia, (int)holeritetipo));
                            }
                        }

                        SqlCommand cmd = new SqlCommand("holerite_importacao", bd.Conn);

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@P_OBRIGACAOCLIENTEPERIODO", ObrigacaoClientePeriodo);
                        cmd.Parameters.AddWithValue("@P_CPF", func.cpf);
                        cmd.Parameters.AddWithValue("@P_REGISTRO", func.reg);
                        cmd.Parameters.AddWithValue("@P_NOME", Wr.Classes.Strings.capitalizeWords(func.Nome));
                        cmd.Parameters.AddWithValue("@P_BANCO", func.FuncionarioResumo.banco);
                        cmd.Parameters.AddWithValue("@P_CONTA", func.FuncionarioResumo.Conta);
                        cmd.Parameters.AddWithValue("@P_FRASE", func.FuncionarioResumo.frase);
                        cmd.Parameters.AddWithValue("@P_HOLERITE_TIPO", (int)holeritetipo);
                        cmd.Parameters.AddWithValue("@P_REC_QUEBRA", recibo);

                        cmd.Parameters.AddWithValue("@P_SAL_COMPETENCIA", func.FuncionarioResumo.Competencia);
                        cmd.Parameters.AddWithValue("@P_SAL_BASE", func.FuncionarioResumo.SalarioBase);
                        cmd.Parameters.AddWithValue("@P_SAL_CONTRIBUICAO", func.FuncionarioResumo.SalContribuicao);
                        cmd.Parameters.AddWithValue("@P_SAL_VENCIMENTOS", func.FuncionarioResumo.TotalVencimentos);
                        cmd.Parameters.AddWithValue("@P_SAL_DESCONTOS", func.FuncionarioResumo.TotalDescontos);
                        cmd.Parameters.AddWithValue("@P_SAL_BASEFGTS", func.FuncionarioResumo.BaseFGTS);
                        cmd.Parameters.AddWithValue("@P_SAL_MESFGTS", func.FuncionarioResumo.MesFGTS);
                        cmd.Parameters.AddWithValue("@P_SAL_BASECALIR", func.FuncionarioResumo.BaseIR);
                        cmd.Parameters.AddWithValue("@P_SAL_LIQUIDO", func.FuncionarioResumo.Liquido);
                        cmd.Parameters.AddWithValue("@P_SAL_FUNCAO", func.FuncionarioResumo.funcao);
                        cmd.Parameters.AddWithValue("@P_SAL_DIVISAO", func.FuncionarioResumo.divisao);
                        cmd.Parameters.AddWithValue("@P_SAL_CREDITO", func.FuncionarioResumo.credito);

                        cmd.Parameters.AddWithValue("@P_SAL_PROVISORIO", provisorio ? 1 : 0);
                        //cmd.Parameters.AddWithValue("@P_FUNC_PIS", domestica ? 1 : 0);

                        SqlParameter parameter_result = cmd.Parameters.Add("@RESULT", SqlDbType.Int);
                        parameter_result.Direction = ParameterDirection.ReturnValue;

                        cmd.ExecuteNonQuery();

                        if (parameter_result.Value != null)
                        {
                            func_id = Convert.ToInt32(parameter_result.Value);
                        }

                        foreach (Evento Evento in func.FuncionarioEventos)
                        {
                            bd.executeCommand(string.Format("INSERT INTO HoleriteEventos (EVENT_FUNC, EVENT_CODIGO, EVENT_DESCRICAO, EVENT_REFERENCIA, EVENT_VENCIMENTO, EVENT_DESCONTO, EVENT_COMPETENCIA, EVENT_HOLERITE_TIPO, EVENT_QUEBRA) VALUES ({0}, '{1}', '{2}', '{3}', '{4}', '{5}', '{6}', {7}, {8})",
                            func_id,
                            Evento.codigo,
                            Evento.descricao,
                            Evento.referencia,
                            Evento.vencimento,
                            Evento.desconto,
                            func.FuncionarioResumo.Competencia,
                            (int)holeritetipo,
                            recibo));
                        }

                        if (!provisorio)
                            EnviarSms(func_id, func.FuncionarioResumo.Competencia, cliente, ObrigacaoArquivo, (Types.Types.HoleritesTiposSimples)holeritetipo);
                    }
                }
                catch (Exception ex)
                {
                    throw new System.ArgumentException("Erro Banco", ex.Message);
                }

                return 1;
            }
            #endregion

            #region Verificacao
            private void VerificarHolerite(Funcionario Func)
            {
                string Mensagem = string.Empty;
                int cnpj = getCliente(Func.CnpjCpf);


                int Competencia = bd.getFieldValueInteger(string.Format("SELECT OBR_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                    "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                    "WHERE OBRCLIPER_ANO = {0} AND OBRCLIPER_MES_FINAL = {1} AND " +
                                                    "OBRCLIPER_IND = {2} ",
                                                    Func.FuncionarioResumo.Competencia.Year, Func.FuncionarioResumo.Competencia.Month, ObrigacaoClientePeriodo));



                if (cnpj <= 0)
                    Mensagem += "CNPJ ou CPF no Holerite não corresponde com o código de empresa, verifique o cadastro da AssecontWeb. <br/> |";
                //if (Competencia <= 0)
                //    Mensagem += "a competência no Holerite não corresponde com a competência da obrigação<br/> |";

                if (Mensagem != "")
                {
                    string MensagemFinal = "Erro de Validação:<br/> " + Mensagem;
                    throw new Exception(MensagemFinal);
                }
            }

            //private bool validarHoleriteDomestica()
            //{
            //    return bd.getFieldValueInteger(string.Format("SELECT CLI_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
            //                                        "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
            //                                        "WHERE CLI_CPF IS NOT NULL AND OBRCLIPER_IND = {0}", ObrigacaoClientePeriodo)) > 0 ? true : false;
            //}

            private int getCliente(string CNPJ_CPF)
            {
                int Cliente = 0;

                Cliente = bd.getFieldValueInteger(string.Format("SELECT CLI_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                    "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                    "WHERE (SUBSTRING(dbo.fn_trim_cnpj(CLI_CNPJ), 0 , 9) = SUBSTRING(dbo.fn_trim_cnpj('{0}'), 0 , 9) OR " +
                                                    "dbo.fn_trim_cnpj(CLI_CPF) = dbo.fn_trim_cnpj('{0}')) AND " +
                                                    "OBRCLIPER_IND = {1}",
                                                    CNPJ_CPF, ObrigacaoClientePeriodo));

                return Cliente;
            }
            #endregion

            private void setDemitidos(int cliente)
            {
                bd.executeCommand(string.Format("UPDATE Funcionarios SET FUNC_DEMISSAO = 1 " +
                     "WHERE NOT EXISTS(SELECT * FROM HoleriteResumoSalario " +
                     "WHERE SAL_FUNC = FUNC_IND AND SAL_COMPETENCIA > DATEADD(MONTH, -2, GETDATE())) " +
                     "AND FUNC_EMPRESA = {0} ", cliente));
            }

            private void EnviarEmail(int ObrigacaoClientePeriodo, Types.Types.HoleritesTipos Holeritetipo)
            {
                try
                {
                    (new Classes.Email.EmailHolerite(ObrigacaoClientePeriodo, Holeritetipo)).Send();
                }
                catch (Exception e)
                {
                    //throw new Exception("Erro no envio do email. <br /> " + e.Message);
                }
            }

            private void EnviarSms(int funcionarioId, DateTime Compentecia, int Cliente, int ObrigacaoArquivo, Types.Types.HoleritesTiposSimples tipo)
            {
                try
                {
                    string periodo = DateUtils.getMonthName(Compentecia.Month) + "/" + Compentecia.Year;

                    foreach (DataRow row in lerDadosFuncionario(funcionarioId).Rows)
                    {
                        (new Assecontweb.Classes.Sms.SmsHolerite(row["FUNC_DDD"].ToString().Trim(), row["FUNC_CELULAR"].ToString().Trim(),
                             row["FUNC_NOME"].ToString().Trim(), row["CARGO"].ToString().Trim(), periodo, Cliente, ObrigacaoArquivo, tipo)).Send();
                    }
                }
                catch (Exception e)
                {
                    //throw new Exception("Erro no envio do sms. <br /> " + e.Message);
                }
            }

            public DataTable lerDadosFuncionario(int funcionarioId)
            {
                return bd.getDataTable(string.Format("SELECT FUNC_IND, FUNC_NOME, FUNC_CELULAR, FUNC_DDD,  " +
                        "(SELECT TOP 1 SAL_FUNCAO FROM HoleriteResumoSalario WHERE FUNC_IND = SAL_FUNC ORDER BY SAL_COMPETENCIA DESC) AS CARGO " +
                        "FROM Funcionarios " +
                        "WHERE FUNC_IND = {0} AND FUNC_CELULAR IS NOT NULL AND FUNC_DDD IS NOT NULL", funcionarioId));
            }
        }
    }
}