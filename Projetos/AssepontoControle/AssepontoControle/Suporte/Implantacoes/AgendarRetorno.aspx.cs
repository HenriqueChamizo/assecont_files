using System;
using System.Web.UI.WebControls;
using Asseponto.Classes;

namespace Asseponto.Suporte.Implantacoes
{
    public partial class AgendarRetorno : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                panelSucesso.Visible = false;
                panelFalha.Visible = false;
            }
        }

        protected void SqlCadastro_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                panelSucesso.Visible = true;
            }
            else
                panelFalha.Visible = true;

            FV_ATUALIZAR_DADOS.Visible = false;
        }


        protected void SqlCadastro_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@USUARIO"].Value = UserApp.UserId;
            e.Command.Parameters["@IM_IND"].Value = Request.QueryString["ind"];
        }

        protected void lbRazaoSocial_Load(object sender, EventArgs e)
        {
            Label txt = (Label)sender;
            txt.Text = (new BDApp()).getFieldValueString("SELECT CAD_RAZAOSOCIAL FROM AssepontoClientes INNER JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND WHERE IM_IND =" + Request.QueryString["ind"]);
        }
    }
}