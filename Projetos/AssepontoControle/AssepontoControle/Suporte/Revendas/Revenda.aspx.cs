using System;
using Asseponto.Classes;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Data.Common;
using Telerik.Web.UI;
using System.Data;
using Wr.Classes;
using System.Net.Mail;

namespace Asseponto.Suporte.Revendas
{
    public partial class Revenda : System.Web.UI.Page
    {
        private int IdRevenda;
        private BDApp bd;
        private DataTable tableAssefin;
        private BDAppAssefin bdAssefin;
        private UserApp user;

        protected void Page_Load(object sender, EventArgs e)
        {
            IdRevenda = Convert.ToInt32(Request.QueryString["ind"]);
            bdAssefin = new BDAppAssefin();
            user = new UserApp();
            bd = new BDApp();

            if (IdRevenda ==  0)
            {
                
                FormView1.ChangeMode(FormViewMode.Insert);
                PanelLoginsRevenda.Visible = false;
                divSiteMenuEsquerdo.Visible = false;
            }
            else{
                FormView1.ChangeMode(FormViewMode.Edit);
                CadastroAssefin.RevendaId = IdRevenda;
        
                RadMenu2.Items.FindItemByText("Clientes da Revenda").NavigateUrl = "~/suporte/Revendas/Clientes.aspx?revenda=" + IdRevenda;

                if (!(new Permissoes(bd)).getAcesso("Manuntecao"))
                    RadMenu2.Items.FindItemByText("Manutenção").Visible = false;
                else
                    RadMenu2.Items.FindItemByText("Manutenção").NavigateUrl = "~/suporte/Revendas/Manuntecao.aspx?revenda=" + IdRevenda;
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //preencherTextBoxsAssepontoControle();
                int indiceAssefin = bdAssefin.getCadastroIndice(bd.getRevendaCnpjCpf(IdRevenda));
                if (indiceAssefin > 0)
                {
                    ((LinkButton)FormView1.FindControl("btAssefin")).Visible = false;
                    tableAssefin = bdAssefin.getCadastro(indiceAssefin);

                    foreach (DataRow dr in tableAssefin.Rows)
                    {
                        preencherTextBoxsAssefinAbaFinanceiro(dr);
                    }
                }
            }
        }

        #region LOGIN
        protected void linkbuttonNovoLogin_Click(object sender, EventArgs e)
        {
            string Login = texteditNovoLogin.Text;

            bd.saveLogin(IdRevenda, Login);

            Response.Redirect(String.Format("Revenda.aspx?ind={0}", IdRevenda));
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            int Ind = Convert.ToInt32(((ImageButton)sender).CommandArgument);

            bd.executeCommand(String.Format("DELETE FROM AssepontoUsuariosRevendas WHERE USUREV_IND = {0}", Ind));

            Response.Redirect(String.Format("Revenda.aspx?ind={0}", IdRevenda));
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            int Ind = Convert.ToInt32(((ImageButton)sender).CommandArgument);
            Enviar_Email_Senha(Ind);
        }

        protected void imageLogar_Click(object sender, ImageClickEventArgs e)
        {
            int Ind = Convert.ToInt32(((ImageButton)sender).CommandArgument);

            string UserName = bd.getFieldValueString(String.Format("SELECT USUREV_LOGIN FROM AssepontoUsuariosRevendas WHERE USUREV_IND = {0}", Ind));
            string Password = bd.getFieldValueString(String.Format("SELECT USUREV_PWD FROM AssepontoUsuariosRevendas WHERE USUREV_IND = {0}", Ind));

            (new UserApp()).Login(Response, Types.UsuarioTipo.Revenda, UserName, Password, null, UserApp.WRITECOOKIE_FALSE);
        }
        #endregion

        #region REP
        protected void SqlREP_Deleted(object sender, SqlDataSourceStatusEventArgs e)
        {
            //depois de realizar um delete, retornar a pagina na edição do cliente.
            Response.Redirect(String.Format("Revenda.aspx?ind={0}", IdRevenda));
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            //Deletar o rep, caso o cliente não comercialize mais ele.
            int id = Convert.ToInt32(((LinkButton)sender).CommandArgument); //Sender = objeto que gerou o evento.
            bd.executeCommand(String.Format("DELETE FROM AssepontoRevendasReps WHERE REVREP_IND = {0}", id));

            //depois de realizar um delete, retornar a pagina na edição do cliente.
            Response.Redirect(String.Format("Revenda.aspx?ind={0}", IdRevenda));
        }

        protected void lbAdd_Click1(object sender, EventArgs e)
        {
            RadComboBox RadComboBox1 = (RadComboBox)FormView1.FindControl("RadComboBox1");
            string rep = RadComboBox1.SelectedValue;

            //Inserido no banco de dados o relogio de acordo com o id do rep e da cliente.
            bd.executeCommand(String.Format("INSERT INTO AssepontoRevendasReps (REVREP_REVENDA, REVREP_REP) VALUES ({0}, {1})", IdRevenda, rep));

            Response.Redirect(String.Format("Revenda.aspx?ind={0}", IdRevenda));
        }

        protected void CustomValidator1_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            if (IdRevenda != 0)
            {
                int id = bd.getFieldValueInteger(String.Format("SELECT COUNT (*) FROM AssepontoRevendasReps Where REVREP_REVENDA = {0}", IdRevenda));
                if (id == 0)
                {
                    args.IsValid = false;
                }
                else
                    linkButtonExpandirNovoLogin.Attributes.Add("onClick", "javascript:controlshow(" + panelNovoLogin.ClientID + "); controlhidden(" + linkButtonExpandirNovoLogin.ClientID + "); return false;");
            }
            else
                args.IsValid = true;
        }
        #endregion

        protected void sqlRevendas_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                bd.setRevendaCadastroAtualizado(UserApp.UserId, IdRevenda);
                setupdatecadastroassefin();
                TextBox REV_RAZAOSOCIAL = (TextBox)Wr.Classes.PageUtils.FindControl(Page, "REV_RAZAOSOCIAL");
                Response.Redirect(String.Format("~/suporte/revendas/revendas.aspx?filtrorazaosocial={0}", REV_RAZAOSOCIAL.Text));
            }
        }


        protected void Salvar_Click(object sender, EventArgs e)
        {
            if (FormView1.CurrentMode == FormViewMode.Insert)
                FormView1.InsertItem(((LinkButton)sender).CausesValidation);
            else
                if (FormView1.CurrentMode == FormViewMode.Edit)
                    FormView1.UpdateItem(((LinkButton)sender).CausesValidation);
        }

        protected void Enviar_Email_Senha(int UsuarioRevenda)
        {
            if (ConfigurationManager.AppSettings["EMAILIGNORAR"] == "1") return;

            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = bd.getRevendaEmail(IdRevenda);
            string EmailCC = bd.getRevendaEmail2(IdRevenda);

            EmailSenhaRevenda email = new EmailSenhaRevenda(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailRevendaGold.htm");
            SmtpStatusCode status = email.Send(EmailTo, EmailCC, UsuarioRevenda);
            if (status != SmtpStatusCode.Ok)
                Response.Redirect(String.Format("Revenda.aspx?ind={0}&erro={1}", IdRevenda, status));
            else
            { 
                bd.executeCommand(String.Format("UPDATE AssepontoUsuariosRevendas SET USUREV_DATA_ENVIO_SENHA = GETDATE(), USUREV_EMAIL_ENVIO_SENHA='{1}', USUREV_EMAIL_ENVIO_SENHA2='{2}' WHERE USUREV_IND = {0}", UsuarioRevenda, EmailTo, EmailCC));
                Response.Redirect(String.Format("Revenda.aspx?ind={0}", IdRevenda));
            }
        }

        protected void sqlRevendas_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            int ind = 0;
            e.Command.CommandText = "SELECT @@IDENTITY";
            DbDataReader reader = e.Command.ExecuteReader();
            reader.Read();
            if ((reader.HasRows) && (!String.IsNullOrEmpty(reader[0].ToString())))
            {
                ind = Convert.ToInt32(reader[0].ToString());
            }
            reader.Close();
            Response.Redirect(String.Format("Revenda.aspx?ind={0}", ind));
        }

        protected void RadComboBox1_DataBinding(object sender, EventArgs e)
        {
            RadComboBox combo = (RadComboBox)sender;
            combo.DataSourceID = "sqlEstados";
            combo.DataTextField = "EST_NOME";
            combo.DataValueField = "EST_SIGLA";
        }

        protected void FormView1_PreRender(object sender, EventArgs e)
        {
            if (IdRevenda == 0)
            {
                Panel PanelREP = (Panel)FormView1.FindControl("PanelREP");
                PanelREP.Visible = false;
            }
        }

        protected void Customv_LGIN_CPF_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (FormView1.CurrentMode == FormViewMode.Insert)
            {
                if (((TextBox)FormView1.FindControl("txtCnpj")).Text == "" && ((TextBox)FormView1.FindControl("txtCpf")).Text == "")
                    args.IsValid = false;
            }
        }

        #region SMS
        protected void imageSms_Click(object sender, ImageClickEventArgs e)
        {
            int Ind = Convert.ToInt32(((ImageButton)sender).CommandArgument);
            Enviar_Sms_Senha(Ind);
        }

        protected void Enviar_Sms_Senha(int UsuarioRevenda)
        {
            string DDD = ((RadMaskedTextBox)FormView1.FindControl("txtDDD")).Text.Trim();
            string Telefone = ((RadMaskedTextBox)FormView1.FindControl("txtCelular")).Text.Trim();

            if (DDD != "" & Telefone != "")
            {
                Asseponto.Classes.Sms Sms = new Asseponto.Classes.Sms(UsuarioRevenda, DDD, Telefone);
                Sms.Send();
                //bd.executeCommand(String.Format("UPDATE AssepontoUsuariosRevendas SET USUREV_DATA_ENVIO_SENHA = GETDATE(), USUREV_EMAIL_ENVIO_SENHA='{1}' WHERE USUREV_IND = {0}", UsuarioRevenda, EmailTo));

                Response.Redirect(String.Format("Revenda.aspx?ind={0}", IdRevenda));
            }
        }
        #endregion

        #region Aba Financeiro - Assefin
        void preencherTextBoxsAssefinAbaFinanceiro(DataRow dr)
        {
            ((TextBox)FormView1.FindControl("txtFinanceiroContato")).Text = dr["CAD_FINANCEIRO_CONTATO"].ToString().Trim();
            ((TextBox)FormView1.FindControl("txtFinanceiroEmail")).Text = dr["CAD_FINANCEIRO_EMAIL"].ToString().Trim();
            ((TextBox)FormView1.FindControl("txtFinanceiroEmail2")).Text = dr["CAD_FINANCEIRO_EMAIL2"].ToString().Trim();
            ((TextBox)FormView1.FindControl("txtFinanceiroEmail3")).Text = dr["CAD_FINANCEIRO_EMAIL3"].ToString().Trim();

            ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroTelefone")).Text = dr["CAD_FINANCEIRO_TELEFONE1"].ToString().Replace("-", "").Replace(".", "").Trim();
            ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroTelefone_DDD")).Text = dr["CAD_FINANCEIRO_TELEFONE1_DDD"].ToString().Trim();

            ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroTelefone2")).Text = dr["CAD_FINANCEIRO_TELEFONE2"].ToString().Replace("-", "").Replace(".", "").Trim();
            ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroTelefone2_DDD")).Text = dr["CAD_FINANCEIRO_TELEFONE2_DDD"].ToString().Trim();

            ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroCelular")).Text = dr["CAD_FINANCEIRO_CELULAR1"].ToString().Replace("-", "").Replace(".", "").Trim();
            ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroCelular_DDD")).Text = dr["CAD_FINANCEIRO_CELULAR1_DDD"].ToString().Trim();
            ((CheckBox)FormView1.FindControl("rbFinanceiroCelularAceita")).Checked = Convert.ToBoolean(dr["CAD_CELULAR_ACEITA"].ToString());
        }
        #endregion

        private void setupdatecadastroassefin()
        {
            bdAssefin.setCadastroAssefin(
                ((TextBox)FormView1.FindControl("REV_RAZAOSOCIAL")).Text,
                ((TextBox)FormView1.FindControl("REV_FANTASIA")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtIE")).Text,

                ((TextBox)FormView1.FindControl("REV_EMAIL")).Text,
                ((TextBox)FormView1.FindControl("txtEmail2")).Text,
                ((TextBox)FormView1.FindControl("txtEmail3")).Text,
                ((TextBox)FormView1.FindControl("REV_LOGRADOURO")).Text,
                ((TextBox)FormView1.FindControl("REV_NUMERO")).Text,
                ((TextBox)FormView1.FindControl("REV_COMPLEMENTO")).Text,
                ((TextBox)FormView1.FindControl("txtBairro")).Text,
                ((TextBox)FormView1.FindControl("REV_CIDADE")).Text,
                ((RadComboBox)FormView1.FindControl("REV_UF")).SelectedValue,
                ((RadMaskedTextBox)FormView1.FindControl("REV_CEP")).Text,

                ((TextBox)FormView1.FindControl("REV_CONTATO")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtTelefone")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtTelefone_ddd")).Text,

                ((RadMaskedTextBox)FormView1.FindControl("txtTelefone2")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtTelefone2_ddd")).Text,

                ((TextBox)FormView1.FindControl("txtFinanceiroContato")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroTelefone")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroTelefone_DDD")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroTelefone2")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroTelefone2_DDD")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroCelular")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroCelular_DDD")).Text,

                ((CheckBox)FormView1.FindControl("rbFinanceiroCelularAceita")).Checked,

                ((TextBox)FormView1.FindControl("txtFinanceiroEmail")).Text,
                ((TextBox)FormView1.FindControl("txtFinanceiroEmail2")).Text,
                ((TextBox)FormView1.FindControl("txtFinanceiroEmail3")).Text,
                 user.UserName(),
                (new BDApp()).getRevendaCnpjCpf(IdRevenda),
                DateTime.Now);
        }

        protected void btAssefin_Click(object sender, EventArgs e)
        {
            setInsertCadastroAssefin();
            Response.Redirect(String.Format("Revenda.aspx?ind={0}", IdRevenda));
        }

        private void setInsertCadastroAssefin()
        {
            string aux = bd.getRevendaCnpjCpf(IdRevenda).Replace("/", "").Replace(".", "").Replace("-", "");
            string cpf = "NULL";
            string cnpj = "NULL";

            if (aux.Length > 11)
                cnpj = aux;
            else
                cpf = aux;

            bdAssefin.setCriarCadastroAssefin(((TextBox)FormView1.FindControl("REV_RAZAOSOCIAL")).Text,
                ((TextBox)FormView1.FindControl("REV_FANTASIA")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtIE")).Text,

                ((TextBox)FormView1.FindControl("REV_EMAIL")).Text,
                ((TextBox)FormView1.FindControl("txtEmail2")).Text,
                ((TextBox)FormView1.FindControl("txtEmail3")).Text,
                ((TextBox)FormView1.FindControl("REV_LOGRADOURO")).Text,
                ((TextBox)FormView1.FindControl("REV_NUMERO")).Text,
                ((TextBox)FormView1.FindControl("REV_COMPLEMENTO")).Text,
                ((TextBox)FormView1.FindControl("txtBairro")).Text,
                ((TextBox)FormView1.FindControl("REV_CIDADE")).Text,
                ((RadComboBox)FormView1.FindControl("REV_UF")).SelectedValue,
                ((RadMaskedTextBox)FormView1.FindControl("REV_CEP")).Text,

                ((TextBox)FormView1.FindControl("REV_CONTATO")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtTelefone")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtTelefone_ddd")).Text,

                ((RadMaskedTextBox)FormView1.FindControl("txtTelefone2")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtTelefone2_ddd")).Text,

                ((TextBox)FormView1.FindControl("txtFinanceiroContato")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroTelefone")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroTelefone_DDD")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroTelefone2")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroTelefone2_DDD")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroCelular")).Text,
                ((RadMaskedTextBox)FormView1.FindControl("txtFinanceiroCelular_DDD")).Text,

                ((CheckBox)FormView1.FindControl("rbFinanceiroCelularAceita")).Checked,

                ((TextBox)FormView1.FindControl("txtFinanceiroEmail")).Text,
                ((TextBox)FormView1.FindControl("txtFinanceiroEmail2")).Text,
                ((TextBox)FormView1.FindControl("txtFinanceiroEmail3")).Text,
                 user.UserName(), cnpj, cpf);

            bd.setRevendaCadastroAtualizado(UserApp.UserId, IdRevenda);
        }

        protected void lbErro_Load(object sender, EventArgs e)
        {
            if(!String.IsNullOrEmpty(Request.QueryString["erro"]) && Request.QueryString["erro"].ToString() != "250")
            {
                Label lbErro = sender as Label;
                lbErro.Text = "Erro '" + Request.QueryString["erro"] + "' no envio do Email";
                lbErro.Visible = true;
            }
        }
    }
}