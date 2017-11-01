using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;

namespace AssecontNovo.HoleriteFunc
{
    public partial class Login1 : System.Web.UI.Page
    {
        private TextBox txtCPF;
        private TextBox txtSenha;
        private TextBox txtRegistro;
        private Label lbSenha;
        private LinkButton lkbEsqueceuSenha;
        private int primeiroAcesso = 0;
        private AssecontNovo.Classes.BDAppAssecont bd;

        protected void Page_Load(object sender, EventArgs e)
        {
            txtCPF = (TextBox)Login1.FindControl("UserName");
            txtSenha = (TextBox)Login1.FindControl("Password");
            txtRegistro = (TextBox)Login1.FindControl("txtRegistro");
            lbSenha = (Label)Login1.FindControl("lbSenha");
            lkbEsqueceuSenha = (LinkButton)Login1.FindControl("lkbEsqueceuSenha");

            if (string.IsNullOrEmpty(txtCPF.Text) && !string.IsNullOrEmpty(Request.QueryString["cpf"]))
                txtCPF.Text = Request.QueryString["cpf"];


            bd = new AssecontNovo.Classes.BDAppAssecont();
            primeiroAcesso = bd.getFieldValueInteger(string.Format("SELECT TOP 1 (CASE WHEN FUNC_DATA_CADASTRO IS NULL THEN FUNC_IND ELSE 0 END) FROM Funcionarios WHERE FUNC_CPF='{0}' ORDER BY FUNC_IND DESC ", txtCPF.Text.Trim(), txtRegistro.Text.Trim()));

            setCampos(primeiroAcesso == 0);
            setMasterPage();
        }

        private void setCampos(bool visible)
        {
            txtSenha.Visible = visible;
            lbSenha.Visible = visible;
            lkbEsqueceuSenha.Visible = visible;
            ((RequiredFieldValidator)Login1.FindControl("PasswordRequired")).Visible = visible;
        }

        private void setMasterPage()
        {
            MasterPage MasterP = (MasterPage)Master;
            ((LinkButton)MasterP.FindControl("lbSair")).Visible = false;
        }

        protected void Login1_LoggingIn(object sender, LoginCancelEventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    if (primeiroAcesso > 0)
                    {
                        if (txtRegistro.Text.Trim().Equals(bd.getRegistroFuncionario(primeiroAcesso)))
                            Response.Redirect(string.Format("PrimeiroLogin.aspx?ind={0}", primeiroAcesso));
                        //((Literal)Login1.Controls[0].FindControl("FailureText")).Text = string.Empty;
                        else
                            ((Literal)Login1.Controls[0].FindControl("FailureText")).Text = "Dados Invalidos...";
                        e.Cancel = true;
                    }
                    else
                    {
                        UserApp user = new UserApp();
                        e.Cancel = !user.Login(Response, txtCPF.Text.Trim(), txtRegistro.Text.Trim(), txtSenha.Text.Trim(), (Literal)Login1.Controls[0].FindControl("FailureText"));
                    }
                }
                catch (Exception ex)
                {
                    string exs = ex.Message;
                }
            }
        }

        protected void lkbEsqueceuSenha_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.Format("~/holeriteFunc/HoleriteNovaSenha.aspx?cpf={0}", txtCPF.Text));
        }
    }
}