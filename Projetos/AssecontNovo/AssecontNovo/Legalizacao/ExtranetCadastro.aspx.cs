using System;
using System.Web.UI;
using AssecontNovo.Classes;
using AssecontNovo.Classes.Emails.Legalizacao;
using AssecontNovo.Classes.Sms;

namespace AssecontNovo.Legalizacao
{
    public partial class ExtranetCadastro : System.Web.UI.Page
    {
        private Types.LegalizacaoServicoTipo lgServico;
        private BDAppAssecont bd;

        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDAppAssecont();
            lgServico = (Types.LegalizacaoServicoTipo)Convert.ToInt32(Request.QueryString["ind"]);

            if (!IsPostBack)
            {
                lbTituloPedido.Text = "Pedido de " + Wr.Classes.Utils.GetDescription(((Types.LegalizacaoServicoTipo)lgServico));

                if (lgServico == Types.LegalizacaoServicoTipo.Abertura)
                    PanelCnpj.Visible = false;
            }
        }

        private void FinalizarPedido(Cliente cliente)
        {
            int protocolo = bd.getLegalizcaoProtocolo();
            int idPedido = bd.setLegalizacaoPedido(cliente.Id, txtObervacao.Text, protocolo, lgServico);

            bd.setLegalizacaoStatus(idPedido);
            enviarEmailExterno(idPedido);

            lbProtocolo.Text = protocolo.ToString();            

            PanelCadastro.Visible = false;
            panelSucesso.Visible = true;
        }

        protected void lbVoltar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Legalizacao/default.aspx");
        }

        protected void btSalvar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string cnpjCpf = txtCNPJ_CPF.Text;

                Cliente cliente = new Cliente();
                cliente.RazaoSocial = txtRazaoSocial.Text;
                cliente.Contato = txtContato.Text;
                cliente.Celular_ddd = txtCelular.Text;
                cliente.Telefone = txtTelefone.Text;
                cliente.Telefone_ddd = txtTelefoneDDD.Text;
                cliente.Email = txtEmail.Text;

                cliente.CpfCnpj = cnpjCpf.Replace('-', ' ').Replace('/', ' ').Replace('.', ' ');
                cliente.ClienteNumero = bd.getClientNumero(cnpjCpf);
                int indice = string.IsNullOrEmpty(cnpjCpf) ? 0 : bd.getLegalizacaoCadastro(cnpjCpf);

                if (indice == 0)
                    cliente.Id = bd.setLegalizacaoCadastrar(cliente);
                else
                    cliente.Id = indice;

                FinalizarPedido(cliente);
            }
        }

        private void enviarEmailExterno(int pedidoId)
        {
            int pedidoEtapa = bd.getFieldValueInteger(string.Format("SELECT LPETA_IND FROM LegalizacaoPedidosEtapas " +
                "INNER JOIN LegalizacaoEtapas ON LEGETA_IND = LPETA_ETAPA WHERE LPETA_PEDIDO = {0} ORDER BY LEGETA_ORDEM ASC", pedidoId));

            (new SmsLegalizacao(pedidoEtapa)).SendSms();
            (new EmailLegalizacaoProcedimento(pedidoEtapa, Server.MapPath("") + "\\..\\Classes\\Emails\\Legalizacao\\EmailLegalizacao.htm")).Send();
        }

        private void enviarEmailInterno()
        {
 
        }
    }
}