using System;
using AssecontNovo.Classes;
using AssecontNovo.Holerite.Classes;

namespace AssecontNovo.HoleriteFunc
{
    public partial class HoleriteNovaSenha : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtCPF.Text = Request.QueryString["cpf"];
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    BDAppAssecont bd = new BDAppAssecont();
                    int userId = bd.getVerificarCadastroFuncionario(txtCPF.Text, txtRegistro.Text);

                    if (userId > 0)
                    {
                        enviarEmailSenha(bd, randomPwd(), userId);
                    }
                    else
                    {
                        if (userId == 0)
                            throw new Exception("Dados invalidos...");
                        else
                            throw new Exception("Você ainda não efetuou o cadastro, por favor, acesse a página www.assecont.com.br e informe só o CPF e o número do registro.");
                    }
                }
                catch (Exception ex)
                {
                    lbErro.Text = ex.Message;
                }
            }
        }


        private string randomPwd()
        {
            string pwd = "";
            Random rand = new Random();
            for (int i = 0; i < 6; i++)
                pwd += rand.Next(0, 9);

            return pwd;
        }

        protected void enviarEmailSenha(BDAppAssecont bd , string newPwd, int userId)
        {
            string nome = bd.getNomeFuncionario(userId);
            string emailfunc = bd.getEmailFuncionario(userId);

            bd.setHoleriteNewPwd(userId, newPwd);

            EmailSenha emailsenha = new EmailSenha("notificacao@assecont.com.br", null, Server.MapPath("") + "\\..\\Classes\\Emails\\HoleritePwd\\EmailSenha.htm");
            emailsenha.Send(emailfunc, newPwd, nome, txtRegistro.Text, txtCPF.Text);

            Response.Redirect("../Avisos/ConfirmacaoHoleritePedidoNewPwd.aspx?email=" + emailfunc.Split('@')[1]);
        }
    }
}