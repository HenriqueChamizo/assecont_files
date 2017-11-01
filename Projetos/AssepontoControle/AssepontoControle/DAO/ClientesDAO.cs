using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAO;
using DAO.Interfaces;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data.Common;

namespace DAO
{
    public class ClienteDAO : ICliente, IDAO
    {
        SqlConnection conn;
        SqlCommand cmd;

        public void SetValuesConnection(Connection connection)
        {
            conn = new SqlConnection(connection.connectionstring);
        }

        public bool GetClienteWithRevenda(ref Modelo.Asseponto.ClienteDetail cliente, ref Modelo.Asseponto.RevendaDetail revenda)
        {
            try
            {
                conn.Open();
                cmd = new SqlCommand(@"select CAD_IND,
                                               CAD_RAZAOSOCIAL,
                                               dbo.fn_cliente_cnpj_cpf(CAD_IND) as CNPJ_CPF_CLIENTE,
                                               case when CAD_TELEFONE1_DDD is null 
			                                        then case when CAD_TELEFONE1 is null or ltrim(rtrim(CAD_TELEFONE1)) = ''
					                                          then '' 
					                                          else ltrim(rtrim(CAD_TELEFONE1)) 
				                                         end 
			                                        else case when CAD_TELEFONE1 is null or ltrim(rtrim(CAD_TELEFONE1)) = ''
					                                          then '' 
					                                          else '(' + ltrim(rtrim(CAD_TELEFONE1_DDD)) + ') ' + ltrim(rtrim(CAD_TELEFONE1)) 
				                                         end 
                                               end as TELEFONE1,
                                               case when CAD_TELEFONE2_DDD is null 
			                                        then case when CAD_TELEFONE2 is null or ltrim(rtrim(CAD_TELEFONE2)) = ''
					                                          then '' 
					                                          else ltrim(rtrim(CAD_TELEFONE2)) 
				                                         end 
			                                        else case when CAD_TELEFONE2 is null or ltrim(rtrim(CAD_TELEFONE2)) = ''
					                                          then '' 
					                                          else '(' + ltrim(rtrim(CAD_TELEFONE2_DDD)) + ') ' + ltrim(rtrim(CAD_TELEFONE2)) 
				                                         end 
	                                           end as TELEFONE2,
	                                           case when CAD_CELULAR_DDD is null 
			                                        then case when CAD_CELULAR_DDD is null or ltrim(rtrim(CAD_CELULAR_DDD)) = ''
					                                          then '' 
					                                          else ltrim(rtrim(CAD_CELULAR)) 
				                                         end 
			                                        else case when CAD_CELULAR_DDD is null or ltrim(rtrim(CAD_CELULAR_DDD)) = ''
					                                          then '' 
					                                          else '(' + ltrim(rtrim(CAD_CELULAR_DDD)) + ') ' + ltrim(rtrim(CAD_CELULAR)) 
				                                         end 
	                                           end as CELULAR, 
	                                           case when CAD_FINANCEIRO_TELEFONE1_DDD is null 
			                                        then case when CAD_FINANCEIRO_TELEFONE1 is null or ltrim(rtrim(CAD_FINANCEIRO_TELEFONE1)) = ''
					                                          then '' 
					                                          else ltrim(rtrim(CAD_FINANCEIRO_TELEFONE1)) 
				                                         end 
			                                        else case when CAD_FINANCEIRO_TELEFONE1 is null or ltrim(rtrim(CAD_FINANCEIRO_TELEFONE1)) = ''
					                                          then '' 
					                                          else '(' + ltrim(rtrim(CAD_FINANCEIRO_TELEFONE1_DDD)) + ') ' + ltrim(rtrim(CAD_FINANCEIRO_TELEFONE1)) 
				                                         end 
                                               end as TELEFONEFINACEIRO,
	                                           case when CAD_FINANCEIRO_TELEFONE2_DDD is null 
			                                        then case when CAD_FINANCEIRO_TELEFONE2 is null or ltrim(rtrim(CAD_FINANCEIRO_TELEFONE2)) = ''
					                                          then '' 
					                                          else ltrim(rtrim(CAD_FINANCEIRO_TELEFONE2)) 
				                                         end 
			                                        else case when CAD_FINANCEIRO_TELEFONE2 is null or ltrim(rtrim(CAD_FINANCEIRO_TELEFONE2)) = ''
					                                          then '' 
					                                          else '(' + ltrim(rtrim(CAD_FINANCEIRO_TELEFONE2_DDD)) + ') ' + ltrim(rtrim(CAD_FINANCEIRO_TELEFONE2)) 
				                                         end 
                                               end as TELEFONEFINACEIRO2,
	                                           case when CAD_FINANCEIRO_CELULAR_DDD is null 
			                                        then case when CAD_FINANCEIRO_CELULAR is null or ltrim(rtrim(CAD_FINANCEIRO_CELULAR)) = ''
					                                          then '' 
					                                          else ltrim(rtrim(CAD_FINANCEIRO_CELULAR)) 
				                                         end 
			                                        else case when CAD_FINANCEIRO_CELULAR is null or ltrim(rtrim(CAD_FINANCEIRO_CELULAR)) = ''
					                                          then '' 
					                                          else '(' + ltrim(rtrim(CAD_FINANCEIRO_CELULAR_DDD)) + ') ' + ltrim(rtrim(CAD_FINANCEIRO_CELULAR)) 
				                                         end 
                                               end as CELULARFINACEIRO,
                                               ltrim(rtrim(CAD_EMAIL)) as CAD_EMAIL, 
	                                           ltrim(rtrim(CAD_EMAIL2)) as CAD_EMAIL2, 
	                                           ltrim(rtrim(CAD_EMAIL3)) as CAD_EMAIL3, 	 
                                               ltrim(rtrim(CAD_FINANCEIRO_EMAIL)) as CAD_FINANCEIRO_EMAIL, 
	                                           ltrim(rtrim(CAD_FINANCEIRO_EMAIL2)) as CAD_FINANCEIRO_EMAIL2, 
	                                           ltrim(rtrim(CAD_FINANCEIRO_EMAIL3)) as CAD_FINANCEIRO_EMAIL3, 
                                               CAD_CONTATO,
                                               CAD_FINANCEIRO_CONTATO,
                                               CAD_OBS, 
	                                           REV_IND, 
	                                           REV_RAZAOSOCIAL, 
	                                           dbo.fn_revenda_cnpj_cpf(REV_IND) as CNPJ_CPF_REVENDA
                                        from AssepontoClientes 
                                        inner join AssepontoRevendas on CAD_REVENDA = REV_IND 
                                        where CAD_IND = @CAD_IND", conn);
                
                
        cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@CAD_IND", cliente.CAD_IND);

                DbDataReader dr = cmd.ExecuteReader();


                while (dr.Read()) {
                    cliente.CAD_RAZAOSOCIAL = Convert.ToString(dr["CAD_RAZAOSOCIAL"]);
                    cliente.CAD_CNPJ = Convert.ToString(dr["CNPJ_CPF_CLIENTE"]);
                    cliente.CAD_TELEFONE1 = Convert.ToString(dr["TELEFONE1"]);
                    cliente.CAD_TELEFONE2 = Convert.ToString(dr["TELEFONE2"]);
                    cliente.CAD_CELULAR = Convert.ToString(dr["CELULAR"]);
                    cliente.CAD_FINANCEIRO_TELEFONE1 = Convert.ToString(dr["TELEFONEFINACEIRO"]);
                    cliente.CAD_FINANCEIRO_TELEFONE2 = Convert.ToString(dr["TELEFONEFINACEIRO2"]);
                    cliente.CAD_FINANCEIRO_CELULAR = Convert.ToString(dr["CELULARFINACEIRO"]);
                    cliente.CAD_EMAIL = Convert.ToString(dr["CAD_EMAIL"]);
                    cliente.CAD_EMAIL2 = Convert.ToString(dr["CAD_EMAIL2"]);
                    cliente.CAD_EMAIL3 = Convert.ToString(dr["CAD_EMAIL3"]);
                    cliente.CAD_FINANCEIRO_EMAIL = Convert.ToString(dr["CAD_FINANCEIRO_EMAIL"]);
                    cliente.CAD_FINANCEIRO_EMAIL2 = Convert.ToString(dr["CAD_FINANCEIRO_EMAIL2"]);
                    cliente.CAD_FINANCEIRO_EMAIL3 = Convert.ToString(dr["CAD_FINANCEIRO_EMAIL3"]);
                    cliente.CAD_CONTATO = Convert.ToString(dr["CAD_CONTATO"]);
                    cliente.CAD_FINANCEIRO_CONTATO = Convert.ToString(dr["CAD_FINANCEIRO_CONTATO"]);
                    cliente.CAD_OBS = Convert.ToString(dr["CAD_OBS"]);
                    revenda.REV_IND = Convert.ToInt32(dr["REV_IND"]);
                    revenda.REV_RAZAOSOCIAL = Convert.ToString(dr["REV_RAZAOSOCIAL"]);
                    revenda.REV_CNPJ = Convert.ToString(dr["CNPJ_CPF_REVENDA"]);
                }

                conn.Close();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool setUpdateCadastroAssefin(Modelo.Assefin.ClienteDetail cliente)
        {
            try
            {
                conn.Open();
                cmd = new SqlCommand("SET DATEFORMAT DMY " +
                "UPDATE Cadastros " +
                "SET CAD_RAZAOSOCIAL = @CAD_RAZAOSOCIAL, " +
                "    CAD_FANTASIA = @CAD_FANTASIA,  " +
                "    CAD_IE = @CAD_IE, " +
                "    CAD_ENDERECO =  @CAD_ENDERECO,  " +
                "    CAD_ENDERECO_NUMERO = @CAD_ENDERECO_NUMERO,  " +
                "    CAD_COMPLEMENTO = @CAD_COMPLEMENTO, " +
                "    CAD_BAIRRO = @CAD_BAIRRO,  " +
                "    CAD_CIDADE = @CAD_CIDADE,  " +
                "    CAD_CEP = @CAD_CEP,  " +
                "    CAD_ESTADO = @CAD_ESTADO, " +
                "    CAD_CONTATO = @CAD_CONTATO,  " +
                "    CAD_TELEFONE1_DDD = @CAD_TELEFONE1_DDD,  " +
                "    CAD_TELEFONE2_DDD = @CAD_TELEFONE2_DDD,  " +
                "    CAD_TELEFONE1 = @CAD_TELEFONE1,  " +
                "    CAD_TELEFONE2 = @CAD_TELEFONE2, " +
                "    CAD_FINANCEIRO_CELULAR1_DDD = @CAD_FINANCEIRO_CELULAR1_DDD,  " +
                "    CAD_FINANCEIRO_CELULAR1 = @CAD_FINANCEIRO_CELULAR1,  " +
                "    CAD_FINANCEIRO_CONTATO = @CAD_FINANCEIRO_CONTATO, " +
                "    CAD_FINANCEIRO_EMAIL = @CAD_FINANCEIRO_EMAIL,  " +
                "    CAD_FINANCEIRO_EMAIL2 = @CAD_FINANCEIRO_EMAIL2, " +
                "    CAD_FINANCEIRO_EMAIL3 = @CAD_FINANCEIRO_EMAIL3, " +
                "    CAD_FINANCEIRO_TELEFONE1_DDD = @CAD_FINANCEIRO_TELEFONE1_DDD,  " +
                "    CAD_FINANCEIRO_TELEFONE1 = @CAD_FINANCEIRO_TELEFONE1,   " +
                "    CAD_FINANCEIRO_TELEFONE2_DDD = @CAD_FINANCEIRO_TELEFONE2_DDD,   " +
                "    CAD_FINANCEIRO_TELEFONE2 = @CAD_FINANCEIRO_TELEFONE2, " +
                "    CAD_CELULAR_ACEITA = @CAD_CELULAR_ACEITA,   " +
                "    CAD_EMAIL = @CAD_EMAIL,   " +
                "    CAD_EMAIL2 = @CAD_EMAIL2,   " +
                "    CAD_EMAIL3 = @CAD_EMAIL3,   " +
                "    CAD_ATUALIZADO_POR = @CAD_ATUALIZADO_POR,   " +
                "    CAD_CADASTRO_ATUALIZADO_EM = @DATAATUALIZA " +
                "WHERE (dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj(@CNPJ_CPF) OR   " +
                "       dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj(@CNPJ_CPF)) ", conn);

                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@DATAATUALIZA", cliente.CAD_CADASTRO_ATUALIZADOEM.ToString("dd/MM/yyyy HH:mm:00"));
                cmd.Parameters.AddWithValue("@CAD_RAZAOSOCIAL", cliente.CAD_RAZAOSOCIAL);
                cmd.Parameters.AddWithValue("@CAD_FANTASIA", cliente.CAD_FANTASIA);
                cmd.Parameters.AddWithValue("@CAD_IE", cliente.CAD_IE);

                cmd.Parameters.AddWithValue("@CAD_EMAIL3", cliente.CAD_EMAIL3);
                cmd.Parameters.AddWithValue("@CAD_EMAIL2", cliente.CAD_EMAIL2);
                cmd.Parameters.AddWithValue("@CAD_EMAIL", cliente.CAD_EMAIL);

                cmd.Parameters.AddWithValue("@CAD_ENDERECO_NUMERO", cliente.CAD_ENDERECO_NUMERO.Trim());
                cmd.Parameters.AddWithValue("@CAD_ENDERECO", cliente.CAD_ENDERECO.Trim());
                cmd.Parameters.AddWithValue("@CAD_COMPLEMENTO", cliente.CAD_ENDERECO_COMPLEMENTO.Trim());
                cmd.Parameters.AddWithValue("@CAD_BAIRRO", cliente.CAD_BAIRRO.Trim());
                cmd.Parameters.AddWithValue("@CAD_CIDADE", cliente.CAD_CIDADE.Trim());
                cmd.Parameters.AddWithValue("@CAD_ESTADO", cliente.CAD_UF.Trim());
                cmd.Parameters.AddWithValue("@CAD_CEP", cliente.CAD_CEP.Trim());

                cmd.Parameters.AddWithValue("@CAD_CONTATO", cliente.CAD_CONTATO);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE1_DDD", cliente.CAD_TELEFONE1_DDD);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE2_DDD", cliente.CAD_TELEFONE2_DDD);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE1", cliente.CAD_TELEFONE1);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE2", cliente.CAD_TELEFONE2);

                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CONTATO", cliente.CAD_FINANCEIRO_CONTATO);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE1_DDD", cliente.CAD_FINANCEIRO_TELEFONE1_DDD);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE1", cliente.CAD_FINANCEIRO_TELEFONE1);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE2_DDD", cliente.CAD_FINANCEIRO_TELEFONE2_DDD);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE2", cliente.CAD_FINANCEIRO_TELEFONE2);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CELULAR1_DDD", cliente.CAD_FINANCEIRO_CELULAR_DDD);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CELULAR1", cliente.CAD_FINANCEIRO_CELULAR);
                cmd.Parameters.AddWithValue("@CAD_CELULAR_ACEITA", cliente.CAD_CELULAR_ACEITA);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL3", cliente.CAD_FINANCEIRO_EMAIL3);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL2", cliente.CAD_FINANCEIRO_EMAIL2);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL", cliente.CAD_FINANCEIRO_EMAIL);
                cmd.Parameters.AddWithValue("@CAD_ATUALIZADO_POR", cliente.CAD_CADASTRO_ATUALIZADOPOR);

                cmd.Parameters.AddWithValue("@CNPJ_CPF", cliente.CAD_CNPJ.Replace(".", "").Replace("/", "").Replace("-", ""));

                cmd.ExecuteNonQuery();
                conn.Close();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool setUpdateCadastroAsseponto(Modelo.Asseponto.ClienteDetail cliente)
        {
            try
            {
                conn.Open();
                cmd = new SqlCommand("SET DATEFORMAT DMY " +
                "UPDATE AssepontoClientes " +
                "SET CAD_RAZAOSOCIAL = @CAD_RAZAOSOCIAL, " +
                "    CAD_FANTASIA = @CAD_FANTASIA,  " +
                "    CAD_IE = @CAD_IE, " +
                "    CAD_ENDERECO =  @CAD_ENDERECO,  " +
                "    CAD_ENDERECO_NUMERO = @CAD_ENDERECO_NUMERO,  " +
                "    CAD_COMPLEMENTO = @CAD_COMPLEMENTO, " +
                "    CAD_BAIRRO = @CAD_BAIRRO,  " +
                "    CAD_CIDADE = @CAD_CIDADE,  " +
                "    CAD_CEP = @CAD_CEP,  " +
                "    CAD_ESTADO = @CAD_ESTADO, " +
                "    CAD_CONTATO = @CAD_CONTATO,  " +
                "    CAD_TELEFONE1_DDD = @CAD_TELEFONE1_DDD,  " +
                "    CAD_TELEFONE2_DDD = @CAD_TELEFONE2_DDD,  " +
                "    CAD_TELEFONE1 = @CAD_TELEFONE1,  " +
                "    CAD_TELEFONE2 = @CAD_TELEFONE2, " +
                "    CAD_FINANCEIRO_CELULAR1_DDD = @CAD_FINANCEIRO_CELULAR1_DDD,  " +
                "    CAD_FINANCEIRO_CELULAR1 = @CAD_FINANCEIRO_CELULAR1,  " +
                "    CAD_FINANCEIRO_CONTATO = @CAD_FINANCEIRO_CONTATO, " +
                "    CAD_FINANCEIRO_EMAIL = @CAD_FINANCEIRO_EMAIL,  " +
                "    CAD_FINANCEIRO_EMAIL2 = @CAD_FINANCEIRO_EMAIL2, " +
                "    CAD_FINANCEIRO_EMAIL3 = @CAD_FINANCEIRO_EMAIL3, " +
                "    CAD_FINANCEIRO_TELEFONE1_DDD = @CAD_FINANCEIRO_TELEFONE1_DDD,  " +
                "    CAD_FINANCEIRO_TELEFONE1 = @CAD_FINANCEIRO_TELEFONE1,   " +
                "    CAD_FINANCEIRO_TELEFONE2_DDD = @CAD_FINANCEIRO_TELEFONE2_DDD,   " +
                "    CAD_FINANCEIRO_TELEFONE2 = @CAD_FINANCEIRO_TELEFONE2, " +
                "    CAD_CELULAR_ACEITA = @CAD_CELULAR_ACEITA,   " +
                "    CAD_EMAIL = @CAD_EMAIL,   " +
                "    CAD_EMAIL2 = @CAD_EMAIL2,   " +
                "    CAD_EMAIL3 = @CAD_EMAIL3,   " +
                "    CAD_ATUALIZADO_POR = @CAD_ATUALIZADO_POR,   " +
                "    CAD_CADASTRO_ATUALIZADO_EM = @DATAATUALIZA " +
                "WHERE (dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj(@CNPJ_CPF) OR   " +
                "       dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj(@CNPJ_CPF)) ", conn);

                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@DATAATUALIZA", cliente.CAD_CADASTRO_ATUALIZADOEM.ToString("dd/MM/yyyy HH:mm:00"));
                cmd.Parameters.AddWithValue("@CAD_RAZAOSOCIAL", cliente.CAD_RAZAOSOCIAL);
                cmd.Parameters.AddWithValue("@CAD_FANTASIA", cliente.CAD_FANTASIA);
                cmd.Parameters.AddWithValue("@CAD_IE", cliente.CAD_IE);

                cmd.Parameters.AddWithValue("@CAD_EMAIL3", cliente.CAD_EMAIL3);
                cmd.Parameters.AddWithValue("@CAD_EMAIL2", cliente.CAD_EMAIL2);
                cmd.Parameters.AddWithValue("@CAD_EMAIL", cliente.CAD_EMAIL);

                cmd.Parameters.AddWithValue("@CAD_ENDERECO_NUMERO", cliente.CAD_ENDERECO_NUMERO.Trim());
                cmd.Parameters.AddWithValue("@CAD_ENDERECO", cliente.CAD_ENDERECO.Trim());
                cmd.Parameters.AddWithValue("@CAD_COMPLEMENTO", cliente.CAD_ENDERECO_COMPLEMENTO.Trim());
                cmd.Parameters.AddWithValue("@CAD_BAIRRO", cliente.CAD_BAIRRO.Trim());
                cmd.Parameters.AddWithValue("@CAD_CIDADE", cliente.CAD_CIDADE.Trim());
                cmd.Parameters.AddWithValue("@CAD_ESTADO", cliente.CAD_UF.Trim());
                cmd.Parameters.AddWithValue("@CAD_CEP", cliente.CAD_CEP.Trim());

                cmd.Parameters.AddWithValue("@CAD_CONTATO", cliente.CAD_CONTATO);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE1_DDD", cliente.CAD_TELEFONE1_DDD);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE2_DDD", cliente.CAD_TELEFONE2_DDD);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE1", cliente.CAD_TELEFONE1);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE2", cliente.CAD_TELEFONE2);

                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CONTATO", cliente.CAD_FINANCEIRO_CONTATO);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE1_DDD", cliente.CAD_FINANCEIRO_TELEFONE1_DDD);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE1", cliente.CAD_FINANCEIRO_TELEFONE1);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE2_DDD", cliente.CAD_FINANCEIRO_TELEFONE2_DDD);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE2", cliente.CAD_FINANCEIRO_TELEFONE2);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CELULAR1_DDD", cliente.CAD_FINANCEIRO_CELULAR_DDD);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CELULAR1", cliente.CAD_FINANCEIRO_CELULAR);
                cmd.Parameters.AddWithValue("@CAD_CELULAR_ACEITA", cliente.CAD_CELULAR_ACEITA);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL3", cliente.CAD_FINANCEIRO_EMAIL3);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL2", cliente.CAD_FINANCEIRO_EMAIL2);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL", cliente.CAD_FINANCEIRO_EMAIL);
                cmd.Parameters.AddWithValue("@CAD_ATUALIZADO_POR", cliente.CAD_CADASTRO_ATUALIZADOPOR);

                cmd.Parameters.AddWithValue("@CNPJ_CPF", cliente.CAD_CNPJ);

                cmd.ExecuteNonQuery();
                conn.Close();
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
