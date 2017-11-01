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
        public class SpedContabilECD : SpedContabil
        {
            private BD bd;
            private string fileName;
            private int obrigacaoArquivo;
            private int obrigacaoClientePeriodo;
            private bool publish;
            private bool ProcessarArquivo = false;
            private byte[] byteArquivo;

            public SpedContabilECD(BD bd, byte[] byteArquivo, int ObrigacaoClientePeriodo, int ArquivoIndice, bool ProcessarArquivo)
            {
                this.bd = bd;
                this.publish = true;
                this.byteArquivo = byteArquivo;
                this.ProcessarArquivo = ProcessarArquivo;
                this.obrigacaoArquivo = ArquivoIndice;
                this.obrigacaoClientePeriodo = ObrigacaoClientePeriodo;

                try
                {
                    getArquivo();
                    setDados();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }

            public SpedContabilECD(BD bd, string fileName, int obrigacaoClientePeriodo, int obrigacaoArquivo, bool publish)
            {
                this.bd = bd;
                this.fileName = fileName;
                this.publish = publish;
                this.obrigacaoArquivo = obrigacaoArquivo;
                this.obrigacaoClientePeriodo = obrigacaoClientePeriodo;

                try
                {
                    getArquivo();
                    setDados();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }

            private void getArquivo()
            {
                List<string> Arquivo = new List<string>();

                if (!ProcessarArquivo)
                    Files.ReadFile(fileName, Arquivo, 1252);
                else
                {
                    Arquivo = Global.ByteToListString_Txt(byteArquivo);
                }

                if (!publish && !Arquivo[0].Contains("|0000|"))
                {
                    throw new Exception("Formato do Anexo Incorreto");
                }

                try
                {
                    readArquivo(Arquivo);
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }

            private void readArquivo(List<string> Arquivo)
            {
                AberturaIndetificacao(Arquivo[0].Split('|'));

                for (int i = 1; i < Arquivo.Count; i++)
                {
                    string[] linha = Arquivo[i].Split('|');

                    if (linha.Length > 1)
                    {
                        if (linha[1].Equals("I355"))
                        {
                            if (linha[2].Equals("510501290055129"))
                                setDepreciacao(getValueSinal(Convert.ToDecimal(linha[4]), Convert.ToChar(linha[5])));
                        }

                        if (linha[1] == "J100")
                        {
                            switch (linha[2])
                            {
                                case "11": //Ativo circulante
                                    setAtivoCirculante(Convert.ToDecimal(linha[6]));
                                    break;

                                case "12": //Ativo não circulante
                                    setAtivoNaoCirculante(Convert.ToDecimal(linha[6]));
                                    break;

                                case "21": //passivo Circulante
                                    setPassivoCirculante(Convert.ToDecimal(linha[6]));
                                    break;

                                case "22": //passivo não circulante
                                    setPassivoNaoCirculante(Convert.ToDecimal(linha[6]));
                                    break;

                                case "24": //Patrimonio Liquido
                                    setPatrimonioLiquido(Convert.ToDecimal(linha[6]));
                                    break;

                                case "1101": //Disponibilidades
                                    setDisponibilidades(Convert.ToDecimal(linha[6]));
                                    break;

                                case "1320": //Imobilizados
                                    setImobilizados(Convert.ToDecimal(linha[6]));
                                    break;

                                case "1104": //Estoques
                                    setEstoques(Convert.ToDecimal(linha[6]));
                                    break;

                                case "1201": //Realizavel Longo Prazo
                                    setAtivoRealizavelLongoPrazo(Convert.ToDecimal(linha[6]));
                                    break;

                                case "2201": //Exigivel Longo Prazo
                                    setPassivoExigivelLongoPrazo(Convert.ToDecimal(linha[6]));
                                    break;

                                case "011301": //DUPLICATAS_A_RECEBER
                                    setDuplicatasReceber(Convert.ToDecimal(linha[6]));
                                    break;

                                case "13": //ATIVO_PERMANENTE
                                    setAtivoPermanente(Convert.ToDecimal(linha[6]));
                                    break;

                                case "1107": //IMPOSTOS A RECUPERAR/COMPENSAR ou ODRCD
                                    setODRCD(Convert.ToDecimal(linha[6]));
                                    break;

                                case "1105": //CREDITOS_TRIBUTARIOS =  Campo OUTROS CREDITOS
                                    setCreditoTributario(Convert.ToDecimal(linha[6]));
                                    break;

                                case "1102": //Bancos 
                                    setBancos(Convert.ToDecimal(linha[6]));
                                    break;

                                case "1106": //BCOS CTA VINCULADA
                                    setBancosVinculados(Convert.ToDecimal(linha[6]));
                                    break;
                            }
                        }

                        if (linha[1] == "J150")
                        {
                            switch (linha[2])
                            {
                                case "903029": //RECEITA_LIQUIDA_VENDAS_E_SERVICOS = Campo RECEITA LIQUIDA OPERACIONAL
                                    setReceitaLiquidaVendaServico(getValueSinal(Convert.ToDecimal(linha[5]), Convert.ToChar(linha[6])));
                                    break;

                                case "904029": //CUSTO_BENS_E_OU_SERVICOS_VENDIDOS = Campo CUSTOS DAS VENDAS
                                    setBensServicosVendidos(getValueSinal(Convert.ToDecimal(linha[5]), Convert.ToChar(linha[6])));
                                    break;

                                case "906029": //INDI_DESPESAS_E_RECEITAS_OPERACIONAIS = Campo DESPESAS/RECEITAS OPERACIONAIS
                                    setDespesasReceitasOperacionais(getValueSinal(Convert.ToDecimal(linha[5]), Convert.ToChar(linha[6])));
                                    break;

                                case "907019": //OUTRAS_RECEITAS_DESPESAS
                                    setOutrasReceitasDespesas(getValueSinal(Convert.ToDecimal(linha[5]), Convert.ToChar(linha[6])));
                                    break;

                                case "907025": //PROVISAO_IR 
                                    setProvisaoIr(getValueSinal(Convert.ToDecimal(linha[5]), Convert.ToChar(linha[6])));
                                    break;

                                case "907031": //PROVISAO_CSLL 
                                    setProvisaoCsll(getValueSinal(Convert.ToDecimal(linha[5]), Convert.ToChar(linha[6])));
                                    break;

                                case "906059": //PROVISAO_BALANCO
                                    setProvisaoBalanco(getValueSinal(Convert.ToDecimal(linha[5]), Convert.ToChar(linha[6])));
                                    break;

                                case "901029": //INDI_RECEITA_BRUTA = Campo Venda Bruta Operacional
                                    setReceitaBruta(getValueSinal(Convert.ToDecimal(linha[5]), Convert.ToChar(linha[6])));
                                    break;

                                case "902029": //Deduções
                                    setDeducao(getValueSinal(Convert.ToDecimal(linha[5]), Convert.ToChar(linha[6])));
                                    break;

                                case "902001": //Devolução
                                    setDevolucao(getValueSinal(Convert.ToDecimal(linha[5]), Convert.ToChar(linha[6])));
                                    break;

                                //case "906029": //Outras despesas não operacionais
                                //    setDespesasReceitasOperacionais(getValueSinal(Convert.ToDecimal(linha[5]), Convert.ToChar(linha[6])));
                                //    break;

                                case "907013": //Outras Receitas não operacionais
                                    setOutrasReceitasNaoOperacionais(getValueSinal(Convert.ToDecimal(linha[5]), Convert.ToChar(linha[6])));
                                    break;
                            }
                        }
                        if (linha[1] == "J200" || linha[1] == "J800")
                            break;
                    }
                }
            }

            private Decimal getValueSinal(Decimal value, Char c)
            {
                if (c.Equals('N'))
                {
                    return value * -1;
                }
                return value;
            }

            private void AberturaIndetificacao(string[] linha) //Bloco 0000
            {
                validarCnpjCpf(linha[6]);
                setDataInicial(ConvertDate(linha[3]));
                setDataFinal(ConvertDate(linha[4]));
            }

            private void validarCnpjCpf(string pessoa)
            {
                setEmpresaId(bd.getFieldValueInteger(string.Format("SELECT CLI_IND FROM Obrigacoes INNER JOIN ObrigacoesClientesPeriodos ON OBR_IND = OBRCLIPER_OBRIGACAO " +
                                                      "INNER JOIN Clientes ON OBRCLIPER_CLIENTE = CLI_IND " +
                                                      "WHERE (SUBSTRING(dbo.fn_trim_cnpj(CLI_CNPJ), 0 , 9) = SUBSTRING(dbo.fn_trim_cnpj('{0}'), 0 , 9) OR " +
                                                      "dbo.fn_trim_cnpj(CLI_CPF) = dbo.fn_trim_cnpj('{0}')) AND " +
                                                      "OBRCLIPER_IND = {1}",
                                                      pessoa, obrigacaoClientePeriodo)));

                if (getEmpresaId() <= 0)
                    throw new Exception("CNPJ ou CPF no SPED Contabil não corresponde com o código de empresa<br/> ");
            }

            private void setDados()
            {
                if (publish)
                {
                    bd.openConnection();
                    SqlCommand cmd = new SqlCommand("importacao_sped_indices", bd.Conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@P_CLIENTE", getEmpresaId());
                    cmd.Parameters.AddWithValue("@P_DATAINICIAL", getDataInicial());
                    cmd.Parameters.AddWithValue("@P_DATAFINAL", getDataFinal());

                    cmd.Parameters.AddWithValue("@P_ATIVO_CIRCULANTE", getAtivoCirculante());
                    cmd.Parameters.AddWithValue("@P_ATIVO_NAO_CIRCULANTE", getAtivoNaoCirculante());
                    cmd.Parameters.AddWithValue("@P_ATIVO_REALIZAVEL_LONGO_PRAZO", getAtivoRealizavelLongoPrazo());
                    cmd.Parameters.AddWithValue("@P_DISPONIBILIDADES", getDisponibilidades());
                    cmd.Parameters.AddWithValue("@P_DUPLICATAS_A_RECEBER", getDuplicatasReceber());
                    cmd.Parameters.AddWithValue("@P_ODRCD", getODRCD());
                    cmd.Parameters.AddWithValue("@P_ESTOQUES", getEstoques());
                    cmd.Parameters.AddWithValue("@P_OUTROSCREDITOS", getCreditoTributario() + getBancos() + getBancosVinculados());
                    cmd.Parameters.AddWithValue("@P_ATIVO_PERMANENTE", getAtivoPermanente());

                    cmd.Parameters.AddWithValue("@P_IMOBILIZADOS", getImobilizados());

                    cmd.Parameters.AddWithValue("@P_PASSIVO_CIRCULANTE", getPassivoCirculante());
                    cmd.Parameters.AddWithValue("@P_PASSIVO_NAO_CIRCULANTE", getPassivoNaoCirculante());
                    cmd.Parameters.AddWithValue("@P_PASSIVO_EXIGIVEL_LONGO_PRAZO", getPassivoExigivelLongoPrazo());
                    cmd.Parameters.AddWithValue("@P_PATRIMONIO_LIQUIDO", getPatrimonioLiquido());

                    cmd.Parameters.AddWithValue("@P_RECEITA_LIQUIDA_VENDAS_E_SERVICOS", getReceitaLiquidaVendaServico());
                    cmd.Parameters.AddWithValue("@P_BENS_E_OU_SERVICOS_VENDIDOS", getBensServicosVendidos());
                    cmd.Parameters.AddWithValue("@P_DESPESAS_E_RECEITAS_OPERACIONAIS", getDespesasReceitasOperacionais());
                    cmd.Parameters.AddWithValue("@P_PROVISAO_IR_CSLL", (getProvisaoCsll() + getProvisaoIr()));
                    cmd.Parameters.AddWithValue("@P_PROVISAO_BALANCO", getProvisaoBalanco());
                    cmd.Parameters.AddWithValue("@P_OUTRAS_RECEITAS_DESPESAS", getOutrasReceitasDespesas());

                    cmd.Parameters.AddWithValue("@P_OUTRAS_RECEITAS_NAO_OPERACIONAIS", getOutrasReceitasNaoOperacionais());
                    cmd.Parameters.AddWithValue("@P_OUTRAS_DESPESAS_NAO_OPERACIONAIS", getOutrasDespesasNaoOperacionais());
                    cmd.Parameters.AddWithValue("@P_RECEITA_BRUTA", getReceitaBruta());
                    cmd.Parameters.AddWithValue("@P_IMPOSTO_SOBRE_VENDAS", getImpostoSobreVendas());
                    cmd.Parameters.AddWithValue("@P_DEPRECIACAO", getDepreciacao());
                    cmd.Parameters.AddWithValue("@P_DEVOLUCAO_VENDAS", getDevolucao());

                    cmd.ExecuteNonQuery();
                    bd.closeConnection();
                }
            }

            private DateTime ConvertDate(string data)
            {
                return Convert.ToDateTime(data.Substring(0, 2) + "/" + data.Substring(2, 2) + "/" + data.Substring(4, 4));
            }
        }
    }
}