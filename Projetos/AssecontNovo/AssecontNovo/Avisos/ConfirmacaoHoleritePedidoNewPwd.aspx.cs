using System;

namespace AssecontNovo.Avisos
{
    public partial class ConfirmacaoHoleritePedidoNewPwd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string email = Request.QueryString["email"];

            if (!String.IsNullOrEmpty(email))
                lbEmail.Text = "E-mail Cadastrado: ****@" + email;

        }
    }
}