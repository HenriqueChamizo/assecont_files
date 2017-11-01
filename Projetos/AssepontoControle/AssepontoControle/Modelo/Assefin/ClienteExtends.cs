using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Modelo.Assefin
{
    public class ClienteDetail : AClienteDetail
    {
        public bool CAD_ATIVO;
        public bool CAD_FORNECEDOR;
        public bool CAD_CLIENTE;
	    public bool CAD_DUVIDOSO;
	    public int CAD_GRUPO;
        public int CAD_CODIGO;
        public int CAD_TIPO_PESSOA;
	    public bool CAD_TRANSPORTADOR;
	    public string CAD_CODIGO_MUNICIPIO;
	    public bool CAD_OPTANTE_SIMPLES;
	    public bool CAD_COMERCIANTE;
	    public string CAD_PAIS;
	    public string CAD_PAIS_CODIGO;
	    public bool CAD_REPRESENTANTE;
	    public string CAD_IM;
	    public int CAD_PERFIL;
        public double CAD_COMISSAO_PORCENTO;
        public DateTime CAD_CELULAR_CADASTRADO_EM;
	    public DateTime CAD_CELULAR_ATUALIZADO_EM;
        public DateTime CAD_BLOQUEIO_LIBERADO_ATE;
        public DateTime CAD_ULTIMA_BAIXA;
	    public bool CAD_IE_ISENTO;
        public bool CAD_IE_NAO_CONTRIBUINTE;
        public string CAD_CADASTRO_ATUALIZADOPOR;
    }
}
