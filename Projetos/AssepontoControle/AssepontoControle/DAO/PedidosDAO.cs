using DAO.Interfaces;
using Modelo.Asseponto;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace DAO
{
    public class PedidosDAO : IDAO
    {
        SqlConnection conn;
        SqlCommand cmd;

        public void SetValuesConnection(Connection connection)
        {
            conn = new SqlConnection(connection.connectionstring);
        }

        public PedidoDetail GetPedidobyId(int ind)
        {
            List<PedidoDetail> pedidos = new List<PedidoDetail>();
            try
            {
                string select =
                    @"SELECT PED_IND, PED_REV_IND, PED_CLI_RAZAO, PED_CLI_CNPJ, PED_CLI_CPF, PED_CLI_IE, PED_CLI_ENDERECO, 
	                         PED_CLI_ENDERECO_NUMERO, PED_CLI_ENDERECO_COMPLEMENTO, PED_CLI_CEP, PED_CLI_BAIRRO, PED_CLI_CIDADE, 
                             PED_CLI_UF, PED_CLI_EMAIL, PED_SKYPE, PED_CLI_TELEFONE, PED_CLI_TELEFONE_DDD, PED_CLI_QTD_FUNCIONA, 
	                         PED_CLI_CONTATO, PED_VERSAO_AQUISICAO, PED_EMAIL2, CASE PED_COM_MANUTENCAO WHEN 1 THEN 'True' ELSE 'False' END AS PED_COM_MANUTENCAO, 
	                         PED_MODELOREP, CASE WHEN PED_REPINSTALADO = 1 THEN 'True' ELSE 'False' END AS PED_REPINSTALADO, 
	                         PED_DESCRICAO, PED_SITUACAO, PED_SOLICITANTE, PED_DATA_FECHAMENTO, PED_REP_FABRICANTE, PED_CLI_TELEFONE2, 
	                         PED_CLI_TELEFONE2_DDD, PED_CLI_CELULAR, PED_CLI_CELULAR_DDD, PED_CLI_CELULAR_ACEITA, PED_FANTASIA, 
	                         PED_DATA, PED_STATUS, PED_PLANILHA_EXCEL 
                        FROM AssepontoPedidosRevendas 
                        WHERE (PED_IND = @PED_IND)";

                conn.Open();
                cmd = new SqlCommand(select, conn);
                cmd.Parameters.AddWithValue("@PED_IND", ind);

                DbDataReader er = cmd.ExecuteReader();
                //DataTable dataTable = er.GetSchemaTable();

                PedidoDetail pedido;
                while (er.Read())//for (int i = 0; i < dataTable.Rows.Count; i++) //(DataRowCollection row in dataTable.Rows)
                {
                    //DataRow row = dataTable.Rows[i];
                    pedido = new PedidoDetail();

                    #region Parametrização
                    pedido.PED_IND = Convert.ToInt32(er["PED_IND"]);
                    pedido.PED_REV_IND = Convert.ToInt32(er["PED_REV_IND"]);
                    pedido.PED_CLI_RAZAO = Convert.ToString(er["PED_CLI_RAZAO"]);
                    pedido.PED_CLI_CNPJ = Convert.ToString(er["PED_CLI_CNPJ"]);
                    pedido.PED_CLI_CNPJ = Convert.ToString(er["PED_CLI_CNPJ"]);
                    pedido.PED_CLI_CPF = Convert.ToString(er["PED_CLI_CPF"]);
                    pedido.PED_CLI_IE = Convert.ToString(er["PED_CLI_IE"]);
                    pedido.PED_CLI_ENDERECO = Convert.ToString(er["PED_CLI_ENDERECO"]);
                    pedido.PED_CLI_ENDERECO_NUMERO = Convert.ToString(er["PED_CLI_ENDERECO_NUMERO"]);
                    pedido.PED_CLI_ENDERECO_COMPLEMENTO = Convert.ToString(er["PED_CLI_ENDERECO_COMPLEMENTO"]);
                    pedido.PED_CLI_CEP = Convert.ToString(er["PED_CLI_CEP"]);
                    pedido.PED_CLI_BAIRRO = Convert.ToString(er["PED_CLI_BAIRRO"]);
                    pedido.PED_CLI_CIDADE = Convert.ToString(er["PED_CLI_CIDADE"]);
                    pedido.PED_CLI_UF = Convert.ToString(er["PED_CLI_UF"]);
                    pedido.PED_CLI_EMAIL = Convert.ToString(er["PED_CLI_EMAIL"]);
                    pedido.PED_SKYPE = Convert.ToString(er["PED_SKYPE"]);
                    pedido.PED_CLI_TELEFONE = Convert.ToString(er["PED_CLI_TELEFONE"]);
                    pedido.PED_CLI_TELEFONE_DDD = Convert.ToString(er["PED_CLI_TELEFONE_DDD"]);
                    pedido.PED_CLI_QTD_FUNCIONA = Convert.ToInt32(er["PED_CLI_QTD_FUNCIONA"]);
                    pedido.PED_CLI_CONTATO = Convert.ToString(er["PED_CLI_CONTATO"]);
                    pedido.PED_VERSAO_AQUISICAO = Convert.ToInt32(er["PED_VERSAO_AQUISICAO"]);
                    pedido.PED_EMAIL2 = Convert.ToString(er["PED_EMAIL2"]);
                    pedido.PED_COM_MANUTENCAO = Convert.ToBoolean(er["PED_COM_MANUTENCAO"]);
                    pedido.PED_MODELOREP = Convert.ToString(er["PED_MODELOREP"]);
                    pedido.PED_REPINSTALADO = Convert.ToBoolean(er["PED_REPINSTALADO"]);
                    pedido.PED_DESCRICAO = Convert.ToString(er["PED_DESCRICAO"]);
                    pedido.PED_SITUACAO = Convert.ToString(er["PED_SITUACAO"]);
                    pedido.PED_SOLICITANTE = Convert.ToString(er["PED_SOLICITANTE"]);
                    pedido.PED_DATA_FECHAMENTO = Convert.ToDateTime(er["PED_DATA_FECHAMENTO"] is DBNull ? DateTime.MinValue : er["PED_DATA_FECHAMENTO"]);
                    pedido.PED_REP_FABRICANTE = Convert.ToInt32(er["PED_REP_FABRICANTE"]);
                    pedido.PED_CLI_TELEFONE2 = Convert.ToString(er["PED_CLI_TELEFONE2"]);
                    pedido.PED_CLI_TELEFONE2_DDD = Convert.ToString(er["PED_CLI_TELEFONE2_DDD"]);
                    pedido.PED_CLI_CELULAR = Convert.ToString(er["PED_CLI_CELULAR"]);
                    pedido.PED_CLI_CELULAR_DDD = Convert.ToString(er["PED_CLI_CELULAR_DDD"]);
                    pedido.PED_CLI_CELULAR_ACEITA = Convert.ToBoolean(er["PED_CLI_CELULAR_ACEITA"]);
                    pedido.PED_FANTASIA = Convert.ToString(er["PED_FANTASIA"]);
                    pedido.PED_DATA = Convert.ToDateTime(er["PED_DATA"]);
                    pedido.PED_STATUS = Convert.ToInt32(er["PED_STATUS"]);
                    //pedido.PED_PLANILHA_EXCEL = Convert.ToBoolean(er["PED_PLANILHA_EXCEL"]);

                    #endregion
                    pedidos.Add(pedido);
                }
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            if (pedidos.Count > 0)
                return pedidos[0];
            else
                return new PedidoDetail();
        }

        public List<FabricantesDropDrow> GetFabricantesDropDown()
        {
            List<FabricantesDropDrow> fabricantes = new List<FabricantesDropDrow>();
            try
            {
                string select =
                    @"SELECT [FABR_NOME], [FABR_COD], [FABR_ATIVO] FROM [AssepontoRepFabricantes] WHERE ([FABR_ATIVO] = 1) ORDER BY [FABR_NOME]";

                conn.Open();
                cmd = new SqlCommand(select, conn);

                DbDataReader er = cmd.ExecuteReader();
                //DataTable dataTable = er.GetSchemaTable();

                FabricantesDropDrow fabricante;
                while (er.Read())//for (int i = 0; i < dataTable.Rows.Count; i++) //(DataRowCollection row in dataTable.Rows)
                {
                    //DataRow row = dataTable.Rows[i];
                    fabricante = new FabricantesDropDrow();

                    #region Parametrização
                    fabricante.FABR_NOME = Convert.ToString(er["FABR_NOME"]);
                    fabricante.FABR_COD = Convert.ToString(er["FABR_COD"]);
                    fabricante.FABR_ATIVO = Convert.ToString(er["FABR_ATIVO"]);

                    #endregion
                    fabricantes.Add(fabricante);
                }
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            if (fabricantes.Count > 0)
                return fabricantes;
            else
                return new List<FabricantesDropDrow>();
        }

        public void SetPedidos(PedidoDetail pedido)
        {
            try
            {
                string update = 
                    @"UPDATE AssepontoPedidosRevendas 
                             SET PED_CLI_RAZAO = @PED_CLI_RAZAO, 
	                             PED_CLI_CNPJ = @PED_CLI_CNPJ, 
	                             PED_CLI_CPF = @PED_CLI_CPF, 
	                             PED_CLI_IE = @PED_CLI_IE, 
	                             PED_CLI_ENDERECO = @PED_CLI_ENDERECO, 
	                             PED_CLI_ENDERECO_NUMERO = @PED_CLI_ENDERECO_NUMERO, 
	                             PED_CLI_ENDERECO_COMPLEMENTO = @PED_CLI_ENDERECO_COMPLEMENTO, 
	                             PED_CLI_CEP = @PED_CLI_CEP, 
	                             PED_CLI_BAIRRO = @PED_CLI_BAIRRO, 
	                             PED_CLI_CIDADE = @PED_CLI_CIDADE, 
	                             PED_CLI_UF = @PED_CLI_UF, 
	                             PED_CLI_EMAIL = @PED_CLI_EMAIL, 
	                             PED_SKYPE = @PED_SKYPE, 
	                             PED_CLI_TELEFONE = @PED_CLI_TELEFONE, 
	                             PED_CLI_TELEFONE_DDD = @PED_CLI_TELEFONE_DDD, 
	                             PED_CLI_QTD_FUNCIONA = @PED_CLI_QTD_FUNCIONA, 
	                             PED_CLI_CONTATO = @PED_CLI_CONTATO, 
	                             PED_VERSAO_AQUISICAO = @PED_VERSAO_AQUISICAO, 
	                             PED_COM_MANUTENCAO = @PED_COM_MANUTENCAO, 
	                             PED_MODELOREP = @PED_MODELOREP, 
	                             PED_REPINSTALADO = @PED_REPINSTALADO, 
	                             PED_DESCRICAO = @PED_DESCRICAO, 
	                             PED_SOLICITANTE = @PED_SOLICITANTE, 
	                             PED_REP_FABRICANTE = @PED_REP_FABRICANTE, 
	                             PED_FANTASIA = @PED_FANTASIA, 
                                 PED_STATUS = @PED_STATUS, 
	                             PED_EMAIL2 = @PED_EMAIL2, 
	                             PED_CLI_TELEFONE2 = @PED_CLI_TELEFONE2,  
	                             PED_CLI_TELEFONE2_DDD = @PED_CLI_TELEFONE2_DDD,  
	                             PED_CLI_CELULAR = @PED_CLI_CELULAR,  
	                             PED_CLI_CELULAR_DDD = @PED_CLI_CELULAR_DDD,  
	                             PED_CLI_CELULAR_ACEITA = @PED_CLI_CELULAR_ACEITA 
                            WHERE PED_IND = @PED_IND";

                conn.Open();
                cmd = new SqlCommand(update, conn);
                cmd.Parameters.AddWithValue("@PED_IND", pedido.PED_IND);
                cmd.Parameters.AddWithValue("@PED_CLI_RAZAO", pedido.PED_CLI_RAZAO);
                cmd.Parameters.AddWithValue("@PED_CLI_CNPJ", pedido.PED_CLI_CNPJ);
                cmd.Parameters.AddWithValue("@PED_CLI_CPF", pedido.PED_CLI_CPF);
                cmd.Parameters.AddWithValue("@PED_CLI_IE", pedido.PED_CLI_IE);
                cmd.Parameters.AddWithValue("@PED_CLI_ENDERECO", pedido.PED_CLI_ENDERECO);
                cmd.Parameters.AddWithValue("@PED_CLI_ENDERECO_NUMERO", pedido.PED_CLI_ENDERECO_NUMERO);
                cmd.Parameters.AddWithValue("@PED_CLI_ENDERECO_COMPLEMENTO", pedido.PED_CLI_ENDERECO_COMPLEMENTO);
                cmd.Parameters.AddWithValue("@PED_CLI_CEP", pedido.PED_CLI_CEP);
                cmd.Parameters.AddWithValue("@PED_CLI_BAIRRO", pedido.PED_CLI_BAIRRO);
                cmd.Parameters.AddWithValue("@PED_CLI_CIDADE", pedido.PED_CLI_CIDADE);
                cmd.Parameters.AddWithValue("@PED_CLI_UF", pedido.PED_CLI_UF);
                cmd.Parameters.AddWithValue("@PED_CLI_EMAIL", pedido.PED_CLI_EMAIL);
                cmd.Parameters.AddWithValue("@PED_SKYPE", pedido.PED_SKYPE);
                cmd.Parameters.AddWithValue("@PED_CLI_TELEFONE", pedido.PED_CLI_TELEFONE);
                cmd.Parameters.AddWithValue("@PED_CLI_TELEFONE_DDD", pedido.PED_CLI_TELEFONE_DDD);
                cmd.Parameters.AddWithValue("@PED_CLI_QTD_FUNCIONA", pedido.PED_CLI_QTD_FUNCIONA);
                cmd.Parameters.AddWithValue("@PED_CLI_CONTATO", pedido.PED_CLI_CONTATO);
                cmd.Parameters.AddWithValue("@PED_VERSAO_AQUISICAO", pedido.PED_VERSAO_AQUISICAO);
                cmd.Parameters.AddWithValue("@PED_COM_MANUTENCAO", pedido.PED_COM_MANUTENCAO);
                cmd.Parameters.AddWithValue("@PED_MODELOREP", pedido.PED_MODELOREP);
                cmd.Parameters.AddWithValue("@PED_REPINSTALADO", pedido.PED_REPINSTALADO);
                cmd.Parameters.AddWithValue("@PED_DESCRICAO", pedido.PED_DESCRICAO);
                cmd.Parameters.AddWithValue("@PED_SOLICITANTE", pedido.PED_SOLICITANTE);
                cmd.Parameters.AddWithValue("@PED_REP_FABRICANTE", pedido.PED_REP_FABRICANTE);
                cmd.Parameters.AddWithValue("@PED_FANTASIA", pedido.PED_FANTASIA);
                cmd.Parameters.AddWithValue("@PED_STATUS", pedido.PED_STATUS);
                cmd.Parameters.AddWithValue("@PED_EMAIL2", pedido.PED_EMAIL2);
                cmd.Parameters.AddWithValue("@PED_CLI_TELEFONE2", pedido.PED_CLI_TELEFONE2);
                cmd.Parameters.AddWithValue("@PED_CLI_TELEFONE2_DDD", pedido.PED_CLI_TELEFONE2_DDD);
                cmd.Parameters.AddWithValue("@PED_CLI_CELULAR", pedido.PED_CLI_CELULAR);
                cmd.Parameters.AddWithValue("@PED_CLI_CELULAR_DDD", pedido.PED_CLI_CELULAR_DDD);
                cmd.Parameters.AddWithValue("@PED_CLI_CELULAR_ACEITA", pedido.PED_CLI_CELULAR_ACEITA);

                if (cmd.ExecuteNonQuery() == 0)
                    throw new Exception("Nenhuma linha afetada!");
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void SetPedidoGetId(PedidoDetail pedido, ref int ind)
        {
            try
            {
                string insert = "";

                if (!string.IsNullOrEmpty(pedido.PED_CLI_CPF) || !string.IsNullOrEmpty(pedido.PED_CLI_CNPJ))
                {
                    if (!string.IsNullOrEmpty(pedido.PED_CLI_CPF))
                    {
                        insert =
                            @"INSERT INTO AssepontoPedidosRevendas(PED_REV_IND, PED_CLI_RAZAO, PED_CLI_CPF, PED_CLI_IE, PED_CLI_ENDERECO, 
                            PED_CLI_ENDERECO_NUMERO, PED_CLI_ENDERECO_COMPLEMENTO, PED_CLI_CEP, PED_CLI_BAIRRO, PED_CLI_CIDADE, PED_CLI_UF, PED_CLI_EMAIL, 
                            PED_SKYPE, PED_CLI_TELEFONE, PED_CLI_TELEFONE_DDD, PED_CLI_QTD_FUNCIONA, PED_CLI_CONTATO, PED_VERSAO_AQUISICAO, 
                            PED_COM_MANUTENCAO, PED_MODELOREP, PED_REPINSTALADO, PED_DESCRICAO, PED_SOLICITANTE, PED_REP_FABRICANTE, PED_FANTASIA, 
                            PED_STATUS, PED_EMAIL2, PED_ASSEPONTO4, PED_ASSEFIN, PED_CLI_TELEFONE2, PED_CLI_TELEFONE2_DDD, PED_CLI_CELULAR, 
                            PED_CLI_CELULAR_DDD, PED_CLI_CELULAR_ACEITA) 
                            VALUES (@PED_REV_IND, @PED_CLI_RAZAO, '" + pedido.PED_CLI_CPF + @"', @PED_CLI_IE, @PED_CLI_ENDERECO, 
                            @PED_CLI_ENDERECO_NUMERO, @PED_CLI_ENDERECO_COMPLEMENTO, @PED_CLI_CEP, @PED_CLI_BAIRRO, @PED_CLI_CIDADE, @PED_CLI_UF, @PED_CLI_EMAIL, 
                            @PED_SKYPE, @PED_CLI_TELEFONE, @PED_CLI_TELEFONE_DDD, @PED_CLI_QTD_FUNCIONA, @PED_CLI_CONTATO, @PED_VERSAO_AQUISICAO, 
                            @PED_COM_MANUTENCAO, @PED_MODELOREP, @PED_REPINSTALADO, @PED_DESCRICAO, @PED_SOLICITANTE, @PED_REP_FABRICANTE, @PED_FANTASIA, 
                            1, @PED_EMAIL2, 1, 0, @PED_CLI_TELEFONE2, @PED_CLI_TELEFONE2_DDD, @PED_CLI_CELULAR, 
                            @PED_CLI_CELULAR_DDD, @PED_CLI_CELULAR_ACEITA)
                            select SCOPE_IDENTITY()";
                    }

                    if (!string.IsNullOrEmpty(pedido.PED_CLI_CNPJ))
                    {
                        insert =
                            @"INSERT INTO AssepontoPedidosRevendas(PED_REV_IND, PED_CLI_RAZAO, PED_CLI_CNPJ, PED_CLI_IE, PED_CLI_ENDERECO, 
                            PED_CLI_ENDERECO_NUMERO, PED_CLI_ENDERECO_COMPLEMENTO, PED_CLI_CEP, PED_CLI_BAIRRO, PED_CLI_CIDADE, PED_CLI_UF, PED_CLI_EMAIL, 
                            PED_SKYPE, PED_CLI_TELEFONE, PED_CLI_TELEFONE_DDD, PED_CLI_QTD_FUNCIONA, PED_CLI_CONTATO, PED_VERSAO_AQUISICAO, 
                            PED_COM_MANUTENCAO, PED_MODELOREP, PED_REPINSTALADO, PED_DESCRICAO, PED_SOLICITANTE, PED_REP_FABRICANTE, PED_FANTASIA, 
                            PED_STATUS, PED_EMAIL2, PED_ASSEPONTO4, PED_ASSEFIN, PED_CLI_TELEFONE2, PED_CLI_TELEFONE2_DDD, PED_CLI_CELULAR, 
                            PED_CLI_CELULAR_DDD, PED_CLI_CELULAR_ACEITA) 
                            VALUES (@PED_REV_IND, @PED_CLI_RAZAO, '" + pedido.PED_CLI_CNPJ + @"', @PED_CLI_IE, @PED_CLI_ENDERECO, 
                            @PED_CLI_ENDERECO_NUMERO, @PED_CLI_ENDERECO_COMPLEMENTO, @PED_CLI_CEP, @PED_CLI_BAIRRO, @PED_CLI_CIDADE, @PED_CLI_UF, @PED_CLI_EMAIL, 
                            @PED_SKYPE, @PED_CLI_TELEFONE, @PED_CLI_TELEFONE_DDD, @PED_CLI_QTD_FUNCIONA, @PED_CLI_CONTATO, @PED_VERSAO_AQUISICAO, 
                            @PED_COM_MANUTENCAO, @PED_MODELOREP, @PED_REPINSTALADO, @PED_DESCRICAO, @PED_SOLICITANTE, @PED_REP_FABRICANTE, @PED_FANTASIA, 
                            1, @PED_EMAIL2, 1, 0, @PED_CLI_TELEFONE2, @PED_CLI_TELEFONE2_DDD, @PED_CLI_CELULAR, 
                            @PED_CLI_CELULAR_DDD, @PED_CLI_CELULAR_ACEITA)
                            select SCOPE_IDENTITY()";
                    }

                    conn.Open();
                    cmd = new SqlCommand(insert, conn);
                    cmd.Parameters.AddWithValue("@PED_IND", pedido.PED_IND);
                    cmd.Parameters.AddWithValue("@PED_REV_IND", pedido.PED_REV_IND);
                    cmd.Parameters.AddWithValue("@PED_CLI_RAZAO", pedido.PED_CLI_RAZAO);
                    cmd.Parameters.AddWithValue("@PED_CLI_IE", pedido.PED_CLI_IE);
                    cmd.Parameters.AddWithValue("@PED_CLI_ENDERECO", pedido.PED_CLI_ENDERECO);
                    cmd.Parameters.AddWithValue("@PED_CLI_ENDERECO_NUMERO", pedido.PED_CLI_ENDERECO_NUMERO);
                    cmd.Parameters.AddWithValue("@PED_CLI_ENDERECO_COMPLEMENTO", pedido.PED_CLI_ENDERECO_COMPLEMENTO);
                    cmd.Parameters.AddWithValue("@PED_CLI_CEP", pedido.PED_CLI_CEP);
                    cmd.Parameters.AddWithValue("@PED_CLI_BAIRRO", pedido.PED_CLI_BAIRRO);
                    cmd.Parameters.AddWithValue("@PED_CLI_CIDADE", pedido.PED_CLI_CIDADE);
                    cmd.Parameters.AddWithValue("@PED_CLI_UF", pedido.PED_CLI_UF);
                    cmd.Parameters.AddWithValue("@PED_CLI_EMAIL", pedido.PED_CLI_EMAIL);
                    cmd.Parameters.AddWithValue("@PED_SKYPE", pedido.PED_SKYPE);
                    cmd.Parameters.AddWithValue("@PED_CLI_TELEFONE", pedido.PED_CLI_TELEFONE);
                    cmd.Parameters.AddWithValue("@PED_CLI_TELEFONE_DDD", pedido.PED_CLI_TELEFONE_DDD);
                    cmd.Parameters.AddWithValue("@PED_CLI_QTD_FUNCIONA", pedido.PED_CLI_QTD_FUNCIONA);
                    cmd.Parameters.AddWithValue("@PED_CLI_CONTATO", pedido.PED_CLI_CONTATO);
                    cmd.Parameters.AddWithValue("@PED_VERSAO_AQUISICAO", pedido.PED_VERSAO_AQUISICAO);
                    cmd.Parameters.AddWithValue("@PED_COM_MANUTENCAO", pedido.PED_COM_MANUTENCAO);
                    cmd.Parameters.AddWithValue("@PED_MODELOREP", pedido.PED_MODELOREP);
                    cmd.Parameters.AddWithValue("@PED_REPINSTALADO", pedido.PED_REPINSTALADO);
                    cmd.Parameters.AddWithValue("@PED_DESCRICAO", pedido.PED_DESCRICAO);
                    cmd.Parameters.AddWithValue("@PED_SOLICITANTE", pedido.PED_SOLICITANTE);
                    cmd.Parameters.AddWithValue("@PED_REP_FABRICANTE", pedido.PED_REP_FABRICANTE);
                    cmd.Parameters.AddWithValue("@PED_FANTASIA", pedido.PED_FANTASIA);
                    cmd.Parameters.AddWithValue("@PED_STATUS", pedido.PED_STATUS);
                    cmd.Parameters.AddWithValue("@PED_EMAIL2", pedido.PED_EMAIL2);
                    cmd.Parameters.AddWithValue("@PED_CLI_TELEFONE2", pedido.PED_CLI_TELEFONE2);
                    cmd.Parameters.AddWithValue("@PED_CLI_TELEFONE2_DDD", pedido.PED_CLI_TELEFONE2_DDD);
                    cmd.Parameters.AddWithValue("@PED_CLI_CELULAR", pedido.PED_CLI_CELULAR);
                    cmd.Parameters.AddWithValue("@PED_CLI_CELULAR_DDD", pedido.PED_CLI_CELULAR_DDD);
                    cmd.Parameters.AddWithValue("@PED_CLI_CELULAR_ACEITA", pedido.PED_CLI_CELULAR_ACEITA);

                    object retur = cmd.ExecuteScalar();
                    if (retur != null)
                        ind = Convert.ToInt32(retur);
                    else
                        throw new Exception("Nenhuma linha afetada!");
                }
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
