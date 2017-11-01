using System;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using System.Data.Common;
using Wr.Classes;
using Telerik.Web.UI;
using System.Configuration;

namespace Asseponto.Revenda.Cadastro
{
    public partial class CadastroRevendas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Convert.ToInt32(Request.QueryString["ind"]) > 0)
            {
                FormView1.ChangeMode(FormViewMode.Edit);
                hiddenStatus.Visible = false;
            }
            else
            {
                FormView1.ChangeMode(FormViewMode.Insert);
                Panel2.Visible = false;
            }
        }

        #region Adicionar ou Remover REP
        /*Adicionar REP*/
        protected void lbAdd_Click1(object sender, EventArgs e)
        {
            BDApp bd = new BDApp();
            string rep = RadComboBox1.SelectedValue;

            int ind = Convert.ToInt32(Request.QueryString["ind"]); //Pegando o id do cliente.
            //Inserido no banco de dados o relogio de acordo com o id do rep e da cliente.
            bd.executeCommand(String.Format("INSERT INTO AssepontoRevendasRepsProvisorios (CADP_REVREP_REVENDA, CADP_REVREP_REP) VALUES ({0}, {1})", ind, rep));

            Response.Redirect(String.Format("~/RevendaCadastro/CadastroRevendas.aspx?ind={0}", ind));
        }

        /*Remover REP*/
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            BDApp bd = new BDApp();
            int id = Convert.ToInt32(((LinkButton)sender).CommandArgument); //Sender = objeto que gerou o evento.
            bd.executeCommand(String.Format("DELETE FROM AssepontoRevendasRepsProvisorios WHERE CADP_REVREP_IND = {0}", id));

            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            Response.Redirect(String.Format("~/RevendaCadastro/CadastroRevendas.aspx?ind={0}", ind));
        }

        protected void SqlREP_Deleted(object sender, SqlDataSourceStatusEventArgs e)
        {
            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            Response.Redirect(String.Format("~/RevendaCadastro/CadastroRevendas.aspx?ind={0}", ind));
        }

        protected void CustomValidator1_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            BDApp bd = new BDApp();
            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            if (ind != 0)
            {
                int id = bd.getFieldValueInteger(String.Format("SELECT COUNT (*) FROM AssepontoRevendasRepsProvisorios Where CADP_REVREP_REVENDA = {0}", ind));
                if (id == 0)
                {
                    args.IsValid = false;
                }
            }
        }
        #endregion

        #region FormView
        protected void FormView1_DataBound1(object sender, EventArgs e)
        {
            if (((FormView)sender).CurrentMode != FormViewMode.ReadOnly)
            {
                Validadores validadores = new Validadores((FormView)sender);
            }
        }

        protected void RadComboBox1_DataBinding(object sender, EventArgs e)
        {
            RadComboBox combo = (RadComboBox)sender;
            combo.DataSourceID = "sqlEstados";
            combo.DataTextField = "EST_NOME";
            combo.DataValueField = "EST_SIGLA";
        }

        protected void RadComboBoxREP_DataBinding(object sender, EventArgs e)
        {
            RadComboBox combo = (RadComboBox)sender;
            combo.DataSourceID = "SqlRepFabricante";
            combo.DataTextField = "FABR_NOME";
            combo.DataValueField = "FABR_COD";
        }
        #endregion

        #region SQL Inserted
        protected void sqlRevendas_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            int ind = 0;
            //depois de inserir no banco o cliente, executa um evento para resgatar o ultimo valor inserido na tabela.
            e.Command.CommandText = "SELECT @@IDENTITY"; //Selecionar o ultimo valor.

            DbDataReader reader = e.Command.ExecuteReader();
            reader.Read();

            if ((reader.HasRows) && (!String.IsNullOrEmpty(reader[0].ToString()))) //Se retornar um valor = true && se for diferente de null.
            {
                ind = Convert.ToInt32(reader[0].ToString()); //atribui o ultimo id para int id;
            }

            reader.Close();
            Response.Redirect(String.Format("~/RevendaCadastro/CadastroRevendas.aspx?ind={0}", ind));
        }
        #endregion

        #region CustomValidator LOGIN/CNPJ
        protected void CustomValidatorLOGIN_ServerValidate(object source, ServerValidateEventArgs args)
        {
            BDApp bd = new BDApp();

            TextBox CADP_REV_LOGIN = (TextBox)FormView1.FindControl("CADP_REV_LOGIN");
            string login = CADP_REV_LOGIN.Text;

            args.IsValid = bd.getFieldValueString(string.Format("SELECT USUREV_LOGIN FROM AssepontoUsuariosRevendas WHERE RTRIM(USUREV_LOGIN) = RTRIM('{0}')", login)) == "";
        }

        protected void CustomValidatorCNPJ_ServerValidate(object source, ServerValidateEventArgs args)
        {
            /*Validar se já existe o CNPJ ou CPF na tabela AssepontoRevendas*/
            BDApp bd = new BDApp();
            RadMaskedTextBox txtCNPJ = (RadMaskedTextBox)FormView1.FindControl("CADP_REV_CNPJ");
            string cnpj = txtCNPJ.Text;

            args.IsValid = bd.getFieldValueString(string.Format("SELECT REV_CNPJ FROM AssepontoRevendas WHERE dbo.fn_asseponto_trim_cnpj(REV_CNPJ) = dbo.fn_asseponto_trim_cnpj('{0}')", cnpj)) == "";
        }

        protected void CustomValidatorCPF_ServerValidate(object source, ServerValidateEventArgs args)
        {
            /*Validar se já existe o CNPJ ou CPF na tabela AssepontoRevendas*/
            BDApp bd = new BDApp();
            RadMaskedTextBox txtCPF = (RadMaskedTextBox)FormView1.FindControl("CADP_REV_CPF");
            string CPF = txtCPF.Text;

            args.IsValid = bd.getFieldValueString(string.Format("SELECT REV_CPF FROM AssepontoRevendas WHERE dbo.fn_asseponto_trim_cnpj(REV_CPF) = dbo.fn_asseponto_trim_cnpj('{0}')", CPF)) == "";
        }
        #endregion

        protected void btConcluir_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                BDApp bd = new BDApp();

                int ind = Convert.ToInt32(Request.QueryString["ind"]);

                TextBox Razao = (TextBox)FormView1.FindControl("CADP_REV_RAZAOSOCIAL");
                TextBox Contato = (TextBox)FormView1.FindControl("CADP_REV_CONTATO");
                TextBox Email = (TextBox)FormView1.FindControl("CADP_REV_EMAIL");
                TextBox Email2 = (TextBox)FormView1.FindControl("txtRevEmail2");
                //RadioButtonList Status = (RadioButtonList)FormView1.FindControl("CADP_REV_STATUS");

                //Revenda = Convert.ToInt32(Status.SelectedValue) == 0 ? "Gold" : "Premium";

                EnviarEmail(Razao.Text, Contato.Text, Email.Text, Email2.Text);
            }
        }

        protected void EnviarEmail(string Razao, string Contato, string Email, string Email2)
        {
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1") return;
            BDApp bd = new BDApp();

            //string EmailFrom = ConfigurationManager.AppSettings["EMAILRECIPIENT"];
            //string EmailTo = ConfigurationManager.AppSettings["EMAILRECIPIENT"];
            //string EmailCC = ConfigurationManager.AppSettings["EMAILRECIPIENTCC"]; // marcos
            //string EmailCC2 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC2"];

            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];//notificação
            string EmailTo = ConfigurationManager.AppSettings["EMAILRECIPIENT"];//valmir
            string EmailCC = ConfigurationManager.AppSettings["EMAILRECIPIENTCC5"];//comercial
            string EmailCC2 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC2"];//rayssa

            EmailRevendas email = new EmailRevendas(EmailFrom, null, Server.MapPath("") + "\\..\\Arquivos\\CadastroRevendas.htm");
            email.Send(EmailTo, EmailCC, EmailCC2, Email2, Razao, DateTime.Now, Email, Contato, "Gold");
            //email.Send(EmailTo, "henrique@assecont.com.br", EmailCC2, Email2, Razao, DateTime.Now, Email, Contato, "Gold");

            Response.Redirect("~/RevendaCadastro/EnviadoCadastroSucesso.aspx");
        }

        protected void Customv_LGIN_CPF_ServerValidate(object source, ServerValidateEventArgs args)
        {
            RadMaskedTextBox txtCNPJ = (RadMaskedTextBox)FormView1.FindControl("CADP_REV_CNPJ");
            RadMaskedTextBox txtCPF = (RadMaskedTextBox)FormView1.FindControl("CADP_REV_CPF");

            if (
                (!string.IsNullOrEmpty(txtCNPJ.Text) && string.IsNullOrEmpty(txtCPF.Text)) ||
                (string.IsNullOrEmpty(txtCNPJ.Text) && !string.IsNullOrEmpty(txtCPF.Text))                
               )
                args.IsValid = true;
            else
                args.IsValid = false;
        }
    }
}