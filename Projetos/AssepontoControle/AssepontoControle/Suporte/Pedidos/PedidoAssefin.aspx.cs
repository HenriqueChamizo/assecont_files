﻿using System;
using System.Configuration;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;
using Wr.Classes;

namespace Asseponto.Suporte.Pedidos
{
    public partial class PedidoAssefin : System.Web.UI.Page
    {
        int PedidoIndice;

        protected void Page_Load(object sender, EventArgs e)
        {
            int PedidoIndice = Convert.ToInt32(Request.QueryString["ind"]);

            if (PedidoIndice == 0)
                FormView1.DefaultMode = FormViewMode.Insert;
            else
                FormView1.DefaultMode = FormViewMode.Edit;
        }
        protected void Enviar_Email_Implantacao(int PedidoIndice)
        {
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1") return;
            BDApp bd = new BDApp();

            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = "suporte@assecont.com.br";

            EmailImplantacao email = new EmailImplantacao(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailImplantacao.htm");
            email.Send(EmailTo, PedidoIndice);
        }

        protected void btFinalizarParaImplantacao_Click(object sender, EventArgs e)
        {
            int PedidoIndice = Convert.ToInt32(Request.QueryString["ind"]);

            BDApp bd = new BDApp();
            //UserApp user = new UserApp();

            bd.executeCommand(String.Format("EXEC asseponto_pedido_finalizar @P_PEDIDO = {0}, @P_TECNICO = {1}", PedidoIndice, UserApp.UserId));
            Enviar_Email_Implantacao(PedidoIndice);

            Response.RedirectPermanent("~/suporte/Pedidos/PedidoImplantacaoEnviado.aspx");
        }

        protected void btExcluir_Click(object sender, EventArgs e)
        {
            FormView1.DeleteItem();
            Response.RedirectPermanent("~/suporte/PedidosAssefin");
        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            if (FormView1.CurrentMode == FormViewMode.Insert)
            {
                HiddenField hiddenStatus = (HiddenField)FormView1.FindControl("hiddenStatus");
                hiddenStatus.Value = "2";

                TextBox PED_DATA = (TextBox)FormView1.FindControl("PED_DATA");
                PED_DATA.Text = DateTime.Now.ToString("dd/MM/yyyy");

                btFinalizarParaImplantacao.Visible = false;
            }

            if (FormView1.CurrentMode == FormViewMode.Edit)
            {
                PedidoIndice = Convert.ToInt32(Request.QueryString["ind"]);
                btSalvar.Visible = false;
                BDApp bd = new BDApp();

                Label labelRevendaRazaoSocial = (Label)FormView1.FindControl("labelRevendaRazaoSocial");
                labelRevendaRazaoSocial.Text = bd.getRevendaRazaoSocialFromPedido(PedidoIndice);

                if (String.IsNullOrEmpty(labelRevendaRazaoSocial.Text))
                {
                    labelRevendaRazaoSocial.Text = "-";
                }

                ((RadComboBox)Wr.Classes.PageUtils.FindControl(FormView1, "comboboxRevenda")).Visible = false;
                HiddenField hiddenfield = ((HiddenField)Wr.Classes.PageUtils.FindControl(FormView1, "hiddenStatus"));

                if (Convert.ToInt32(hiddenfield.Value) == (int)Types.PedidoStatus.Fechado)
                {
                    //panelObsPedido.Visible = false;
                    sitecorpoboxbottom.Visible = false;
                }
            }
        }

        protected void sqlPedidosRevendas_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            try
            {
                BDApp bd = new BDApp();
                PedidoIndice = bd.getIdentity(e.Command);
                UserApp user = new UserApp();

                bd.executeCommand(String.Format("EXEC asseponto_pedido_finalizar @P_PEDIDO = {0}, @P_TECNICO = {1}", PedidoIndice, UserApp.UserId));
                Enviar_Email_Implantacao(PedidoIndice);

                Response.RedirectPermanent("~/suporte/Pedidos/PedidoImplantacaoEnviado.aspx");
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                lbErro.Visible = true;
                lbErro.Style.Add("color", "red");
                lbErro.Text = "Erro: " + ex.Message;
            }
        }

        #region RadComboBox DataBinding
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
            //Binding do Combox Lista de Revendas
            RadComboBox combo = (RadComboBox)sender;
            combo.DataSourceID = "sqlRevendas";
            combo.DataTextField = "REV_RAZAOSOCIAL";
            combo.DataValueField = "REV_IND";
        }

        protected void RadComboBox3_DataBinding(object sender, EventArgs e)
        {
            //Binding do Combox Versão do Assefin
            RadComboBox combo = (RadComboBox)sender;
            combo.DataSourceID = "SQLAssefinVersoes";
            combo.DataTextField = "VER_ASSEF_NOME";
            combo.DataValueField = "VER_ASSEF_IND";
        }
        #endregion

        #region Custom Validator
        protected void CustomValidator1_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            //Custom validator é obigatorio que preencha o campo para validar, mas se tirar o control to validate,
            //pode configurar o que vai ? ou como vai validar?, depois de clicar no button.
            RadMaskedTextBox txtCNPJ = (RadMaskedTextBox)FormView1.FindControl("PED_CLI_CNPJ");
            RadMaskedTextBox txtCPF = (RadMaskedTextBox)FormView1.FindControl("PED_CLI_CPF");

            if (txtCNPJ.Text == "" && txtCPF.Text == "")
            {
                args.IsValid = false;
            }
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            /*Validar se já existe o CNPJ ou CPF na tabela AssepontoClientes*/
            BDApp bd = new BDApp();
            RadMaskedTextBox txtCNPJ = (RadMaskedTextBox)FormView1.FindControl("PED_CLI_CNPJ");
            RadMaskedTextBox txtCPF = (RadMaskedTextBox)FormView1.FindControl("PED_CLI_CPF");
            string cnpj = txtCNPJ.Text;
            string cpf = txtCPF.Text;

            args.IsValid = bd.getFieldValueString(string.Format("SELECT CAD_RAZAOSOCIAL FROM AssepontoClientes WHERE (dbo.fn_asseponto_trim_cnpj(CAD_CNPJ) = dbo.fn_asseponto_trim_cnpj('{0}') OR dbo.fn_asseponto_trim_cnpj(CAD_CPF) = dbo.fn_asseponto_trim_cnpj('{1}')) AND CAD_ASSEFIN = 1", cnpj, cpf)) == "";
        }
        #endregion

        protected void btSalvar_Click(object sender, EventArgs e)
        {
            try
            {
                //sqlPedidosRevendas.Inserting = true;
                sqlPedidosRevendas.Insert();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                lbErro2.Visible = true;
                lbErro2.Style.Add("color", "red");
                lbErro2.Text = "Erro: " + ex.Message;
            }
        }
    }
}