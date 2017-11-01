using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using Wr.Classes;

namespace AssecontNovo.HoleriteFunc
{
    public partial class PrimeiroLogin : System.Web.UI.Page
    {
        private int userId;
        private string cpf;
        private string registro;
        private BDAppAssecont bd;

        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDAppAssecont();

            userId = Convert.ToInt32(Request.QueryString["ind"]);

            if (!IsPostBack)
            {
                verificarCadastro();
                lbNome.Text = bd.getNomeFuncionario(userId);
            }
        }

        void verificarCadastro()
        {
            if(bd.getCadastroEfetuado(userId) || userId == 0)
                Response.Redirect("../HoleriteFunc/Login.aspx");
        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            if (((FormView)sender).CurrentMode != FormViewMode.ReadOnly)
            {
                Validadores validadores = new Validadores((FormView)sender);
            }
        }

        protected void btSalvar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                cpf = bd.getCpfFuncionario(userId);
                registro = bd.getRegistroFuncionario(userId);

                FormView1.UpdateItem(((LinkButton)sender).CausesValidation);
                TextBox txtSenha = (TextBox)FormView1.FindControl("txtSenha");

                (new UserApp()).Login(Response, cpf, registro, txtSenha.Text.Trim(), null);
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            TextBox txtSenha = (TextBox)FormView1.FindControl("txtSenha");
            if (txtSenha.Text.Length < 6 || txtSenha.Text.Length > 10 || txtSenha.Text == "")
            {
                args.IsValid = false;
            }
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new AssecontNovo.Classes.BDAppAssecont()).Conn.ConnectionString;
        }

        protected void SqlDatadboFuncionarios_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            //e.Command.Parameters["@FUNC_IND"].Value = userId;
        }
    }
}