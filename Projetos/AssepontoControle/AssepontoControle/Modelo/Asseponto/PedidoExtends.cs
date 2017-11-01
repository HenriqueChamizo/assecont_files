using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Modelo.Asseponto
{
    public class PedidoDetail
    {
        public int PED_IND;
        public int PED_REV_IND;
        public string PED_CLI_RAZAO;
        public string PED_CLI_CNPJ;
        public string PED_CLI_CPF;
        public string PED_CLI_IE;
        public string PED_CLI_ENDERECO;
        public string PED_CLI_ENDERECO_NUMERO;
        public string PED_CLI_ENDERECO_COMPLEMENTO;
        public string PED_CLI_CEP;
        public string PED_CLI_BAIRRO;
        public string PED_CLI_CIDADE;
        public string PED_CLI_UF;
        public string PED_CLI_EMAIL;
        public string PED_SKYPE;
        public string PED_CLI_TELEFONE;
        public string PED_CLI_TELEFONE_DDD;
        public int PED_CLI_QTD_FUNCIONA;
        public string PED_CLI_CONTATO;
        public int PED_VERSAO_AQUISICAO;
        public string PED_EMAIL2;
        public bool PED_COM_MANUTENCAO; 
	    public string PED_MODELOREP;
        public bool PED_REPINSTALADO; 
	    public string PED_DESCRICAO;
        public string PED_SITUACAO;
        public string PED_SOLICITANTE;
        public DateTime PED_DATA_FECHAMENTO;
        public int PED_REP_FABRICANTE;
        public string PED_CLI_TELEFONE2;
        public string PED_CLI_TELEFONE2_DDD;
        public string PED_CLI_CELULAR;
        public string PED_CLI_CELULAR_DDD;
        public bool PED_CLI_CELULAR_ACEITA;
        public string PED_FANTASIA;
        public DateTime PED_DATA;
        public int PED_STATUS;
        public bool PED_PLANILHA_EXCEL;

        public List<FabricantesDropDrow> fabricantes;
    }
}
