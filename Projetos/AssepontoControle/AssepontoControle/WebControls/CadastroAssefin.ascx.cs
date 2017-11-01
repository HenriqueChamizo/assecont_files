using System;
using System.Data;
using Asseponto.Classes;

namespace Asseponto.WebControls
{
    public partial class CadastroAssefin : System.Web.UI.UserControl
    {
        private int _clienteId;
        public int ClienteId
        {
            get { return _clienteId; }
            set { _clienteId = value; }
        }

        private int _revendaId;
        public int RevendaId
        {
            get { return _revendaId; }
            set { _revendaId = value; }
        }

        private int _assefinId;
        public int AssefinId
        {
            get { return _assefinId; }
            set { _assefinId = value; }
        }

        private string cnpjCpf;

        DateTime dateTimeAssepontoControle;
        DateTime dateTimeAssefin;
        private string atualizadoPor;

        protected void Page_Load(object sender, EventArgs e)
        {
            ChecarAtualizacao();
        }

        void ChecarAtualizacao()
        {
            BDApp bd = new BDApp();

            if (ClienteId == 0)
                TablRevendaAssepontoControle(bd, RevendaId);
            else
                TableClienteAssepontoControle(bd, ClienteId);


            BDAppAssefin bdAssefin = new BDAppAssefin();
            AssefinId = bdAssefin.getCadastroIndice(cnpjCpf);
            DataTable dtAssefin = bdAssefin.getCadastroAtualizado(AssefinId);

            if (AssefinId == 0)
            {
                lbMsgCadastroAssefin.Text = "CADASTRO NÃO LOCALIZADO NO ASSEFIN";
                getAtualizacaoAssepontoControle();
            }
            else
            {
                TdAssefin.Style.Add("display", "none");
                if (!(dtAssefin.Rows[0]["CAD_CADASTRO_ATUALIZADO_EM"] is DBNull) && dtAssefin.Rows.Count > 0)
                    dateTimeAssefin = Convert.ToDateTime(dtAssefin.Rows[0]["CAD_CADASTRO_ATUALIZADO_EM"]);

                if (dateTimeAssefin.CompareTo(dateTimeAssepontoControle) == 0 && dateTimeAssefin != DateTime.MinValue)
                {
                    ExibirMsg("Assefin/AssepontoControle", dateTimeAssefin, dtAssefin.Rows[0]["CAD_ATUALIZADO_POR"].ToString());
                }
                else
                {
                    lbMsgAtualizacao.Text = "DESATUALIZADO !";
                    TdAtualizacao.Style.Add("background-color", "crimson");
                }
            }
        }

        void getAtualizacaoAssepontoControle()
        {
            if (string.IsNullOrEmpty(atualizadoPor))
            {
                lbMsgAtualizacao.Text = "DESATUALIZADO !";
                TdAtualizacao.Style.Add("background-color", "crimson");
            }
            else
                ExibirMsg("assepontoControle", dateTimeAssepontoControle, atualizadoPor);
        }

        void ExibirMsg(string text, DateTime date, string atualizadoPor)
        {
            lbMsgAtualizacao.Text += "ATUALIZADO NO " + text + " <br />EM " + date.ToString("dd/MM/yyyy HH:mm") +
                     " POR " + atualizadoPor;
        }

        bool TableClienteAssepontoControle(BDApp bd, int indice)
        {
            cnpjCpf = bd.getClienteCnpjCpf(ClienteId);
            DataTable dtAsseponto = bd.getCadastroUltimaAtualizacao(indice);

            if (dtAsseponto.Rows.Count > 0)
            {
                dateTimeAssepontoControle = Convert.ToDateTime(dtAsseponto.Rows[0]["CAD_CADASTRO_ATUALIZADOEM"]);
                atualizadoPor = dtAsseponto.Rows[0]["SUP_NOME"].ToString();
                return true;
            }
            else
                return false;
        }

        bool TablRevendaAssepontoControle(BDApp bd, int indice)
        {
            cnpjCpf = bd.getRevendaCnpjCpf(indice);
            DataTable dtAsseponto = bd.getRevendaUltimaAtualizacao(indice);

            if (dtAsseponto.Rows.Count > 0)
            {
                dateTimeAssepontoControle = Convert.ToDateTime(dtAsseponto.Rows[0]["REV_CADASTRO_ATUALIZADOEM"]);
                atualizadoPor = dtAsseponto.Rows[0]["SUP_NOME"].ToString();
                return true;
            }
            else
                return false;
        }
    }
}