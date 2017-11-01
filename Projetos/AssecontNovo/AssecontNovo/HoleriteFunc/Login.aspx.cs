using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssecontNovo.HoleriteFunc
{
    public partial class Login : System.Web.UI.Page
    {
        //private TextBox txtCPF;
        //private TextBox txtSenha;
        //private TextBox txtRegistro;
        //private Label lbSenha;
        //private LinkButton lkbEsqueceuSenha;
        private int primeiroAcesso = 0;
        private Classes.BDAppAssecont bd;
        
        protected void Page_Load(object sender, EventArgs e)
        {
        //    txtCPF = 
        //    txtCPF = (TextBox)Login1.FindControl("UserName");
        //    txtSenha = (TextBox)Login1.FindControl("Password");
        //    txtRegistro = (TextBox)Login1.FindControl("txtRegistro");
        //    lbSenha = (Label)Login1.FindControl("lbSenha");
        //    lkbEsqueceuSenha = (LinkButton)Login1.FindControl("lkbEsqueceuSenha");

        //    if (string.IsNullOrEmpty(txtCPF.Text) && !string.IsNullOrEmpty(Request.QueryString["cpf"]))
        //        txtCPF.Text = Request.QueryString["cpf"];


        //    bd = new AssecontNovo.Classes.BDAppAssecont();
        //    primeiroAcesso = bd.getFieldValueInteger(string.Format("SELECT TOP 1 (CASE WHEN FUNC_DATA_CADASTRO IS NULL THEN FUNC_IND ELSE 0 END) FROM Funcionarios WHERE FUNC_CPF='{0}' ORDER BY FUNC_IND DESC ", txtCPF.Text.Trim(), txtRegistro.Text.Trim()));

        //    setCampos(primeiroAcesso == 0);
        //    setMasterPage();
        }

        protected void btnEntrar_Click(object sender, EventArgs e)
        {
            string redirect;
            if (string.IsNullOrEmpty(txtCpf.Text) ||
                string.IsNullOrEmpty(txtRegistro.Text) ||
                string.IsNullOrEmpty(txtPassword.Text))
            {
                string url = Request.Url.ToString().Replace("?erro=true", "");
                redirect = url + "?erro=true";
                //Response.Redirect(url + "?erro=true");
            }
            else
            {
                try
                {
                    bd = new Classes.BDAppAssecont();
                    primeiroAcesso = bd.getFieldValueInteger(string.Format("SELECT TOP 1 (CASE WHEN FUNC_DATA_CADASTRO IS NULL THEN FUNC_IND ELSE 0 END) FROM Funcionarios WHERE FUNC_CPF='{0}' ORDER BY FUNC_IND DESC ", txtCpf.Text.Trim(), txtRegistro.Text.Trim()));

                    if (primeiroAcesso > 0)
                    {
                        if (txtRegistro.Text.Trim().Equals(bd.getRegistroFuncionario(primeiroAcesso)))
                        {
                            redirect = string.Format("PrimeiroLogin.aspx?ind={0}", primeiroAcesso);
                            //Response.RedirectPermanent(string.Format("PrimeiroLogin.aspx?ind={0}", primeiroAcesso));
                        }
                        else
                        {
                            string url = Request.Url.ToString().Replace("?erro=true", "");
                            redirect = url + "?erro=true";
                            //Response.Redirect(url + "?erro=true");
                        }
                    }
                    else
                    {
                        Literal literal = new Literal();
                        Classes.UserApp user = new Classes.UserApp();
                        if (user.Login(Response, txtCpf.Text.Trim(), txtRegistro.Text.Trim(), txtPassword.Text.Trim(), literal))
                        {
                            redirect = "~/holeriteFunc/HoleriteFuncionario.aspx";
                            //Response.Redirect("~/holeriteFunc/HoleriteFuncionario.aspx");
                        }
                        else
                        {
                            string url = Request.Url.ToString().Replace("?erro=true", "");
                            redirect = url + "?erro=true";
                            //Response.Redirect(url + "?erro=true");
                        }
                    }
                }
                catch (Exception ex)
                {
                    string url = Request.Url.ToString().Replace("?erro=true", "");
                    redirect = url + "?erro=" + ex.Message;
                    //Response.Redirect(url + "?erro=" + ex.Message);
                }
            }
            Response.Redirect(redirect);
        }

        protected void btnEsqueceuSenha_Click(object sender, EventArgs e)
        {
            Response.RedirectPermanent(string.Format("~/holeriteFunc/HoleriteNovaSenha.aspx?cpf={0}", txtCpf.Text));
        }

        protected void lblError_Load(object sender, EventArgs e)
        {
            string erro = Request.QueryString["erro"] as string;
            if (string.IsNullOrEmpty(erro))
                lblError.Visible = false;
            else
            {
                if (erro != "true")
                    lblError.Text = "Erro: " + erro;
                lblError.Visible = true;
            }
        }
    }
}