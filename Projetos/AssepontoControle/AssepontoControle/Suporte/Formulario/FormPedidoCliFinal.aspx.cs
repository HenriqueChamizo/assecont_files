using System;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;
using Wr.Classes;

namespace Asseponto.Suporte.Formulario
{
    public partial class FormPedidoCliFinal : System.Web.UI.Page
    {
        private int PedidoIndice;
        private BDApp bd;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Enviar_Email_Pedido()
        {
            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = ConfigurationManager.AppSettings["EMAILRECIPIENT"];
            string EmailCC = ConfigurationManager.AppSettings["EMAILRECIPIENTCC"];
            string EmailCC2 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC2"];
            string EmailCC3 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC3"];
            string EmailCC4 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC4"];
            string EmailCC5 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC5"];

            EmailPedido email = new EmailPedido(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailPedido.htm");
            email.Send(EmailTo, EmailCC, EmailCC2, EmailCC3, EmailCC4, EmailCC5, PedidoIndice);
        }

        protected void Enviar_Email_Pedido_Retorno()
        {
            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = ((TextBox)FvClienteFinal.FindControl("txtEmail")).Text;
            string EmailCC = ((TextBox)FvClienteFinal.FindControl("txtEmail2")).Text;

            EmailPedidoRetorno email = new EmailPedidoRetorno(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailPedidoRetorno.htm");
            email.Send(EmailTo, EmailCC, PedidoIndice);
        }

        protected void sqlPedidosRevendas_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (Page.IsValid)
            {
                PedidoIndice = bd.getIdentity(e.Command);

                Enviar_Email_Pedido();
                Enviar_Email_Pedido_Retorno();

                Response.Redirect("http://www.asseponto.com.br/assepontocontrole/RevendaCadastro/EnviadoCadastroSucesso.aspx");
            }
        }

        protected void RadComboBox1_DataBinding(object sender, EventArgs e)
        {
            //Binding do Combox UF
            RadComboBox combo = (RadComboBox)sender;
            combo.DataSourceID = "sqlEstados";
            combo.DataTextField = "EST_NOME";
            combo.DataValueField = "EST_SIGLA";
        }

        protected void RadComboBox2_DataBinding(object sender, EventArgs e)
        {
            //Binding do Combox Lista de Relogios
            RadComboBox combo = (RadComboBox)sender;
            combo.DataSourceID = "sqlAssepontoRepFabricantes";
            combo.DataTextField = "FABR_NOME";
            combo.DataValueField = "FABR_COD";
        }

        protected void CustomValidator1_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            RadMaskedTextBox txtCNPJ = (RadMaskedTextBox)FvClienteFinal.FindControl("txtCNPJ");
            RadMaskedTextBox txtCPF = (RadMaskedTextBox)FvClienteFinal.FindControl("txtCPF");

            if (
               (!string.IsNullOrEmpty(txtCNPJ.Text) && string.IsNullOrEmpty(txtCPF.Text)) ||
               (string.IsNullOrEmpty(txtCNPJ.Text) && !string.IsNullOrEmpty(txtCPF.Text))
              )
                args.IsValid = true;
            else
                args.IsValid = false;
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            bd = new BDApp();

            /*Validar se já existe o CNPJ ou CPF na tabela AssepontoClientes*/
            RadMaskedTextBox txtCNPJ = (RadMaskedTextBox)FvClienteFinal.FindControl("txtCNPJ");
            RadMaskedTextBox txtCPF = (RadMaskedTextBox)FvClienteFinal.FindControl("txtCPF");
            string cnpj = txtCNPJ.Text;
            string cpf = txtCPF.Text;

            if (cnpj != "")
                args.IsValid = bd.getFieldValueString(string.Format("SELECT CAD_RAZAOSOCIAL FROM AssepontoClientes WHERE dbo.fn_asseponto_trim_cnpj(CAD_CNPJ) = dbo.fn_asseponto_trim_cnpj('{0}') AND CAD_ASSEPONTO4 = 1", cnpj)) == "";

            if (args.IsValid && cpf != "")
                args.IsValid = bd.getFieldValueString(string.Format("SELECT CAD_RAZAOSOCIAL FROM AssepontoClientes WHERE dbo.fn_asseponto_trim_cnpj(CAD_CPF) = dbo.fn_asseponto_trim_cnpj('{0}') AND CAD_ASSEPONTO4 = 1", cpf)) == "";
        }

        protected void FvClienteFinal_DataBound(object sender, EventArgs e)
        {
            //Verificando se não tiver em modo leitura, validar os campos obrigatorios.
            if (((FormView)sender).CurrentMode != FormViewMode.ReadOnly)
            {
                Validadores validadores = new Validadores((FormView)sender);
            }
        }
    }
}