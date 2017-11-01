using System;
using Wr.Classes;
using System.Configuration;
using System.Data;
using System.Collections.Generic;

namespace Asseponto.Classes
{
    public class BDApp : BD
    {
        public BDApp()
        {
            Conectar();
        }

        public List<String> getImplantacoesStatusTipo(int indCli, Types.ImplantacaoAndamento indAnda)
        {
            return getFieldValueListString(String.Format("SELECT DISTINCT LTRIM(RTRIM(TIPO_STAT_NOME)) + ';' + LTRIM(RTRIM(TIPO_STAT_IND)) + ';' + " +
				                                         "LTRIM(RTRIM(case " +
				                                         "				when exists(select IM_CLIENTE " +
				                                         "							from AssepontoImplantacoes " +
				                                         "							where IM_CLIENTE = {0} and IM_ANDAMENTO_TIPO = TIPO_STAT_IND) " +
                                                         "				then '1' else '0' end)) as COLUNA " +
                                                         "FROM AssepontoImplantacoesStatusTipo " +
                                                         "WHERE TIPO_STAT_STATUS = {1} " +
                                                         "ORDER BY COLUNA ", indCli, (int)indAnda));
        }

        public List<string> getMesesFromPlanos()
        {
            return getFieldValueListString("select distinct (CONVERT(VARCHAR(5), APLAN_MESES) + ' meses') AS 'DESCRICAO' from AssepontoPlanos where APLAN_MESES is not null order by 'DESCRICAO' desc");
        }

        public List<string> getEmailsSuporte()
        {
            return getFieldValueListString("select SUP_EMAIL from AssepontoSuporte where SUP_ATIVO = 1 and SUP_EMAIL is not null and (SUP_PERFIL = 1 OR SUP_PERFIL = 2)");
        }

        public bool getEmailFinalizaImplantacaoEnviado(int Ind)
        {
            if (String.IsNullOrEmpty(getFieldValueString(string.Format("select IM_ENVIA_EMAIL_POR from AssepontoImplantacoes where IM_IND = {0}",Ind))))
                return false;
            else
                return true;
        }

        public bool getClienteExists(int ind)
        {
            return getFieldValueBool(string.Format("select case when(exists(select * from AssepontoClientes where CAD_IND = {0})) then 1 else 0 end", ind));
        }

        public string getRevendaRazaoSocialFromPedido(int Ind)
        {
            return getFieldValueString(string.Format("SELECT REV_RAZAOSOCIAL FROM AssepontoRevendas INNER JOIN AssepontoPedidosRevendas ON PED_REV_IND = REV_IND WHERE PED_IND = {0}", Ind));
        }

        public int getCountPedidosAberto()
        {
            return getFieldValueInteger(string.Format("SELECT COUNT(PED_IND) FROM AssepontoPedidosRevendas WHERE (PED_STATUS = 1)"));
        }

        public string getRevendaEmailFromPedido(int Ind)
        {
            return getFieldValueString(string.Format("SELECT REV_EMAIL FROM AssepontoRevendas INNER JOIN AssepontoPedidosRevendas ON PED_REV_IND = REV_IND WHERE PED_IND = {0}", Ind));
        }

        public string getRevendaEmailFromPedido2(int Ind)
        {
            return getFieldValueString(string.Format("SELECT REV_EMAIL2 FROM AssepontoRevendas INNER JOIN AssepontoPedidosRevendas ON PED_REV_IND = REV_IND WHERE PED_IND = {0}", Ind));
        }

        public string getRevendaEmail(int Ind)
        {
            return getFieldValueString(string.Format("SELECT REV_EMAIL FROM AssepontoRevendas WHERE REV_IND = {0}", Ind));
        }

        public string getRevendaEmail2(int Ind)
        {
            return getFieldValueString(string.Format("SELECT REV_EMAIL2 FROM AssepontoRevendas WHERE REV_IND = {0}", Ind));
        }

        public string getClienteRazaoSocialFromPedido(int Ind)
        {
            return getFieldValueString(string.Format("SELECT PED_CLI_RAZAO FROM AssepontoPedidosRevendas WHERE PED_IND = {0}", Ind));
        }

        public string getRepFromPedido(int Ind)
        {
            return getFieldValueString(string.Format("SELECT RTRIM(FABR_NOME) + ':' + PED_MODELOREP FROM AssepontoPedidosRevendas INNER JOIN AssepontoRepFabricantes ON FABR_COD = PED_REP_FABRICANTE WHERE PED_IND = {0}", Ind));
        }

        public string getVersaoFromPedido(int Ind)
        {
            return getFieldValueString(string.Format("SELECT VERS4_DESCRICAO FROM AssepontoPedidosRevendas INNER JOIN Asseponto4Versoes ON VERS4_COD = PED_VERSAO_AQUISICAO WHERE PED_IND = {0}", Ind));
        }

        public string getClienteRazaoSocialFromPendencia(int Ind)
        {
            return getFieldValueString(string.Format("SELECT CAD_RAZAOSOCIAL FROM AssepontoClientes INNER JOIN AssepontoPendencias ON PEN_INDCADASTRO = CAD_IND WHERE PEN_IND = {0}", Ind));
        }

        public int getClienteFromPendencia(int Ind)
        {
            return getFieldValueInteger(string.Format("SELECT PEN_INDCADASTRO FROM AssepontoPendencias WHERE PEN_IND = {0}", Ind));
        }

        public string getEmailClienteFromPendencia(int Ind)
        {
            return getFieldValueString(string.Format("SELECT CAD_EMAIL FROM AssepontoPendencias INNER JOIN AssepontoClientes ON CAD_IND = PEN_INDCADASTRO WHERE PEN_IND = {0}", Ind));
        }

        public string getEmailClienteFromPendencia2(int Ind)
        {
            return getFieldValueString(string.Format("SELECT CAD_EMAIL2 FROM AssepontoPendencias INNER JOIN AssepontoClientes ON CAD_IND = PEN_INDCADASTRO WHERE PEN_IND = {0}", Ind));
        }

        public string getEmailRevendaFromPendencia(int Ind)
        {
            return getFieldValueString(string.Format("SELECT REV_EMAIL FROM AssepontoPendencias INNER JOIN AssepontoClientes ON CAD_IND = PEN_INDCADASTRO LEFT JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA WHERE PEN_IND = {0}", Ind));
        }

        public string getEmailRevendaFromPendencia2(int Ind)
        {
            return getFieldValueString(string.Format("SELECT REV_EMAIL2 FROM AssepontoPendencias INNER JOIN AssepontoClientes ON CAD_IND = PEN_INDCADASTRO LEFT JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA WHERE PEN_IND = {0}", Ind));
        }

        public string getProtocoloFromPendencia(int Ind)
        {
            return getFieldValueString(string.Format("SELECT PEN_PROTOCOLO FROM AssepontoPendencias WHERE PEN_IND = {0}", Ind));
        }

        public int getImplantacaoFromPendencia(int Ind)
        {
            return getFieldValueInteger(string.Format("SELECT PEN_IMPLANTACAO FROM AssepontoPendencias WHERE PEN_IND = {0}", Ind));
        }

        public string getDataFromPedido(int Ind)
        {
            return getFieldValueString(string.Format("SELECT dbo.fn_asseponto_datetostr(PED_DATA) FROM AssepontoRevendas INNER JOIN AssepontoPedidosRevendas ON PED_REV_IND = REV_IND WHERE PED_IND = {0}", Ind));
        }

        public string getDataFechamentoFromPedido(int Ind)
        {
            return getFieldValueString(string.Format("SELECT dbo.fn_asseponto_datetostr(PED_DATAFECHAMENTO) FROM AssepontoRevendas INNER JOIN AssepontoPedidosRevendas ON PED_REV_IND = REV_IND WHERE PED_IND = {0}", Ind));
        }

        public string getRevendaRazaoSocial(int Ind)
        {
            return getFieldValueString(string.Format("SELECT dbo.fn_asseponto_capital(REV_RAZAOSOCIAL) FROM AssepontoRevendas WHERE REV_IND = {0}", Ind));
        }

        public string getClienteRazaoSocial(int Ind)
        {
            return getFieldValueString(string.Format("SELECT dbo.fn_asseponto_capital(CAD_RAZAOSOCIAL) FROM AssepontoClientes WHERE CAD_IND = {0}", Ind));
        }

        public string getClienteCnpjCpf(int Ind)
        {
            return getFieldValueString(string.Format("SELECT dbo.fn_cliente_cnpj_cpf(CAD_IND) FROM AssepontoClientes WHERE CAD_IND = {0}", Ind));
        }

        public string getClienteOrRevendaCnpjCpf(int Ind)
        {
            return getFieldValueString(string.Format(@"select top 1 
		                                                        case 
			                                                        when MNT_CLIENTE is not null
			                                                        then dbo.fn_asseponto_trim_cnpj(CAD_CNPJ) 
			                                                        else dbo.fn_asseponto_trim_cnpj(REV_CNPJ) 
		                                                        end
                                                        from AssepontoClientes
                                                        left join AssepontoManutencao on MNT_CLIENTE = CAD_IND
                                                        inner join AssepontoRevendas on REV_IND = CAD_REVENDA
                                                        where CAD_IND = {0} 
                                                        order by MNT_DATA desc", Ind));
        }

        public string getClienteRazaoSocialFromImplantacao(int Ind)
        {
            return getFieldValueString(string.Format("SELECT dbo.fn_asseponto_capital(CAD_RAZAOSOCIAL) FROM AssepontoImplantacoes INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE WHERE IM_IND = {0}", Ind));
        }

        public string getClienteEmailFromImplantacao(int Ind)
        {
            return getFieldValueString(string.Format("SELECT CAD_EMAIL FROM AssepontoImplantacoes INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE WHERE IM_IND = {0}", Ind));
        }

        public string getClienteContatosFromImplantacao(int Ind)
        {
            return getFieldValueString(string.Format("select ISNULL(CAD_CONTATO, ISNULL(CAD_CONTATO2, ISNULL(CAD_CONTATO3, ''))) from AssepontoImplantacoes Inner Join AssepontoClientes on CAD_IND = IM_CLIENTE where IM_IND = {0}", Ind));
        }

        public string getSuporteNomeFromImplantacao(int Ind)
        {
            return getFieldValueString(string.Format("select SUP_NOME from AssepontoImplantacoes inner join AssepontoSuporte a on SUP_IND = IM_ENVIA_EMAIL_POR where IM_IND = {0}", Ind));
        }

        public string getClienteEmailFromImplantacao2(int Ind)
        {
            return getFieldValueString(string.Format("SELECT CAD_EMAIL2 FROM AssepontoImplantacoes INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE WHERE IM_IND = {0}", Ind));
        }

        public int getAndamentoFromImplantacao(int Ind)
        {
            return getFieldValueInteger(string.Format("SELECT IM_ANDAMENTO FROM AssepontoImplantacoes WHERE IM_IND = {0}", Ind));
        }

        public string getClienteIndiceFromImplantacao(int Ind)
        {
            return getFieldValueString(string.Format("SELECT IM_CLIENTE FROM AssepontoImplantacoes WHERE IM_IND = {0}", Ind));
        }

        public string getClienteRevendaEmail(int Ind)
        {
            return getFieldValueString(string.Format("SELECT REV_EMAIL FROM AssepontoRevendas INNER JOIN AssepontoClientes ON REV_IND = CAD_REVENDA WHERE CAD_IND = {0}", Ind));
        }

        public string getRevendaEmailFromUsuariosRevendas(int Ind)
        {
            return getFieldValueString(string.Format("SELECT REV_EMAIL FROM AssepontoRevendas INNER JOIN AssepontoUsuariosRevendas ON USUREV_REVENDA = REV_IND WHERE USUREV_IND = {0}", Ind));
        }

        public string getRevendaRazaoSocialFromUsuariosRevendas(int Ind)
        {
            return getFieldValueString(string.Format("SELECT REV_RAZAOSOCIAL FROM AssepontoRevendas INNER JOIN AssepontoUsuariosRevendas ON USUREV_REVENDA = REV_IND WHERE USUREV_IND = {0}", Ind));
        }

        public string getRevendaCnpjCpf(int Ind)
        {
            return getFieldValueString(string.Format("SELECT dbo.fn_Revenda_cnpj_cpf(REV_IND) FROM AssepontoRevendas WHERE REV_IND = {0}", Ind));
        }

        public string getLoginFromUsuariosRevendas(int Ind)
        {
            return getFieldValueString(string.Format("SELECT USUREV_LOGIN FROM AssepontoUsuariosRevendas WHERE USUREV_IND = {0}", Ind));
        }

        public string getLoginFromContatoRevendas(int Ind)
        {
            return getFieldValueString(string.Format("SELECT dbo.fn_asseponto_capital(REV_CONTATO) FROM AssepontoRevendas INNER JOIN AssepontoUsuariosRevendas ON USUREV_REVENDA = REV_IND WHERE USUREV_IND = {0}", Ind));
        }

        public string getPasswordFromUsuariosRevendas(int Ind)
        {
            return getFieldValueString(string.Format("SELECT USUREV_PWD FROM AssepontoUsuariosRevendas WHERE USUREV_IND = {0}", Ind));
        }

        public void updatePendencia(string Descricao, int Pendencia)
        {
            executeCommand(String.Format("UPDATE AssepontoPendencias SET PEN_PROBLEMA = '{0}', PEN_DATAHORA = GETDATE() WHERE PEN_IND = {1}", Descricao, Pendencia));
        }

        public void saveLogin(int Revenda, string Login)
        {
            executeCommand(String.Format("EXEC asseponto_revenda_login @P_REVENDA = {0}, @P_LOGIN = '{1}'", Revenda, Login));
        }

        public void saveRevendaLoginDataAcesso(string Login)
        {
            executeCommand(String.Format("UPDATE AssepontoUsuariosRevendas SET USUREV_ACESSO_ANTERIOR = USUREV_ULTIMO_ACESSO, USUREV_ULTIMO_ACESSO = GETDATE() WHERE USUREV_LOGIN = '{0}'", Login));
        }

        public void setImplantacaoStatusFinalizado(int user, int Implantacao)
        {
            executeCommand(String.Format("UPDATE AssepontoImplantacoes SET IM_STATUS = 2, IM_FINALIZADO_POR = {1}, IM_AGENDA_CONCLUIDO_POR = {1}, IM_TERMINO = GETDATE() WHERE IM_IND = {0}", Implantacao, user));
        }

        public void setImplantacaoAgendaFinalizada(int user, int agenda)
        {
            executeCommand(String.Format("UPDATE AssepontoImplantacoesAgenda SET AGE_FINALIZADO_EM = GETDATE(),	AGE_FINALIZADO_POR = {1} WHERE AGE_IND = {0}", agenda, user));
        }

        public int getImplantacaoStatusFinalizado(int Implantacao)
        {
            return getFieldValueInteger(String.Format("SELECT IM_STATUS FROM AssepontoImplantacoes WHERE IM_IND = {0}", Implantacao));
        }

        public int getImplantacaoNPendencias(int Implantacao)
        {
            return getFieldValueInteger(String.Format("SELECT COUNT(*) FROM AssepontoPendencias WHERE PEN_IMPLANTACAO = {0}", Implantacao));
        }

        public void setImplantacaoInicioImplantacao(int Implantacao)
        {
            executeCommand(String.Format("UPDATE AssepontoImplantacoes SET IM_INICIO_IMPLANTACAO = GETDATE() WHERE IM_IND = {0}", Implantacao));
        }

        public string getEmailFromSuporte(int Suporte)
        {
            return ConfigurationManager.AppSettings["EMAILSENDER"];
            //return getFieldValueString(String.Format("SELECT SUP_EMAIL FROM AssepontoSuporte WHERE SUP_IND = {0}", Suporte));
        }

        public string getEmailFromCliente(int Cliente)
        {
            return getFieldValueString(String.Format("SELECT CAD_EMAIL FROM AssepontoClientes WHERE CAD_IND = {0}", Cliente));
        }

        public string getEmailFromCliente2(int Cliente)
        {
            return getFieldValueString(String.Format("SELECT CAD_EMAIL2 FROM AssepontoClientes WHERE CAD_IND = {0}", Cliente));
        }

        public string getAndamentoImplantacao(int Cliente)
        {
            return getFieldValueString(String.Format("SELECT STAT_NOME FROM AssepontoImplantacoesStatus INNER JOIN AssepontoImplantacoes ON IM_ANDAMENTO = STAT_IND WHERE IM_ANDAMENTO <> 7 AND IM_CLIENTE = {0}", Cliente));
        }

        public int getRelatorioPedidosRep(int mes, int ano, int rep)
        {
            return getFieldValueInteger(String.Format("SELECT COUNT(DISTINCT IM_IND) FROM AssepontoClientes LEFT JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND WHERE (MONTH(IM_INICIO) = {0} AND YEAR(IM_INICIO) = {1} AND CAD_REP_FABRICANTE = {2}) OR (MONTH(IM_INICIO) = {0} AND YEAR(IM_INICIO) = {1} AND {2} = 0)", mes, ano, rep));
        }

        public int getRelatorioImplantacaoIncompleto(int mes, int ano)
        {
            return getFieldValueInteger(String.Format("SELECT COUNT(CAD_RAZAOSOCIAL) AS QtdFinalizadas FROM AssepontoClientes INNER JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND WHERE IM_STATUS = 2 AND MONTH(IM_TERMINO) = {0} AND IM_ANDAMENTO != 7 AND YEAR(IM_TERMINO) = {1}", mes, ano));
        }

        public int getRelatorioManuntecaoRep(int mes, int ano, int rep)
        {
            return getFieldValueInteger(String.Format("SELECT COUNT(CAD_IND) FROM AssepontoManutencao INNER JOIN AssepontoClientes ON CAD_IND = MNT_CLIENTE LEFT JOIN AssepontoVersoes ON VER_COD = MNT_VERSAO_ASSEPONTO WHERE (MONTH(MNT_DATA) = {0} AND YEAR(MNT_DATA) = {1} AND CAD_REP_FABRICANTE = {2}) OR (MONTH(MNT_DATA) = {0} AND YEAR(MNT_DATA) = {1} AND {2} = 0)", mes, ano, rep));
        }

        public int getCountImplantacaoAndamento(int Andamento, int Status, int PontoWeb = 0)
        {
            return getFieldValueInteger(String.Format("SELECT COUNT(IM_ANDAMENTO) FROM AssepontoImplantacoes WHERE IM_ANDAMENTO = {0} AND IM_STATUS = {1} AND (IM_ASSEPONTOWEB = {2} OR IM_VERSAO = 8)", Andamento, Status, PontoWeb));
        }

        public int getCountImplantacaoAndamentoTipo(int Andamento, int Status, int tipo, bool assepontoweb = false)
        {
            if (!assepontoweb)
                return getFieldValueInteger(String.Format("SELECT COUNT(IM_ANDAMENTO) FROM AssepontoImplantacoes WHERE IM_ANDAMENTO = {0} AND IM_STATUS = {1} AND IM_ANDAMENTO_TIPO = {2} and IM_VERSAO != 8", Andamento, Status, tipo));
            else
                return getFieldValueInteger(String.Format("SELECT COUNT(IM_ANDAMENTO) FROM AssepontoImplantacoes WHERE IM_ANDAMENTO = {0} AND IM_STATUS = {1} AND IM_ANDAMENTO_TIPO = {2} AND IM_VERSAO = 8", Andamento, Status, tipo));
        }

        public int getCountRevendaCadastradas(int ind, int ano)
        {
            return getFieldValueInteger(String.Format("SELECT COUNT(DISTINCT REV_RAZAOSOCIAL) AS NOME FROM AssepontoRevendas INNER JOIN AssepontoRevendasReps ON REVREP_REVENDA = REV_IND WHERE " +
                           "MONTH(REV_DATA_CADASTRO) = {0} AND YEAR(REV_DATA_CADASTRO) = {1}", ind, ano));
        }

        public int getCountSolicitacoesCliente()
        {
            return getFieldValueInteger("SELECT COUNT(*) FROM AssepontoSolicitacoes " +
                                        "OUTER APPLY(SELECT CAD_IND FROM AssepontoClientes WHERE ASOL_CLIENTE = CAD_IND) A " +
                                        "OUTER APPLY(SELECT CADP_IND FROM AssepontoClientesProvisorios WHERE ASOL_CLIENTE_PROVISORIO = CADP_IND) B " +
                                        "WHERE ASOL_LIBERADO_MANUAL = 0 AND ASOL_LIBERADOEM IS NULL AND (CAD_IND IS NOT NULL OR CADP_IND IS NOT NULL)");
        }


        public int getCountSolicitacoesRevenda()
        {
            return getFieldValueInteger("SELECT COUNT(*) FROM AssepontoRevendasProvisorios WHERE CADP_REV_LIBERADO_EM IS NULL");
        }

        public int getCountTreinamentoCliente(int mes, int ano)
        {
            return getFieldValueInteger(String.Format("SELECT COUNT(*) FROM AssepontoAgendaTreinamentos INNER JOIN AssepontoAgendaClientes ON AGE_IND = AGECLI_AGENDA " +
                                    "WHERE MONTH(AGE_DATA_HORA) = {0} AND YEAR(AGE_DATA_HORA) = {1} AND AGE_REALIZADO = 1 AND AGE_CANCELADO = 0 AND AGE_ASSEPONTO4 = 1 ", mes, ano));
        }

        public int getCountQuestionarioTrienamento(int mes, int ano)
        {
            return getFieldValueInteger(String.Format("SELECT COUNT(*) FROM AssepontoQuestTreinamento WHERE QUEST_TREI_ATUALIZACAO IS NOT NULL AND MONTH(QUEST_TREI_DATA) = {0} AND YEAR(QUEST_TREI_DATA) = {1}", mes, ano));
        }

        public int getCountQuestionarioCliente(int mes, int ano)
        {
            return getFieldValueInteger(String.Format("SELECT COUNT(*) FROM AssepontoQuestAtendimento WHERE QUEST_DATA_ATUALIZACAO IS NOT NULL AND MONTH(QUEST_DATA_ATUALIZACAO) = {0} AND YEAR(QUEST_DATA_ATUALIZACAO) = {1}", mes, ano));
        }

        public int getCountCertificadoNaoEnviado(int mes, int ano)
        {
            return getFieldValueInteger(String.Format("SELECT COUNT(DISTINCT IM_IND) FROM AssepontoClientes LEFT JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND WHERE MONTH(IM_INICIO) = {0} AND YEAR(IM_INICIO) = {1} AND CAD_DTA_CERTIFICADO IS NULL AND IM_ASSEPONTO4 = 1", mes, ano));
        }

        public int getCountCertificadoEnviado(int mes, int ano)
        {
            return getFieldValueInteger(String.Format("SELECT COUNT(DISTINCT IM_IND) FROM AssepontoClientes LEFT JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND WHERE MONTH(IM_INICIO) = {0} AND YEAR(IM_INICIO) = {1} AND CAD_DTA_CERTIFICADO IS NOT NULL AND IM_ASSEPONTO4 = 1", mes, ano));
        }

        public int getCountEmpresasExpiradas(int mes, int ano)
        {
            return getFieldValueInteger(string.Format("SELECT COUNT(*) AS QtdPedido " +
                                                      "FROM AssepontoClientes " +
                                                      "CROSS APPLY( SELECT TOP 1 * " +
                                                                   "FROM AssepontoNSeries " +
                                                                   "WHERE NSE_CLIENTE = CAD_IND AND " +
                                                                         "NSE_SOLICITACAO = 1 " +
                                                                   "ORDER BY NSE_DATA ) a " +
                                                      "INNER JOIN AssepontoRevendas on REV_IND = CAD_REVENDA " +
                                                      "WHERE dbo.fn_asseponto_cliente_tem_manutencao_ativa(CAD_IND) = 0 AND " +
                                                            "CAD_RAZAOSOCIAL NOT LIKE '%excluir%' AND CAD_TESTE = 0 AND " +
                                                            "MONTH(NSE_DATA) = {0} AND YEAR(NSE_DATA) = {1} AND " +
                                                            "DATEDIFF(DAY, NSE_DATA, GETDATE()) > 60 AND " +
                                                            "(REV_COBRAR_CLIENTES IS NOT NULL AND REV_COBRAR_CLIENTES <> 0)", mes, ano));
        }

        public int getCountEmpresasExpiradasByRevenda(int rev, int mes, int ano)
        {
            return getFieldValueInteger(string.Format(@"SELECT COUNT(*) AS QtdPedido 
                                                      FROM AssepontoClientes 
                                                      CROSS APPLY( SELECT TOP 1 * 
                                                                   FROM AssepontoNSeries 
                                                                   WHERE NSE_CLIENTE = CAD_IND AND 
                                                                         NSE_SOLICITACAO = 1 
                                                                   ORDER BY NSE_DATA ) a 
                                                      INNER JOIN AssepontoRevendas on REV_IND = CAD_REVENDA 
                                                      WHERE REV_IND = {0} and --dbo.fn_asseponto_cliente_tem_manutencao_ativa(CAD_IND) = 0 AND 
                                                            MONTH(NSE_DATA) = {1} AND YEAR(NSE_DATA) = {2} AND 
                                                            DATEDIFF(DAY, NSE_DATA, GETDATE()) > 60 ", rev, mes, ano));
        }

        public int getCountImplantacaoAgendasHoje()
        {
            return getFieldValueInteger("select COUNT(*) FROM AssepontoImplantacoesAgenda INNER JOIN AssepontoImplantacoes ON AGE_IMPLANTACAO = IM_IND INNER JOIN AssepontoImplantacoesStatus ON STAT_IND = IM_ANDAMENTO INNER JOIN AssepontoImplantacoesStatusTipo on TIPO_STAT_IND = IM_ANDAMENTO_TIPO WHERE CONVERT(DATE, AGE_DATA) <= CONVERT(DATE, GETDATE()) AND AGE_FINALIZADO_POR IS NULL ");
        }

        public DateTime getUltimoEnvioBAA()
        {
            return getFieldValueDateTime("SELECT TOP 1 BAA_DATAINICIO_SESSION FROM BeAnywhereAtendimento ORDER BY BAA_DATAINICIO_SESSION DESC");
        }

        public DataTable getCadastroUltimaAtualizacao(int ind)
        {
            return getDataTable(string.Format("SELECT SUP_NOME, CAD_CADASTRO_ATUALIZADOEM FROM AssepontoClientes INNER JOIN AssepontoSuporte ON SUP_IND = CAD_CADASTRO_ATUALIZADOPOR WHERE CAD_IND = {0}", ind));
        }

        public DataTable getRevendaUltimaAtualizacao(int ind)
        {
            return getDataTable(string.Format("SELECT SUP_NOME, REV_CADASTRO_ATUALIZADOEM FROM AssepontoRevendas INNER JOIN AssepontoSuporte ON SUP_IND = REV_CADASTRO_ATUALIZADOPOR WHERE REV_IND = {0}", ind));
        }

        public void setCadastroAtualizado(int userId, int ind)
        {
            executeCommand(string.Format("UPDATE AssepontoClientes SET CAD_CADASTRO_ATUALIZADOEM = GETDATE(), CAD_CADASTRO_ATUALIZADOPOR = {0} WHERE CAD_IND = {1}", userId, ind));
        }

        public void setRevendaCadastroAtualizado(int userId, int ind)
        {
            executeCommand(string.Format("UPDATE AssepontoRevendas SET REV_CADASTRO_ATUALIZADOEM = GETDATE(), REV_CADASTRO_ATUALIZADOPOR = {0} WHERE REV_IND = {1}", userId, ind));
        }

        public Decimal getValorAtendimentoAvulso30()
        {
            return getFieldValueDecimal("SELECT TOP 1 APLAN_VALUE FROM AssepontoPlanos WHERE APLAN_VALOR_AVULSO_30_DIAS = 1");
        }

        public Decimal getValorAtendimentoAvulso()
        {
            return getFieldValueDecimal("SELECT TOP 1 APLAN_VALUE FROM AssepontoPlanos WHERE APLAN_VALOR_AVULSO_POR_ATENDIMENTO = 1");
        }

        public int getMaximoFuncionarios()
        {
            return getFieldValueInteger("SELECT TOP 1 APLAN_QTD_FUNC FROM AssepontoPlanos ORDER BY APLAN_QTD_FUNC DESC");
        }

        public Boolean getComunicadoHabilitado()
        {
           return getFieldValueBool("SELECT CONFG_ENVIO_COMUNICADO FROM AssepontoConfiguracao WHERE CONFG_IND = 1");
        }
    }

    public class BDAppAssecontweb : BD
    {
        public BDAppAssecontweb()
        {
            BDConnection conn = new BDConnection("200.170.88.138", "assecont2", "assecont5272", "*h6prMvr");
            //Conectar("200.170.88.138", "assecont2", "assecont5272", "*h6prMvr");
            Conectar(conn);
        }
    }
}