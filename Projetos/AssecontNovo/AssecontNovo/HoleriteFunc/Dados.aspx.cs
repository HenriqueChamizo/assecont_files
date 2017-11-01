using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using Wr.Classes;

namespace AssecontNovo.HoleriteFunc
{
    public partial class Dados : System.Web.UI.Page
    {
        private UserApp user;
        protected void Page_Load(object sender, EventArgs e)
        {
            user = new UserApp();
            MasterPage MasterP = (MasterPage)Master;
            ((LinkButton)MasterP.FindControl("lbSair")).Visible = false;
            setNome();

        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            if (((FormView)sender).CurrentMode != FormViewMode.ReadOnly)
            {
                Validadores validadores = new Validadores((FormView)sender);
            }
        }

        private void setNome()
        {
            if (user.UserId == 0)
                Response.Redirect("http://www.assecont.com.br/holeriteFunc/Login.aspx");

            LbNome.Text = user.UserName; // bd.getNomeFuncionario(ind);;
        }

        protected void btSalvar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                FormViewSenha.UpdateItem(((LinkButton)sender).CausesValidation);
                Response.RedirectPermanent("~/holeriteFunc/HoleriteFuncionario.aspx");
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            TextBox txtSenha = (TextBox)FormViewSenha.FindControl("txtSenha");
            if (txtSenha.Text.Length < 6 || txtSenha.Text.Length > 10 || string.IsNullOrEmpty(txtSenha.Text))
            {
                args.IsValid = false;
            }
        }

        protected void btCancelar_Click(object sender, EventArgs e)
        {
            Response.RedirectPermanent("~/holeriteFunc/HoleriteFuncionario.aspx");
        }

        protected void btGravar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                FormViewDados.UpdateItem(((LinkButton)sender).CausesValidation);
                Response.RedirectPermanent("~/holeriteFunc/HoleriteFuncionario.aspx");
            }
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new AssecontNovo.Classes.BDAppAssecont()).Conn.ConnectionString;
        }

        protected void SqlDataSenha_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@FUNC_IND"].Value = user.UserId;
        } 
    }
}