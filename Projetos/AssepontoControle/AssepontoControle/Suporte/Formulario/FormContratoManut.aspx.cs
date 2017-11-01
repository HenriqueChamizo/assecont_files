using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using System.Configuration;

namespace Asseponto.Suporte.Formulario
{
    public class Periodos
    {
        public int meses;
        public string descricao;
    }

    public partial class FormContratoManut : System.Web.UI.Page
    {
        public bool avulso = false;

        private List<Periodos> listaPeriodos()
        {
            List<Periodos> per = new List<Periodos>();
            BDApp bd = new BDApp();
            List<string> list = bd.getMesesFromPlanos();
            foreach (string l in list)
            {
                String[] Split = l.Trim().Split(new String[] { " " }, StringSplitOptions.None);
                per.Add(new Periodos() { meses = Convert.ToInt32(Split[0]), descricao = l.Trim() });
            }
            //per.Add(new Periodos() { meses = 6, descricao = "6 meses" });
            //per.Add(new Periodos() { meses = 12, descricao = "12 meses" });

            return per;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (Periodos per in listaPeriodos())
            {
                cmbPeriodo.Items.Add(per.descricao);
            }
            if (!IsPostBack)
                ManutencaoContrato.Visible = panelDescricao.Visible = false;

            string btn = Request.QueryString["btn"];
            if (btn == "avulso")
            {
                RFieldsQtd.Enabled = RCustomQtd.Enabled = txtQtd.Visible = lbVigencia.Visible = false;
                lbPeriodo.Visible = lbFuncionario.Visible = lkOK6.Visible = lkOK12.Visible = lkOK18.Visible = cmbPeriodo.Visible = false;
                lbEmail.Visible = txtEmail.Visible = lkSolicitar.Visible = avulso = true;
                panelDescricao.Visible = lbContato.Visible = lbNome.Visible = txtNome.Visible = true;
            }
            else if (btn == "6")
            {
                lkOK6.Visible = true;
                lkOK12.Visible = false;
                lkOK18.Visible = false;
                panelAvulso.Visible = lkSolicitar.Visible = avulso = false;
            }
            else if (btn == "12")
            {
                lkOK6.Visible = false;
                lkOK12.Visible = true;
                lkOK18.Visible = false;
                panelAvulso.Visible = lkSolicitar.Visible = avulso = false;
            }
            else if (btn == "18")
            {
                lkOK6.Visible = false;
                lkOK12.Visible = false;
                lkOK18.Visible = true;
                panelAvulso.Visible = lkSolicitar.Visible = avulso = false;
            }
            else
            {
                lkOK6.Visible = true;
                lkOK12.Visible = true;
                lkOK18.Visible = true;
                panelAvulso.Visible = lkSolicitar.Visible = avulso = false;
            }
        }

        protected void lkOK6_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                ManutencaoContrato.Visible = panelDescricao.Visible = true;

                //Periodos per = listaPeriodos().Find(f => f.descricao == cmbPeriodo.Text);
                //if (per != null)
                //    ManutencaoContrato.Meses = per.meses;
                //else
                //    ManutencaoContrato.Meses = 12;
                ManutencaoContrato.Meses = 6;
                ManutencaoContrato.Funcionarios = Convert.ToInt32(txtQtd.Text);
                ManutencaoContrato.RazaoSocial = txtRazaoSocial.Text.Trim();
                ManutencaoContrato.CNPJ_CPF = txtCnpj.Text;
                ManutencaoContrato.getDados();
                // num = Convert.ToInt32(txtQtd.Text);
                //lbContratante.Text = 
                //lbCnpjContratante.Text = string.Format(@"{0:00\.000\.000/0000\-00}", Convert.ToDouble(txtCnpj.Text));
                //lbValor2.Text = string.Format("{0:n2}", valor);
                //lbValorDescricao.Text = extensoValor;

                panelFunc.Visible = false;
            }
        }

        protected void lkOK12_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                ManutencaoContrato.Visible = panelDescricao.Visible = true;

                //Periodos per = listaPeriodos().Find(f => f.descricao == cmbPeriodo.Text);
                //if (per != null)
                //    ManutencaoContrato.Meses = per.meses;
                //else
                //    ManutencaoContrato.Meses = 12;
                ManutencaoContrato.Meses = 12;
                ManutencaoContrato.Funcionarios = Convert.ToInt32(txtQtd.Text);
                ManutencaoContrato.RazaoSocial = txtRazaoSocial.Text.Trim();
                ManutencaoContrato.CNPJ_CPF = txtCnpj.Text;
                ManutencaoContrato.getDados();
                // num = Convert.ToInt32(txtQtd.Text);
                //lbContratante.Text = 
                //lbCnpjContratante.Text = string.Format(@"{0:00\.000\.000/0000\-00}", Convert.ToDouble(txtCnpj.Text));
                //lbValor2.Text = string.Format("{0:n2}", valor);
                //lbValorDescricao.Text = extensoValor;

                panelFunc.Visible = false;
            }
        }

        protected void lkOK18_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                ManutencaoContrato.Visible = panelDescricao.Visible = true;

                //Periodos per = listaPeriodos().Find(f => f.descricao == cmbPeriodo.Text);
                //if (per != null)
                //    ManutencaoContrato.Meses = per.meses;
                //else
                //    ManutencaoContrato.Meses = 12;
                ManutencaoContrato.Meses = 18;
                ManutencaoContrato.Funcionarios = Convert.ToInt32(txtQtd.Text);
                ManutencaoContrato.RazaoSocial = txtRazaoSocial.Text.Trim();
                ManutencaoContrato.CNPJ_CPF = txtCnpj.Text;
                ManutencaoContrato.getDados();
                // num = Convert.ToInt32(txtQtd.Text);
                //lbContratante.Text = 
                //lbCnpjContratante.Text = string.Format(@"{0:00\.000\.000/0000\-00}", Convert.ToDouble(txtCnpj.Text));
                //lbValor2.Text = string.Format("{0:n2}", valor);
                //lbValorDescricao.Text = extensoValor;

                panelFunc.Visible = false;
            }
        }

        protected void lkSolicitar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    EnviaEmailAvulso();
                    EnviaEmailAvulsoCliente();

                    lbRazaoSocialDigitada.Text = txtRazaoSocial.Text;
                    lbEmailDigitada.Text = txtEmail.Text;
                    panelFunc.Visible = false;
                    panelAvulso.Visible = true;
                }
                catch (Exception ex)
                {
                    string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"]; //bd.getEmailFromSuporte(UserApp.UserId);
                    EmailMsgInterna msgInterna = new EmailMsgInterna(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailMsgInterna.htm");
                    msgInterna.Send("henrique@assecont.com.br", ex.Message, "Exception AssepontoControle - FormContratoManut");
                }
            }
        }

        protected void RCustomQtd_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = Convert.ToInt32(txtQtd.Text) > (new BDApp()).getMaximoFuncionarios() ? false : true;
        }

        protected void RCustomCnpj_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = Wr.Classes.Validadores.ValidaCnpj(txtCnpj.Text);
        }

        private void EnviaEmailAvulso()
        {
            string SERVICO = "Solicitação de Prestação de Serviço Avulso às " + DateTime.Now.ToString();
            string CONTATO = txtNome.Text;
            string CNPJCPF = (txtCnpj.Text).Replace(".", "").Replace("-", "").Replace("/", "");
            string EMAIL = txtEmail.Text;
            
            BDAppAssefin bd = new BDAppAssefin();
            bool existe = bd.getFieldValueBool(String.Format("select case when exists(select * from Cadastros where CAD_CNPJ = '{0}' or CAD_CPF = '{0}') then 1 else 0 end", CNPJCPF));

            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"]; //bd.getEmailFromSuporte(UserApp.UserId);

            EmailAtendimentoAvulso emailAvulso = new EmailAtendimentoAvulso(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailAtendimentoAvulo.htm");
            emailAvulso.SendInterno(CONTATO, EMAIL, CNPJCPF, SERVICO, existe);
        }

        private void EnviaEmailAvulsoCliente()
        {
            string SERVICO = "Solicitação de Prestação de Serviço Avulso às " + DateTime.Now.ToString();
            string CONTATO = txtNome.Text;
            string CNPJCPF = txtCnpj.Text;
            string EMAIL = txtEmail.Text;

            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"]; //bd.getEmailFromSuporte(UserApp.UserId);

            EmailAtendimentoAvulso emailAvulso = new EmailAtendimentoAvulso(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailAtendimentoAvuloCliente.htm");
            emailAvulso.SendCliente(CONTATO, EMAIL, CNPJCPF, SERVICO);
        }
    }
}