using System;
using System.Collections.Generic;
using System.Data;

namespace AssecontNovo.Classes.Sms
{
    public class SmsLegalizacao : SmsApp
    {
        private int pedidoEtapa;
        private string Texto;
        private string DDD;
        private string Celular;

        BDAppAssecont bd = new BDAppAssecont();

        public SmsLegalizacao(int pedidoEtapa)
        {
            this.pedidoEtapa = pedidoEtapa;
            getDados();
        }

        public void getDados()
        {
            string query = string.Format("SELECT LEGPED_PROTOCOLO, LEGETA_SMS_DESCRICAO, LEGCLI_CELULAR_DDD, LEGCLI_CELULAR FROM LegalizacaoClientes " +
                  "INNER JOIN LegalizacaoPedidos ON LEGPED_CADASTRO = LEGCLI_IND " +
                  "INNER JOIN LegalizacaoPedidosEtapas ON LEGPED_IND = LPETA_PEDIDO " +
                  "INNER JOIN LegalizacaoEtapas ON LEGETA_IND = LPETA_ETAPA " +
                  "WHERE LPETA_IND = {0}", pedidoEtapa);

           
            DataTable tb = bd.getDataTable(query);

            foreach (DataRow dr in tb.Rows)
            {
                Texto = dr["LEGETA_SMS_DESCRICAO"].ToString().Trim().Replace("%PROTOCOLO%", dr["LEGPED_PROTOCOLO"].ToString());
                DDD = dr["LEGCLI_CELULAR_DDD"].ToString().Trim();
                Celular = dr["LEGCLI_CELULAR"].ToString().Trim();
            }            
        }

        public void SendSms()
        {
            Send(DDD, Celular, Texto);
        }

        protected override void updateTableGeneric(int codigoStatus)
        {
            if (codigoStatus == 0)
            {
                bd.executeCommand("UPDATE LegalizacaoPedidosEtapas SET LPETA_SMS_ENVIADO_EM = GETDATE() WHERE LPETA_IND = " + pedidoEtapa);
            }
        }
    }
}