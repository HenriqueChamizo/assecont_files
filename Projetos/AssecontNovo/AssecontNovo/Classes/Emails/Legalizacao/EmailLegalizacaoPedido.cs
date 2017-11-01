using System;
using System.Data;
namespace AssecontNovo.Classes.Emails.Legalizacao
{
    public class EmailLegalizacaoPedido : EmailLegalizacao
    {
        private int pedidoEtapa;
        private string Template;
        private string contato;
        private string razaoSocial;
        private string protocolo;
        private string cnpj;
        private string titulo;
        private string email;
        private string telefone;
        private Types.LegalizacaoServicoTipo tipo;
        BDAppAssecont bd = new BDAppAssecont();

        public EmailLegalizacaoPedido(int pedidoEtapa, string Template)
        {
            this.pedidoEtapa = pedidoEtapa;
            this.Template = Template;
        }

        protected override void getDados()
        {
            string query = string.Format("SELECT LEGPED_SERVICO, LEGCLI_CNPJ, LEGCLI_TELEFONE_DDD + ' ' + LEGCLI_TELEFONE AS TELEFONE, " +
                  "LEGPED_PROTOCOLO, LEGCLI_EMAIL, LEGCLI_RAZAOSOCIAL, LEGCLI_CONTATO " +
                  "FROM LegalizacaoClientes " +
                  "INNER JOIN LegalizacaoPedidos ON LEGPED_CADASTRO = LEGCLI_IND " +
                  "WHERE LEGPED_IND = {0}", pedidoEtapa);

            DataTable tb = bd.getDataTable(query);

            foreach (DataRow dr in tb.Rows)
            {
                tipo = (Types.LegalizacaoServicoTipo)Convert.ToInt32(dr["LEGPED_SERVICO"].ToString().Trim());
                contato = dr["LEGCLI_CONTATO"].ToString().Trim();
                razaoSocial = dr["LEGCLI_RAZAOSOCIAL"].ToString().Trim();
                protocolo = dr["LEGPED_PROTOCOLO"].ToString().Trim();
                email = dr["LEGCLI_EMAIL"].ToString().Trim();
                cnpj = dr["LEGCLI_CNPJ"].ToString().Trim();
                telefone = dr["TELEFONE"].ToString().Trim();
            }
            titulo = "Pedido de " + Wr.Classes.Utils.GetDescription(tipo) + " no protocolo: " + protocolo;
        }

        public void Send()
        {
            base.Send(titulo, "flavia@assecont.com.br");
        }

        protected override string CorpoEmailTemplate()
        {
            string corpoEmail = Wr.Classes.Files.ReadFile(Template);

            corpoEmail = corpoEmail.Replace("%CONTATO%", contato);
            corpoEmail = corpoEmail.Replace("%CONTATO%", contato);
            corpoEmail = corpoEmail.Replace("%RAZAOSOCIAL%", razaoSocial);
            corpoEmail = corpoEmail.Replace("%PROTOCOLO%", protocolo);
            corpoEmail = corpoEmail.Replace("%TITULO%", titulo);
            corpoEmail = corpoEmail.Replace("%TELEFONE%", telefone);
            if (!string.IsNullOrEmpty(cnpj)) corpoEmail = corpoEmail.Replace("%CNPJ%", "CNPJ: " + cnpj);
            corpoEmail = corpoEmail.Replace("%SERVICO%", Wr.Classes.Utils.GetDescription(tipo));

            return corpoEmail;
        }
    }
}