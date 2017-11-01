using System;
using System.Data;
using System.Data.SqlClient;
using Wr.Classes;

namespace AssecontNovo.Classes
{
    public abstract class BDApp : BD
    {
        public BDApp()
        {
            Conectar();
        }
    }

    public class BDAppAssecont : BDApp
    {
        public BDAppAssecont()
        {
            string server = "200.170.88.138";
            string database = "assecont2";
            string user = "assecont5272";
            string password = "*h6prMvr";
            Conectar(new BDConnection(server, database, user, password));
        }

        public DataTable getListaEmailsAssecontExterno(int classficacao)
        {
            return getDataTable(String.Format("SELECT LOWER(RTRIM(LOGE_EMAIL)) AS EMAIL FROM LoginsExternos " +
                                      "INNER JOIN LoginsExternosEmpresas ON LOGE_IND = LOGEE_LOGIN_EXTERNO " +
                                      "INNER JOIN PerfisClientes ON PERFCLI_CLIENTE = LOGEE_EMPRESA " +
                                      "WHERE PERFCLI_PERFILITEM = {0} AND EXISTS(SELECT CLI_DESLIGAMENTO FROM Clientes WHERE CLI_IND = LOGEE_EMPRESA) ", classficacao));
        }

        public DataTable getListaEmailsAssecontInterno(int setor)
        {
            return getDataTable(String.Format("SELECT LOWER(RTRIM(LOGI_EMAIL)) AS EMAIL FROM LoginsInternos WHERE LOGI_SETOR = {0} AND LOGI_ATIVO = 1 AND LOGI_DESLIGAMENTO IS NULL", setor));
        }

        #region Holerite
        public bool getExistsRecibo(int ind, int mes, int ano, int tipo)
        {
            return getFieldValueInteger(String.Format("SELECT SAL_HOLERITE_TIPO FROM Funcionarios INNER JOIN HoleriteResumoSalario ON SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = {3}", ind, mes, ano, tipo)) > 0;
        }

        public int getFuncionarioHolerite(string cpf)
        {
            return getFieldValueInteger(String.Format("SELECT CASE WHEN FUNC_CPF IS NOT NULL THEN 1 ELSE 0 END FROM Funcionarios WHERE dbo.fn_trim_cnpj(FUNC_CPF) = dbo.fn_trim_cnpj('{0}') ", cpf));
        }

        public int getVerificarCadastroFuncionario(string cpf, string registro)
        {
            return getFieldValueInteger(String.Format("SELECT (CASE WHEN FUNC_DATA_CADASTRO IS NULL THEN -1 ELSE FUNC_IND END) FROM Funcionarios WHERE FUNC_CPF = '{0}' AND FUNC_REG = '{1}' ", cpf, registro));
        }

        public bool getCadastroEfetuado(int userId)
        {
            return getFieldValueBool(String.Format("SELECT (CASE WHEN FUNC_DATA_CADASTRO IS NULL THEN 0 ELSE 1 END) FROM Funcionarios WHERE FUNC_IND = {0} ", userId));
        }

        public string getNomeFuncionario(int userId)
        {
            return getFieldValueString(String.Format("SELECT FUNC_NOME FROM Funcionarios WHERE FUNC_IND = {0}", userId));
        }

        public string getEmailFuncionario(int userId)
        {
            return getFieldValueString(String.Format("SELECT FUNC_EMAIL FROM Funcionarios WHERE FUNC_IND = {0}", userId)).Trim().ToLower();
        }

        public string getRegistroFuncionario(int userId)
        {
            return getFieldValueString(String.Format("SELECT FUNC_REG FROM Funcionarios WHERE FUNC_IND = {0}", userId)).Trim();
        }

        public string getCpfFuncionario(int userId)
        {
            return getFieldValueString(String.Format("SELECT FUNC_CPF FROM Funcionarios WHERE FUNC_IND = {0}", userId));
        }

        public void setReciboVisualizadoFuncionario(int userId, int mes, int ano)
        {
            executeCommand(String.Format("UPDATE HoleriteResumoSalario SET SAL_VISUALIZADO = GETDATE() WHERE SAL_FUNC = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_VISUALIZADO IS NULL", userId, mes, ano));
        }

        public void setHoleriteNewPwd(int userId, string pwd)
        {
            executeCommand(String.Format("UPDATE Funcionarios SET FUNC_SENHA = '{0}', FUNC_DATA_PEDIDO_SENHA = GETDATE() WHERE FUNC_IND = {1} AND FUNC_DATA_CADASTRO IS NOT NULL", pwd, userId));
        }

        public int getCountRecibos(int userId, int mes, int ano)
        {
            return getFieldValueInteger(String.Format("SELECT COUNT(SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario WHERE SAL_FUNC = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_PROVISORIO = 0", userId, mes, ano));
        }

        public DateTime getDataUltimoReciboAnexado(int userId)
        {
            return getFieldValueDateTime(String.Format("SELECT TOP 1 SAL_COMPETENCIA FROM Funcionarios INNER JOIN HoleriteResumoSalario ON SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND SAL_DATA_CRIACAO IS NOT NULL AND SAL_PROVISORIO = 0 ORDER BY SAL_DATA_CRIACAO DESC ", userId));
        }

        public int getUltimoReciboAnexadoTipo(int userId, int mes, int ano)
        {
            return getFieldValueInteger(String.Format("SELECT TOP 1 SAL_HOLERITE_TIPO FROM Funcionarios INNER JOIN HoleriteResumoSalario ON SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_PROVISORIO = 0  ORDER BY SAL_DATA_CRIACAO DESC", userId, mes, ano));
        }

        public int getFuncionarioUserId(string cpf, string registro)
        {
            return getFieldValueInteger(string.Format("SELECT FUNC_IND FROM Funcionarios WHERE FUNC_CPF='{0}' AND FUNC_REG='{1}'", cpf, registro));
        }
        #endregion

        public int getClienteID(int Numero)
        {
            return getFieldValueInteger(String.Format("SELECT CLI_IND FROM Clientes WHERE CLI_NUMERO = '{0}'", Numero));
        }

        public string getFrase()
        {
            return getFieldValueString("SELECT TOP 1 RAD_FRASE FROM FrasesRandom ORDER BY NEWID()");
        }

        public DateTime getUltimoQuestionarioRespondidoSocio()
        {
            return getFieldValueDateTime("SELECT TOP 1 QUERESDADOS_DATA FROM QuestionariosRespostasDados WHERE QUERESDADOS_SOCIO IS NOT NULL ORDER BY QUERESDADOS_DATA DESC");
        }

        public string getClientNumero(string CNPJ_CPF)
        {
            return getFieldValueString(String.Format("SELECT CLI_NUMERO FROM Clientes WHERE dbo.fn_trim_cnpj(CLI_IND) = '{0}'", CNPJ_CPF));
        }

        public int getLegalizacaoCadastro(string CNPJ_CPF)
        {
            return getFieldValueInteger(String.Format("SELECT LEGCLI_IND FROM LegalizacaoClientes WHERE dbo.fn_trim_cnpj(LEGCLI_CNPJ) = dbo.fn_trim_cnpj('{0}')", CNPJ_CPF));
        }

        public int setLegalizacaoCadastrar(Cliente cliente)
        {
            return getFieldValueInteger(string.Format("INSERT INTO LegalizacaoClientes " +
                        "(LEGCLI_RAZAOSOCIAL, LEGCLI_CONTATO, LEGCLI_EMAIL, LEGCLI_TELEFONE_DDD, LEGCLI_TELEFONE, LEGCLI_CELULAR_DDD, LEGCLI_CELULAR, LEGCLI_CNPJ, LEGCLI_NUMERO) VALUES " +
                        "('{0}', '{1}', '{2}', '{3}', '{4}', '{5}', '{6}', '{7}', '{8}' ) SELECT @@IDENTITY",
                        cliente.RazaoSocial,
                        cliente.Contato,
                        cliente.Email,
                        cliente.Telefone_ddd,
                        cliente.Telefone,
                        cliente.Celular,
                        cliente.Celular_ddd,
                        cliente.CpfCnpj,
                        cliente.ClienteNumero));
        }

        public int setLegalizacaoPedido(int IdCadastro, string Observacao, int protocolo, Types.LegalizacaoServicoTipo servico)
        {
            return getFieldValueInteger(string.Format("INSERT INTO legalizacaoPedidos (LEGPED_CADASTRO, LEGPED_OBS, LEGPED_PROTOCOLO, LEGPED_SERVICO) VALUES " +
                 "({0}, '{1}', '{2}', {3}) SELECT @@IDENTITY",
                 IdCadastro,
                 Observacao,
                 protocolo,
                 (int)servico));
        }

        public int getLegalizcaoProtocolo()
        {
            openConnection();
            SqlCommand cmd = new SqlCommand("legalizacaoProtocolo", Conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Clear();

            SqlParameter parameter_indice = cmd.Parameters.Add("@PROTOCOLO", System.Data.SqlDbType.Int);
            parameter_indice.Direction = System.Data.ParameterDirection.Output;

            cmd.ExecuteNonQuery();
            closeConnection();

            return Convert.ToInt32(parameter_indice.Value);
        }

        public bool setLegalizacaoStatus(int PedidoId)
        {
            try
            {
                DataTable dt = getDataTable("SELECT LEGETA_IND FROM LegalizacaoEtapas");

                for (int i = 0; i < dt.Rows.Count; i++)
                    executeCommand(string.Format("INSERT INTO LegalizacaoPedidosEtapas (LPETA_PEDIDO, LPETA_ETAPA, LPETA_STATUS) VALUES ({0}, {1}, {2}) ", PedidoId, dt.Rows[i]["LEGETA_IND"], (i == 0 ? 1 : 0)));
            }
            catch  { return false; }
            return true;
        }
    }

    public class BDAppAssecontAntigo : BDApp
    {
        public BDAppAssecontAntigo()
        {
            Conectar(new BDConnection("200.170.88.138", "assecont", "assecont24886", "Bkos584%dc"));
        }

        public int getClienteNumero(int ind)
        {
            return getFieldValueInteger(string.Format("SELECT CLI_NUMERO FROM dbClientes WHERE CLI_IND = '{0}'", ind));
        }
    }

    public class BDAppAssefin : BDApp
    {
        public BDAppAssefin()
        {
            Conectar(new BDConnection("200.98.136.201", "assefin_assecont4", "assefin45231", "768fkl448mb"));
        }

        public int getCliente(string CnpjCpf)
        {
            return getFieldValueInteger(string.Format("SELECT CAD_IND FROM Cadastros WHERE dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj('{0}') OR " +
                                                "dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj('{0}')", CnpjCpf));
        }

        public int getCountBoletosEmAberto(int clienteId)
        {
            return getFieldValueInteger(string.Format("SELECT ISNULL(COUNT(*), 0) AS Total FROM Boletos " +
                        "INNER JOIN ContasRegistros ON BOL_IND = CTAR_BOLETO " +
                        "WHERE BOL_CANCELADO = 0 AND CTAR_VALOR_PAGTO IS NULL AND BOL_IGNORAR = 0 AND CTAR_IGNORADO = 0 AND " +
                        "(CASE WHEN dbo.fn_data_eh_feriado(dbo.fn_dia_util(BOL_VENCIMENTO)) = 1 THEN DATEADD(DAY, 1, dbo.fn_dia_util(BOL_VENCIMENTO)) ELSE dbo.fn_dia_util(BOL_VENCIMENTO) END) " +
                        "< CONVERT(DATE, GETDATE()) AND BOL_CONTRA_APRESENTACAO = 0 AND BOL_CADASTRO = {0} ", clienteId));
        }
    }

    public class BDAppTecnologia : BDApp
    {
        public BDAppTecnologia()
        {
            Conectar(new BDConnection("200.170.88.138", "assecont1", "assecont3730", "Gklwi89Hmk"));
        }

        public DataTable getListaEmailsCliente(bool UF = false)
        {
            if (UF)
                return getDataTable("SELECT DISTINCT CAD_EMAIL + (CASE WHEN CAD_EMAIL2 IS NOT NULL THEN ';' + CAD_EMAIL2 ELSE '' END) AS EMAILS " +
                    "FROM AssepontoClientes WHERE CAD_EMAIL IS NOT NULL AND RTRIM(CAD_EMAIL) <> '' " +
                    "AND dbo.fn_asseponto_cliente_tem_manutencao_ativa(CAD_IND) = 1 AND UPPER(CAD_UF) = 'SP'");
            else
                return getDataTable("SELECT DISTINCT CAD_EMAIL + (CASE WHEN CAD_EMAIL2 IS NOT NULL THEN ';' + CAD_EMAIL2 ELSE '' END) AS EMAILS " +
                    "FROM AssepontoClientes WHERE CAD_EMAIL IS NOT NULL AND RTRIM(CAD_EMAIL) <> '' AND dbo.fn_asseponto_cliente_tem_manutencao_ativa(CAD_IND) = 1 ");
        }

        public DataTable getListaEmailsClienteSemManutencao(bool UF = false)
        {
            string str;
            if (UF)
                str = "SELECT DISTINCT (CASE WHEN LTRIM(RTRIM(A.EMAIL1)) != '' " +
                      "                      THEN CASE WHEN LTRIM(RTRIM(A.EMAIL2)) != '' " +
                      "                                THEN CASE WHEN LTRIM(RTRIM(A.EMAIL3)) != '' " +
                      "                                          THEN A.EMAIL1 + ';' + A.EMAIL2 + ';' + A.EMAIL3 " +
                      "                                          ELSE A.EMAIL1 + ';' + A.EMAIL2 " +
                      "                                     END " +
                      "                                ELSE A.EMAIL1 " +
                      "                           END " +
                      "                      ELSE '' " +
                      "                 END) AS EMAILS " +
                      "FROM(" +
                      "    SELECT DISTINCT CAD_IND, CAD_REVENDA, " +
                      "        (CASE WHEN(LTRIM(RTRIM(CAD_EMAIL)) != '') " +
                      "              THEN((CASE WHEN CAD_EMAIL_ENVIAR IS NOT NULL AND CAD_EMAIL_ENVIAR = 1 " +
                      "                         THEN LTRIM(RTRIM(CAD_EMAIL)) ELSE '' END)) " +
                      "                    ELSE '' " +
                      "         END) AS EMAIL1, " +
                      "         (CASE WHEN(LTRIM(RTRIM(CAD_EMAIL2)) != '') " +
                      "               THEN((CASE WHEN CAD_EMAIL2_ENVIAR IS NOT NULL AND CAD_EMAIL2_ENVIAR = 1 " +
                      "                          THEN '' + LTRIM(RTRIM(CAD_EMAIL2)) ELSE '' END)) " +
                      "               ELSE '' " +
                      "          END) AS EMAIL2, " +
                      "          (CASE WHEN(LTRIM(RTRIM(CAD_EMAIL3)) != '') " +
                      "                THEN((CASE WHEN CAD_EMAIL3_ENVIAR IS NOT NULL AND CAD_EMAIL3_ENVIAR = 1 " +
                      "                           THEN '' + LTRIM(RTRIM(CAD_EMAIL3)) ELSE '' END)) " +
                      "                ELSE '' " +
                      "           END) AS EMAIL3 " +
                      "    FROM AssepontoClientes WHERE UPPER(CAD_UF) = 'SP' " +
                      "    ) A " +
                      "OUTER APPLY(" +
                      "    SELECT TOP 1 NSE_DATA, DATEDIFF(day, NSE_DATA, GETDATE()) as DIASCORRIDOS " +
                      "         FROM AssepontoNSeries " +
                      "         WHERE NSE_CLIENTE = CAD_IND AND " +
                      "               NSE_SOLICITACAO = 1 " +
                      "         ORDER BY NSE_DATA DESC " +
                      ") AC " +
                      "OUTER APPLY(" +
                      "    SELECT TOP 1 IM_ANDAMENTO FROM AssepontoImplantacoes WHERE IM_CLIENTE = CAD_IND AND IM_FINALIZADO_POR IS NULL " +
                      ") AD " +
                      "INNER JOIN AssepontoRevendas on CAD_REVENDA = REV_IND " +
                      "WHERE EMAIL1 IS NOT NULL AND LTRIM(RTRIM(EMAIL1)) != '' AND " +
                      "      (NOT EXISTS(SELECT * FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND) OR " +
                      "      (SELECT TOP 1 MNT_CANCELADO " +
                      "      FROM AssepontoManutencao " +
                      "      WHERE MNT_CLIENTE = CAD_IND " +
                      "      ORDER BY MNT_DATA DESC, MNT_IND DESC) = 1) AND " +
                      "      DIASCORRIDOS >= 60 AND " +
                      "      (REV_COBRAR_CLIENTES IS NULL OR REV_COBRAR_CLIENTES = 1) " +
                      "ORDER BY EMAILS ";
            else
                str = "SELECT DISTINCT (CASE WHEN LTRIM(RTRIM(A.EMAIL1)) != '' " +
                      "                      THEN CASE WHEN LTRIM(RTRIM(A.EMAIL2)) != '' " +
                      "                                THEN CASE WHEN LTRIM(RTRIM(A.EMAIL3)) != '' " +
                      "                                          THEN A.EMAIL1 + ';' + A.EMAIL2 + ';' + A.EMAIL3 " +
                      "                                          ELSE A.EMAIL1 + ';' + A.EMAIL2 " +
                      "                                     END " +
                      "                                ELSE A.EMAIL1 " +
                      "                           END " +
                      "                      ELSE '' " +
                      "                 END) AS EMAILS " +
                      "FROM(" +
                      "    SELECT DISTINCT CAD_IND, CAD_REVENDA, " +
                      "        (CASE WHEN(LTRIM(RTRIM(CAD_EMAIL)) != '') " +
                      "              THEN((CASE WHEN CAD_EMAIL_ENVIAR IS NOT NULL AND CAD_EMAIL_ENVIAR = 1 " +
                      "                         THEN LTRIM(RTRIM(CAD_EMAIL)) ELSE '' END)) " +
                      "                    ELSE '' " +
                      "         END) AS EMAIL1, " +
                      "         (CASE WHEN(LTRIM(RTRIM(CAD_EMAIL2)) != '') " +
                      "               THEN((CASE WHEN CAD_EMAIL2_ENVIAR IS NOT NULL AND CAD_EMAIL2_ENVIAR = 1 " +
                      "                          THEN '' + LTRIM(RTRIM(CAD_EMAIL2)) ELSE '' END)) " +
                      "               ELSE '' " +
                      "          END) AS EMAIL2, " +
                      "          (CASE WHEN(LTRIM(RTRIM(CAD_EMAIL3)) != '') " +
                      "                THEN((CASE WHEN CAD_EMAIL3_ENVIAR IS NOT NULL AND CAD_EMAIL3_ENVIAR = 1 " +
                      "                           THEN '' + LTRIM(RTRIM(CAD_EMAIL3)) ELSE '' END)) " +
                      "                ELSE '' " +
                      "           END) AS EMAIL3 " +
                      "    FROM AssepontoClientes " +
                      "    ) A " +
                      "OUTER APPLY(" +
                      "    SELECT TOP 1 NSE_DATA, DATEDIFF(day, NSE_DATA, GETDATE()) as DIASCORRIDOS " +
                      "         FROM AssepontoNSeries " +
                      "         WHERE NSE_CLIENTE = CAD_IND AND " +
                      "               NSE_SOLICITACAO = 1 " +
                      "         ORDER BY NSE_DATA DESC " +
                      ") AC " +
                      "OUTER APPLY(" +
                      "    SELECT TOP 1 IM_ANDAMENTO FROM AssepontoImplantacoes WHERE IM_CLIENTE = CAD_IND AND IM_FINALIZADO_POR IS NULL " +
                      ") AD " +
                      "INNER JOIN AssepontoRevendas on CAD_REVENDA = REV_IND " +
                      "WHERE EMAIL1 IS NOT NULL AND LTRIM(RTRIM(EMAIL1)) != '' AND " +
                      "      (NOT EXISTS(SELECT * FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND) OR " +
                      "      (SELECT TOP 1 MNT_CANCELADO " +
                      "      FROM AssepontoManutencao " +
                      "      WHERE MNT_CLIENTE = CAD_IND " +
                      "      ORDER BY MNT_DATA DESC, MNT_IND DESC) = 1) AND " +
                      "      DIASCORRIDOS >= 60 AND " +
                      "      (REV_COBRAR_CLIENTES IS NULL OR REV_COBRAR_CLIENTES = 1) " +
                      "ORDER BY EMAILS ";
            return getDataTable(str);
        }

        public DataTable getListaEmailsClienteComManutencao60(int antes, int depois, bool UF = false)
        {
            string str;
            if (UF)
                str = "SELECT DISTINCT " +
                      "    (CASE  " +
                      "        WHEN CAD_EMAIL_ENVIAR IS NOT NULL AND CAD_EMAIL_ENVIAR != 0  " +
                      "        THEN LTRIM(RTRIM(CAD_EMAIL)) ELSE '' END) + " +
                      "    (CASE  " +
                      "        WHEN CAD_EMAIL2 IS NOT NULL AND RTRIM(CAD_EMAIL2) != '' AND CAD_EMAIL2_ENVIAR IS NOT NULL AND CAD_EMAIL2_ENVIAR != 0  " +
                      "        THEN ';' + LTRIM(RTRIM(CAD_EMAIL2)) ELSE '' END) +   " +
                      "    (CASE  " +
                      "        WHEN CAD_EMAIL3 IS NOT NULL AND RTRIM(CAD_EMAIL3) != '' AND CAD_EMAIL3_ENVIAR IS NOT NULL AND CAD_EMAIL3_ENVIAR != 0  " +
                      "        THEN ';' + LTRIM(RTRIM(CAD_EMAIL3)) ELSE '' END) AS EMAILS  " +
                      "   FROM AssepontoClientes " +
                      "OUTER APPLY (	select top 1 * from AssepontoSolicitacoes where CAD_IND = ASOL_CLIENTE AND ASOL_VERSAO IS NOT NULL order by ASOL_LIBERADOEM DESC ) a " +
                      "OUTER APPLY (	select top 1 NSE_DATA, DATEDIFF(day, NSE_DATA, GETDATE()) as DIASCORRIDOS from AssepontoNSeries WHERE NSE_CLIENTE = CAD_IND AND NSE_SOLICITACAO = 1 ORDER BY NSE_DATA DESC ) b " +
                      "INNER JOIN AssepontoRevendas on CAD_REVENDA = REV_IND " +
                      "WHERE  " +
                      "(CAD_EMAIL IS NOT NULL AND RTRIM(CAD_EMAIL) != '' AND CAD_EMAIL_ENVIAR IS NOT NULL AND CAD_EMAIL_ENVIAR != 0) AND " +
                      "(ASOL_VERSAO = 4 OR ASOL_VERSAO = 5 OR ASOL_VERSAO = 6 OR ASOL_VERSAO = 7) AND  " +
                      "(NOT EXISTS(SELECT * FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND) OR  " +
                      "(SELECT TOP 1 MNT_CANCELADO FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND ORDER BY MNT_DATA DESC, MNT_IND DESC) = 1) AND " +
                      "(DIASCORRIDOS >= (60 - {0}) AND DIASCORRIDOS <= (60 + {1})) AND " +
                      "(REV_COBRAR_CLIENTES is null or REV_COBRAR_CLIENTES = 1) AND " +
                      "UPPER(CAD_UF) = 'SP' " +
                      "ORDER BY EMAILS ";
            else
                str = "SELECT DISTINCT " +
                      "    (CASE  " +
                      "        WHEN CAD_EMAIL_ENVIAR IS NOT NULL AND CAD_EMAIL_ENVIAR != 0  " +
                      "        THEN LTRIM(RTRIM(CAD_EMAIL)) ELSE '' END) + " +
                      "    (CASE  " +
                      "        WHEN CAD_EMAIL2 IS NOT NULL AND RTRIM(CAD_EMAIL2) != '' AND CAD_EMAIL2_ENVIAR IS NOT NULL AND CAD_EMAIL2_ENVIAR != 0  " +
                      "        THEN ';' + LTRIM(RTRIM(CAD_EMAIL2)) ELSE '' END) +   " +
                      "    (CASE  " +
                      "        WHEN CAD_EMAIL3 IS NOT NULL AND RTRIM(CAD_EMAIL3) != '' AND CAD_EMAIL3_ENVIAR IS NOT NULL AND CAD_EMAIL3_ENVIAR != 0  " +
                      "        THEN ';' + LTRIM(RTRIM(CAD_EMAIL3)) ELSE '' END) AS EMAILS  " +
                      "   FROM AssepontoClientes " +
                      "OUTER APPLY (	select top 1 * from AssepontoSolicitacoes where CAD_IND = ASOL_CLIENTE AND ASOL_VERSAO IS NOT NULL order by ASOL_LIBERADOEM DESC ) a " +
                      "OUTER APPLY (	select top 1 NSE_DATA, DATEDIFF(day, NSE_DATA, GETDATE()) as DIASCORRIDOS from AssepontoNSeries WHERE NSE_CLIENTE = CAD_IND AND NSE_SOLICITACAO = 1 ORDER BY NSE_DATA DESC ) b " +
                      "INNER JOIN AssepontoRevendas on CAD_REVENDA = REV_IND " +
                      "WHERE  " +
                      "(CAD_EMAIL IS NOT NULL AND RTRIM(CAD_EMAIL) != '' AND CAD_EMAIL_ENVIAR IS NOT NULL AND CAD_EMAIL_ENVIAR != 0) AND " +
                      "(ASOL_VERSAO = 4 OR ASOL_VERSAO = 5 OR ASOL_VERSAO = 6 OR ASOL_VERSAO = 7) AND  " +
                      "(NOT EXISTS(SELECT * FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND) OR  " +
                      "(SELECT TOP 1 MNT_CANCELADO FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND ORDER BY MNT_DATA DESC, MNT_IND DESC) = 1) AND " +
                      "(DIASCORRIDOS >= (60 - {0}) AND DIASCORRIDOS <= (60 + {1})) AND " +
                      "(REV_COBRAR_CLIENTES is null or REV_COBRAR_CLIENTES = 1) " +
                      "ORDER BY EMAILS ";
            return getDataTable(String.Format(str, antes, depois));
        }

        public DataTable getListaEmailsRevendas(bool UF = false)
        {
            if (UF)
                return getDataTable("SELECT DISTINCT LOWER(RTRIM(REV_EMAIL)) + (CASE WHEN REV_EMAIL2 IS NOT NULL THEN ';' + LOWER(RTRIM(REV_EMAIL2)) ELSE '' END) AS EMAILS " +
                                                                            "FROM AssepontoRevendas WHERE REV_EMAIL IS NOT NULL AND RTRIM(REV_EMAIL) <> '' AND UPPER(REV_UF) = 'SP' ");
            else
                return getDataTable("SELECT DISTINCT LOWER(RTRIM(REV_EMAIL)) + (CASE WHEN REV_EMAIL2 IS NOT NULL THEN ';' + LOWER(RTRIM(REV_EMAIL2)) ELSE '' END) AS EMAILS " +
                                                                            "FROM AssepontoRevendas WHERE REV_EMAIL IS NOT NULL AND RTRIM(REV_EMAIL) <> ''");
        }
    }
}