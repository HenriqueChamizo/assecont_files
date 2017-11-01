using System;
using System.Data;

namespace Assecontweb.Classes.Views
{
    public class BDAppSped : Assecontweb.Classes.BDApp
    {
        //public BDAppSped()
        //{
        //    Conectar();
        //} 

        public DataTable getSpedClientes(int top, DateTime competencia, int clienteId)
        {
            Decimal total = getTotalProdutos(competencia.Month, competencia.Year, clienteId);

            return getDataTable(String.Format("SELECT TOP {0} PART_NOME AS NOME, (CASE WHEN PART_CNPJ IS NULL THEN dbo.fn_format_cpf(PART_CPF) ELSE dbo.fn_format_cnpj(PART_CNPJ) END) AS 'CNPJ/CPF',  " + 
                    "SUM(PRO_QUANTIDADE) AS QUANTIDADE, SUM(PRO_VALOR) AS VALOR, " +
                    "SUM(PRO_VALOR) * 100 / {1} AS PORCENTAGEM  " +
                    "FROM SpedParticipantes   " +
                    "INNER JOIN SpedNotasFiscais ON NOT_PARTICIPANTE = PART_IND    " +
                    "INNER JOIN SpedProdutos ON NOT_IND = PRO_NOTAFISCAL     " +
                    "WHERE MONTH(NOT_DATA_EMISSAO) = {2} AND YEAR(NOT_DATA_EMISSAO) = {3} AND NOT_EMPRESA = {4} " +
                    "GROUP BY PART_NOME, PART_CNPJ, PART_CPF    " +
                    "ORDER BY SUM(PRO_VALOR) DESC", top, total, competencia.Month, competencia.Year, clienteId));
        }

        public DataTable getSpedProdutos(int top, DateTime competencia, int clienteId)
        {
            Decimal total = getTotalProdutos(competencia.Month, competencia.Year, clienteId);

            return getDataTable(String.Format("SELECT TOP {0} PRO_CODIGO AS CODIGO, PRO_DESCRICAO AS DESCRICAO, PRO_COD_NCM AS NCM, SUM(PRO_QUANTIDADE) AS QUANTIDADE, SUM(PRO_VALOR) AS VALOR,  " +
				"SUM(PRO_VALOR) * 100 / {1} AS PORCENTAGEM  " +
				"FROM SpedProdutos  " +
				"INNER JOIN SpedNotasFiscais ON NOT_IND = PRO_NOTAFISCAL   " +
				"INNER JOIN SpedParticipantes ON NOT_PARTICIPANTE = PART_IND  " +
				"WHERE MONTH(NOT_DATA_EMISSAO) = {2} AND YEAR(NOT_DATA_EMISSAO) = {3} AND NOT_EMPRESA = {4}  " +
                "GROUP BY PRO_CODIGO, PRO_DESCRICAO, PRO_COD_NCM  " +
                "ORDER BY SUM(PRO_VALOR) DESC", top, total, competencia.Month, competencia.Year, clienteId));
        }

        public Decimal getTotalProdutos(int mes, int ano, int clienteId)
        {
            return getFieldValueDecimal(String.Format("SELECT SUM(PRO_VALOR) FROM SpedProdutos  " +
		                "INNER JOIN SpedNotasFiscais ON NOT_IND = PRO_NOTAFISCAL " +
		                "INNER JOIN SpedParticipantes ON NOT_PARTICIPANTE = PART_IND " +
                        "WHERE MONTH(NOT_DATA_EMISSAO) = {0} AND YEAR(NOT_DATA_EMISSAO) = {1} AND NOT_EMPRESA = {2}", mes, ano, clienteId));
        }
    }
}
