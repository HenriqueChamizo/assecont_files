using System;
using System.Data;
namespace AssecontNovo.Classes.Emails.Legalizacao
{
    public class EmailLegalizacaoProcedimento : EmailLegalizacao
    {
        private int pedidoEtapa;
        private string Template;
        private string contato;
        private string razaoSocial;
        private string protocolo;
        private string texto;
        private string titulo;
        private string email;
        private Types.LegalizacaoServicoTipo tipo;
        BDAppAssecont bd = new BDAppAssecont();

        public EmailLegalizacaoProcedimento(int pedidoEtapa, string Template) {
            this.pedidoEtapa = pedidoEtapa;
            this.Template = Template;
        }

        protected override void getDados()
        {
            string query = string.Format("SELECT LEGPED_SERVICO, " +
                  "LEGPED_PROTOCOLO, LEGETA_EMAIL_TITULO, LEGETA_EMAIL_DESCRICAO, LEGCLI_EMAIL, LEGCLI_RAZAOSOCIAL, LEGCLI_CONTATO " +
                  "FROM LegalizacaoClientes " +
                  "INNER JOIN LegalizacaoPedidos ON LEGPED_CADASTRO = LEGCLI_IND " +
                  "INNER JOIN LegalizacaoPedidosEtapas ON LEGPED_IND = LPETA_PEDIDO " +
                  "INNER JOIN LegalizacaoEtapas ON LEGETA_IND = LPETA_ETAPA " +
                  "WHERE LPETA_IND = {0}", pedidoEtapa);

            DataTable tb = bd.getDataTable(query);

            foreach (DataRow dr in tb.Rows)
            {
                tipo = (Types.LegalizacaoServicoTipo)Convert.ToInt32(dr["LEGPED_SERVICO"].ToString().Trim());
                contato = dr["LEGCLI_CONTATO"].ToString().Trim();
                razaoSocial = dr["LEGCLI_RAZAOSOCIAL"].ToString().Trim();
                protocolo = dr["LEGPED_PROTOCOLO"].ToString().Trim();
                texto = dr["LEGETA_EMAIL_DESCRICAO"].ToString().Trim();
                titulo = dr["LEGETA_EMAIL_TITULO"].ToString().Trim().Replace("%PROTOCOLO%", protocolo);
                email = dr["LEGCLI_EMAIL"].ToString().Trim();
            }
        }

        public void Send()
        {
            base.Send(titulo, email);
        }

        protected override string CorpoEmailTemplate() {

            string corpoEmail = Wr.Classes.Files.ReadFile(Template);

            corpoEmail = corpoEmail.Replace("%CONTATO%", contato);
            corpoEmail = corpoEmail.Replace("%TEXTO%", texto);
            corpoEmail = corpoEmail.Replace("%RAZAOSOCIAL%", razaoSocial);
            corpoEmail = corpoEmail.Replace("%PROTOCOLO%", protocolo);
            corpoEmail = corpoEmail.Replace("%TITULO%", titulo);
            corpoEmail = corpoEmail.Replace("%SERVICO%", Wr.Classes.Utils.GetDescription(tipo));

            return corpoEmail;
        }

        protected override void atualizar()
        {
            bd.executeCommand("UPDATE LegalizacaoPedidosEtapas SET LPETA_EMAIL_ENVIADO_EM = GETDATE() WHERE LPETA_IND = " + pedidoEtapa);
        }
    }
}