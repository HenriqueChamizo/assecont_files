using System;
using System.Data;
using System.Data.SqlClient;
using Wr.Classes;

namespace Asseponto.Classes
{
    public class BDAppAssefin : Wr.Classes.BD
    {
        public const int atendimentoAvulso30 = 126;
        public const int atendimentoAvulso = 90;

        public BDAppAssefin()
        {
            BDConnection conn = new BDConnection("200.98.136.201", "Assefin_assecont4", "assefin45231", "768fkl448mb");
            //Conectar("200.98.136.201", "Assefin_assecont4", "assefin45231", "768fkl448mb");
            Conectar(conn);
        }

        public bool getClienteExists(int ind)
        {
            return getFieldValueBool(string.Format("select case when(exists(select * from Cadastros where CAD_IND = {0})) then 1 else 0 end", ind));
        }

        public int ChecarPendencias(string cnpj_cpf)
        {
            return getFieldValueInteger(string.Format("SELECT COUNT(*) FROM Boletos " +
                "INNER JOIN Grupos ON BOL_GRUPO = GRU_IND " +
                "INNER JOIN Cadastros ON BOL_CADASTRO = CAD_IND " +
                "INNER JOIN ContasRegistros ON BOL_IND = CTAR_BOLETO " +
                "WHERE (dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj('{0}') OR dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj('{0}')) " +
                "AND CTAR_VALOR_PAGTO IS NULL AND " +
                "(CAD_BLOQUEIO_LIBERADO_ATE IS NULL OR CAD_BLOQUEIO_LIBERADO_ATE IS NOT NULL  " +
                "AND CAD_BLOQUEIO_LIBERADO_ATE <= GETDATE())  " +
                "AND DATEADD(Day, 15, BOL_VENCIMENTO) <= GETDATE() " +
                "AND BOL_CANCELADO = 0 AND BOL_IGNORAR = 0 AND CTAR_IGNORADO = 0 AND CTAR_CONTRA_APRESENTACAO = 0  " +
                "AND BOL_CONTRA_APRESENTACAO = 0 ", cnpj_cpf));
            //"AND GRU_IND = 3 "
        }

        public DataTable getContratoArquivo(int id)
        {
            return getDataTable(string.Format("SELECT FATUCONARQ_NOME, FATUCONARQ_ARQUIVO FROM FaturamentoContratosArquivo WHERE FATUCONARQ_IND = {0}", id));
        }

        public int getCadastroIndice(string cnpj_cpf)
        {
            return getFieldValueInteger(string.Format("SELECT CAD_IND FROM Cadastros WHERE (dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj('{0}') OR dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj('{0}')) ", cnpj_cpf));
        }

        public DataTable getCadastroAtualizado(int indice)
        {
            return getDataTable(string.Format("SELECT CAD_ATUALIZADO_POR, CAD_CADASTRO_ATUALIZADO_EM FROM Cadastros WHERE CAD_IND = {0} ", indice));
        }

        public DataTable getCadastro(int indice)
        {
            return getDataTable(string.Format("SELECT [CAD_IND], [CAD_RAZAOSOCIAL], [CAD_FANTASIA], [CAD_CNPJ], [CAD_IE], [CAD_ENDERECO], [CAD_CIDADE], [CAD_BAIRRO], [CAD_ESTADO], [CAD_CEP], " +
	                                                 "[CAD_TELEFONE1], [CAD_TELEFONE2], [CAD_CONTATO], [CAD_EMAIL], [CAD_ATIVO], [CAD_FORNECEDOR], [CAD_CLIENTE], [CAD_DUVIDOSO], [CAD_GRUPO], " +
                                                     "[CAD_CODIGO], [CAD_FAX], [CAD_EMAIL2], [CAD_TIPO_PESSOA], [CAD_TRANSPORTADOR], [CAD_CODIGO_MUNICIPIO], [CAD_ENDERECO_NUMERO], [CAD_COMPLEMENTO], " +
                                                     "[CAD_OPTANTE_SIMPLES], [CAD_COMERCIANTE], [CAD_CPF], [CAD_PAIS], [CAD_PAIS_CODIGO], [CAD_REPRESENTANTE], [CAD_IM], [CAD_PERFIL], " +
                                                     "[CAD_COMISSAO_PORCENTO], [CAD_EMAIL3], [CAD_TELEFONE1_DDD], [CAD_TELEFONE2_DDD], [CAD_CELULAR1], [CAD_CELULAR1_DDD], [CAD_OBS], " +
                                                     "[CAD_FINANCEIRO_CONTATO], [CAD_FINANCEIRO_TELEFONE1_DDD], [CAD_FINANCEIRO_TELEFONE1], [CAD_FINANCEIRO_TELEFONE2_DDD], [CAD_FINANCEIRO_TELEFONE2], " +
                                                     "[CAD_FINANCEIRO_CELULAR1_DDD], [CAD_FINANCEIRO_CELULAR1], [CAD_FINANCEIRO_EMAIL], [CAD_FINANCEIRO_EMAIL2], [CAD_FINANCEIRO_EMAIL3], " +
                                                     "[CAD_CELULAR_CADASTRADO_EM], [CAD_CADASTRO_ATUALIZADO_EM], [CAD_CELULAR_ACEITA], [CAD_CELULAR_ATUALIZADO_EM], [CAD_BLOQUEIO_LIBERADO_ATE], " +
                                                     "[CAD_ULTIMA_BAIXA], [CAD_ATUALIZADO_POR] " +
                                              "FROM [dbo].[Cadastros] " +
                                              "WHERE CAD_IND = {0} ", indice));
        }

        public void setCadastroAssefin(string razaoSociaol, string nomefantasia, string IE,
            string email, string email2, string email3, string endereco, string enderecoNumero, string enderecoComplemento, string bairro, string cidade, string UF, string cep,
            string contato, string telefone, string telefone_ddd, string telefone2, string telefone2_ddd, string financeiro_contato, string financeiro_telefone, string financeiro_telefone_ddd,
            string financeiro_telefone2, string financeiro_telefone_ddd2, string financeiro_celular, string financeiro_celular_ddd, Boolean financeiro_celular_aceita,
            string financeiro_email, string financeiro_email2, string financeiro_email3, string userName, string cnpj_cpf, DateTime dtAtualiza)
        {

            openConnection();
            SqlCommand cmd = new SqlCommand("SET DATEFORMAT DMY " +
            "UPDATE Cadastros SET CAD_RAZAOSOCIAL = @CAD_RAZAOSOCIAL, CAD_FANTASIA = @CAD_FANTASIA, CAD_IE = @CAD_IE, " +
            "CAD_ENDERECO =  @CAD_ENDERECO, CAD_ENDERECO_NUMERO = @CAD_ENDERECO_NUMERO, CAD_COMPLEMENTO = @CAD_COMPLEMENTO, " +
            "CAD_BAIRRO = @CAD_BAIRRO, CAD_CIDADE = @CAD_CIDADE, CAD_CEP = @CAD_CEP, CAD_ESTADO = @CAD_ESTADO, " +
            "CAD_CONTATO = @CAD_CONTATO, CAD_TELEFONE1_DDD = @CAD_TELEFONE1_DDD, CAD_TELEFONE2_DDD = @CAD_TELEFONE2_DDD, CAD_TELEFONE1 = @CAD_TELEFONE1, CAD_TELEFONE2 = @CAD_TELEFONE2, " +
            "CAD_FINANCEIRO_CELULAR1_DDD = @CAD_FINANCEIRO_CELULAR1_DDD, CAD_FINANCEIRO_CELULAR1 = @CAD_FINANCEIRO_CELULAR1, CAD_FINANCEIRO_CONTATO = @CAD_FINANCEIRO_CONTATO, " +
            "CAD_FINANCEIRO_EMAIL = @CAD_FINANCEIRO_EMAIL, CAD_FINANCEIRO_EMAIL2 = @CAD_FINANCEIRO_EMAIL2, CAD_FINANCEIRO_EMAIL3 = @CAD_FINANCEIRO_EMAIL3, " +
            "CAD_FINANCEIRO_TELEFONE1_DDD = @CAD_FINANCEIRO_TELEFONE1_DDD, CAD_FINANCEIRO_TELEFONE1 = @CAD_FINANCEIRO_TELEFONE1, CAD_FINANCEIRO_TELEFONE2_DDD = @CAD_FINANCEIRO_TELEFONE2_DDD, CAD_FINANCEIRO_TELEFONE2 = @CAD_FINANCEIRO_TELEFONE2, " +
            "CAD_CELULAR_ACEITA = @CAD_CELULAR_ACEITA, CAD_EMAIL = @CAD_EMAIL, CAD_EMAIL2 = @CAD_EMAIL2, CAD_EMAIL3 = @CAD_EMAIL3, CAD_ATUALIZADO_POR = @CAD_ATUALIZADO_POR, CAD_CADASTRO_ATUALIZADO_EM = @DATAATUALIZA " +
            "WHERE (dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj(@CNPJ_CPF) OR dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj(@CNPJ_CPF)) ", Conn);

            cmd.CommandType = CommandType.Text;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@DATAATUALIZA", dtAtualiza.ToString("dd/MM/yyyy HH:mm:00"));
            cmd.Parameters.AddWithValue("@CAD_RAZAOSOCIAL", razaoSociaol);
            cmd.Parameters.AddWithValue("@CAD_FANTASIA", nomefantasia);
            cmd.Parameters.AddWithValue("@CAD_IE", IE);

            cmd.Parameters.AddWithValue("@CAD_EMAIL3", email3);
            cmd.Parameters.AddWithValue("@CAD_EMAIL2", email2);
            cmd.Parameters.AddWithValue("@CAD_EMAIL", email);

            cmd.Parameters.AddWithValue("@CAD_ENDERECO_NUMERO", enderecoNumero.Trim());
            cmd.Parameters.AddWithValue("@CAD_ENDERECO", endereco.Trim());
            cmd.Parameters.AddWithValue("@CAD_COMPLEMENTO", enderecoComplemento.Trim());
            cmd.Parameters.AddWithValue("@CAD_BAIRRO", bairro.Trim());
            cmd.Parameters.AddWithValue("@CAD_CIDADE", cidade.Trim());
            cmd.Parameters.AddWithValue("@CAD_ESTADO", UF.Trim());
            cmd.Parameters.AddWithValue("@CAD_CEP", cep.Trim());

            cmd.Parameters.AddWithValue("@CAD_CONTATO", contato);
            cmd.Parameters.AddWithValue("@CAD_TELEFONE1_DDD", telefone_ddd);
            cmd.Parameters.AddWithValue("@CAD_TELEFONE2_DDD", telefone2_ddd);
            cmd.Parameters.AddWithValue("@CAD_TELEFONE1", telefone);
            cmd.Parameters.AddWithValue("@CAD_TELEFONE2", telefone2);

            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CONTATO", financeiro_contato);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE1_DDD", financeiro_telefone_ddd);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE1", financeiro_telefone);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE2_DDD", financeiro_telefone_ddd2);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE2", financeiro_telefone2);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CELULAR1_DDD", financeiro_celular_ddd);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CELULAR1", financeiro_celular);
            cmd.Parameters.AddWithValue("@CAD_CELULAR_ACEITA", financeiro_celular_aceita);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL3", financeiro_email3);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL2", financeiro_email2);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL", financeiro_email);
            cmd.Parameters.AddWithValue("@CAD_ATUALIZADO_POR", userName);

            cmd.Parameters.AddWithValue("@CNPJ_CPF", cnpj_cpf);

            cmd.ExecuteNonQuery();
            closeConnection();
        }


        public void setCriarCadastroAssefin(string razaoSociaol, string nomefantasia, string IE,
            string email, string email2, string email3, string endereco, string enderecoNumero, string enderecoComplemento, string bairro, string cidade, string UF, string cep,
            string contato, string telefone, string telefone_ddd, string telefone2, string telefone2_ddd, string financeiro_contato, string financeiro_telefone, string financeiro_telefone_ddd,
            string financeiro_telefone2, string financeiro_telefone_ddd2, string financeiro_celular, string financeiro_celular_ddd, Boolean financeiro_celular_aceita,
            string financeiro_email, string financeiro_email2, string financeiro_email3, string userName, string cnpj, string cpf)
        {

            openConnection();
            SqlCommand cmd = new SqlCommand("INSERT INTO Cadastros " +
            "(CAD_RAZAOSOCIAL, CAD_FANTASIA, CAD_IE, CAD_ENDERECO, CAD_ENDERECO_NUMERO, CAD_COMPLEMENTO, CAD_BAIRRO, CAD_CIDADE, CAD_CEP, CAD_ESTADO, " +
            "CAD_CONTATO, CAD_TELEFONE1_DDD, CAD_TELEFONE2_DDD, CAD_TELEFONE1, CAD_TELEFONE2, " +
            "CAD_FINANCEIRO_CELULAR1_DDD, CAD_FINANCEIRO_CELULAR1, CAD_FINANCEIRO_CONTATO, CAD_FINANCEIRO_EMAIL, CAD_FINANCEIRO_EMAIL2, CAD_FINANCEIRO_EMAIL3, " +
            "CAD_FINANCEIRO_TELEFONE1_DDD, CAD_FINANCEIRO_TELEFONE1, CAD_FINANCEIRO_TELEFONE2_DDD, CAD_FINANCEIRO_TELEFONE2, " +
            "CAD_CELULAR_ACEITA, CAD_EMAIL, CAD_EMAIL2, CAD_EMAIL3, CAD_ATUALIZADO_POR, CAD_CADASTRO_ATUALIZADO_EM, CAD_CNPJ, CAD_CPF, CAD_GRUPO ) VALUES " +

            "(@CAD_RAZAOSOCIAL, @CAD_FANTASIA, @CAD_IE, @CAD_ENDERECO, @CAD_ENDERECO_NUMERO, @CAD_COMPLEMENTO, @CAD_BAIRRO, @CAD_CIDADE, @CAD_CEP, @CAD_ESTADO, " +
            "@CAD_CONTATO, @CAD_TELEFONE1_DDD, @CAD_TELEFONE2_DDD, @CAD_TELEFONE1, @CAD_TELEFONE2, " +
            "@CAD_FINANCEIRO_CELULAR1_DDD, @CAD_FINANCEIRO_CELULAR1, @CAD_FINANCEIRO_CONTATO, @CAD_FINANCEIRO_EMAIL, @CAD_FINANCEIRO_EMAIL2, @CAD_FINANCEIRO_EMAIL3, " +
            "@CAD_FINANCEIRO_TELEFONE1_DDD, @CAD_FINANCEIRO_TELEFONE1, @CAD_FINANCEIRO_TELEFONE2_DDD, @CAD_FINANCEIRO_TELEFONE2, " +
            "@CAD_CELULAR_ACEITA, @CAD_EMAIL, @CAD_EMAIL2, @CAD_EMAIL3, @CAD_ATUALIZADO_POR, GETDATE(), @CNPJ, @CPF, 1 )", Conn);

            cmd.CommandType = CommandType.Text;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@CAD_RAZAOSOCIAL", razaoSociaol);
            cmd.Parameters.AddWithValue("@CAD_FANTASIA", nomefantasia);
            cmd.Parameters.AddWithValue("@CAD_IE", IE);

            cmd.Parameters.AddWithValue("@CAD_EMAIL", email);
            cmd.Parameters.AddWithValue("@CAD_EMAIL2", email2);
            cmd.Parameters.AddWithValue("@CAD_EMAIL3", email3);

            cmd.Parameters.AddWithValue("@CAD_ENDERECO", endereco);
            cmd.Parameters.AddWithValue("@CAD_ENDERECO_NUMERO", enderecoNumero);
            cmd.Parameters.AddWithValue("@CAD_COMPLEMENTO", enderecoComplemento);
            cmd.Parameters.AddWithValue("@CAD_BAIRRO", bairro);
            cmd.Parameters.AddWithValue("@CAD_CIDADE", cidade);
            cmd.Parameters.AddWithValue("@CAD_ESTADO", UF);
            cmd.Parameters.AddWithValue("@CAD_CEP", cep);

            cmd.Parameters.AddWithValue("@CAD_CONTATO", contato);
            cmd.Parameters.AddWithValue("@CAD_TELEFONE1", telefone);
            cmd.Parameters.AddWithValue("@CAD_TELEFONE1_DDD", telefone_ddd);
            cmd.Parameters.AddWithValue("@CAD_TELEFONE2", telefone2);
            cmd.Parameters.AddWithValue("@CAD_TELEFONE2_DDD", telefone2_ddd);

            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CONTATO", financeiro_contato);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE1", financeiro_telefone);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE1_DDD", financeiro_telefone_ddd);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE2", financeiro_telefone2);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE2_DDD", financeiro_telefone_ddd2);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CELULAR1", financeiro_celular);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CELULAR1_DDD", financeiro_celular_ddd);
            cmd.Parameters.AddWithValue("@CAD_CELULAR_ACEITA", financeiro_celular_aceita);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL", financeiro_email);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL2", financeiro_email2);
            cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL3", financeiro_email3);
            cmd.Parameters.AddWithValue("@CAD_ATUALIZADO_POR", userName);

            cmd.Parameters.AddWithValue("@CNPJ", cnpj);
            cmd.Parameters.AddWithValue("@CPF", cpf);

            cmd.ExecuteNonQuery();
            closeConnection();
        }

        public void setContratoFaturamento(byte[] Arquivo, string Nome, int Indice, string Usuario)
        {
            string query = "INSERT INTO FaturamentoContratosArquivo (FATUCONARQ_NOME, FATUCONARQ_ARQUIVO, FATUCONARQ_FATURAMENTO_CONTRATO, FATUCONARQ_POR) VALUES (@NOME, @ARQUIVO, @CONTRATO, @USUARIO) ";

            openConnection();
            SqlCommand cmd = new SqlCommand(query, Conn);
            cmd.Parameters.AddWithValue("@ARQUIVO", Arquivo);
            cmd.Parameters.AddWithValue("@NOME", Nome);
            cmd.Parameters.AddWithValue("@CONTRATO", Indice);
            cmd.Parameters.AddWithValue("@USUARIO", Usuario);

            cmd.ExecuteNonQuery();
            closeConnection();
        }

        public void deleteContratoFaturamento(int Indice)
        {
            string query = "DELETE FROM FaturamentoContratosArquivo WHERE FATUCONARQ_IND = {0}";
            executeCommand(string.Format(query, Indice));
        }

        public int setCriarPedido(int Grupo, string usuario, int cliente, Single valor, int quantidade)
        {
            openConnection();
            SqlCommand cmd = new SqlCommand("INSERT INTO PedidosVendas " +
            "(PEDV_GRUPO, PEDV_USUARIO, PEDV_CADASTRO, PEDV_NUMERO, PEDV_VALOR, PEDV_NITENS, PEDV_DATA) VALUES " +
            "(@GRUPO, @USUARIO, @CADASTRO, @NUMERO, @VALOR, @ITENS, GETDATE() )", Conn);

            cmd.CommandType = CommandType.Text;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@GRUPO", Grupo);
            cmd.Parameters.AddWithValue("@USUARIO", 8);
            cmd.Parameters.AddWithValue("@CADASTRO", cliente);
            cmd.Parameters.AddWithValue("@NUMERO", 1);
            cmd.Parameters.AddWithValue("@VALOR", valor);
            cmd.Parameters.AddWithValue("@ITENS", quantidade);

            cmd.ExecuteNonQuery();

            int result = getIdentity(cmd); // getFieldValueInteger("SELECT @@IDENTITY");

            closeConnection();

            return result;
        }

        public void setCriarPedidoItem(int pedido, int produto, int quantidade, Single valor)
        {
            openConnection();
            SqlCommand cmd = new SqlCommand("INSERT INTO PedidosVendasItens " +
           "(PEDVI_PEDIDO, PEDVI_PRODUTO, PEDVI_QUANTIDADE, PEDVI_VALOR_UNITARIO ) VALUES " +
           "(@PEDIDO, @PRODUTO, @QUANTIDADE, @VALOR )", Conn);

            cmd.CommandType = CommandType.Text;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@PEDIDO", pedido);
            cmd.Parameters.AddWithValue("@PRODUTO", produto);
            cmd.Parameters.AddWithValue("@QUANTIDADE", quantidade);
            cmd.Parameters.AddWithValue("@VALOR", valor);
            
            cmd.ExecuteNonQuery();
            closeConnection();
        }
    }
}