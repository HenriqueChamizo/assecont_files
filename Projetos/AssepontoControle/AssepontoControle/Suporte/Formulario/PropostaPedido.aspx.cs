using System;
using System.Configuration;
using Asseponto.Classes;

namespace Asseponto.Suporte.Formulario
{
    public partial class PropostaPedido : System.Web.UI.Page
    {
        private int tipo;
        private Single valor;
        private BDApp bd;
        private BDAppAssefin bdAssefin;

        private string descricao;
        private string contato;
        private string emailPrincipal;
        private string cnpjCpf;

        protected void Page_Load(object sender, EventArgs e)
        {
            tipo = Convert.ToInt32(Request.QueryString["t"]);
            bd = new BDApp();

            contato = txtContato.Text;
            emailPrincipal = txtEmail.Text;
            cnpjCpf = txtCNPJCpf.Text.Trim().Replace('/', ' ').Replace('.', ' ').Replace('_', ' ');

            VerificarValores();
        }

        protected void btnAceitar_Click(object sender, EventArgs e)
        {
            bdAssefin = new BDAppAssefin();
            int indice = bdAssefin.getCadastroIndice(cnpjCpf);
            if (indice > 0)
                RealizarPedido(indice);
            else
                EmailAderirServico(false);

            EmailRetornoCliente();
        }

        void VerificarValores()
        {
            if (tipo == BDAppAssefin.atendimentoAvulso30)
            {
                lbTipoServico.Text = descricao = "2) Contratação Avulso (30 dias) dos serviços de Suporte Técnico Mensal";
                valor = Convert.ToSingle(bd.getValorAtendimentoAvulso30());

                lbDescricao.Text = "<p style='-webkit-margin-after: 0;'> " +
                    "<ul style='list-style-type: none;' > " +
                        "<li>b)&nbsp;&nbsp;Não inclui atualizações up-grandes do software AssePonto.</li> " +
                        "<li>a)&nbsp;&nbsp;Serviços disponíveis por 30 dias a contar da data do pagamento.</li> " +
                        "<li>c)&nbsp;&nbsp;Liberação mediante comprovação do pagamento.</li> " +
                    "</ul> </p>  " +
                    "<b style='font-size: 14pt; padding-left: 38px;'><span style='font-size: 25pt; vertical-align: sub;'>&gt; </span> " +
                        string.Format("{0:n2}", valor) +
                    "</b>";
            }
            else
            {
                lbTipoServico.Text = descricao = "3) Contratação Avulso (por atendimento) de suporte Técnico";
                valor = Convert.ToSingle(bd.getValorAtendimentoAvulso());

                lbDescricao.Text = "<p style='-webkit-margin-after: 0;'> " +
                    "<ul  style='list-style-type: none;' > " +
                        "<li>a)&nbsp;&nbsp;Não inclui atualizações up-grandes do Software AssePonto.</li> " +
                        "<li>b)&nbsp;&nbsp;Liberação do serviço mediante comprovação do pagamento.</li> " +
                    "</ul> </p>  " +
                    "<b style='font-size: 14pt; padding-left: 38px;'><span style='font-size: 25pt; vertical-align: sub;'>&gt; </span> " +
                        string.Format("{0:n2}", valor) +
                    "</b>";
            }
        }

        void RealizarPedido(int indice)
        {
            int pedido = bdAssefin.setCriarPedido(3, "Cliente", indice, valor, 1);
            bdAssefin.setCriarPedidoItem(pedido, BDAppAssefin.atendimentoAvulso30, 1, valor);
            EmailAderirServico(true);
        }

        void EmailAderirServico(Boolean cadastrado)
        {
            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            EmailAtendimentoAvulso email = new EmailAtendimentoAvulso(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailAtendimentoAvulo.htm");
            email.SendInterno(contato, emailPrincipal, cnpjCpf, descricao, cadastrado);
        }

        void EmailRetornoCliente()
        {
            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            EmailAtendimentoAvulso email = new EmailAtendimentoAvulso(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailAtendimentoAvuloCliente.htm");
            email.SendCliente(contato, emailPrincipal, cnpjCpf, descricao);
        }
    }
}